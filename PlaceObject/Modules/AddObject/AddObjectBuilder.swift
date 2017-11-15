//
//  AddObjectBuilder.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/15/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

public class AddObjectBuilder: NSObject {

    public class func viewController() -> AddObjectViewController {
        let view = AddObjectView.create() as AddObjectViewProtocol
        let model: AddObjectModelProtocol = AddObjectModel()
        let dataSource = AddObjectDataSource(withModel: model)
        let router = AddObjectRouter()

        let viewController = AddObjectViewController(withView: view, model: model, router: router, dataSource: dataSource)
        return viewController
    }
}
