//
//  BackgroundPictureImageView.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 23/01/2021.
//

import UIKit

class BackgroundPictureImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func downloadImage(from URLString: String) {
        NetworkManager.shared.downloadImage(from: URLString) { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds           = true
    }
}
