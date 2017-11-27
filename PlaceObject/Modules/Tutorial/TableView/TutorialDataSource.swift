//
//  TutorialDataSource.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/27/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

class TutorialDataSource: NSObject, UITableViewDataSource {

    weak var cellDelegate: TutorialCellDelegate?
    private let model: TutorialModelProtocol

    init(withModel model: TutorialModelProtocol) {
        self.model = model
    }

    func regicterNibsForTableView(tableView: UITableView) {
        TutorialTableViewCell.register(for:tableView)
    }

    // MARK: - Private methods

    func configure(cell: TutorialTableViewCell, forItem item: String) {
        cell.titleLabel.text = item
    }

    // MARK: - UITableViewDataSource

    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.commands.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.deque(for: indexPath) as TutorialTableViewCell
        cell.delegate = cellDelegate

        let testItem = self.model.commands[indexPath.row];
        self.configure(cell: cell, forItem: testItem)

        return cell
    }
}
