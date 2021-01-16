//
//  ViewController+Ext.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 16/01/2021.
//

import UIKit

extension UIViewController {
    func presentEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = FavoritesEmptyStateView(with: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
