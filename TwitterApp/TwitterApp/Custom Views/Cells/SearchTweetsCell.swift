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
    var commentView             = SearchTweetsMediaInfoView()
    var sharesView              = SearchTweetsMediaInfoView()
    var likesView               = SearchTweetsMediaInfoView()
    
    
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
    
    func set(with usersTweet: SearchUserTweet) {
        tweetBodyLabel.text                         = usersTweet.tweetText
        timeDateLabel.text                          = usersTweet.createdAt
        commentView.set(itemInfoType: .comments,    with: Int(usersTweet.likesCounter))
        sharesView.set(itemInfoType: .shares,       with: Int(usersTweet.retweetCounter))
        likesView.set(itemInfoType: .likes,         with: Int(usersTweet.likesCounter))
    }
    
    private func configureCell() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 15
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
        addToFavoritesButton.layer.borderWidth = 1
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
            addToFavoritesButton.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            addToFavoritesButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            addToFavoritesButton.heightAnchor.constraint(equalToConstant: 30),
            addToFavoritesButton.widthAnchor.constraint(equalTo: addToFavoritesButton.heightAnchor),
            
            timeDateLabel.centerXAnchor.constraint  (equalTo: centerXAnchor, constant: 0),
            timeDateLabel.topAnchor.constraint      (equalTo: topAnchor, constant: 10),
            timeDateLabel.heightAnchor.constraint   (equalToConstant: 25),
            timeDateLabel.widthAnchor.constraint    (equalToConstant: 150),
            
            mediaStackView.bottomAnchor.constraint  (equalTo: bottomAnchor, constant: -10),
            mediaStackView.leadingAnchor.constraint (equalTo: leadingAnchor, constant: 30),
            mediaStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -30),
            mediaStackView.heightAnchor.constraint  (equalToConstant: 60),
            
            tweetBodyLabel.topAnchor.constraint     (equalTo: timeDateLabel.bottomAnchor, constant: 0),
            tweetBodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            tweetBodyLabel.leadingAnchor.constraint (equalTo: leadingAnchor, constant: 20),
            tweetBodyLabel.bottomAnchor.constraint  (equalTo: mediaStackView.topAnchor, constant: 0),
        ])
    }
}
