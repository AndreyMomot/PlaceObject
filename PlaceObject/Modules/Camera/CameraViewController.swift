//
//  CameraViewController.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/15/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import Speech

typealias CameraViewControllerType = MVCViewController<CameraModelProtocol, CameraViewProtocol, CameraRouter>

class CameraViewController: CameraViewControllerType, ARSCNViewDelegate, SFSpeechRecognizerDelegate, UIPopoverPresentationControllerDelegate, AddObjectViewControllerDelegate {
    
    // MARK: Initializers
    let session = ARSession()
    var sessionConfig: ARConfiguration = ARWorldTrackingConfiguration()
    var virtualObject: VirtualObject!
    
    required public init(withView view: CameraViewProtocol!, model: CameraModelProtocol!, router: CameraRouter?) {
        super.init(withView: view, model: model, router: router)
    }
    
    // MARK: - View life cycle

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        customView.delegate = self
        resetSettings()
        Setting.registerDefaults()
        setupScene()
        self.customView.setStatusText()
        speechAuth()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Create a session configuration with plane detection
        if let configuration = sessionConfig as? ARWorldTrackingConfiguration {
            configuration.planeDetection = .horizontal
            
            // Run the view's session
            session.run(configuration)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        // Pause the view's session
        self.customView.sceneView.session.pause()
    }
    
    func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
        self.customView.trackingState = camera.trackingState
    }
    
    private func setupScene() {
        
        // Set up sceneView
        customView.sceneView.delegate = self
        customView.sceneView.session = session
        customView.sceneView.autoenablesDefaultLighting = true
        
        // Create VirtualObject
        virtualObject = VirtualObject()
    }
    
    func resetVirtualObject() {
        virtualObject.unloadModel()
        
        // Reset selected object id for row highlighting in object selection view controller.
    //    UserDefaults.standard.set(-1, for: .selectedObjectID)
    }
    
    // MARK: - ARSCNViewDelegate
    
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        DispatchQueue.main.async {
            self.customView.setStatusText()
            self.hitTestVisualization?.render()
        }
    }
    
    private func createVirtualObject(hitPosition : SCNVector3) {
        
        virtualObject.position = hitPosition
        self.customView.sceneView.scene.rootNode.addChildNode(virtualObject)
    }

    // MARK: - Add Object Implementation
    private func loadVirtualObject(at index: Int) {
        resetVirtualObject()
        
        // Load the content asynchronously
        DispatchQueue.global().async {
            let object = VirtualObject.availableObjects[index]
            object.viewController = self
            self.virtualObject = object
            
            object.loadModel()
        }
    }
    
    // MARK: - Gesture Recognizers
    
    var currentGesture: Gesture?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        guard let object = virtualObject else {
            return
        }
        
        if currentGesture == nil {
            currentGesture = Gesture.startGestureFromTouches(touches, self.customView.sceneView, object)
        } else {
            currentGesture = currentGesture!.updateGestureFromTouches(touches, .touchBegan)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if virtualObject == nil {
            return
        }
        currentGesture = currentGesture?.updateGestureFromTouches(touches, .touchMoved)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if virtualObject == nil {
            return
        }
        
        currentGesture = currentGesture?.updateGestureFromTouches(touches, .touchEnded)
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        if virtualObject == nil {
            return
        }
        currentGesture = currentGesture?.updateGestureFromTouches(touches, .touchCancelled)
    }
    
    // MARK: - Virtual Object Manipulation
    
    // Use average of recent virtual object distances to avoid rapid changes in object scale.
    var recentVirtualObjectDistances = [CGFloat]()
    
    func setNewVirtualObjectPosition(_ pos: SCNVector3) {
        
        guard let object = virtualObject, let cameraTransform = session.currentFrame?.camera.transform else {
            return
        }
        
        let cameraWorldPos = SCNVector3.positionFromTransform(cameraTransform)
        var cameraToPosition = pos - cameraWorldPos
        
        // Limit the distance of the object from the camera to a maximum of 10 meters.
        cameraToPosition.setMaximumLength(10)
        
        object.position = cameraWorldPos + cameraToPosition
        
        if object.parent == nil {
            self.customView.sceneView.scene.rootNode.addChildNode(object)
        }
    }
    
    func moveVirtualObjectToPosition(_ pos: SCNVector3?, _ instantly: Bool, _ filterPosition: Bool) {
        
        guard let newPosition = pos else {
            // Reset the content selection in the menu only if the content has not yet been initially placed.
            if virtualObject == nil {
                resetVirtualObject()
            }
            return
        }
        
        if instantly {
            setNewVirtualObjectPosition(newPosition)
        } else {
            updateVirtualObjectPosition(newPosition, filterPosition)
        }
    }
    
    func updateVirtualObjectPosition(_ pos: SCNVector3, _ filterPosition: Bool) {
        guard let object = virtualObject else {
            return
        }
        
        guard let cameraTransform = session.currentFrame?.camera.transform else {
            return
        }
        
        let cameraWorldPos = SCNVector3.positionFromTransform(cameraTransform)
        var cameraToPosition = pos - cameraWorldPos
        
        // Limit the distance of the object from the camera to a maximum of 10 meters.
        cameraToPosition.setMaximumLength(10)
        
        // Compute the average distance of the object from the camera over the last ten
        // updates. If filterPosition is true, compute a new position for the object
        // with this average. Notice that the distance is applied to the vector from
        // the camera to the content, so it only affects the percieved distance of the
        // object - the averaging does _not_ make the content "lag".
        let hitTestResultDistance = CGFloat(cameraToPosition.length())
        
        recentVirtualObjectDistances.append(hitTestResultDistance)
        recentVirtualObjectDistances.keepLast(10)
        
        if filterPosition {
            let averageDistance = recentVirtualObjectDistances.average!
            
            cameraToPosition.setLength(Float(averageDistance))
            let averagedDistancePos = cameraWorldPos + cameraToPosition
            
            object.position = averagedDistancePos
        } else {
            object.position = cameraWorldPos + cameraToPosition
        }
    }
    
    var dragOnInfinitePlanesEnabled = false
    
    func worldPositionFromScreenPosition(_ position: CGPoint,
                                         objectPos: SCNVector3?,
                                         infinitePlane: Bool = false) -> (position: SCNVector3?, planeAnchor: ARPlaneAnchor?, hitAPlane: Bool) {
        
        // -------------------------------------------------------------------------------
        // 1. Always do a hit test against exisiting plane anchors first.
        //    (If any such anchors exist & only within their extents.)
        
        let planeHitTestResults = self.customView.sceneView.hitTest(position, types: .existingPlaneUsingExtent)
        if let result = planeHitTestResults.first {
            
            let planeHitTestPosition = SCNVector3.positionFromTransform(result.worldTransform)
            let planeAnchor = result.anchor
            
            // Return immediately - this is the best possible outcome.
            return (planeHitTestPosition, planeAnchor as? ARPlaneAnchor, true)
        }
        
        // -------------------------------------------------------------------------------
        // 2. Collect more information about the environment by hit testing against
        //    the feature point cloud, but do not return the result yet.
        
        var featureHitTestPosition: SCNVector3?
        var highQualityFeatureHitTestResult = false
        
        let highQualityfeatureHitTestResults = self.customView.sceneView.hitTestWithFeatures(position, coneOpeningAngleInDegrees: 18, minDistance: 0.2, maxDistance: 2.0)
        
        if !highQualityfeatureHitTestResults.isEmpty {
            let result = highQualityfeatureHitTestResults[0]
            featureHitTestPosition = result.position
            highQualityFeatureHitTestResult = true
        }
        
        // -------------------------------------------------------------------------------
        // 3. If desired or necessary (no good feature hit test result): Hit test
        //    against an infinite, horizontal plane (ignoring the real world).
        
        if (infinitePlane && dragOnInfinitePlanesEnabled) || !highQualityFeatureHitTestResult {
            
            let pointOnPlane = objectPos ?? SCNVector3Zero
            
            let pointOnInfinitePlane = self.customView.sceneView.hitTestWithInfiniteHorizontalPlane(position, pointOnPlane)
            if pointOnInfinitePlane != nil {
                return (pointOnInfinitePlane, nil, true)
            }
        }
        
        // -------------------------------------------------------------------------------
        // 4. If available, return the result of the hit test against high quality
        //    features if the hit tests against infinite planes were skipped or no
        //    infinite plane was hit.
        
        if highQualityFeatureHitTestResult {
            return (featureHitTestPosition, nil, false)
        }
        
        // -------------------------------------------------------------------------------
        // 5. As a last resort, perform a second, unfiltered hit test against features.
        //    If there are no features in the scene, the result returned here will be nil.
        
        let unfilteredFeatureHitTestResults = self.customView.sceneView.hitTestWithFeatures(position)
        if !unfilteredFeatureHitTestResults.isEmpty {
            let result = unfilteredFeatureHitTestResults[0]
            return (result.position, nil, false)
        }
        
        return (nil, nil, false)
    }
    
    // MARK: - Enable Default Lighting
    
    func toggleDefaultLighting(_ enabled: Bool) {
        
        if enabled {
            self.customView.sceneView.autoenablesDefaultLighting = true
        } else {
            self.customView.sceneView.autoenablesDefaultLighting = false
        }
    }
    
    // MARK: - VirtualObjectSelectionViewControllerDelegate
    
    func addObjectViewController(_: AddObjectViewController, didSelectObjectAt index: Int) {
        loadVirtualObject(at: index)
    }
    
    func addObjectViewControllerDidDeselectObject(_: AddObjectViewController) {
        resetVirtualObject()
    }
    
    // MARK: - Hit Test Visualization
    var hitTestVisualization: HitTestVisualization?
    
    private  var showHitTestAPIVisualization = UserDefaults.standard.bool(for: .hitTestMode) {
        didSet {
            UserDefaults.standard.set(showHitTestAPIVisualization, for: .hitTestMode)
            if showHitTestAPIVisualization {
                hitTestVisualization = HitTestVisualization(sceneView: self.customView.sceneView)
            } else {
                hitTestVisualization = nil
            }
        }
    }
    
    // MARK: - Debug Visualizations
    
    private var showDebugVisuals: Bool = UserDefaults.standard.bool(for: .debugMode) {
        didSet {
            
            if showDebugVisuals {
                self.customView.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
            } else {
                self.customView.sceneView.debugOptions = []
            }
            
            // save pref
            UserDefaults.standard.set(showDebugVisuals, for: .debugMode)
        }
    }
    
    // MARK: - Change Object Color
    private var changeObjectColor: Bool = UserDefaults.standard.bool(for: .changeColor) {
        didSet {
            for node in virtualObject.childNodes {
                if changeObjectColor {
                    node.childNodes.first?.geometry?.firstMaterial?.diffuse.contents = UIColor.red
                } else {
                    node.childNodes.first?.geometry?.firstMaterial?.diffuse.contents = UIColor.white
                }
                // save pref
                UserDefaults.standard.set(changeObjectColor, for: .changeColor)
            }
        }
    }
    
    @objc func dismissSettings() {
        self.dismiss(animated: true, completion: nil)
        updateSettings()
    }
    
    func updateSettings() {
        let defaults = UserDefaults.standard
        
        changeObjectColor = defaults.bool(for: .changeColor)
        showDebugVisuals = defaults.bool(for: .debugMode)
        toggleDefaultLighting(defaults.bool(for: .defaultLighting))
        showHitTestAPIVisualization = defaults.bool(for: .hitTestMode)
    }
    
    func resetSettings() {
        let defaults = UserDefaults.standard
        
        defaults.set(-1, for: .selectedObjectID)
        defaults.set(false, for: .changeColor)
        defaults.set(false, for: .debugMode)
        defaults.set(true, for: .defaultLighting)
        defaults.set(false, for: .hitTestMode)
    }
    
    // MARK: - UIPopoverPresentationControllerDelegate
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        updateSettings()
    }
    
    func showPopover(vc: UIViewController, size: CGSize, title: String, button: UIButton) {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissSettings))
        vc.navigationItem.rightBarButtonItem = barButtonItem
        vc.title = title
        
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .popover
        navigationController.popoverPresentationController?.delegate = self
        navigationController.preferredContentSize = size
        self.present(navigationController, animated: true, completion: nil)
        
        navigationController.popoverPresentationController?.sourceView = button
        navigationController.popoverPresentationController?.sourceRect = button.bounds
    }
    
    // MARK: - Speech Recognition
    let speechRecognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "en-US"))
    var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    let audioEngine = AVAudioEngine()
    
    // MARK: - Speech Recognition Authorization Request
    func speechAuth() {
        self.customView.recordSpeechButton.isEnabled = false
        speechRecognizer?.delegate = self

        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            
            var isButtonEnabled = false
            
            switch authStatus {
            case .authorized:
                isButtonEnabled = true
                
            case .denied:
                isButtonEnabled = false
                print("User denied access to speech recognition")
                
            case .restricted:
                isButtonEnabled = false
                print("Speech recognition restricted in this device")
                
            case .notDetermined:
                isButtonEnabled = false
                print("Speech recognition not yet authorized")
            }
            
            OperationQueue.main.addOperation {
                self.customView.recordSpeechButton.isEnabled = isButtonEnabled
            }
        }
    }
    
    func startRecording() {
        
        if recognitionTask != nil {
            recognitionTask?.cancel()
            recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSessionCategoryRecord)
            try audioSession.setMode(AVAudioSessionModeMeasurement)
            try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        } catch {
            print("audioSession properties weren't set because of an error")
        }
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        guard let inputNode = audioEngine.inputNode else {
            fatalError("Audio engine has no input node")
        }
        
        guard let recognitionRequest = recognitionRequest else {
            fatalError("Unable to create an SFSpeechAudioBufferRecognitionRequest object")
        }
        
        recognitionRequest.shouldReportPartialResults = true
        
        recognitionTask = speechRecognizer?.recognitionTask(with: recognitionRequest, resultHandler: { (result, error) in
            
            var isFinal = false
            
            if result != nil {
                
                self.customView.speechRecognitionLabel.text = result!.bestTranscription.formattedString
                isFinal = (result?.isFinal)!
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.customView.recordSpeechButton.isEnabled = true
            }
        })
        
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer, when) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        do {
            try audioEngine.start()
        } catch {
            print("audioEngine couldn't start because of an error.")
        }
        
        self.customView.speechRecognitionLabel.text = "Please, say a command!"
    }
    
    // MARK: - SFSpeechRecognizerDelegate
    func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            self.customView.recordSpeechButton.isEnabled = true
        } else {
            self.customView.recordSpeechButton.isEnabled = false
        }
    }
}

// MARK: - CameraViewDelegate
extension CameraViewController: CameraViewDelegate {

    func viewRefresh(view: CameraViewProtocol) {
        DispatchQueue.main.async {
            self.customView.restartExperienceButtonIsEnabled = false
            self.restart()
            
            // Disable Restart button for five seconds in order to give the session enough time to restart.
            DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
                self.customView.restartExperienceButtonIsEnabled = true
            })
        }
    }
    
    private func restart() {
        resetVirtualObject()
        resetSettings()
        updateSettings()
    }
    
    func viewShowInfo(view: CameraViewProtocol, button: UIButton) {
        
        let tutorialViewController = TutorialBuilder.viewController()
        let size = CGSize(width: self.customView.sceneView.bounds.size.width - 20, height: self.customView.sceneView.bounds.size.height - 50)
        self.showPopover(vc: tutorialViewController, size: size, title: "Tutorial", button: button)
    }
    
    func viewAddObject(view: CameraViewProtocol, button: UIButton) {
        let rowHeight = 45
        let popoverSize = CGSize(width: 250, height: rowHeight * VirtualObject.availableObjects.count)
        
        let objectViewController = AddObjectViewController(size: popoverSize)
        objectViewController.delegate = self
        objectViewController.modalPresentationStyle = .popover
        objectViewController.popoverPresentationController?.delegate = self
        self.present(objectViewController, animated: true, completion: nil)
        objectViewController.popoverPresentationController?.sourceView = button
        objectViewController.popoverPresentationController?.sourceRect = button.bounds
    }
    
    func viewShowSettings(view: CameraViewProtocol, button: UIButton) {
        
        let settingsViewController = SettingsBuilder.viewController()
        let size = CGSize(width: self.customView.sceneView.bounds.size.width - 20, height: self.customView.sceneView.bounds.size.height - 50)
        self.showPopover(vc: settingsViewController, size: size, title: "Settings", button: button)
    }
    
    func viewStartRecord(view: CameraViewProtocol) {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            self.customView.recordSpeechButton.isEnabled = false
        } else {
            startRecording()
        }
    }
}

