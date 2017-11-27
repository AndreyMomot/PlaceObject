//
//  SettingsViewController.swift
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

extension UserDefaults {
    func bool(for setting: Setting) -> Bool {
        return bool(forKey: setting.rawValue)
    }
    func set(_ bool: Bool, for setting: Setting) {
        set(bool, forKey: setting.rawValue)
    }
    func integer(for setting: Setting) -> Int {
        return integer(forKey: setting.rawValue)
    }
    func set(_ integer: Int, for setting: Setting) {
        set(integer, forKey: setting.rawValue)
    }
}

typealias SettingsViewControllerType = MVCViewController<SettingsModelProtocol, SettingsViewProtocol, SettingsRouter>

class SettingsViewController: SettingsViewControllerType {
    
    // MARK: Initializers
    
    required public init(withView view: SettingsViewProtocol!, model: SettingsModelProtocol!, router: SettingsRouter?) {
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
        loadSettings()
    }
    
    func loadSettings() {
        let defaults = UserDefaults.standard
        
        self.customView.changeColorSwitch.isOn = defaults.bool(for: .changeColor)
        self.customView.defaultLightingSwitch.isOn = defaults.bool(for: .defaultLighting)
        self.customView.debugModeSwitch.isOn = defaults.bool(for: .debugMode)
        self.customView.hitTestModeSwitch.isOn = defaults.bool(for: .hitTestMode)
    }
}

// MARK: - SettingsViewDelegate

extension SettingsViewController: SettingsViewDelegate {

    public func viewChangedSwitch(view: SettingsViewProtocol, sender: UISwitch) {
        let defaults = UserDefaults.standard
        switch sender {
        case self.customView.changeColorSwitch:
            defaults.set(sender.isOn, forKey: Setting.changeColor.rawValue)
        case self.customView.defaultLightingSwitch:
            defaults.set(sender.isOn, forKey: Setting.defaultLighting.rawValue)
        case self.customView.debugModeSwitch:
            defaults.set(sender.isOn, forKey: Setting.debugMode.rawValue)
        case self.customView.hitTestModeSwitch:
            defaults.set(sender.isOn, forKey: Setting.hitTestMode.rawValue)
        default:
            break
        }
    }
}

// MARK: - SettingsModelDelegate

extension SettingsViewController: SettingsModelDelegate {
}
