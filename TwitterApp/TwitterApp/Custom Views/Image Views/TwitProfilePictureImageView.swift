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
    
    func downloadImage(from URLString: String) {
        NetworkManager.shared.downloadImage(from: URLString) { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image = image }
        }
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
