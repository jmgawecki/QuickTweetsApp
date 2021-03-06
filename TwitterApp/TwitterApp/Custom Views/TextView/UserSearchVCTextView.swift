//
//  UserSearchVCTextView.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 10/01/2021.
//

import UIKit

final class UserSearchVCTextView: UITextView {
    //MARK: - Initialisers

    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configureTextView()
    }
    
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    //MARK: - Configurations

    
    private func configureTextView() {
        translatesAutoresizingMaskIntoConstraints = false
        isEditable          = false
        font                = UIFont.preferredFont(forTextStyle: .body)
        backgroundColor     = .secondarySystemBackground
    }
}
