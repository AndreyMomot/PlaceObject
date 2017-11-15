//
//  SettingsView.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/15/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

public protocol SettingsViewDelegate: NSObjectProtocol {

    func viewSomeAction(view: SettingsViewProtocol)
}

public protocol SettingsViewProtocol: NSObjectProtocol {

    weak var delegate: SettingsViewDelegate? { get set }
    var tableView: UITableView! { get }
}

public class SettingsView: UIView, SettingsViewProtocol{

    // MARK: - SettingsView interface methods

    weak public var delegate: SettingsViewDelegate?
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
