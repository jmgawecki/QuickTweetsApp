//
//  FavoriteTwitsCell.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 10/01/2021.
//

import UIKit

class FavoriteTweetsCell: UICollectionViewCell {
    
    static let reuseId = "FavoriteTwitsCell"
    
    
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

    private func configureCell() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 15
    }

    
    private func layoutUI() {
        
    }
}
