//
//  TwitUserInfoHeaderVC.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 28/12/2020.
//

import UIKit

class TwitUserInfoHeaderVC: UIViewController {

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
    var images:     [UIImageView]               = []
   
    
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        layoutUI()
    }
    
    



    //MARK: - @Objective functions

    
    


    //MARK: - Private Functions
    
    private func configureVC() {
        view.backgroundColor    = .systemBackground
        title                   = "User's Twits"
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    
    

    //MARK: - Layout configuration

    private func layoutUI() {
        bodyLabels  = [idLabel, locationLabel, birthDateLabel, followingCounter, followingLabel, followersCounter, followersLabel]
        images      = [locationImage, birthDateImage]
        
        view.addSubview(usernameLabel)
        view.addSubview(avatarImageView)
        usernameLabel.layer.borderWidth     = 2
        avatarImageView.layer.borderWidth   = 2
        
        for label in bodyLabels {
            view.addSubview(label)
            label.layer.borderWidth = 2
        }
        for image in images     {
            view.addSubview(image)
            image.layer.borderWidth = 2
            image.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let paddingUpDown:      CGFloat = 5
        let paddingLeftRight:   CGFloat = 5
        
        NSLayoutConstraint.activate([
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: paddingLeftRight),
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: paddingUpDown),
            avatarImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.45),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: paddingUpDown),
            usernameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: paddingLeftRight),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -paddingLeftRight),
            usernameLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.10),

            idLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: paddingUpDown),
            idLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: paddingLeftRight),
            idLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -paddingLeftRight),
            idLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.10),

            followingCounter.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: paddingUpDown),
            followingCounter.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: paddingLeftRight),
            followingCounter.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),
            followingCounter.heightAnchor.constraint(equalTo: followingCounter.widthAnchor),

            followingLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: paddingUpDown),
            followingLabel.leadingAnchor.constraint(equalTo: followingCounter.trailingAnchor, constant: paddingLeftRight),
            followingLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.40),
            followingLabel.heightAnchor.constraint(equalTo: followingCounter.heightAnchor),

            followersCounter.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: paddingUpDown),
            followersCounter.leadingAnchor.constraint(equalTo: followingLabel.trailingAnchor, constant: paddingLeftRight),
            followersCounter.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),
            followersCounter.heightAnchor.constraint(equalTo: followingCounter.heightAnchor),

            followersLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: paddingUpDown),
            followersLabel.leadingAnchor.constraint(equalTo: followersCounter.trailingAnchor, constant: paddingLeftRight),
            followersLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.40),
            followersLabel.heightAnchor.constraint(equalTo: followingCounter.heightAnchor),

            locationImage.topAnchor.constraint(equalTo: view.topAnchor, constant: paddingUpDown),
            locationImage.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: paddingLeftRight),
            locationImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),
            locationImage.heightAnchor.constraint(equalTo: locationImage.widthAnchor),

            locationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: paddingUpDown),
            locationLabel.leadingAnchor.constraint(equalTo: locationImage.trailingAnchor, constant: paddingLeftRight),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -paddingLeftRight),
            locationLabel.heightAnchor.constraint(equalTo: locationImage.heightAnchor),

            birthDateImage.topAnchor.constraint(equalTo: locationImage.bottomAnchor, constant: paddingUpDown),
            birthDateImage.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: paddingLeftRight),
            birthDateImage.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.1),
            birthDateImage.heightAnchor.constraint(equalTo: locationImage.heightAnchor),

            birthDateLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: paddingUpDown),
            birthDateLabel.leadingAnchor.constraint(equalTo: birthDateImage.trailingAnchor, constant: paddingLeftRight),
            birthDateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -paddingLeftRight),
            birthDateLabel.heightAnchor.constraint(equalTo: birthDateImage.heightAnchor),
        ])
        
    }
    
    
}
