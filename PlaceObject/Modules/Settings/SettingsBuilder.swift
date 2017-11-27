//
//  SettingsBuilder.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/27/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

class SettingsBuilder: NSObject {

    class func viewController() -> SettingsViewController {

        let view: SettingsViewProtocol = SettingsView.create() as  SettingsViewProtocol
        let model: SettingsModelProtocol = SettingsModel()
        let router = SettingsRouter()
        
        let viewController = SettingsViewController(withView: view, model: model, router: router)
        return viewController
    }
}
