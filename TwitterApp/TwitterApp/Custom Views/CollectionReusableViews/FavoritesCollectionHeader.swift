//
//  FavoritesCollectionHeader.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 10/01/2021.
//

import UIKit

protocol FavoritesCollectionHeaderDelegates: class {
    func didRemoveUserFromFavorites(index: IndexPath, user: User)
}


class FavoritesCollectionHeader: UICollectionReusableView {
    
    static let reuseId              = "FavoritesUsersHeaderView"
        
    var removeFromFavoritesButton   = UIButton()
    var avatarImageView             = TwitProfilePictureImageView(frame: .zero)
    var forenameLabel               = TwitInfoHeaderTitleLabel()
    var usernameLabel               = TwitInfoHeaderBodyLabel(textAlignment: .center)
    
    var bodyLabels: [TwitInfoHeaderBodyLabel]   = []
    var images: [UIImageView]                   = []
    
    var delegate: FavoritesCollectionHeaderDelegates!
    var index: IndexPath!
    var user: User!
    
    //MARK: - Overrides
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
        configureRemoveFromFavoritesButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //MARK: - Configurations
    
    @objc private func removeFromFavoritesTapped() {
        delegate.didRemoveUserFromFavorites(index: index, user: user)
    }
    
    func set(with user: User, index: IndexPath) {
        avatarImageView.downloadImage(from: user.profileImageUrl!)
        forenameLabel.text          = user.name
        usernameLabel.text          = user.screenName
        self.index                  = index
        self.user                   = user
    }
    
    private func configure() {
        backgroundColor             = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureRemoveFromFavoritesButton() {
        #warning("refactor strings to constants")
        removeFromFavoritesButton.setImage(UIImage(systemName: "minus"), for: .normal)
        removeFromFavoritesButton.tintColor = ColorsTwitter.twitterBlue
        removeFromFavoritesButton.addTarget(self, action: #selector(removeFromFavoritesTapped), for: .touchUpInside)
        
    }
    
    

    //MARK: - Layout configuration

    private func layoutUI() {
        addSubview(removeFromFavoritesButton)
        addSubview(avatarImageView)
        addSubview(forenameLabel)
        addSubview(usernameLabel)
        removeFromFavoritesButton.translatesAutoresizingMaskIntoConstraints = false
        
        let paddingUpDown: CGFloat = 5
        
        NSLayoutConstraint.activate([
            removeFromFavoritesButton.topAnchor.constraint          (equalTo: topAnchor, constant: 5),
            removeFromFavoritesButton.trailingAnchor.constraint     (equalTo: trailingAnchor, constant: -5),
            removeFromFavoritesButton.heightAnchor.constraint       (equalToConstant: 30),
            removeFromFavoritesButton.widthAnchor.constraint        (equalTo: removeFromFavoritesButton.heightAnchor),
            
            avatarImageView.topAnchor.constraint                    (equalTo: topAnchor, constant: 0),
            avatarImageView.centerXAnchor.constraint                (equalTo: centerXAnchor),
            avatarImageView.widthAnchor.constraint                  (equalTo: widthAnchor, multiplier: 0.40),
            avatarImageView.heightAnchor.constraint                 (equalTo: avatarImageView.widthAnchor),
    
            forenameLabel.topAnchor.constraint                      (equalTo: avatarImageView.bottomAnchor, constant: paddingUpDown),
            forenameLabel.centerXAnchor.constraint                  (equalTo: centerXAnchor),
            forenameLabel.widthAnchor.constraint                    (equalTo: widthAnchor, multiplier: 0.6),
            forenameLabel.heightAnchor.constraint                   (equalTo: heightAnchor, multiplier: 0.10),

            usernameLabel.topAnchor.constraint                      (equalTo: forenameLabel.bottomAnchor, constant: paddingUpDown),
            usernameLabel.centerXAnchor.constraint                  (equalTo: centerXAnchor),
            usernameLabel.widthAnchor.constraint                    (equalTo: widthAnchor, multiplier: 0.6),
            usernameLabel.heightAnchor.constraint                   (equalTo: heightAnchor, multiplier: 0.10),
        ])
    }
}
