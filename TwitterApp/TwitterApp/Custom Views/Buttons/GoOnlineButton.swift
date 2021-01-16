//
//  GoOnlineButton.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 16/01/2021.
//

import UIKit

protocol GoOnlineViewDelegate: class {
    func didTapGoOnlineButton()
}

class GoOnlineButton: UIButton {
    
    weak var delegate: GoOnlineViewDelegate!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureGoOnlineButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func goOnlineButtonTapped() {
        delegate.didTapGoOnlineButton()
    }
    
    private func configureGoOnlineButton() {
        translatesAutoresizingMaskIntoConstraints = false
        setTitle("See more", for: .normal)
        setTitleColor(ColorsTwitter.twitterBlue, for: .normal)
        addTarget(self, action: #selector(goOnlineButtonTapped), for: .touchUpInside)
    }
}
