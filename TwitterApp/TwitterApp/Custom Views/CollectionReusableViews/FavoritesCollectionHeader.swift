//
//  FavoritesCollectionHeader.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 10/01/2021.
//

import UIKit

// MARK: - Protocols and delegates


protocol FavoritesCollectionHeaderDelegates: class {
    func didRemoveUserFromFavorites(user: User)
}


final class FavoritesCollectionHeader: UICollectionReusableView {
    // MARK: - Declarations
    
    
    static let reuseId          = "FavoritesUsersHeaderView"
            
    var removeFromFavButton     = RemoveFromFavButton(title: TweetStrings.removeFromFav)
    var profileImgView          = TwitProfilePictureImageView(frame: .zero)
    var forenameLabel           = TwitInfoHeaderTitleLabel()
    var usernameLabel           = TwitInfoHeaderBodyLabel(textAlignment: .center)
    
    var bodyLabels:             [TwitInfoHeaderBodyLabel]   = []
    var images:                 [UIImageView]               = []
    
    weak var delegate:          FavoritesCollectionHeaderDelegates!
    var user:                   User!
    
    
    //MARK: - Initialisers
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        configure()
        layoutUI()
        configureRemoveFromFavoritesButton()
    }
    
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    

    //MARK: - Objectives
    
    
    @objc private func removeFromFavoritesTapped() {
        delegate.didRemoveUserFromFavorites(user: user)
    }
    
    
    // MARK: - Called outside
    
    
    func set(with user: User) {
        profileImgView.downloadImage(from: user.profileImageUrl!)
        forenameLabel.text          = user.name
        usernameLabel.text          = user.screenName
        self.user                   = user
    }
    
    
    // MARK: - ReusableView Configrations
    
    
    private func configure() {
        backgroundColor             = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    private func configureRemoveFromFavoritesButton() {
        removeFromFavButton.addTarget(self, action: #selector(removeFromFavoritesTapped), for: .touchUpInside)
    }
    

    //MARK: - Layout configuration

    
    private func layoutUI() {
        addSubviews(removeFromFavButton, profileImgView, forenameLabel, usernameLabel)
        
        let padding: CGFloat = 5
        
        NSLayoutConstraint.activate([
            removeFromFavButton.topAnchor.constraint        (equalTo: topAnchor, constant: 5),
            removeFromFavButton.trailingAnchor.constraint   (equalTo: trailingAnchor, constant: -5),
            removeFromFavButton.heightAnchor.constraint     (equalToConstant: 50),
            removeFromFavButton.widthAnchor.constraint      (equalToConstant: 80),
            
            profileImgView.topAnchor.constraint             (equalTo: topAnchor, constant: 0),
            profileImgView.centerXAnchor.constraint         (equalTo: centerXAnchor),
            profileImgView.widthAnchor.constraint           (equalTo: widthAnchor, multiplier: 0.40),
            profileImgView.heightAnchor.constraint          (equalTo: profileImgView.widthAnchor),
    
            forenameLabel.topAnchor.constraint              (equalTo: profileImgView.bottomAnchor, constant: padding),
            forenameLabel.centerXAnchor.constraint          (equalTo: centerXAnchor),
            forenameLabel.widthAnchor.constraint            (equalTo: widthAnchor, multiplier: 0.6),
            forenameLabel.heightAnchor.constraint           (equalTo: heightAnchor, multiplier: 0.10),

            usernameLabel.topAnchor.constraint              (equalTo: forenameLabel.bottomAnchor, constant: padding),
            usernameLabel.centerXAnchor.constraint          (equalTo: centerXAnchor),
            usernameLabel.widthAnchor.constraint            (equalTo: widthAnchor, multiplier: 0.6),
            usernameLabel.heightAnchor.constraint           (equalTo: heightAnchor, multiplier: 0.10),
        ])
    }
}
