//
//  TwitterMainVC.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 28/12/2020.
//

import UIKit
import Swifter


final class MainVC: UIViewController {
    
    let swifter             = NetworkManager.shared.swifter
    
    
    let logoImgeView        = TwitImageView(frame: .zero)
    let searchButton        = TwitButton(backgroundColor: ColorsTwitter.twitterBlue, fontSize: 20, message: "Search for user")
    let favUsersButton      = TwitButton(backgroundColor: ColorsTwitter.twitterLighGray, fontSize: 20, message: "Users")
    let favTwitsButton      = TwitButton(backgroundColor: ColorsTwitter.twitterLighGray, fontSize: 20, message: "Twits")
    
    var buttonsArray: [UIButton] = []
    
    
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authoriseAPI()
        configureVC()
        layoutUI()
        configureUIElements()
        configureButtons()
    }
    
    
    //MARK: - @Objective functions
    
    @objc private func searchButtonTapped(sender: UIButton) {
        self.animateButtonsView(sender)
        let destVC              = UserSearchVC()
        destVC.title            = "User search"
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    @objc private func toFavoritesUsersTapped(sender: UIButton) {
        self.animateButtonsView(sender)
        let destVC              = FavoriteUsersVC()
        navigationController?.pushViewController(destVC, animated: true)
    }
    
    @objc private func toFavoriteTweetsTapped(sender: UIButton) {
        self.animateButtonsView(sender)
        let destVC              = FavoriteTweetsVC()
        navigationController?.pushViewController(destVC, animated: true)
    }

    
    //MARK: - Private Functions
    
    private func authoriseAPI() {
        var hasAlreadyLaunched :Bool!
        hasAlreadyLaunched = UserDefaults.standard.bool(forKey: "hasAlreadyLaunched")
        if hasAlreadyLaunched {
        } else {
            UserDefaults.standard.set(true, forKey: "hasAlreadyLaunched")
            
            if let callbackURL = URL(string: "TwitterApp://success") {
                swifter.authorize(withCallback: callbackURL, presentingFrom: self, success: { token, _ in
                    print("MUCH SUCCESS")
                    
                }, failure: { error in
                    print("ERROR")
                })
            }
        }
    }
    
    private func configureVC() {
        view.backgroundColor    = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureButtons() {
        searchButton.addTarget(self, action: #selector(searchButtonTapped(sender:)), for: .touchUpInside)
        favUsersButton.addTarget(self, action: #selector(toFavoritesUsersTapped(sender:)), for: .touchUpInside)
        favTwitsButton.addTarget(self, action: #selector(toFavoriteTweetsTapped(sender:)), for: .touchUpInside)
    }
    
    
    //MARK: - Layout configuration
    
    private func configureUIElements() {
        logoImgeView.image = Images.twitterLogo
    }
    
    
    private func layoutUI() {
        view.addSubviews(searchButton, favUsersButton, favTwitsButton, logoImgeView)
        
        let paddingUpDown: CGFloat = 20
        
        
        NSLayoutConstraint.activate([
            logoImgeView.topAnchor.constraint       (equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            logoImgeView.centerXAnchor.constraint   (equalTo: view.centerXAnchor),
            logoImgeView.widthAnchor.constraint     (equalToConstant: 220),
            logoImgeView.heightAnchor.constraint    (equalTo: logoImgeView.widthAnchor),
            
            searchButton.topAnchor.constraint       (equalTo: logoImgeView.bottomAnchor, constant: 50),
            searchButton.centerXAnchor.constraint   (equalTo: view.centerXAnchor),
            searchButton.widthAnchor.constraint     (equalToConstant: 280),
            searchButton.heightAnchor.constraint    (equalToConstant: 50),
            
            favUsersButton.topAnchor.constraint     (equalTo: searchButton.bottomAnchor, constant: paddingUpDown),
            favUsersButton.leadingAnchor.constraint (equalTo: searchButton.leadingAnchor, constant: 0),
            favUsersButton.widthAnchor.constraint   (equalToConstant: 130),
            favUsersButton.heightAnchor.constraint  (equalToConstant: 50),
            
            favTwitsButton.topAnchor.constraint     (equalTo: searchButton.bottomAnchor, constant: paddingUpDown),
            favTwitsButton.trailingAnchor.constraint(equalTo: searchButton.trailingAnchor, constant: 0),
            favTwitsButton.widthAnchor.constraint   (equalToConstant: 130),
            favTwitsButton.heightAnchor.constraint  (equalToConstant: 50),
        ])
    }

}

