//
//  TwitTwitsCell.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 04/01/2021.
//

import UIKit

class TwitsCell: UICollectionViewCell {
    
    static let reuseId      = "cell"
    
    let avatarImage         = TwitImageView(frame: .zero)
    let usernameLabel       = UserResultLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with message: String) {
        usernameLabel.text  = message
    }
    
    private func layoutUI() {
        addSubview(avatarImage)
        addSubview(usernameLabel)
        avatarImage.image   = TwitterPNGs.twitterLogoBlueOnWhite
        
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            avatarImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            avatarImage.widthAnchor.constraint(equalTo: avatarImage.heightAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            usernameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 15),
        ])
    }
}
