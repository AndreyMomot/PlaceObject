//
//  UserDefaults+Common.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/30/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import Foundation

// MARK: - UserDefaults extensions
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
