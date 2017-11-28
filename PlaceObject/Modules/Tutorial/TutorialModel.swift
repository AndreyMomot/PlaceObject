//
//  TutorialModel.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/27/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

public protocol TutorialModelDelegate: NSObjectProtocol {}

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
        return ["⬅️ - 'Move Left'", "➡️ - 'Move Right'", "🔄 - 'Rotate'", "⏫ - 'Scale Up'", "⏬ - 'Scale Down'", "🔴 - 'Red'", "⚪️ - 'White'"]
    }

    // MARK: - TutorialModel methods
    weak public var delegate: TutorialModelDelegate?
    public private(set) var commands: [String]
}
