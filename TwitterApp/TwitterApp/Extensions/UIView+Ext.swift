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
    
    /// Sets translatesAutoresizingMaskIntoConstraints = false for the array of UIViews specified in a function
    func tamicToFalse(_ views: UIView...) {
        for view in views { view.translatesAutoresizingMaskIntoConstraints = false }
    }
}
