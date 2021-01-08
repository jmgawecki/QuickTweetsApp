//
//  TwitterMainVC.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 28/12/2020.
//

import UIKit

class TwitterMainVC: UIViewController {

    let searchButton          = TwitButton(backgroundColor: .systemGray, fontSize: 20, message: "Search for user")
    let toFavoriteUsersButton = TwitButton(backgroundColor: .systemGray, fontSize: 30, message: "Favorite Users")
    let toFavoriteTwitsButton = TwitButton(backgroundColor: .systemGray, fontSize: 30, message: "Favorite Twits")
    
    var buttonsArray: [UIButton] = []
    
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        layoutUI()
        configureSearchButton()
        configureToFavoritesUsersButton()
//        print(URLs.baseUrlWithToken + URLs.endUrlReturnUserInfo)
    }
    
    
    //MARK: - @Objective functions
    
    @objc private func searchButtonTapped() {
        let destVC = SearchUserVC()
        destVC.title = "User search"
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    @objc private func toFavoritesUsersTapped() {
        let destVC = FavoritesUsersVC()
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    //MARK: - Private Functions
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureSearchButton() {
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    private func configureToFavoritesUsersButton() {
        toFavoriteUsersButton.addTarget(self, action: #selector(toFavoritesUsersTapped), for: .touchUpInside)
    }
    
    
    //MARK: - Layout configuration
    
    private func layoutUI() {
        buttonsArray = [searchButton, toFavoriteUsersButton, toFavoriteTwitsButton]
        for button in buttonsArray { view.addSubview(button) }
        
        let paddingLeftRight: CGFloat   = 30
        let paddingUpDown: CGFloat      = 20
        
        
        NSLayoutConstraint.activate([
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: paddingUpDown),
            searchButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: paddingLeftRight),
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -paddingLeftRight),
            searchButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.17),
            
            toFavoriteUsersButton.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: paddingUpDown),
            toFavoriteUsersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: paddingLeftRight),
            toFavoriteUsersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -paddingLeftRight),
            toFavoriteUsersButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.30),
            
            toFavoriteTwitsButton.topAnchor.constraint(equalTo: toFavoriteUsersButton.bottomAnchor, constant: paddingUpDown),
            toFavoriteTwitsButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: paddingLeftRight),
            toFavoriteTwitsButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -paddingLeftRight),
            toFavoriteTwitsButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.30),
        ])
    }

}

