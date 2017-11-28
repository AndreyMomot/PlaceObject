//
//  TutorialTableViewCell.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/27/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

class TutorialTableViewCell: UITableViewCell {

    weak var delegate: TutorialCellDelegate?
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

protocol TutorialCellDelegate: NSObjectProtocol {}
