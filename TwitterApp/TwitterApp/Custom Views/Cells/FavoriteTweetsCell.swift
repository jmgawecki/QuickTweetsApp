//
//  FavoriteTwitsCell.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 10/01/2021.
//

import UIKit

protocol FavoriteTweetsCellDelegate: class {
    func didRemoveTweetFromFavorites(tweet: FavoriteTweet)
}

protocol FavoriteTweetsCellSafariDelegates: class {
    func didRequestSafari(with urlString: String?)
}

class FavoriteTweetsCell: UICollectionViewCell {
    
    static let reuseId          = "FavoriteTwitsCell"
    
    var removeFavButton    = UIButton()
    
    var profileImgView         = TwitProfilePictureImageView(frame: .zero)
    var nameLabel           = TwitInfoHeaderTitleLabel(from: .left)
        
    let dateLabel           = UILabel()
    let tweetBodyLabel          = UserSearchVCTextView()
    
    let mediaStackView          = UIStackView()
    let sharesView              = CellMediaInfoView()
    let likesView               = CellMediaInfoView()
    var safariButton          = GoSafariButton()
    
    var favoriteTweet:          FavoriteTweet!
    
    weak var delegateSafari:    FavoriteTweetsCellSafariDelegates!
    weak var delegate:          FavoriteTweetsCellDelegate!
    
    
    //MARK: - Overrides
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        configureUIElements()
        layoutUI()
        configureRemoveButton()
        configureGoSafariButton()
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
    
    
    //MARK: - Functions called outside
    
    func set(with favoriteTweet: FavoriteTweet, buttonTitle: String?) {
        self.favoriteTweet            = favoriteTweet
        profileImgView.downloadImage(from: favoriteTweet.profileImageUrl!)
        tweetBodyLabel.text           = favoriteTweet.tweetText
        dateLabel.text                = favoriteTweet.createdAt.formatToTwitterPostDate()
        nameLabel.text                = favoriteTweet.name
            
        sharesView.set(itemInfoType:  .shares, with: favoriteTweet.retweetCounter.convertToKMFormatStr())
        likesView.set(itemInfoType:   .likes,  with: favoriteTweet.likesCounter.convertToKMFormatStr())
        
        if buttonTitle != nil {
            safariButton.setTitle(buttonTitle, for: .normal)
            safariButton.isEnabled    = true
        } else {
            safariButton.isEnabled    = false
        }
    }
    
    
    //MARK: - Private Functions
    
    private func configureRemoveButton() {
        removeFavButton.setImage(Images.minus, for: .normal)
        removeFavButton.tintColor      = ColorsTwitter.twitterBlue
        removeFavButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
    }
    
    
    private func configureGoSafariButton() {
        safariButton.addTarget(self, action: #selector(didTapGoSafariButton), for: .touchUpInside)
    }
    
    
    //MARK:- Layout
    
    private func configureCell() {
        backgroundColor                 = .secondarySystemBackground
        layer.cornerRadius              = 15
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
    
    
    private func layoutUI() {
        addSubviews(removeFavButton, profileImgView, nameLabel, dateLabel, tweetBodyLabel, mediaStackView, safariButton)
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
                
            safariButton.bottomAnchor.constraint        (equalTo: bottomAnchor, constant: -10),
            safariButton.leadingAnchor.constraint       (equalTo: mediaStackView.trailingAnchor, constant: 0),
            safariButton.trailingAnchor.constraint      (equalTo: trailingAnchor, constant: 0),
            safariButton.heightAnchor.constraint        (equalToConstant: 60),
            
            tweetBodyLabel.topAnchor.constraint         (equalTo: profileImgView.bottomAnchor, constant: 0),
            tweetBodyLabel.trailingAnchor.constraint    (equalTo: trailingAnchor, constant: -20),
            tweetBodyLabel.leadingAnchor.constraint     (equalTo: leadingAnchor, constant: 20),
            tweetBodyLabel.heightAnchor.constraint      (equalToConstant: 156),
        ])
    }
}
