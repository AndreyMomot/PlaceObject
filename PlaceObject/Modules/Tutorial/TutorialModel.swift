//
//  TutorialModel.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/15/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

protocol TutorialModelDelegate: NSObjectProtocol {
    
}

protocol TutorialModelProtocol: NSObjectProtocol {
    
    weak var delegate: TutorialModelDelegate? { get set }
}

class TutorialModel: NSObject, TutorialModelProtocol {
    
    // MARK: - TutorialModel methods

    weak public var delegate: TutorialModelDelegate?
    
    /** Implement TutorialModel methods here */
    
    
    // MARK: - Private methods
    
    /** Implement private methods here */
    
}
