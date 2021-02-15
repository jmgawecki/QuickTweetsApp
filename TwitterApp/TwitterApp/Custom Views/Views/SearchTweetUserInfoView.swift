//
//  ItemInfoView.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 09/01/2021.
//

import UIKit

final class SearchTweetUserInfoView: UIView {
    //MARK: - Declarations
    

    enum ItemInfoType {
        case following, followers
    }
    
    let symbolImgView     = UIImageView()
    let countLabel        = TwitInfoHeaderBodyLabel(textAlignment: .center)
    let titleLabel        = TwitInfoHeaderBodyLabel(textAlignment: .left)
   
    
    //MARK:- Overrieds
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:- Configurations
    
    
    private func configure() {
        addSubviews(symbolImgView, countLabel, titleLabel)
        tamic(symbolImgView)
        
        symbolImgView.translatesAutoresizingMaskIntoConstraints = false
        symbolImgView.contentMode = .scaleAspectFill
        symbolImgView.tintColor   = ColorsTwitter.twitterBlue
        
        NSLayoutConstraint.activate([
            symbolImgView.topAnchor.constraint      (equalTo: self.topAnchor),
            symbolImgView.leadingAnchor.constraint  (equalTo: self.leadingAnchor),
            symbolImgView.widthAnchor.constraint    (equalToConstant: 20),
            symbolImgView.heightAnchor.constraint   (equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint     (equalTo: symbolImgView.centerYAnchor),
            titleLabel.leadingAnchor.constraint     (equalTo: symbolImgView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint    (equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint      (equalToConstant: 18),
            
            countLabel.topAnchor.constraint         (equalTo: symbolImgView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint     (equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint    (equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint      (equalToConstant: 18)
        ])
    }
    
    
    //MARK: - Called outside
    func set(itemInfoType: ItemInfoType, with count: String) {
        switch itemInfoType {
        case .following:
            symbolImgView.image     = SFSymbolsAsImg.following
            titleLabel.text         = TweetStrings.following
            countLabel.text         = count
            
        case .followers:
            symbolImgView.image     = SFSymbolsAsImg.followers
            titleLabel.text         = TweetStrings.followers
            countLabel.text         = count
        }
    }
}
