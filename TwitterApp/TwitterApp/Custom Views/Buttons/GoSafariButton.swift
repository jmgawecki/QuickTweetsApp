//
//  GoSafariButton.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 23/01/2021.
//

import UIKit

final class GoSafariButton: UIButton {
    
    
    //MARK:- Overrides

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Initialisers
    
    convenience init(title: String, isEnabled: Bool) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
        self.isEnabled = isEnabled

    }
    
    
    //MARK:- Configurations
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor         = .secondarySystemBackground
        titleLabel?.font        = UIFont.systemFont(ofSize: 17, weight: .light)
        setTitleColor(ColorsTwitter.twitterBlue, for: .normal)
    }
}
