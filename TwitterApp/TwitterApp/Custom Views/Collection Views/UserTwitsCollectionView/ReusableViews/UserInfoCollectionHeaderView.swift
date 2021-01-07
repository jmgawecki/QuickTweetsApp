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
    var forenameLabel       = TwitInfoHeaderTitleLabel()
    var usernameLabel             = TwitInfoHeaderBodyLabel()
    
    var locationLabel       = TwitInfoHeaderBodyLabel()
    var locationImage       = UIImageView()
    
    var birthDateLabel      = TwitInfoHeaderBodyLabel()
    var birthDateImage      = UIImageView()
    
    var followingCounter    = TwitInfoHeaderBodyLabel()
    var followingLabel      = TwitInfoHeaderBodyLabel()
    
    var followersCounter    = TwitInfoHeaderBodyLabel()
    var followersLabel      = TwitInfoHeaderBodyLabel()
    
    var bodyLabels: [TwitInfoHeaderBodyLabel]   = []
    var images: [UIImageView]                   = []
    
    //MARK: - Overrides
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
        configureUIElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //MARK: - Configurations
    
    private func configure() {
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
       
    }
    
    private func configureUIElements() {
        avatarImageView.image = UIImage(named: "TwitterLogo")
        forenameLabel.text = "User's Forename"
        usernameLabel.text = "User's username"
        
        locationLabel.text = "Location"
        locationImage.image = UIImage(systemName: "location")
        
        birthDateLabel.text = "05/12/1996"
        birthDateImage.image = UIImage(systemName:"calendar.circle.fill")
        
        followingCounter.text = "35"
        followingLabel.text = "Following"
        
        followersCounter.text = "120"
        followersLabel.text = "Followers"
    }

    
    

    //MARK: - Layout configuration

    private func layoutUI() {
        bodyLabels  = [usernameLabel, locationLabel, birthDateLabel, followingCounter, followingLabel, followersCounter, followersLabel]
        images      = [locationImage, birthDateImage]
        
        addSubview(forenameLabel)
        addSubview(avatarImageView)
        
        for label in bodyLabels {
            addSubview(label)
        }
        for image in images     {
            addSubview(image)
            image.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let paddingUpDown: CGFloat = 5
        let paddingLeftRight: CGFloat = 10
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: paddingLeftRight),
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: paddingUpDown),
            avatarImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.40),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            forenameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: paddingUpDown),
            forenameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: paddingLeftRight),
            forenameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -paddingLeftRight),
            forenameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.10),

            usernameLabel.topAnchor.constraint(equalTo: forenameLabel.bottomAnchor, constant: paddingUpDown),
            usernameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: paddingLeftRight),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -paddingLeftRight),
            usernameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.10),

            followingCounter.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: paddingUpDown),
            followingCounter.leadingAnchor.constraint(equalTo: leadingAnchor, constant: paddingLeftRight),
            followingCounter.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1),
            followingCounter.heightAnchor.constraint(equalTo: followingCounter.widthAnchor),

            followingLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: paddingUpDown),
            followingLabel.leadingAnchor.constraint(equalTo: followingCounter.trailingAnchor, constant: paddingLeftRight),
            followingLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.37),
            followingLabel.heightAnchor.constraint(equalTo: followingCounter.heightAnchor),

            followersCounter.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: paddingUpDown),
            followersCounter.leadingAnchor.constraint(equalTo: followingLabel.trailingAnchor, constant: paddingLeftRight),
            followersCounter.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.1),
            followersCounter.heightAnchor.constraint(equalTo: followingCounter.heightAnchor),

            followersLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: paddingUpDown),
            followersLabel.leadingAnchor.constraint(equalTo: followersCounter.trailingAnchor, constant: paddingLeftRight),
            followersLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.37),
            followersLabel.heightAnchor.constraint(equalTo: followingCounter.heightAnchor),
            followersLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10), /// That one estimates the size of the header

            locationImage.topAnchor.constraint(equalTo: topAnchor, constant: paddingUpDown),
            locationImage.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: paddingLeftRight),
            locationImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.08),
            locationImage.heightAnchor.constraint(equalTo: locationImage.widthAnchor),

            locationLabel.topAnchor.constraint(equalTo: topAnchor, constant: paddingUpDown),
            locationLabel.leadingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: paddingLeftRight),
            locationLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -paddingLeftRight),
            locationLabel.heightAnchor.constraint(equalTo: locationImage.heightAnchor),

            birthDateImage.topAnchor.constraint(equalTo: locationImage.bottomAnchor, constant: paddingUpDown),
            birthDateImage.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: paddingLeftRight),
            birthDateImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.08),
            birthDateImage.heightAnchor.constraint(equalTo: locationImage.heightAnchor),

            birthDateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: paddingUpDown),
            birthDateLabel.leadingAnchor.constraint(equalTo: birthDateImage.trailingAnchor, constant: paddingLeftRight),
            birthDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -paddingLeftRight),
            birthDateLabel.heightAnchor.constraint(equalTo: birthDateImage.heightAnchor),
        ])
    }
    
    
}
