//
//  FavoriteUsersCell.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 08/01/2021.
//

import UIKit

protocol FavoriteUsersCellDelegates: class {
    func didRequestSafari(with urlString: String?)
}

class FavoriteUsersCell: UICollectionViewCell {
    
    
    static let reuseId      = "cell"
                    
    let tweetBodyLabel      = UserSearchVCTextView()
    var mediaStackView      = UIStackView()
    var sharesView          = CellMediaInfoView()
    var likesView           = CellMediaInfoView()
    var timeDateLabel       = UILabel()
    var goSafariButton      = GoSafariButton()
    
    weak var delegateSafari: FavoriteUsersCellDelegates!
    var tweet: Tweet!
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        configureTimeDateLabel()
        layoutUI()
        configureMediaStackView()
        configureGoSafariButton()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        guard tweet.urlToExpandWithSafari != nil else {
            self.goSafariButton.isHidden = true
            goSafariButton.isEnabled = false
            return
        }
        self.goSafariButton.setTitle(TweetStrings.seeFull, for: .normal)
    }
    
    
    
    @objc private func didTapGoSafariButton() {
        delegateSafari.didRequestSafari(with: tweet.urlToExpandWithSafari)
    }
    
    
    
    func set(with tweet: Tweet, buttonTitle: String?, isEnabled: Bool) {
        self.tweet                          = tweet
        timeDateLabel.text                  = tweet.createdAt.formatToTwitterPostDate()
        tweetBodyLabel.text                 = tweet.tweetText
        
        sharesView.set(itemInfoType:        .shares,    with: tweet.retweetCounter.convertToKMFormatStr())
        likesView.set(itemInfoType:         .likes,     with: tweet.likesCounter.convertToKMFormatStr())
        
            }
    
    
    private func configureCell() {
        backgroundColor                     = .secondarySystemBackground
        layer.cornerRadius                  = 15
    }
    
    
    private func configureGoSafariButton() {
        goSafariButton.addTarget(self, action: #selector(didTapGoSafariButton), for: .touchUpInside)
    }
    
    
    private func configureMediaStackView() {
        mediaStackView.axis                 = .horizontal
        mediaStackView.distribution         = .equalSpacing
        mediaStackView.alignment            = .center
        
        mediaStackView.addArrangedSubview(sharesView)
        mediaStackView.addArrangedSubview(likesView)
    }
    
    
    private func configureTimeDateLabel() {
        timeDateLabel.textColor             = .systemGray
        timeDateLabel.textAlignment         = .center
    }
    
    
    private func layoutUI() {
        addSubviews(timeDateLabel, tweetBodyLabel, mediaStackView, goSafariButton)
        tamic(mediaStackView, timeDateLabel)
        
        let mediaLeadingPadding: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 10 : 30
        let mediaWidthMltp: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 0.55 : 0.5

        NSLayoutConstraint.activate([
            timeDateLabel.centerXAnchor.constraint  (equalTo: centerXAnchor, constant: 0),
            timeDateLabel.topAnchor.constraint      (equalTo: topAnchor, constant: 10),
            timeDateLabel.heightAnchor.constraint   (equalToConstant: 25),
            timeDateLabel.widthAnchor.constraint    (equalToConstant: 150),
            
            mediaStackView.bottomAnchor.constraint  (equalTo: bottomAnchor, constant: -10),
            mediaStackView.leadingAnchor.constraint (equalTo: leadingAnchor, constant: mediaLeadingPadding),
            mediaStackView.widthAnchor.constraint   (equalTo: widthAnchor, multiplier: mediaWidthMltp),
            mediaStackView.heightAnchor.constraint  (equalToConstant: 60),
            
            goSafariButton.bottomAnchor.constraint  (equalTo: bottomAnchor, constant: -10),
            goSafariButton.leadingAnchor.constraint (equalTo: mediaStackView.trailingAnchor, constant: 0),
            goSafariButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            goSafariButton.heightAnchor.constraint  (equalToConstant: 60),
            
            tweetBodyLabel.topAnchor.constraint     (equalTo: timeDateLabel.bottomAnchor, constant: 0),
            tweetBodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tweetBodyLabel.leadingAnchor.constraint (equalTo: leadingAnchor, constant: 20),
            tweetBodyLabel.bottomAnchor.constraint  (equalTo: mediaStackView.topAnchor, constant: 0),
        ])
    }
}
