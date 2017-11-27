//
//  TutorialView.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/27/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

public protocol TutorialViewDelegate: NSObjectProtocol {
}

public protocol TutorialViewProtocol: NSObjectProtocol {

    weak var delegate: TutorialViewDelegate? { get set }
    var tableView: UITableView! { get }
}

public class TutorialView: UIView, TutorialViewProtocol{

    // MARK: - TutorialView interface methods
    weak public var delegate: TutorialViewDelegate?
    @IBOutlet weak public var tableView: UITableView!

    override public func awakeFromNib() {
        super.awakeFromNib()
    }
}
