//
//  TutorialBuilder.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/27/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

public class TutorialBuilder: NSObject {

    public class func viewController() -> TutorialViewController {
        let view = TutorialView.create() as TutorialViewProtocol
        let model: TutorialModelProtocol = TutorialModel()
        let dataSource = TutorialDataSource(withModel: model)
        let router = TutorialRouter()

        let viewController = TutorialViewController(withView: view, model: model, router: router, dataSource: dataSource)
        return viewController
    }
}
