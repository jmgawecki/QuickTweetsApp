//
//  CircledProfilePictureView.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 16/01/2021.
//

import UIKit

class CircledProfilePictureView: UIView {
    
    var profilePicture = TwitProfilePictureImageView(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCornerRadius(with size: CGFloat) {
        layer.cornerRadius = size
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints   = false
        addSubview(profilePicture)
        profilePicture.frame                        = self.bounds
        layer.borderWidth                           = 2
        profilePicture.setcornerRadius()

    }
    
}
