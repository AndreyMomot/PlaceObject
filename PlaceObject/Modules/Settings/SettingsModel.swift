//
//  SettingsModel.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/27/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

protocol SettingsModelDelegate: NSObjectProtocol {
    
}

protocol SettingsModelProtocol: NSObjectProtocol {
    
    weak var delegate: SettingsModelDelegate? { get set }
}

class SettingsModel: NSObject, SettingsModelProtocol {
    
    // MARK: - SettingsModel methods

    weak public var delegate: SettingsModelDelegate?
    
    /** Implement SettingsModel methods here */
    
    
    // MARK: - Private methods
    
    /** Implement private methods here */
    
}
