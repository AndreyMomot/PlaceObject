//
//  AddObjectModel.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/15/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

public protocol AddObjectModelDelegate: NSObjectProtocol {

    func modelDidChanged(model: AddObjectModelProtocol)
}

public protocol AddObjectModelProtocol: NSObjectProtocol {

    weak var delegate: AddObjectModelDelegate? { get set }
    var items: [String] { get }
}

public class AddObjectModel: NSObject, AddObjectModelProtocol {

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

    // MARK: - AddObjectModel methods

    weak public var delegate: AddObjectModelDelegate?
    public private(set) var items: [String]

    /** Implement AddObjectModel methods here */


    // MARK: - Private methods

    /** Implement private methods here */

}
