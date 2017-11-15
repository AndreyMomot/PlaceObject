//
//  AddObjectViewController.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/15/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

public typealias AddObjectViewControllerType = MVCViewController<AddObjectModelProtocol, AddObjectViewProtocol, AddObjectRouter>

public class AddObjectViewController: AddObjectViewControllerType, UITableViewDelegate {

    private var dataSource: AddObjectDataSource!

    // MARK: - Initializers

    convenience init(withView view: AddObjectViewProtocol, model: AddObjectModelProtocol, router: AddObjectRouter, dataSource: AddObjectDataSource) {

        self.init(withView: view, model: model, router: router)

        self.model.delegate = self

        self.dataSource = dataSource
        self.dataSource.cellDelegate = self

        // your custom code
    }

    public required init(withView view: AddObjectViewProtocol!, model: AddObjectModelProtocol!, router: AddObjectRouter?) {
        super.init(withView: view, model: model, router: router)
    }

    // MARK: - View life cycle

    override public func viewDidLoad() {
        super.viewDidLoad()

        self.customView.delegate = self
        self.connectTableViewDependencies()
    }

    private func connectTableViewDependencies() {

        self.customView.tableView.delegate = self
        self.dataSource.regicterNibsForTableView(tableView: self.customView.tableView)
        self.customView.tableView.dataSource = self.dataSource
    }

    // MARK: - Table view delegate

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath, animated: true)

        self.router?.navigateToSomeScreen(from: self, withBackgroundColor: UIColor.gray)
    }
}

// MARK: - AddObjectViewDelegate

extension AddObjectViewController: AddObjectViewDelegate {

    public func viewSomeAction(view: AddObjectViewProtocol) {
    }
}

// MARK: - AddObjectModelDelegate

extension AddObjectViewController: AddObjectModelDelegate {

    public func modelDidChanged(model: AddObjectModelProtocol) {
    }
}

// MARK: - AddObjectCellDelegate

extension AddObjectViewController: AddObjectCellDelegate {

    func cellDidTapSomeButton(cell: AddObjectTableViewCell) {
    }
}
