//
//  TwitTwitsCell.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 04/01/2021.
//

import UIKit

class SearchTweetsCell: UICollectionViewCell {
    
    static let reuseId          = "cell"
        
    let addToFavoritesButton    = UIButton()
    var timeDateLabel           = UILabel()
    let tweetBodyLabel          = UserSearchVCTextView()
    var mediaStackView          = UIStackView()
    let seeOnlineButton         = UIButton()
    var commentView             = CellMediaInfoView()
    var sharesView              = CellMediaInfoView()
    var likesView               = CellMediaInfoView()
    
    var tweet: Tweet!
    
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
        timeDateLabel.text                          = usersTweet.createdAt.formatToTwitterPostDate()
        commentView.set(itemInfoType: .comments,    with: usersTweet.likesCounter.convertToKMFormattedString())
        sharesView.set(itemInfoType: .shares,       with: usersTweet.retweetCounter.convertToKMFormattedString())
        likesView.set(itemInfoType: .likes,         with: usersTweet.likesCounter.convertToKMFormattedString())

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
        
        mediaStackView.addArrangedSubview(commentView)
        mediaStackView.addArrangedSubview(sharesView)
        mediaStackView.addArrangedSubview(likesView)
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
            mediaStackView.trailingAnchor.constraint        (equalTo: trailingAnchor, constant: -30),
            mediaStackView.heightAnchor.constraint          (equalToConstant: 60),
                    
            tweetBodyLabel.topAnchor.constraint             (equalTo: timeDateLabel.bottomAnchor, constant: 0),
            tweetBodyLabel.trailingAnchor.constraint        (equalTo: trailingAnchor, constant: -20),
            tweetBodyLabel.leadingAnchor.constraint         (equalTo: leadingAnchor, constant: 20),
            tweetBodyLabel.bottomAnchor.constraint          (equalTo: mediaStackView.topAnchor, constant: 0),
        ])
    }
}
