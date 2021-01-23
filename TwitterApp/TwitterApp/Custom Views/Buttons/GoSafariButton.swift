//
//  GoSafariButton.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 23/01/2021.
//

import UIKit

final class GoSafariButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(title: String, isEnabled: Bool) {
        self.init(frame: .zero)
        setTitle(title, for: .normal)
        self.isEnabled = isEnabled

    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor         = .secondarySystemBackground
        titleLabel?.font        = UIFont.systemFont(ofSize: 17, weight: .light)
        setTitleColor(ColorsTwitter.twitterBlue, for: .normal)
    }

}
