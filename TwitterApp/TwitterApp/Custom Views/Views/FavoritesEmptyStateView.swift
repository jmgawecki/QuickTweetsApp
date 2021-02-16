//
//  FavoritesEmptyStateView.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 15/01/2021.
//

import UIKit

class FavoritesEmptyStateView: UIView {
    //MARK: - Declarations
    
    
    let messageLabel        = UILabel()
    
    let twitterLogoView     = TwitImageView(frame: .zero)
    let twitterLogoViewTop  = TwitImageView(frame: .zero)
    
    
    //MARK:- Overrides

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        configureUI()
        layoutUI()
        animate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:- Initialisers
    
    
    convenience init(with message: String) {
        self.init(frame: .zero)
        messageLabel.text = message
    }
    
    
    //MARK:- Animations
    
    
    private func animate() {
        alpha = 0
        UIView.animate(withDuration: 0.5) { self.alpha = 1.0}
    }
    
    
    //MARK:- Layout configuration
    
    
    private func configureCell() {
        backgroundColor = .systemBackground
    }
    
    
    private func configureUI() {
        messageLabel.font                       = UIFont.preferredFont(forTextStyle: .largeTitle)
        messageLabel.numberOfLines              = 4
        messageLabel.adjustsFontSizeToFitWidth  = true
        messageLabel.textColor                  = ColorsTwitter.twitterBlue
        twitterLogoView.image                   = Images.twitterLogo
        twitterLogoViewTop.image                = Images.twitterLogo
    }
    
    
    private func layoutUI() {
        addSubviews(messageLabel, twitterLogoView, twitterLogoViewTop)
        tamicToFalse(messageLabel)
        
        NSLayoutConstraint.activate([
            twitterLogoViewTop.centerXAnchor.constraint (equalTo: centerXAnchor, constant: 0),
            twitterLogoViewTop.centerYAnchor.constraint (equalTo: centerYAnchor, constant: -80),
            twitterLogoViewTop.widthAnchor.constraint   (equalToConstant: 100),
            twitterLogoViewTop.heightAnchor.constraint  (equalTo: twitterLogoViewTop.widthAnchor),
            
            messageLabel.topAnchor.constraint           (equalTo: twitterLogoViewTop.bottomAnchor, constant: -10),
            messageLabel.heightAnchor.constraint        (equalToConstant: 200),
            messageLabel.leadingAnchor.constraint       (equalTo: leadingAnchor, constant: 15),
            messageLabel.trailingAnchor.constraint      (equalTo: trailingAnchor, constant: -15),
        
            twitterLogoView.centerXAnchor.constraint    (equalTo: centerXAnchor, constant: 0),
            twitterLogoView.centerYAnchor.constraint    (equalTo: centerYAnchor, constant: 450),
            twitterLogoView.widthAnchor.constraint      (equalToConstant: 500),
            twitterLogoView.heightAnchor.constraint     (equalTo: twitterLogoView.widthAnchor),
        ])
    }
}
