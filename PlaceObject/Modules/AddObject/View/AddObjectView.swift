//
//  AddObjectView.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/15/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

public protocol AddObjectViewDelegate: NSObjectProtocol {

    func viewSomeAction(view: AddObjectViewProtocol)
}

public protocol AddObjectViewProtocol: NSObjectProtocol {

    weak var delegate: AddObjectViewDelegate? { get set }
    var tableView: UITableView! { get }
}

public class AddObjectView: UIView, AddObjectViewProtocol{

    // MARK: - AddObjectView interface methods

    weak public var delegate: AddObjectViewDelegate?
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
