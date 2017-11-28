//
//  CameraModel.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/15/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

protocol CameraModelDelegate: NSObjectProtocol {}

protocol CameraModelProtocol: NSObjectProtocol {
    weak var delegate: TutorialModelDelegate? { get set }
    var commands: [String] { get }
}

class CameraModel: NSObject, CameraModelProtocol {
    
    override init() {
        self.commands = []
        super.init()
        
        self.commands = self.getCommands()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getCommands() -> [String] {
        return ["move left", "move right", "rotate", "scale up", "scale down", "red", "white"]
    }
    
    // MARK: - TutorialModel methods
    weak public var delegate: TutorialModelDelegate?
    public private(set) var commands: [String]
}
