//
//  SettingsBuilder.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/15/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

public class SettingsBuilder: NSObject {

    public class func viewController() -> SettingsViewController {
        let view = SettingsView.create() as SettingsViewProtocol
        let model: SettingsModelProtocol = SettingsModel()
        let dataSource = SettingsDataSource(withModel: model)
        let router = SettingsRouter()

        let viewController = SettingsViewController(withView: view, model: model, router: router, dataSource: dataSource)
        return viewController
    }
}
