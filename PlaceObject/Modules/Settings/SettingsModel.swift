//
//  SettingsModel.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/15/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

public protocol SettingsModelDelegate: NSObjectProtocol {

    func modelDidChanged(model: SettingsModelProtocol)
}

public protocol SettingsModelProtocol: NSObjectProtocol {

    weak var delegate: SettingsModelDelegate? { get set }
    var items: [String] { get }
}

public class SettingsModel: NSObject, SettingsModelProtocol {

    override init() {
        self.items = []
        super.init()

        self.items = self.getTestItems()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func getTestItems() -> [String] {
        return ["Item 0", "Item 1", "Item 2"]
    }

    // MARK: - SettingsModel methods

    weak public var delegate: SettingsModelDelegate?
    public private(set) var items: [String]

    /** Implement SettingsModel methods here */


    // MARK: - Private methods

    /** Implement private methods here */

}
