//
//  SettingsViewController.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/15/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

public typealias SettingsViewControllerType = MVCViewController<SettingsModelProtocol, SettingsViewProtocol, SettingsRouter>

public class SettingsViewController: SettingsViewControllerType, UITableViewDelegate {

    private var dataSource: SettingsDataSource!

    // MARK: - Initializers

    convenience init(withView view: SettingsViewProtocol, model: SettingsModelProtocol, router: SettingsRouter, dataSource: SettingsDataSource) {

        self.init(withView: view, model: model, router: router)

        self.model.delegate = self

        self.dataSource = dataSource
        self.dataSource.cellDelegate = self

        // your custom code
    }

    public required init(withView view: SettingsViewProtocol!, model: SettingsModelProtocol!, router: SettingsRouter?) {
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

// MARK: - SettingsViewDelegate

extension SettingsViewController: SettingsViewDelegate {

    public func viewSomeAction(view: SettingsViewProtocol) {
    }
}

// MARK: - SettingsModelDelegate

extension SettingsViewController: SettingsModelDelegate {

    public func modelDidChanged(model: SettingsModelProtocol) {
    }
}

// MARK: - SettingsCellDelegate

extension SettingsViewController: SettingsCellDelegate {

    func cellDidTapSomeButton(cell: SettingsTableViewCell) {
    }
}
