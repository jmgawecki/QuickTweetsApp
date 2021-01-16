//
//  FavoriteUsersCell.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 08/01/2021.
//

import UIKit
import SafariServices

protocol FavoriteUsersCellDelegates: class {
    func didRequestSafari(with urlString: String?)
}


class FavoriteUsersCell: UICollectionViewCell {
    
    
    static let reuseId                      = "cell"
                    
    let tweetBodyLabel                      = UserSearchVCTextView()
    var mediaStackView                      = UIStackView()
    var goOnlineButton                      = GoOnlineButton()
    var sharesView                          = MediaInfoViewTweet()
    var likesView                           = MediaInfoViewTweet()
    var timeDateLabel                       = UILabel()
    
    weak var delegate: FavoriteUsersCellDelegates!
    
    var urlString: String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        configureTimeDateLabel()
        layoutUI()
        configureMediaStackView()
//        debugConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with tweet: Tweet) {
        timeDateLabel.text                  = tweet.createdAt.createFormattedSwifterDateString()
        tweetBodyLabel.text                 = tweet.tweetText
        
        sharesView.set(itemInfoType:        .shares, with: tweet.retweetCounter.converToKFormatString())
        likesView.set(itemInfoType:         .likes, with: tweet.likesCounter.converToKFormatString())
        
        urlString                           = tweet.urlToExpandWithSafari
    }
    
    private func configureCell() {
        backgroundColor                     = .secondarySystemBackground
        layer.cornerRadius                  = 15
    }
    
    private func debugConfiguration() {
        tweetBodyLabel.layer.borderWidth    = 1
        mediaStackView.layer.borderWidth    = 1
        timeDateLabel.layer.borderWidth     = 1
        goOnlineButton.layer.borderWidth    = 1
    }
    
    private func configureMediaStackView() {
        mediaStackView.axis                 = .horizontal
        mediaStackView.distribution         = .equalSpacing
        mediaStackView.alignment            = .center
        goOnlineButton.delegate             = self
        
        
        mediaStackView.addArrangedSubview(likesView)
        mediaStackView.addArrangedSubview(sharesView)
    }
    
    private func configureTimeDateLabel() {
        timeDateLabel.textColor             = .systemGray
        timeDateLabel.textAlignment         = .center
        
    }
    
    private func layoutUI() {
        addSubview(timeDateLabel)
        addSubview(tweetBodyLabel)
        addSubview(mediaStackView)
        addSubview(goOnlineButton)
        mediaStackView.translatesAutoresizingMaskIntoConstraints = false
        timeDateLabel.translatesAutoresizingMaskIntoConstraints  = false
        
        NSLayoutConstraint.activate([
            timeDateLabel.centerXAnchor.constraint  (equalTo: centerXAnchor, constant: 0),
            timeDateLabel.topAnchor.constraint      (equalTo: topAnchor, constant: 10),
            timeDateLabel.heightAnchor.constraint   (equalToConstant: 25),
            timeDateLabel.widthAnchor.constraint    (equalToConstant: 150),
            
            mediaStackView.bottomAnchor.constraint  (equalTo: bottomAnchor, constant: -10),
            mediaStackView.leadingAnchor.constraint (equalTo: leadingAnchor, constant: 30),
            mediaStackView.widthAnchor.constraint   (equalTo: widthAnchor, multiplier: 0.55),
            mediaStackView.heightAnchor.constraint  (equalToConstant: 30),
            
            goOnlineButton.bottomAnchor.constraint  (equalTo: bottomAnchor, constant: -10),
            goOnlineButton.leadingAnchor.constraint (equalTo: mediaStackView.trailingAnchor, constant: 5),
            goOnlineButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            goOnlineButton.heightAnchor.constraint  (equalToConstant: 30),
            
            tweetBodyLabel.topAnchor.constraint     (equalTo: timeDateLabel.bottomAnchor, constant: 0),
            tweetBodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tweetBodyLabel.leadingAnchor.constraint (equalTo: leadingAnchor, constant: 20),
            tweetBodyLabel.heightAnchor.constraint  (equalToConstant: 150),
        ])
    }
}

extension FavoriteUsersCell: GoOnlineViewDelegate {
    func didTapGoOnlineButton() {
        delegate.didRequestSafari(with: urlString)
    }
}
