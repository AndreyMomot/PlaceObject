//
//  CameraViewController.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/15/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

typealias CameraViewControllerType = MVCViewController<CameraModelProtocol, CameraViewProtocol, CameraRouter>

class CameraViewController: CameraViewControllerType {
    
    // MARK: Initializers
    
    required public init(withView view: CameraViewProtocol!, model: CameraModelProtocol!, router: CameraRouter?) {
        super.init(withView: view, model: model, router: router)
    }
    
    // MARK: - View life cycle

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        customView.delegate = self
        model.delegate = self
    }
}

// MARK: - CameraViewDelegate

extension CameraViewController: CameraViewDelegate {

    public func viewSomeAction(view: CameraViewProtocol) {
    }
}

// MARK: - CameraModelDelegate

extension CameraViewController: CameraModelDelegate {
}
