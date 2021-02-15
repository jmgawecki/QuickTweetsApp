//
//  RemoveFromFavButton.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 23/01/2021.
//

import UIKit

final class RemoveFromFavButton: UIButton {
    
    //MARK: - Overrides

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Initialisers
    
    
    convenience init(title: String) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
    }
    
    //MARK:- Configurations
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font      = UIFont.systemFont(ofSize: 15, weight: .semibold)
        backgroundColor       = .systemBackground
        setTitleColor(ColorsTwitter.twitterBlue, for: .normal)
    }
}
