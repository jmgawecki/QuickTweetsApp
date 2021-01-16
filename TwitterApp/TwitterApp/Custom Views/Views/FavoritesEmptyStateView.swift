//
//  FavoritesEmptyStateView.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 15/01/2021.
//

import UIKit

class FavoritesEmptyStateView: UIView {
    #warning("refactor to custom later")
    let messageLabel    = UILabel()
    
    let twitterLogoView = TwitImageView(frame: .zero)
    let twitterLogoViewTop = TwitImageView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        configure()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(with message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    private func configure() {
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.font                       = UIFont.preferredFont(forTextStyle: .largeTitle)
        messageLabel.numberOfLines              = 4
        messageLabel.adjustsFontSizeToFitWidth  = true
        messageLabel.textColor                  = ColorsTwitter.twitterBlue
        twitterLogoView.image                   = TwitterPNGs.twitterLogo
        twitterLogoViewTop.image                = TwitterPNGs.twitterLogo
    }
    
    private func layoutUI() {
        addSubview(messageLabel)
        addSubview(twitterLogoView)
        addSubview(twitterLogoViewTop)
        
        NSLayoutConstraint.activate([
            twitterLogoViewTop.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            twitterLogoViewTop.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -80),
            twitterLogoViewTop.widthAnchor.constraint(equalToConstant: 100),
            twitterLogoViewTop.heightAnchor.constraint(equalTo: twitterLogoViewTop.widthAnchor),
            
            messageLabel.topAnchor.constraint(equalTo: twitterLogoViewTop.bottomAnchor, constant: -10),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            twitterLogoView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0),
            twitterLogoView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 450),
            twitterLogoView.widthAnchor.constraint(equalToConstant: 500),
            twitterLogoView.heightAnchor.constraint(equalTo: twitterLogoView.widthAnchor),
        ])
    }
}
