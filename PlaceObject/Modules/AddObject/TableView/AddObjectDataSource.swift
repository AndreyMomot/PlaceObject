//
//  AddObjectDataSource.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/15/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

class AddObjectDataSource: NSObject, UITableViewDataSource {

    weak var cellDelegate: AddObjectCellDelegate?
    private let model: AddObjectModelProtocol

    init(withModel model: AddObjectModelProtocol) {
        self.model = model
    }

    func regicterNibsForTableView(tableView: UITableView) {
        AddObjectTableViewCell.register(for:tableView)
    }

    // MARK: - Private methods

    func configure(cell: AddObjectTableViewCell, forItem item: String) {
        cell.titleLabel.text = item
    }

    // MARK: - UITableViewDataSource

    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.deque(for: indexPath) as AddObjectTableViewCell
        cell.delegate = cellDelegate

        let testItem = self.model.items[indexPath.row];
        self.configure(cell: cell, forItem: testItem)

        return cell
    }
}
