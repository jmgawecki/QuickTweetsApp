//
//  TwitTwitsCell.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 04/01/2021.
//

protocol SearchTweetsCellDelegates: class {
    func didRequestSafari(with urlString: String?)
}

import UIKit

class SearchTweetsCell: UICollectionViewCell {
    
    static let reuseId          = "cell"
        
    let addToFavoritesButton    = UIButton()
    var timeDateLabel           = UILabel()
    let tweetBodyLabel          = UserSearchVCTextView()
    var mediaStackView          = UIStackView()
    var goOnlineButton          = GoOnlineButton()
    var sharesView              = MediaInfoViewTweet()
    var likesView               = MediaInfoViewTweet()
    
    var tweet: Tweet!
    weak var delegate: SearchTweetsCellDelegates!
    var urlString: String!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        configureUIElements()
        layoutUI()
        configureMediaStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func addToFavoritesTapped() {
        PersistenceManager.updateWithTweets(newFavoriteTweet: tweet, persistenceAction: .add) { [weak self] (error) in
            guard self != nil else { return }
            guard let error = error else {
                print("sucess")
                return
            }
            print(error.rawValue)
        }
    }
    
    func set(with usersTweet: Tweet) {
        tweet                                       = usersTweet
        tweetBodyLabel.text                         = usersTweet.tweetText
        timeDateLabel.text                          = usersTweet.createdAt.createFormattedSwifterDateString()
        sharesView.set(itemInfoType: .shares,       with: usersTweet.retweetCounter.converToKFormatString())
        likesView.set(itemInfoType: .likes,         with: usersTweet.likesCounter.converToKFormatString())
        urlString                                   = tweet.urlToExpandWithSafari
    }

    private func configureCell() {
        backgroundColor                     = .secondarySystemBackground
        layer.cornerRadius                  = 15
    }
    
    private func debugConfiguration() {
        tweetBodyLabel.layer.borderWidth    = 1
        mediaStackView.layer.borderWidth    = 1
        timeDateLabel.layer.borderWidth     = 1
    }
    
    private func configureMediaStackView() {
        mediaStackView.axis                 = .horizontal
        mediaStackView.distribution         = .equalSpacing
        mediaStackView.alignment            = .center
        goOnlineButton.delegate               = self
        
        mediaStackView.addArrangedSubview(likesView)
        mediaStackView.addArrangedSubview(sharesView)
    }
    
    private func configureUIElements() {
        timeDateLabel.textColor             = .systemGray
        timeDateLabel.textAlignment         = .center
        
        addToFavoritesButton.setImage(UIImage(systemName: "plus"), for: .normal)
        addToFavoritesButton.tintColor      = ColorsTwitter.twitterBlue
        addToFavoritesButton.addTarget(self, action: #selector(addToFavoritesTapped), for: .touchUpInside)
    }
    
    private func layoutUI() {
        addSubview(addToFavoritesButton)
        addSubview(timeDateLabel)
        addSubview(tweetBodyLabel)
        addSubview(mediaStackView)
        addSubview(goOnlineButton)
        
        addToFavoritesButton.translatesAutoresizingMaskIntoConstraints  = false
        mediaStackView.translatesAutoresizingMaskIntoConstraints        = false
        timeDateLabel.translatesAutoresizingMaskIntoConstraints         = false
        
        NSLayoutConstraint.activate([
            addToFavoritesButton.topAnchor.constraint       (equalTo: topAnchor, constant: 5),
            addToFavoritesButton.trailingAnchor.constraint  (equalTo: trailingAnchor, constant: -5),
            addToFavoritesButton.heightAnchor.constraint    (equalToConstant: 30),
            addToFavoritesButton.widthAnchor.constraint     (equalTo: addToFavoritesButton.heightAnchor),
            
            timeDateLabel.centerXAnchor.constraint          (equalTo: centerXAnchor, constant: 0),
            timeDateLabel.topAnchor.constraint              (equalTo: topAnchor, constant: 10),
            timeDateLabel.heightAnchor.constraint           (equalToConstant: 25),
            timeDateLabel.widthAnchor.constraint            (equalToConstant: 150),
                    
            mediaStackView.bottomAnchor.constraint          (equalTo: bottomAnchor, constant: -10),
            mediaStackView.leadingAnchor.constraint         (equalTo: leadingAnchor, constant: 30),
            mediaStackView.widthAnchor.constraint           (equalTo: widthAnchor, multiplier: 0.55),
            mediaStackView.heightAnchor.constraint          (equalToConstant: 30),
            
            goOnlineButton.bottomAnchor.constraint          (equalTo: bottomAnchor, constant: -10),
            goOnlineButton.leadingAnchor.constraint         (equalTo: mediaStackView.trailingAnchor, constant: 5),
            goOnlineButton.trailingAnchor.constraint        (equalTo: trailingAnchor, constant: -5),
            goOnlineButton.heightAnchor.constraint          (equalToConstant: 30),
                    
            tweetBodyLabel.topAnchor.constraint             (equalTo: timeDateLabel.bottomAnchor, constant: 0),
            tweetBodyLabel.trailingAnchor.constraint        (equalTo: trailingAnchor, constant: -20),
            tweetBodyLabel.leadingAnchor.constraint         (equalTo: leadingAnchor, constant: 20),
            tweetBodyLabel.bottomAnchor.constraint          (equalTo: mediaStackView.topAnchor, constant: 0),
        ])
    }
}

extension SearchTweetsCell: GoOnlineViewDelegate {
    func didTapGoOnlineButton() {
        delegate.didRequestSafari(with: urlString)
    }
}

