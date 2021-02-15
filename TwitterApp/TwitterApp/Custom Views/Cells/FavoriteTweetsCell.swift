//
//  FavoriteTwitsCell.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 10/01/2021.
//

import UIKit

// MARK: - Protocols and Delegates


protocol FavoriteTweetsCellDelegate: class {
    func didRemoveTweetFromFavorites(tweet: FavoriteTweet)
}

protocol FavoriteTweetsCellSafariDelegates: class {
    func didRequestSafari(with urlString: String?)
}

class FavoriteTweetsCell: UICollectionViewCell {
    // MARK: - Declarations
    
    
    static let reuseId          = "FavoriteTwitsCell"
    
    var removeFavButton    = UIButton()
    
    var profileImgView         = TwitProfilePictureImageView(frame: .zero)
    var nameLabel           = TwitInfoHeaderTitleLabel(from: .left)
        
    let dateLabel           = UILabel()
    let tweetBodyLabel          = UserSearchVCTextView()
    
    let mediaStackView          = UIStackView()
    let sharesView              = CellMediaInfoView()
    let likesView               = CellMediaInfoView()
    var goSafariButton          = GoSafariButton()
    
    var favoriteTweet:          FavoriteTweet!
    
    weak var delegateSafari:    FavoriteTweetsCellSafariDelegates!
    weak var delegate:          FavoriteTweetsCellDelegate!
    
    
    //MARK: - Initialisers
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        configureUIElements()
        layoutUI()
        configureRemoveButton()
        configureGoSafariButton()
    }
    
    
    override func prepareForReuse() {
        self.goSafariButton.isHidden = false
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Objectives
    
    @objc private func removeButtonTapped() {
        delegate.didRemoveTweetFromFavorites(tweet: favoriteTweet)
    }
    
    
    @objc private func didTapGoSafariButton() {
        delegateSafari.didRequestSafari(with: favoriteTweet.urlToExpandWithSafari)
    }
    
    
    //MARK: - Called outside
    
    func set(with tweet: FavoriteTweet, buttonTitle: String?) {
        self.favoriteTweet            = tweet
        profileImgView.downloadImage(from: tweet.profileImageUrl!)
        tweetBodyLabel.text           = tweet.tweetText
        dateLabel.text                = tweet.createdAt.formatToTwitterPostDate()
        nameLabel.text                = tweet.name
            
        sharesView.set(itemInfoType:  .shares, with: tweet.retweetCounter.convertToKMFormatStr())
        likesView.set(itemInfoType:   .likes,  with: tweet.likesCounter.convertToKMFormatStr())
        
        if tweet.urlToExpandWithSafari == nil { goSafariButton.isEnabled = true }
        self.goSafariButton.setTitle(TweetStrings.seeFull, for: .normal)
    }
    
    
    //MARK: - Configuration
    
    
    private func configureCell() {
        backgroundColor                 = .secondarySystemBackground
        layer.cornerRadius              = 15
    }
    
    
    private func configureRemoveButton() {
        removeFavButton.setImage(Images.minus, for: .normal)
        removeFavButton.tintColor      = ColorsTwitter.twitterBlue
        removeFavButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
    }
    
    
    private func configureGoSafariButton() {
        goSafariButton.addTarget(self, action: #selector(didTapGoSafariButton), for: .touchUpInside)
    }
    
    
    private func configureUIElements() {
        dateLabel.textColor             = .systemGray
        dateLabel.textAlignment         = .left
        
        mediaStackView.axis             = .horizontal
        mediaStackView.distribution     = .equalSpacing
        mediaStackView.alignment        = .center
        
        mediaStackView.addArrangedSubview(sharesView)
        mediaStackView.addArrangedSubview(likesView)
    }
    
    
    //MARK:- Layout configuration
    
    
    private func layoutUI() {
        addSubviews(removeFavButton, profileImgView, nameLabel, dateLabel, tweetBodyLabel, mediaStackView, goSafariButton)
        tamic(mediaStackView, dateLabel, removeFavButton)
        
        let mediaLeadingPadding: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 10 : 30
        let mediaWidthMltp: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 0.55 : 0.5
        
        NSLayoutConstraint.activate([ //85 + 156 + 70
            removeFavButton.topAnchor.constraint        (equalTo: topAnchor, constant: 5),
            removeFavButton.trailingAnchor.constraint   (equalTo: trailingAnchor, constant: -5),
            removeFavButton.heightAnchor.constraint     (equalToConstant: 25),
            removeFavButton.widthAnchor.constraint      (equalTo: removeFavButton.heightAnchor),
                
            profileImgView.topAnchor.constraint         (equalTo: topAnchor, constant: 10),
            profileImgView.leadingAnchor.constraint     (equalTo: leadingAnchor, constant: 20),
            profileImgView.widthAnchor.constraint       (equalToConstant: 75),
            profileImgView.heightAnchor.constraint      (equalTo: profileImgView.widthAnchor),
                
            nameLabel.leadingAnchor.constraint          (equalTo: profileImgView.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint         (equalTo: removeFavButton.leadingAnchor, constant: 0),
            nameLabel.heightAnchor.constraint           (equalToConstant: 28),
            nameLabel.bottomAnchor.constraint           (equalTo: profileImgView.centerYAnchor),
                
            dateLabel.topAnchor.constraint              (equalTo: nameLabel.bottomAnchor, constant: 0),
            dateLabel.leadingAnchor.constraint          (equalTo: profileImgView.trailingAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint         (equalTo: removeFavButton.leadingAnchor, constant: 0),
            dateLabel.heightAnchor.constraint           (equalToConstant: 28),
                
            mediaStackView.bottomAnchor.constraint      (equalTo: bottomAnchor, constant: -10),
            mediaStackView.leadingAnchor.constraint     (equalTo: leadingAnchor, constant: mediaLeadingPadding),
            mediaStackView.widthAnchor.constraint       (equalTo: widthAnchor, multiplier: mediaWidthMltp),
            mediaStackView.heightAnchor.constraint      (equalToConstant: 60),
                
            goSafariButton.bottomAnchor.constraint      (equalTo: bottomAnchor, constant: -10),
            goSafariButton.leadingAnchor.constraint     (equalTo: mediaStackView.trailingAnchor, constant: 0),
            goSafariButton.trailingAnchor.constraint    (equalTo: trailingAnchor, constant: 0),
            goSafariButton.heightAnchor.constraint      (equalToConstant: 60),
            
            tweetBodyLabel.topAnchor.constraint         (equalTo: profileImgView.bottomAnchor, constant: 0),
            tweetBodyLabel.trailingAnchor.constraint    (equalTo: trailingAnchor, constant: -20),
            tweetBodyLabel.leadingAnchor.constraint     (equalTo: leadingAnchor, constant: 20),
            tweetBodyLabel.heightAnchor.constraint      (equalToConstant: 156),
        ])
    }
}
