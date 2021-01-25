//
//  TwitTwitsCell.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 04/01/2021.
//

import UIKit

protocol SearchTweetsCellDelegates: class {
    func didRequestSafari(with urlString: String?)
}

class SearchTweetsCell: UICollectionViewCell {
    
    static let reuseId          = "cell"
        
    let addToFavoritesButton    = UIButton()
    var timeDateLabel           = UILabel()
    let tweetBodyLabel          = UserSearchVCTextView()
    var mediaStackView          = UIStackView()
    let seeOnlineButton         = UIButton()
    var sharesView              = CellMediaInfoView()
    var likesView               = CellMediaInfoView()
    var goSafariButton          = GoSafariButton()
    
    weak var delegateSafari: SearchTweetsCellDelegates!
    var tweet:               Tweet!
    var user:                User!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        configureUIElements()
        layoutUI()
        configureMediaStackView()
        configureGoSafariButton()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc private func addToFavoritesTapped(sender: UIView) {
        animateButtonView(sender)
        let favorite = fromTweetToFavoriteTweet(user: user, tweet: tweet)
        PersistenceManager.updateWithTweets(favoriteTweet: favorite, persistenceAction: .add) { [weak self] (error) in
            guard self != nil else { return }
            guard let error = error else {
                print("sucess")
                return
            }
            print(error.rawValue)
        }
        self.addToFavoritesButton.isEnabled = false
    }
    
    
    @objc private func didTapGoSafariButton(_ sender: UIView) {
        animateButtonView(sender)
        delegateSafari.didRequestSafari(with: tweet.urlToExpandWithSafari)
    }
    
    
    private func fromTweetToFavoriteTweet(user: User ,tweet: Tweet) -> FavoriteTweet {
        let favoriteTweet = FavoriteTweet(twitsId: tweet.twitsId,
                                          name: user.name,
                                          tweetText: tweet.tweetText,
                                          profileImageUrl: user.profileImageUrl,
                                          urlToExpandWithSafari: tweet.urlToExpandWithSafari,
                                          likesCounter: tweet.likesCounter,
                                          retweetCounter: tweet.retweetCounter,
                                          createdAt: tweet.createdAt)
        return favoriteTweet
    }
    
    private func animateButtonView(_ viewToAnimate: UIView) {
        UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 2, options: .curveEaseIn) {
            viewToAnimate.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        } completion: { (_) in
            UIView.animate(withDuration: 0.15, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 2, options: .curveEaseIn, animations: { viewToAnimate.transform = CGAffineTransform.init(scaleX: 1, y: 1) }, completion: nil)
        }
        UIView.animate(withDuration: 0.2, animations: {viewToAnimate.alpha = 0}) { [weak self] (true) in
            guard let self = self else { return }
            switch true {
            case true:
                DispatchQueue.main.async {
                    self.addToFavoritesButton.setImage(SFSymbolsAsImg.checkmark, for: .normal)
                }
                UIView.animate(withDuration: 0.2, animations: {viewToAnimate.alpha = 1} )
            case false:
                return
            }
        }
    }
    
    func set(with usersTweet: Tweet, user: User, buttonTitle: String?, isEnabled: Bool) {
        self.user                               = user
        tweet                                   = usersTweet
        tweetBodyLabel.text                     = usersTweet.tweetText
        timeDateLabel.text                      = usersTweet.createdAt.formatToTwitterPostDate()
        
        sharesView.set(itemInfoType: .shares,   with: usersTweet.retweetCounter.convertToKMFormatStr())
        likesView.set(itemInfoType: .likes,     with: usersTweet.likesCounter.convertToKMFormatStr())
        
        if buttonTitle != nil {
            goSafariButton.setTitle(buttonTitle, for: .normal)
            goSafariButton.isEnabled = true
        } else {
            goSafariButton.isEnabled = false
        }
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
    
    
    private func configureUIElements() {
        timeDateLabel.textColor             = .systemGray
        timeDateLabel.textAlignment         = .center
        
        addToFavoritesButton.setImage(SFSymbolsAsImg.plus, for: .normal)
        addToFavoritesButton.tintColor      = ColorsTwitter.twitterBlue
        addToFavoritesButton.addTarget(self, action: #selector(addToFavoritesTapped), for: .touchUpInside)
    }
    
    
    private func layoutUI() {
        addSubviews(addToFavoritesButton, timeDateLabel, tweetBodyLabel, mediaStackView, goSafariButton)
        tamic(addToFavoritesButton, mediaStackView, timeDateLabel)
        
        let mediaLeadingPadding: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 10 : 30
        let mediaWidthMltp: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 0.55 : 0.5
        
        NSLayoutConstraint.activate([
            addToFavoritesButton.topAnchor.constraint       (equalTo: topAnchor, constant: 5),
            addToFavoritesButton.trailingAnchor.constraint  (equalTo: trailingAnchor, constant: -5),
            addToFavoritesButton.heightAnchor.constraint    (equalToConstant: 23),
            addToFavoritesButton.widthAnchor.constraint     (equalTo: addToFavoritesButton.heightAnchor),
            
            timeDateLabel.centerXAnchor.constraint          (equalTo: centerXAnchor, constant: 0),
            timeDateLabel.topAnchor.constraint              (equalTo: topAnchor, constant: 10),
            timeDateLabel.heightAnchor.constraint           (equalToConstant: 25),
            timeDateLabel.widthAnchor.constraint            (equalToConstant: 150),
                    
            mediaStackView.bottomAnchor.constraint          (equalTo: bottomAnchor, constant: -10),
            mediaStackView.leadingAnchor.constraint         (equalTo: leadingAnchor, constant: mediaLeadingPadding),
            mediaStackView.widthAnchor.constraint           (equalTo: widthAnchor, multiplier: mediaWidthMltp),
            mediaStackView.heightAnchor.constraint          (equalToConstant: 60),
            
            goSafariButton.bottomAnchor.constraint          (equalTo: bottomAnchor, constant: -10),
            goSafariButton.leadingAnchor.constraint         (equalTo: mediaStackView.trailingAnchor, constant: 0),
            goSafariButton.trailingAnchor.constraint        (equalTo: trailingAnchor, constant: 0),
            goSafariButton.heightAnchor.constraint          (equalToConstant: 60),
                    
            tweetBodyLabel.topAnchor.constraint             (equalTo: timeDateLabel.bottomAnchor, constant: 0),
            tweetBodyLabel.trailingAnchor.constraint        (equalTo: trailingAnchor, constant: -20),
            tweetBodyLabel.leadingAnchor.constraint         (equalTo: leadingAnchor, constant: 20),
            tweetBodyLabel.heightAnchor.constraint          (equalToConstant: 156),
        ])
    }
}
