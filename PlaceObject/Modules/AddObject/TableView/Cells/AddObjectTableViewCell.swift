//
//  AddObjectTableViewCell.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/15/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

class AddObjectTableViewCell: UITableViewCell {

    weak var delegate: AddObjectCellDelegate?
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    // MARK: - IBAction

    @IBAction func someButtonAction() {
        self.delegate?.cellDidTapSomeButton(cell: self)
    }
}


protocol AddObjectCellDelegate: NSObjectProtocol {

    /** Delegate method example */
    func cellDidTapSomeButton(cell: AddObjectTableViewCell)
}
