//
//  CameraView.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/15/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

protocol CameraViewDelegate: NSObjectProtocol {
    
    func viewSomeAction(view: CameraViewProtocol)
}

protocol CameraViewProtocol: NSObjectProtocol {
    
    weak var delegate: CameraViewDelegate? { get set }
}

class CameraView: UIView, CameraViewProtocol{
    
    // MARK: - CameraView interface methods

    weak public var delegate: CameraViewDelegate?
    
    // MARK: - Overrided methods

    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - IBActions
    
    func someButtonAction() {

        self.delegate?.viewSomeAction(view: self)
    }
}
