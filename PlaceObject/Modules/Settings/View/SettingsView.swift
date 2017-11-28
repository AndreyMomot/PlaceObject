//
//  SettingsView.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/27/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

protocol SettingsViewDelegate: NSObjectProtocol {
    
    func viewChangedSwitch(view: SettingsViewProtocol, sender: UISwitch)
}

protocol SettingsViewProtocol: NSObjectProtocol {
    
    weak var delegate: SettingsViewDelegate? { get set }
    var changeColorSwitch: UISwitch! { get }
    var defaultLightingSwitch: UISwitch! { get }
    var debugModeSwitch: UISwitch! { get }
    var hitTestModeSwitch: UISwitch! { get }
}

class SettingsView: UIView, SettingsViewProtocol{
    
    @IBOutlet var changeColorSwitch: UISwitch!
    @IBOutlet var defaultLightingSwitch: UISwitch!
    @IBOutlet var debugModeSwitch: UISwitch!
    @IBOutlet var hitTestModeSwitch: UISwitch!
    
    // MARK: - SettingsView interface methods
    weak public var delegate: SettingsViewDelegate?
    
    // MARK: - Overrided methods
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - IBActions
    @IBAction func onChangedSwitch(_ sender: UISwitch) {
        self.delegate?.viewChangedSwitch(view: self, sender: sender)
    }
}
