//
//  UserInfoCollectionHeaderView.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 04/01/2021.
//

import UIKit

class UserInfoCollectionHeaderView: UICollectionReusableView {
    
    static let reuseId  = "header"
        
    var avatarImageView     = TwitImageView(frame: .zero)
    var usernameLabel       = TwitInfoHeaderTitleLabel(frame: .zero)
    var idLabel             = TwitInfoHeaderBodyLabel(frame: .zero)
    
    var locationLabel       = TwitInfoHeaderBodyLabel(frame: .zero)
    var locationImage       = UIImageView()
    
    var birthDateLabel      = TwitInfoHeaderBodyLabel(frame: .zero)
    var birthDateImage      = UIImageView()
    
    var followingCounter    = TwitInfoHeaderBodyLabel(frame: .zero)
    var followingLabel      = TwitInfoHeaderBodyLabel(frame: .zero)
    
    var followersCounter    = TwitInfoHeaderBodyLabel(frame: .zero)
    var followersLabel      = TwitInfoHeaderBodyLabel(frame: .zero)
    
    var bodyLabels: [TwitInfoHeaderBodyLabel]   = []
    var images: [UIImageView]                   = []
    
    //MARK: - Overrides
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //MARK: - Configurations
    
    private func configure() {
        backgroundColor = .systemRed
        translatesAutoresizingMaskIntoConstraints = false
       
    }

    
    

    //MARK: - Layout configuration

    private func layoutUI() {
        bodyLabels  = [idLabel, locationLabel, birthDateLabel, followingCounter, followingLabel, followersCounter, followersLabel]
        images      = [locationImage, birthDateImage]
        
        addSubview(usernameLabel)
        usernameLabel.layer.borderWidth = 2
        addSubview(avatarImageView)
        avatarImageView.layer.borderWidth = 2
        
        for label in bodyLabels {
            addSubview(label)
            label.layer.borderWidth = 2
        }
        for image in images     {
            addSubview(image)
            image.layer.borderWidth = 2
            image.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let paddingUpDown: CGFloat = 5
        let paddingLeftRight: CGFloat = 5
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: paddingLeftRight),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: paddingUpDown),
            avatarImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.45),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: paddingUpDown),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: paddingLeftRight),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -paddingLeftRight),
            usernameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.10),

            idLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: paddingUpDown),
            idLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: paddingLeftRight),
            idLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -paddingLeftRight),
            idLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.10),

            followingCounter.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: paddingUpDown),
            followingCounter.leadingAnchor.constraint(equalTo: leadingAnchor, constant: paddingLeftRight),
            followingCounter.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1),
            followingCounter.heightAnchor.constraint(equalTo: followingCounter.widthAnchor),

            followingLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: paddingUpDown),
            followingLabel.leadingAnchor.constraint(equalTo: followingCounter.trailingAnchor, constant: paddingLeftRight),
            followingLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.40),
            followingLabel.heightAnchor.constraint(equalTo: followingCounter.heightAnchor),

            followersCounter.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: paddingUpDown),
            followersCounter.leadingAnchor.constraint(equalTo: followingLabel.trailingAnchor, constant: paddingLeftRight),
            followersCounter.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1),
            followersCounter.heightAnchor.constraint(equalTo: followingCounter.heightAnchor),

            followersLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: paddingUpDown),
            followersLabel.leadingAnchor.constraint(equalTo: followersCounter.trailingAnchor, constant: paddingLeftRight),
            followersLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.40),
            followersLabel.heightAnchor.constraint(equalTo: followingCounter.heightAnchor),

            locationImage.topAnchor.constraint(equalTo: topAnchor, constant: paddingUpDown),
            locationImage.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: paddingLeftRight),
            locationImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1),
            locationImage.heightAnchor.constraint(equalTo: locationImage.widthAnchor),

            locationLabel.topAnchor.constraint(equalTo: topAnchor, constant: paddingUpDown),
            locationLabel.leadingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: paddingLeftRight),
            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -paddingLeftRight),
            locationLabel.heightAnchor.constraint(equalTo: locationImage.heightAnchor),

            birthDateImage.topAnchor.constraint(equalTo: locationImage.bottomAnchor, constant: paddingUpDown),
            birthDateImage.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: paddingLeftRight),
            birthDateImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1),
            birthDateImage.heightAnchor.constraint(equalTo: locationImage.heightAnchor),

            birthDateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: paddingUpDown),
            birthDateLabel.leadingAnchor.constraint(equalTo: birthDateImage.trailingAnchor, constant: paddingLeftRight),
            birthDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -paddingLeftRight),
            birthDateLabel.heightAnchor.constraint(equalTo: birthDateImage.heightAnchor),
        ])
        
    }
    
    
}
