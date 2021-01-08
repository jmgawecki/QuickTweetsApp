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
        layoutUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    //MARK: - Configurations
    
    func set(with message: String) {
        postBodyLabel.text = message
    }
    
    
    private func configureCell() {
        contentView.layer.borderWidth   = 2
        contentView.layer.borderColor   = UIColor.cyan.cgColor
        contentView.layer.cornerRadius  = 30
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
