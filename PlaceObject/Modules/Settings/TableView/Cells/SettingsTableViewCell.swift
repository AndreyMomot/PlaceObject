//
//  SettingsTableViewCell.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/15/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {

    weak var delegate: SettingsCellDelegate?
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - IBAction

    @IBAction func someButtonAction() {
        self.delegate?.cellDidTapSomeButton(cell: self)
    }
}


protocol SettingsCellDelegate: NSObjectProtocol {

    /** Delegate method example */
    func cellDidTapSomeButton(cell: SettingsTableViewCell)
}
