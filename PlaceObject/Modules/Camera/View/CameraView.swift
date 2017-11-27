//
//  CameraView.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/15/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit
import ARKit

protocol CameraViewDelegate: NSObjectProtocol {
    
    func viewRefresh(view: CameraViewProtocol)
    func viewShowInfo(view: CameraViewProtocol, button: UIButton)
    func viewAddObject(view: CameraViewProtocol, button: UIButton)
    func viewShowSettings(view: CameraViewProtocol, button: UIButton)
    func viewStartRecord(view: CameraViewProtocol)
}

protocol CameraViewProtocol: NSObjectProtocol {
    
    weak var delegate: CameraViewDelegate? { get set }
    var sceneView: ARSCNView! { get }
    var statusTextView: UITextView! { get }
    var trackingState: ARCamera.TrackingState! { get set }
    var restartExperienceButtonIsEnabled: Bool { get set }
    var addButton: UIButton! { get }
    var settingsButton: UIButton! { get }
    var speechRecognitionLabel: UILabel! { get set }
    var recordSpeechButton: UIButton! { get }
    func setStatusText()
}

class CameraView: UIView, CameraViewProtocol{
    
    // MARK: - CameraView interface methods
    @IBOutlet var sceneView: ARSCNView!
    @IBOutlet var statusTextView: UITextView!
    @IBOutlet var refreshButton: UIButton!
    @IBOutlet var infoButton: UIButton!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var settingsButton: UIButton!
    @IBOutlet var speechRecognitionLabel: UILabel!
    @IBOutlet var recordSpeechButton: UIButton!
    
    var trackingState: ARCamera.TrackingState!
    weak public var delegate: CameraViewDelegate?
    var restartExperienceButtonIsEnabled = true

    // MARK: - Overrided methods

    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setStatusText() {
        let text = "Tracking: \(getTrackingDescription())\n"
        statusTextView.text = text
    }
    
    private func getTrackingDescription() -> String {
        var description = ""
        if let t = trackingState {
            switch(t) {
            case .notAvailable:
                description = "TRACKING UNAVAILABLE"
                statusTextView.textColor = UIColor.red
            case .normal:
                description = "TRACKING NORMAL"
                statusTextView.textColor = UIColor.green
            case .limited(let reason):
                statusTextView.textColor = UIColor.red
                switch reason {
                case .excessiveMotion:
                    description = "TRACKING LIMITED - Too much camera movement"
                case .insufficientFeatures:
                    description = "TRACKING LIMITED - Not enough surface detail"
                case .initializing:
                    description = "INITIALIZING"
                }
            }
        }
        return description
    }
    
    // MARK: - IBActions
    
    @IBAction func onPressedRefreshButton(_ sender: Any) {
        self.delegate?.viewRefresh(view: self)
    }
    
    @IBAction func onPressedInfoButton(_ button: UIButton) {
        self.delegate?.viewShowInfo(view: self, button: button)
    }
    
    @IBAction func onPressedAddButton(_ button: UIButton) {
        self.delegate?.viewAddObject(view: self, button: button)
    }
    
    @IBAction func onPressedSettingsButton(_ button: UIButton) {
        self.delegate?.viewShowSettings(view: self, button: button)
    }
    @IBAction func onPressedRecordSpeechButton(_ sender: Any) {
        self.speechRecognitionLabel.text = "Please say a command"
        self.delegate?.viewStartRecord(view: self)
    }
}
