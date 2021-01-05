//
//  TwitTextField.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 28/12/2020.
//

import UIKit

class TwitTextField: UITextField {
    
    
    
    //MARK: - Overrides

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //MARK: - Configurations

    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 15
        layer.borderWidth = 2
        placeholder = "Enter username.."
        font = UIFont.systemFont(ofSize: 25, weight: .regular)
        
        returnKeyType = .search
        autocorrectionType = .no
    }
}
