//
//  SearchTweetsMediaView.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 10/01/2021.
//

import UIKit

class CellMediaInfoView: UIView {

    enum ItemInfoType {
        case comments, shares, likes
    }
    
    let symbolImageView   = UIImageView()
    let countLabel        = TwitInfoHeaderBodyLabel(textAlignment: .left)
   
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
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor   = ColorsTwitter.twitterBlue
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint        (equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint    (equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint      (equalToConstant: 20),
            symbolImageView.heightAnchor.constraint     (equalToConstant: 20),
            
            countLabel.centerYAnchor.constraint         (equalTo: symbolImageView.centerYAnchor),
            countLabel.leadingAnchor.constraint         (equalTo: symbolImageView.trailingAnchor, constant: 12),
            countLabel.trailingAnchor.constraint        (equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint          (equalToConstant: 18),
            
         
        ])
    }
    
    func set(itemInfoType: ItemInfoType, with count: String) {
        switch itemInfoType {
        case .comments:
            symbolImageView.image   = SFSymbols.comment
            countLabel.text         = String(count)
            
        case .shares:
            symbolImageView.image   = SFSymbols.shares
            countLabel.text         = String(count)
            
        case .likes:
            symbolImageView.image   = SFSymbols.likes
            countLabel.text         = String(count)
        }
    }
}
