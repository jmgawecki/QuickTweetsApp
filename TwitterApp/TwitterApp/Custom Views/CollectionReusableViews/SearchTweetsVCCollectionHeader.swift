//
//  UserInfoCollectionHeaderView.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 04/01/2021.
//

import UIKit

class SearchTweetsVCCollectionHeader: UICollectionReusableView {
    // MARK: - Declarations
    
    
    static let reuseId  = "UserTwitsHeaderView"
        
    var backgroundImageView = BackgroundPictureImageView(frame: .zero)
    var avatarImageView     = TwitProfilePictureImageView(frame: .zero)
    var forenameLabel       = TwitInfoHeaderTitleLabel()
    var usernameLabel       = TwitInfoHeaderBodyLabel(textAlignment: .center)
    
    var followStackView     = UIStackView()
    var followerView        = SearchTweetUserInfoView()
    var followingView       = SearchTweetUserInfoView()
    
    var bodyLabels: [TwitInfoHeaderBodyLabel]   = []
    var images:     [UIImageView]               = []

    
    //MARK: - Initialisers
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        configureStackViews()
        layoutUI()
    }
    
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    // MARK: - Called outside
    
    
    func set(with user: User) {
        let backgroundPictureUrl = user.profileBackgroundUrl
        if backgroundPictureUrl != nil { backgroundImageView.downloadImage(from: backgroundPictureUrl!) }
        avatarImageView.downloadImage(from: user.profileImageUrl!)
        forenameLabel.text              = user.name
        usernameLabel.text              = "@\(user.screenName)"
        followerView.set(itemInfoType:  .followers, with: user.followersCount.convertToKMFormatStr())
        followingView.set(itemInfoType: .following, with: user.followingCount.convertToKMFormatStr())
    }
    

    //MARK: - Configurations
    
    
    private func configure() {
        backgroundColor         = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
    }

    
    private func configureStackViews() {
        followStackView.axis            = .horizontal
        followStackView.distribution    = .equalSpacing

        followStackView.addArrangedSubview(followerView)
        followStackView.addArrangedSubview(followingView)
    }
    

    //MARK: - Layout configuration

    
    private func layoutUI() {
        addSubviews(forenameLabel, usernameLabel, backgroundImageView, avatarImageView, followStackView)
        
        followStackView.backgroundColor     = .systemBackground
        followStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let paddingUpDown: CGFloat          = 5
        let followStackViewWidth: CGFloat   = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 250 : 300
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint        (equalTo: topAnchor, constant: -30),
            avatarImageView.centerXAnchor.constraint    (equalTo: centerXAnchor),
            avatarImageView.widthAnchor.constraint      (equalTo: widthAnchor, multiplier: 0.40),
            avatarImageView.heightAnchor.constraint     (equalTo: avatarImageView.widthAnchor),
            
            forenameLabel.topAnchor.constraint          (equalTo: avatarImageView.bottomAnchor, constant: paddingUpDown),
            forenameLabel.centerXAnchor.constraint      (equalTo: centerXAnchor),
            forenameLabel.widthAnchor.constraint        (equalTo: widthAnchor, multiplier: 0.6),
            forenameLabel.heightAnchor.constraint       (equalTo: heightAnchor, multiplier: 0.10),
            
            usernameLabel.topAnchor.constraint          (equalTo: forenameLabel.bottomAnchor, constant: paddingUpDown),
            usernameLabel.centerXAnchor.constraint      (equalTo: centerXAnchor),
            usernameLabel.widthAnchor.constraint        (equalTo: widthAnchor, multiplier: 0.6),
            usernameLabel.heightAnchor.constraint       (equalTo: heightAnchor, multiplier: 0.10),

            followStackView.topAnchor.constraint        (equalTo: usernameLabel.bottomAnchor, constant: 10),
            followStackView.centerXAnchor.constraint    (equalTo: centerXAnchor),
            followStackView.widthAnchor.constraint      (equalToConstant: followStackViewWidth),
            followStackView.heightAnchor.constraint     (equalToConstant: 50),
        ])
    }
}
