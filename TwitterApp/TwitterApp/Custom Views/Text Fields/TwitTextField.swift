//
//  TwitTextField.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 28/12/2020.
//

import UIKit

final class TwitTextField: UITextField {
    
    
    
    //MARK: - Overrides

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureKeyboardToolbar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:- Objectives
    
    @objc private func barButtonTapped() {
        resignFirstResponder()
    }
    
    //MARK: - Configurations
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor         = .systemBackground
        
        layer.cornerRadius      = 15
        layer.borderWidth       = 2
        layer.borderColor       = ColorsTwitter.twitterDarkGray.cgColor
        
        placeholder             = "Enter username.."
        font                    = UIFont.systemFont(ofSize: 20, weight: .regular)
        
        textAlignment           = .center
        returnKeyType           = .search
        autocorrectionType      = .no
        autocapitalizationType  = .none
    }
    
    private func configureKeyboardToolbar() {
        let toolbar         = UIToolbar()
        let flexibleSpace   = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done            = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(barButtonTapped))
        toolbar.items = [flexibleSpace, done]
        toolbar.sizeToFit()
        inputAccessoryView = toolbar
    }
}
