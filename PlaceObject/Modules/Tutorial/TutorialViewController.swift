//
//  TutorialViewController.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/27/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

public typealias TutorialViewControllerType = MVCViewController<TutorialModelProtocol, TutorialViewProtocol, TutorialRouter>

public class TutorialViewController: TutorialViewControllerType, UITableViewDelegate {

    private var dataSource: TutorialDataSource!

    // MARK: - Initializers
    convenience init(withView view: TutorialViewProtocol, model: TutorialModelProtocol, router: TutorialRouter, dataSource: TutorialDataSource) {

        self.init(withView: view, model: model, router: router)

        self.model.delegate = self

        self.dataSource = dataSource
        self.dataSource.cellDelegate = self
    }

    public required init(withView view: TutorialViewProtocol!, model: TutorialModelProtocol!, router: TutorialRouter?) {
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
    }
}

// MARK: - TutorialViewDelegate
extension TutorialViewController: TutorialViewDelegate {}

// MARK: - TutorialModelDelegate
extension TutorialViewController: TutorialModelDelegate {}

// MARK: - TutorialCellDelegate
extension TutorialViewController: TutorialCellDelegate {}
