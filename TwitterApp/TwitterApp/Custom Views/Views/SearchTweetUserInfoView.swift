//
//  ItemInfoView.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 09/01/2021.
//

import UIKit

class SearchTweetUserInfoView: UIView {

    enum ItemInfoType {
        case following, followers
    }
    
    let symbolImageView   = UIImageView()
    let countLabel        = TwitInfoHeaderBodyLabel(textAlignment: .center)
    let titleLabel        = TwitInfoHeaderBodyLabel(textAlignment: .left)
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(symbolImageView)
        addSubview(countLabel)
        addSubview(titleLabel)
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor   = ColorsTwitter.twitterBlue
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func set(itemInfoType: ItemInfoType, with count: String) {
        switch itemInfoType {
        case .following:
            symbolImageView.image   = SFSymbols.following
            titleLabel.text         = TweetStrings.following
            countLabel.text         = count
            
        case .followers:
            symbolImageView.image   = SFSymbols.followers
            titleLabel.text         = TweetStrings.followers
            countLabel.text         = count
        }
    }
    
}
