//
//  TwitInfoHeaderBodyLabel.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 28/12/2020.
//

import UIKit

class TwitInfoHeaderBodyLabel: UILabel {

    //MARK: - Overrides
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment   = textAlignment
    }


    //MARK: - Configurations
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        font            = UIFont.systemFont(ofSize: 17, weight: .regular)
        tintColor       = .secondaryLabel
        
    }

}
