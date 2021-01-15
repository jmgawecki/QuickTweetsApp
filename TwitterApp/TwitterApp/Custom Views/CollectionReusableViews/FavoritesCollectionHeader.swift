//
//  FavoritesCollectionHeader.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 10/01/2021.
//

import UIKit

class FavoritesCollectionHeader: UICollectionReusableView {
    
    static let reuseId      = "FavoritesUsersHeaderView"
        
    var avatarImageView     = TwitProfilePictureImageView(frame: .zero)
    var forenameLabel       = TwitInfoHeaderTitleLabel()
    var usernameLabel       = TwitInfoHeaderBodyLabel(textAlignment: .center)
    
   
    
    
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
    
    func set(with user: User) {
        avatarImageView.image       = UIImage(named: "myProfile")
        forenameLabel.text          = user.name
        usernameLabel.text          = user.screenName
    }
    
    private func configure() {
        backgroundColor             = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    

    //MARK: - Layout configuration

    private func layoutUI() {
        addSubview(avatarImageView)
        addSubview(forenameLabel)
        addSubview(usernameLabel)
        
        let paddingUpDown: CGFloat = 5
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            avatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            avatarImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.40),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
    
            forenameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: paddingUpDown),
            forenameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            forenameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            forenameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.10),

            usernameLabel.topAnchor.constraint(equalTo: forenameLabel.bottomAnchor, constant: paddingUpDown),
            usernameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            usernameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.6),
            usernameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.10),
        ])
    }
}
