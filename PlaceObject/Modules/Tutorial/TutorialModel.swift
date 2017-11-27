//
//  TutorialModel.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/27/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

public protocol TutorialModelDelegate: NSObjectProtocol {

    func modelDidChanged(model: TutorialModelProtocol)
}

public protocol TutorialModelProtocol: NSObjectProtocol {

    weak var delegate: TutorialModelDelegate? { get set }
    var commands: [String] { get }
}

public class TutorialModel: NSObject, TutorialModelProtocol {

    override init() {
        self.commands = []
        super.init()

        self.commands = self.getCommands()
    }

    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func getCommands() -> [String] {
        return ["Up", "Down", "Left", "Right", "Rotate", "Scale Up", "Scale Down", "Red", "Black"]
    }

    // MARK: - TutorialModel methods

    weak public var delegate: TutorialModelDelegate?
    public private(set) var commands: [String]

    /** Implement TutorialModel methods here */


    // MARK: - Private methods

    /** Implement private methods here */

}
