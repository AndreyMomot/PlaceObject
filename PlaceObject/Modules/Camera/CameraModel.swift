//
//  CameraModel.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/15/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

protocol CameraModelDelegate: NSObjectProtocol {
    
}

protocol CameraModelProtocol: NSObjectProtocol {
    
    weak var delegate: CameraModelDelegate? { get set }
}

class CameraModel: NSObject, CameraModelProtocol {
    
    // MARK: - CameraModel methods

    weak public var delegate: CameraModelDelegate?
    
    /** Implement CameraModel methods here */
    
    
    // MARK: - Private methods
    
    /** Implement private methods here */
    
}
