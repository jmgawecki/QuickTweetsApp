//
//  UIView+Ext.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 24/01/2021.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
    
    func debugConfiguration(_ views: UIView...) {
        for view in views {
            view.layer.borderWidth = 1 }
    }
    
    func tamic(_ views: UIView...) {
        for view in views { view.translatesAutoresizingMaskIntoConstraints = false }
    }
}
