//
//  TwitButton.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 28/12/2020.
//

import UIKit

final class TwitButton: UIButton {

    
    //MARK: - Overrides
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Initialisers
    
    
    convenience init(backgroundColor: UIColor, fontSize: CGFloat, message: String) {
        self.init(frame: .zero)
        self.backgroundColor    = backgroundColor
        titleLabel?.font        = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
        setTitle(message, for: .normal)
        
    }
    
    
    //MARK: - Configurations
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints   = false
        layer.cornerRadius                          = 15
        setTitleColor(.white, for: .normal)
    }
}
