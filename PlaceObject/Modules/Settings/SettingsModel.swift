//
//  SettingsModel.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/15/17.
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

public protocol SettingsModelDelegate: NSObjectProtocol {

    func modelDidChanged(model: SettingsModelProtocol)
}

public protocol SettingsModelProtocol: NSObjectProtocol {

    weak var delegate: SettingsModelDelegate? { get set }
}

public class SettingsModel: NSObject, SettingsModelProtocol {

    override init() {
        super.init()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - SettingsModel methods

    weak public var delegate: SettingsModelDelegate?
}
