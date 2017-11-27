//
//  CameraRouter.swift
//  PlaceObject
//
//  Created by Andrei Momot on 11/15/17.
//  Copyright © 2017 Andrey Momot. All rights reserved.
//

import UIKit

public class CameraRouter: NSObject {
    
    func showPopover(fromVC: UIViewController, vc: UIViewController, size: CGSize, selector: Selector, title: String, button: UIButton) {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: selector)
        vc.navigationItem.rightBarButtonItem = barButtonItem
        vc.title = title
        
        let navigationController = UINavigationController(rootViewController: vc)
        navigationController.modalPresentationStyle = .popover
        navigationController.popoverPresentationController?.delegate = fromVC as? UIPopoverPresentationControllerDelegate
        navigationController.preferredContentSize = size
        fromVC.present(navigationController, animated: true, completion: nil)
        
        navigationController.popoverPresentationController?.sourceView = button
        navigationController.popoverPresentationController?.sourceRect = button.bounds
    }
}
