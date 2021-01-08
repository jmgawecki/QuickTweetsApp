//
//  TwitUserFavoritesCell.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 08/01/2021.
//

import UIKit

class TwitUserFavoritesCell: UICollectionViewCell {
    
    static let reuseId = "UserFavoritesCell"
    
    let postBodyLabel = TwitInfoHeaderBodyLabel()
    
    //MARK: - Overrides
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //MARK: - Configurations
    
    func set(with message: String) {
        postBodyLabel.text = message
    }
    
    private func configureCell() {
        addSubview(postBodyLabel)
        postBodyLabel.layer.borderWidth = 2
        
        NSLayoutConstraint.activate([
            postBodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            postBodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            postBodyLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            postBodyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        ])
    }
}
