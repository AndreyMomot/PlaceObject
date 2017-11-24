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

typealias CameraViewControllerType = MVCViewController<CameraModelProtocol, CameraViewProtocol, CameraRouter>

class CameraViewController: CameraViewControllerType, ARSCNViewDelegate, UIPopoverPresentationControllerDelegate, AddObjectViewControllerDelegate {
    
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
        model.delegate = self
        setupScene()
        self.customView.setStatusText()
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
    
    private func updateSettings() {
        let defaults = UserDefaults.standard
        
        changeObjectColor = defaults.bool(for: .changeColor)
        showDebugVisuals = defaults.bool(for: .debugMode)
        toggleDefaultLighting(defaults.bool(for: .defaultLighting))
        showHitTestAPIVisualization = defaults.bool(for: .hitTestMode)
    }
    
    private func resetSettings() {
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
//        updateSettings()
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
 //       resetSettings()
 //       updateSettings()
    }
    
    func viewShowInfo(view: CameraViewProtocol) {
        
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
        // ToDo: - lauch settings
    }
}

// MARK: - CameraModelDelegate

extension CameraViewController: CameraModelDelegate {
}
