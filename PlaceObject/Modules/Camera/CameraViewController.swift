//
//  CameraViewController.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/15/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit
import ARKit

typealias CameraViewControllerType = MVCViewController<CameraModelProtocol, CameraViewProtocol, CameraRouter>

class CameraViewController: CameraViewControllerType, ARSCNViewDelegate {
    
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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        
    }
    
    private func setupScene() {
        
        // Set up sceneView
        customView.sceneView.delegate = self
        customView.sceneView.session = session
        customView.sceneView.autoenablesDefaultLighting = true
        
        // Create VirtualObject
        virtualObject = VirtualObject()
    }
}

// MARK: - CameraViewDelegate

extension CameraViewController: CameraViewDelegate {
    
    func viewRefresh(view: CameraViewProtocol) {
        
    }
    
    func viewShowInfo(view: CameraViewProtocol) {
        
    }
    
    func viewAddObject(view: CameraViewProtocol) {
        
    }
    
    func viewShowSettings(view: CameraViewProtocol) {
        
    }
}

// MARK: - CameraModelDelegate

extension CameraViewController: CameraModelDelegate {
}
