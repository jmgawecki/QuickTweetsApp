//
//  FavoritesCollectionHeader.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 10/01/2021.
//

import UIKit
#warning("refactor protocol - delete indexPath passed")
protocol FavoritesCollectionHeaderDelegates: class {
    func didRemoveUserFromFavorites(index: IndexPath, user: User)
}


class FavoritesCollectionHeader: UICollectionReusableView {
    
    static let reuseId              = "FavoritesUsersHeaderView"
        
    var removeFromFavoritesButton   = RemoveFromFavButton(title: "Remove")
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
        backgroundColor = .systemBackground
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
        removeFromFavoritesButton.addTarget(self, action: #selector(removeFromFavoritesTapped), for: .touchUpInside)
        
    }
    
    

    //MARK: - Layout configuration

    private func layoutUI() {
        addSubview(removeFromFavoritesButton)
        addSubview(avatarImageView)
        addSubview(forenameLabel)
        addSubview(usernameLabel)
        
        let paddingUpDown: CGFloat = 5
        
        NSLayoutConstraint.activate([
            removeFromFavoritesButton.topAnchor.constraint          (equalTo: topAnchor, constant: 5),
            removeFromFavoritesButton.trailingAnchor.constraint     (equalTo: trailingAnchor, constant: -5),
            removeFromFavoritesButton.heightAnchor.constraint       (equalToConstant: 50),
            removeFromFavoritesButton.widthAnchor.constraint        (equalToConstant: 80),
            
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
