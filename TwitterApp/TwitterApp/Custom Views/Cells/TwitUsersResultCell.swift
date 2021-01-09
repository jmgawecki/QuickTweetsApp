//
//  TwitUsersResultCell.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 28/12/2020.
//

import UIKit

class TwitUsersResultCell: UICollectionViewCell {
    
    static let reuseId      = "cell"
    
    let avatarImage         = TwitImageView(frame: .zero)
    let usernameLabel       = TwitUserResultLabel()

    

    //MARK: - Overrides
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        layoutUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //MARK: - Configurations
    
    func set(message: String) {
        usernameLabel.text  = message
    }
    
    
    private func configure() {
        backgroundColor     = .systemBackground
        layer.borderWidth   = 2
    }
    
    
    //MARK: - Layout configuration
    
    private func layoutUI() {
        addSubview(avatarImage)
        addSubview(usernameLabel)
        avatarImage.image   = UIImage(named: "TwitterLogo")
        
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
            avatarImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            avatarImage.widthAnchor.constraint(equalTo: avatarImage.heightAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            usernameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImage.trailingAnchor, constant: 0),
        ])
    }
    
}
