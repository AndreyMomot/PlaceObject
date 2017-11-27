//
//  TutorialViewController.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/15/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

typealias TutorialViewControllerType = MVCViewController<TutorialModelProtocol, TutorialViewProtocol, TutorialRouter>

class TutorialViewController: TutorialViewControllerType {
    
    // MARK: Initializers
    
    required public init(withView view: TutorialViewProtocol!, model: TutorialModelProtocol!, router: TutorialRouter?) {
        super.init(withView: view, model: model, router: router)
    }
    
    // MARK: - View life cycle

    override public func viewDidLoad() {
        super.viewDidLoad()
        
        customView.delegate = self
        model.delegate = self
    }
}

// MARK: - TutorialViewDelegate

extension TutorialViewController: TutorialViewDelegate {

    public func viewSomeAction(view: TutorialViewProtocol) {

    }
}

// MARK: - TutorialModelDelegate

extension TutorialViewController: TutorialModelDelegate {
}
