//
//  SearchTweetsMediaView.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 10/01/2021.
//

import UIKit

final class CellMediaInfoView: UIView {

    enum ItemInfoType {
        case comments, shares, likes
    }
    
    let symbolImgView   = UIImageView()
    let countLabel        = TwitInfoHeaderBodyLabel(textAlignment: .left)
   
    
    //MARK:- Overrides
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK:- Configurations
    
    private func configure() {
        addSubviews(symbolImgView, countLabel)
        tamic(symbolImgView)
        
        symbolImgView.contentMode = .scaleAspectFill
        symbolImgView.tintColor   = ColorsTwitter.twitterBlue
        
        NSLayoutConstraint.activate([
            symbolImgView.centerYAnchor.constraint    (equalTo: self.centerYAnchor),
            symbolImgView.leadingAnchor.constraint    (equalTo: self.leadingAnchor),
            symbolImgView.widthAnchor.constraint      (equalToConstant: 20),
            symbolImgView.heightAnchor.constraint     (equalToConstant: 20),
            
            countLabel.centerYAnchor.constraint       (equalTo: symbolImgView.centerYAnchor),
            countLabel.leadingAnchor.constraint       (equalTo: symbolImgView.trailingAnchor, constant: 12),
            countLabel.trailingAnchor.constraint      (equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint        (equalToConstant: 18),
            
         
        ])
    }
    
    
    func set(itemInfoType: ItemInfoType, with count: String) {
        switch itemInfoType {
        case .comments:
            symbolImgView.image   = SFSymbols.comment
            countLabel.text       = String(count)
            
        case .shares:
            symbolImgView.image   = SFSymbols.shares
            countLabel.text       = String(count)
            
        case .likes:
            symbolImgView.image   = SFSymbols.likes
            countLabel.text       = String(count)
        }
    }
}
