//
//  FavoriteUsersCell.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 08/01/2021.
//

import UIKit

class FavoriteUsersCell: UICollectionViewCell {
    
    static let reuseId                  = "UserFavoritesCell"
    
    let postBodyLabel                   = TwitInfoHeaderBodyLabel()
    
    //MARK: - Overrides
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        layoutUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //MARK: - Configurations
    
    func set(with message: String) {
        postBodyLabel.text              = message
    }
    
    
    private func configureCell() {
        layer.cornerRadius  = 30
        backgroundColor     = .secondarySystemBackground
    }
    
    
    private func layoutUI() {
        addSubview(postBodyLabel)
        
        NSLayoutConstraint.activate([
            postBodyLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            postBodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            postBodyLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            postBodyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
        ])
    }
}
