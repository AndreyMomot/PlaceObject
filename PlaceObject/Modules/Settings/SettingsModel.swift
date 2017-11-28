//
//  SettingsModel.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/27/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

enum Setting: String {
    // Bool settings with SettingsViewController switches
    case changeColor
    case defaultLighting
    case debugMode
    case hitTestMode
    
    // Integer state used in virtual object picker
    case selectedObjectID
    
    static func registerDefaults() {
        UserDefaults.standard.register(defaults: [
            Setting.defaultLighting.rawValue: true,
            Setting.selectedObjectID.rawValue: -1
            ])
    }
}

protocol SettingsModelDelegate: NSObjectProtocol {}

protocol SettingsModelProtocol: NSObjectProtocol {
    
    weak var delegate: SettingsModelDelegate? { get set }
}

class SettingsModel: NSObject, SettingsModelProtocol {
    
    // MARK: - SettingsModel methods
    weak public var delegate: SettingsModelDelegate?
}
