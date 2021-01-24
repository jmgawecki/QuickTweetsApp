//
//  AlertContainerView.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 24/01/2021.
//

import UIKit

final class AlertContainerView: UIView {


    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        backgroundColor       = .systemBackground
        layer.cornerRadius    = 16
        layer.borderWidth     = 2
        layer.borderColor     = UIColor.white.cgColor
        translatesAutoresizingMaskIntoConstraints = false
    }
}
