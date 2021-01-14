//
//  FavoriteUsersCell.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 08/01/2021.
//

import UIKit

class FavoriteUsersCell: UICollectionViewCell {
    
    
    static let reuseId                      = "cell"
                    
    let tweetBodyLabel                      = UserSearchVCTextView()
    var mediaStackView                      = UIStackView()
    var commentView                         = SearchTweetsMediaInfoView()
    var sharesView                          = SearchTweetsMediaInfoView()
    var likesView                           = SearchTweetsMediaInfoView()
    var timeDateLabel                       = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        configureTimeDateLabel()
        layoutUI()
        configureMediaStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(with message: String) {
        tweetBodyLabel.text                 = message
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
        
        commentView.set(itemInfoType:       .comments, with: 21)
        sharesView.set(itemInfoType:        .shares, with: 12)
        likesView.set(itemInfoType:         .likes, with: 136)
        
        mediaStackView.addArrangedSubview(commentView)
        mediaStackView.addArrangedSubview(sharesView)
        mediaStackView.addArrangedSubview(likesView)
    }
    
    private func configureTimeDateLabel() {
        timeDateLabel.text = "Jan 14, 2019"
        timeDateLabel.textColor = .systemGray
        timeDateLabel.textAlignment = .center
    }
    
    private func layoutUI() {
        addSubview(timeDateLabel)
        addSubview(tweetBodyLabel)
        addSubview(mediaStackView)
        mediaStackView.translatesAutoresizingMaskIntoConstraints = false
        timeDateLabel.translatesAutoresizingMaskIntoConstraints  = false
        
        NSLayoutConstraint.activate([
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
