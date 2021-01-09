//
//  TwitProfilePictureImageView.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 09/01/2021.
//

import UIKit

class TwitProfilePictureImageView: UIImageView {
    
    
    
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
        
        layer.borderWidth       = 2
        layer.borderColor       = ColorsTwitter.twitterDarkGray.cgColor
        layer.cornerRadius      = 75
        layer.masksToBounds     = true
        
        clipsToBounds           = true
        image                   = TwitterPNGs.twitterLogo
    }
}
