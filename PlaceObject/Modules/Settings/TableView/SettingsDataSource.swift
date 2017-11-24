//
//  SettingsDataSource.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/15/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

class SettingsDataSource: NSObject, UITableViewDataSource {

    weak var cellDelegate: SettingsCellDelegate?
    private let model: SettingsModelProtocol

    init(withModel model: SettingsModelProtocol) {
        self.model = model
    }

    func regicterNibsForTableView(tableView: UITableView) {
        SettingsTableViewCell.register(for:tableView)
    }

    // MARK: - Private methods

//    func configure(cell: SettingsTableViewCell, forItem item: String) {
//        cell.titleLabel.text = item
//    }

    // MARK: - UITableViewDataSource

    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.deque(for: indexPath) as SettingsTableViewCell
        cell.delegate = cellDelegate
        
//        if (indexPath.row == 0) {
//            cell.titleLabel.text = Setting.changeColor.rawValue
//        } else if (indexPath.row == 1) {
//            cell.titleLabel.text = Setting.defaultLighting.rawValue
//        } else if (indexPath.row == 2) {
//            cell.titleLabel.text = Setting.debugMode.rawValue
//        } else if (indexPath.row == 3) {
//            cell.titleLabel.text = Setting.hitTestMode.rawValue
//        }
        


//        let testItem = self.model.items[indexPath.row];
//        self.configure(cell: cell, forItem: testItem)

        return cell
    }
}
