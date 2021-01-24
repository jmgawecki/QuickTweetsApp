//
//  FavoriteTwitsCell.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 10/01/2021.
//

import UIKit

protocol FavoriteTweetsCellDelegate: class {
    func didRemoveTweetFromFavorites(tweet: Tweet)
}

protocol FavoriteTweetsCellSafariDelegates: class {
    func didRequestSafari(with urlString: String?)
}

class FavoriteTweetsCell: UICollectionViewCell {
    
    static let reuseId      = "FavoriteTwitsCell"
    
    var removeFavoriteButton        = UIButton()
    
    var avatarImageView     = TwitProfilePictureImageView(frame: .zero)
    var forenameLabel       = TwitInfoHeaderTitleLabel(from: .left)
    
    let timeDateLabel       = UILabel()
    let tweetBodyLabel      = UserSearchVCTextView()

    let mediaStackView      = UIStackView()
    let commentView         = CellMediaInfoView()
    let sharesView          = CellMediaInfoView()
    let likesView           = CellMediaInfoView()
    var goSafariButton      = GoSafariButton()
    
    var tweet: Tweet!
    
    weak var delegateSafari: FavoriteTweetsCellSafariDelegates!
    weak var delegate: FavoriteTweetsCellDelegate!
    
    
    //MARK: - Overrides
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
//        debugConfiguration()
        configureUIElements()
        addSubviews()
        layoutUI()
        configureMediaStackView()
        configureRemoveButton()
        configureGoSafariButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Objectives
    
    @objc private func removeButtonTapped() {
        delegate.didRemoveTweetFromFavorites(tweet: tweet)
    }
    
    @objc private func didTapGoSafariButton() {
        delegateSafari.didRequestSafari(with: tweet.urlToExpandWithSafari)
    }
    
    //MARK: - Configurations
    
    func set(with tweet: Tweet, buttonTitle: String?, isEnabled: Bool) {
        #warning("fix comment, shares, likes later, add authors profile picture into tweets network call")
        self.tweet                          = tweet
        //        avatarImageView.downloadImage(from: tweet)
        tweetBodyLabel.text                 = tweet.tweetText
        timeDateLabel.text                  = tweet.createdAt.formatToTwitterPostDate()
        forenameLabel.text                  = tweet.user
            
        sharesView.set(itemInfoType:        .shares,    with:  tweet.retweetCounter.convertToKMFormattedString())
        likesView.set(itemInfoType:         .likes,     with:  tweet.likesCounter.convertToKMFormattedString())
        
        if buttonTitle != nil {
            goSafariButton.setTitle(buttonTitle, for: .normal)
            goSafariButton.isEnabled = true
        } else {
            goSafariButton.isEnabled = false
        }
    }
    
    private func configureRemoveButton() {
        removeFavoriteButton.setImage(UIImage(systemName: "minus"), for: .normal)
        removeFavoriteButton.tintColor      = ColorsTwitter.twitterBlue
        removeFavoriteButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
    }
    
    
    private func configureCell() {
        backgroundColor                     = .secondarySystemBackground
        layer.cornerRadius                  = 15
    }
    
    private func configureGoSafariButton() {
        goSafariButton.addTarget(self, action: #selector(didTapGoSafariButton), for: .touchUpInside)
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
        
        mediaStackView.addArrangedSubview(sharesView)
        mediaStackView.addArrangedSubview(likesView)
    }
    
    
    private func configureUIElements() {
        timeDateLabel.textColor             = .systemGray
        timeDateLabel.textAlignment         = .left
    }
    
    private func addSubviews() {
        addSubview(removeFavoriteButton)
        addSubview(avatarImageView)
        addSubview(forenameLabel)
        addSubview(timeDateLabel)
        addSubview(tweetBodyLabel)
        addSubview(mediaStackView)
        addSubview(goSafariButton)
    }

    
    private func layoutUI() {
        mediaStackView.translatesAutoresizingMaskIntoConstraints       = false
        timeDateLabel.translatesAutoresizingMaskIntoConstraints        = false
        removeFavoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            removeFavoriteButton.topAnchor.constraint       (equalTo: topAnchor, constant: 5),
            removeFavoriteButton.trailingAnchor.constraint  (equalTo: trailingAnchor, constant: -5),
            removeFavoriteButton.heightAnchor.constraint    (equalToConstant: 25),
            removeFavoriteButton.widthAnchor.constraint     (equalTo: removeFavoriteButton.heightAnchor),
            
            avatarImageView.topAnchor.constraint            (equalTo: topAnchor, constant: 0),
            avatarImageView.leadingAnchor.constraint        (equalTo: leadingAnchor, constant: 0),
            avatarImageView.widthAnchor.constraint          (equalTo: widthAnchor, multiplier: 0.25),
            avatarImageView.heightAnchor.constraint         (equalTo: avatarImageView.widthAnchor),
            
            forenameLabel.topAnchor.constraint              (equalTo: avatarImageView.topAnchor, constant: 0),
            forenameLabel.leadingAnchor.constraint          (equalTo: avatarImageView.trailingAnchor, constant: 10),
            forenameLabel.trailingAnchor.constraint         (equalTo: trailingAnchor, constant: 0),
            forenameLabel.heightAnchor.constraint           (equalTo: heightAnchor, multiplier: 0.10),
            
            timeDateLabel.topAnchor.constraint              (equalTo: forenameLabel.bottomAnchor, constant: 0),
            timeDateLabel.leadingAnchor.constraint          (equalTo: avatarImageView.trailingAnchor, constant: 10),
            timeDateLabel.trailingAnchor.constraint         (equalTo: trailingAnchor, constant: 0),
            timeDateLabel.heightAnchor.constraint           (equalTo: heightAnchor, multiplier: 0.1),
            
            mediaStackView.bottomAnchor.constraint          (equalTo: bottomAnchor, constant: -10),
            mediaStackView.leadingAnchor.constraint         (equalTo: leadingAnchor, constant: 30),
            mediaStackView.widthAnchor.constraint           (equalTo: widthAnchor, multiplier: 0.5),
            mediaStackView.heightAnchor.constraint          (equalToConstant: 60),
            
            goSafariButton.bottomAnchor.constraint          (equalTo: bottomAnchor, constant: -10),
            goSafariButton.leadingAnchor.constraint         (equalTo: mediaStackView.trailingAnchor, constant: 0),
            goSafariButton.trailingAnchor.constraint        (equalTo: trailingAnchor, constant: 0),
            goSafariButton.heightAnchor.constraint          (equalToConstant: 60),
            
            tweetBodyLabel.topAnchor.constraint             (equalTo: avatarImageView.bottomAnchor, constant: 0),
            tweetBodyLabel.trailingAnchor.constraint        (equalTo: trailingAnchor, constant: -20),
            tweetBodyLabel.leadingAnchor.constraint         (equalTo: leadingAnchor, constant: 20),
            tweetBodyLabel.bottomAnchor.constraint          (equalTo: mediaStackView.topAnchor, constant: 0),
        ])
    }
}
