//
//  TutorialView.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/15/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

protocol TutorialViewDelegate: NSObjectProtocol {
    
    func viewSomeAction(view: TutorialViewProtocol)
}

protocol TutorialViewProtocol: NSObjectProtocol {
    
    weak var delegate: TutorialViewDelegate? { get set }
}

class TutorialView: UIView, TutorialViewProtocol{
    
    // MARK: - TutorialView interface methods

    weak public var delegate: TutorialViewDelegate?
    
    // MARK: - Overrided methods

    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - IBActions
    
    func someButtonAction() {

        self.delegate?.viewSomeAction(view: self)
    }
}
