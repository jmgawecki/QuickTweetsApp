//
//  FavoriteTwitsCell.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 10/01/2021.
//

import UIKit

class FavoriteTweetsCell: UICollectionViewCell {
    
    static let reuseId      = "FavoriteTwitsCell"
    
    var avatarImageView     = TwitProfilePictureImageView(frame: .zero)
    var forenameLabel       = TwitInfoHeaderTitleLabel(from: .left)
    
    let timeDateLabel       = UILabel()
    let tweetBodyLabel      = UserSearchVCTextView()

    let mediaStackView      = UIStackView()
    let commentView         = SearchTweetsMediaInfoView()
    let sharesView          = SearchTweetsMediaInfoView()
    let likesView           = SearchTweetsMediaInfoView()
    
    
    //MARK: - Overrides
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
//        debugConfiguration()
        configureUIElements()
        addSubviews()
        layoutUI()
        configureMediaStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Configurations
    
    func set(with tweet: Tweet) {
        #warning("fix comment, shares, likes later, add authors profile picture into tweets network call")
        //        avatarImageView.downloadImage(from: tweet)
        tweetBodyLabel.text             = tweet.tweetText
        timeDateLabel.text              = tweet.createdAt
        forenameLabel.text              = tweet.user
        
        commentView.set(itemInfoType:   .comments,  with: Int(tweet.retweetCounter))
        sharesView.set(itemInfoType:    .shares,    with:  Int(tweet.retweetCounter))
        likesView.set(itemInfoType:     .likes,     with: Int(tweet.retweetCounter))
    }
    
    
    private func configureCell() {
        backgroundColor         = .secondarySystemBackground
        layer.cornerRadius      = 15
    }
    
    
    private func debugConfiguration() {
        tweetBodyLabel.layer.borderWidth    = 1
        mediaStackView.layer.borderWidth    = 1
        timeDateLabel.layer.borderWidth     = 1
        avatarImageView.layer.borderWidth   = 1
        forenameLabel.layer.borderWidth     = 1
    }
    
    
    private func configureMediaStackView() {
        mediaStackView.axis                 = .horizontal
        mediaStackView.distribution         = .equalSpacing
        mediaStackView.alignment            = .center
        
        mediaStackView.addArrangedSubview(commentView)
        mediaStackView.addArrangedSubview(sharesView)
        mediaStackView.addArrangedSubview(likesView)
    }
    
    
    private func configureUIElements() {
        timeDateLabel.textColor             = .systemGray
        timeDateLabel.textAlignment         = .left
    }
    
    private func addSubviews() {
        addSubview(avatarImageView)
        addSubview(forenameLabel)
        addSubview(timeDateLabel)
        addSubview(tweetBodyLabel)
        addSubview(mediaStackView)
    }

    
    private func layoutUI() {
        mediaStackView.translatesAutoresizingMaskIntoConstraints    = false
        timeDateLabel.translatesAutoresizingMaskIntoConstraints     = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            avatarImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.25),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            forenameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 0),
            forenameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 0),
            forenameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            forenameLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.10),
            
            timeDateLabel.topAnchor.constraint(equalTo: forenameLabel.bottomAnchor, constant: 0),
            timeDateLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 0),
            timeDateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            timeDateLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.1),
            
            mediaStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            mediaStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            mediaStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            mediaStackView.heightAnchor.constraint(equalToConstant: 60),
            
            tweetBodyLabel.topAnchor.constraint(equalTo: timeDateLabel.bottomAnchor, constant: 0),
            tweetBodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tweetBodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            tweetBodyLabel.bottomAnchor.constraint(equalTo: mediaStackView.topAnchor, constant: 0),
        ])
    }
}
