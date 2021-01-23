//
//  RemoveFromFavButton.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 23/01/2021.
//

import UIKit

final class RemoveFromFavButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        titleLabel?.font      = UIFont.systemFont(ofSize: 15, weight: .semibold)
        backgroundColor       = .systemBackground
        setTitleColor(ColorsTwitter.twitterBlue, for: .normal)
        #warning("why the color does not change")
    }
}
