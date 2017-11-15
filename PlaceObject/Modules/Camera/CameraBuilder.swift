//
//  CameraBuilder.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/15/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

class CameraBuilder: NSObject {

    class func viewController() -> CameraViewController {

        let view: CameraViewProtocol = CameraView.create() as  CameraViewProtocol
        let model: CameraModelProtocol = CameraModel()
        let router = CameraRouter()
        
        let viewController = CameraViewController(withView: view, model: model, router: router)
        return viewController
    }
}
