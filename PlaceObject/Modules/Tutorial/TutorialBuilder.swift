//
//  TutorialBuilder.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/15/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

class TutorialBuilder: NSObject {

    class func viewController() -> TutorialViewController {

        let view: TutorialViewProtocol = TutorialView.create() as  TutorialViewProtocol
        let model: TutorialModelProtocol = TutorialModel()
        let router = TutorialRouter()
        
        let viewController = TutorialViewController(withView: view, model: model, router: router)
        return viewController
    }
}
