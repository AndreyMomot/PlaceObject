//
//  TutorialView.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/27/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

public protocol TutorialViewDelegate: NSObjectProtocol {

    func viewSomeAction(view: TutorialViewProtocol)
}

public protocol TutorialViewProtocol: NSObjectProtocol {

    weak var delegate: TutorialViewDelegate? { get set }
    var tableView: UITableView! { get }
}

public class TutorialView: UIView, TutorialViewProtocol{

    // MARK: - TutorialView interface methods

    weak public var delegate: TutorialViewDelegate?
    @IBOutlet weak public var tableView: UITableView!

    // add view private properties/outlets/methods here

    // MARK: - IBActions

    @IBAction func someButtonAction() {
        self.delegate?.viewSomeAction(view: self)
    }

    // MARK: - Overrided methods

    override public func awakeFromNib() {
        super.awakeFromNib()

        // setup view and table view programmatically here
    }
}
