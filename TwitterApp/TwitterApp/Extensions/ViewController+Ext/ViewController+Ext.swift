//
//  ViewController+Ext.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 16/01/2021.
//

import UIKit
import SafariServices

extension UIViewController {
    func presentEmptyStateView(with message: String, in view: UIView) {
        let emptyStateView = FavoritesEmptyStateView(with: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
    func animateButtonsView(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn) {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        } completion: { (_) in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: { viewToAnimate.transform = CGAffineTransform.init(scaleX: 1, y: 1) }, completion: nil)
        }
    }

}
