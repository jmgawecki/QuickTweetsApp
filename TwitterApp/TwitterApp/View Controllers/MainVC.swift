//
//  TwitterMainVC.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 28/12/2020.
//

import UIKit
import Swifter


class MainVC: UIViewController {
    
    let swifter = NetworkManager.shared.swifter
    
    
    let twitterLogoImageView        = TwitImageView(frame: .zero)
    let searchButton                = TwitButton(backgroundColor: ColorsTwitter.twitterBlue, fontSize: 20, message: "Search for user")
    let favoriteUsersButton       = TwitButton(backgroundColor: ColorsTwitter.twitterLighGray, fontSize: 20, message: "Users")
    let favoriteTwitsButton       = TwitButton(backgroundColor: ColorsTwitter.twitterLighGray, fontSize: 20, message: "Twits")
    
    var buttonsArray: [UIButton]    = []
    
    //MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authoriseAPI()
        configureVC()
        layoutUI()
        configureUIElements()
        configureSearchButton()
        configureFavoritesUsersButton()
        configureFavoriteTweetsButton()
        
        
    }
    
    
    //MARK: - @Objective functions
    
    @objc private func searchButtonTapped(sender: UIButton) {
        self.animateButtonsView(sender)
        let destVC              = UserSearchVC()
        destVC.title            = "User search"
        swifter.showUser(UserTag.screenName("barackobama"), includeEntities: true) { (json) in
            print(json)
        } failure: { (error) in
            return
        }

        swifter.getTimeline(for: UserTag.screenName("barackobama"), customParam: [:], count: 1, sinceID: nil, maxID: nil, trimUser: true, excludeReplies: true, includeRetweets: true, contributorDetails: true, includeEntities: true, tweetMode: .default) { (json) in
            print(json)
        } failure: { (error) in
            return
        }
        
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
    
    //MARK: - Animations
    
   
    
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
    
    private func configureSearchButton() {
        searchButton.addTarget(self, action: #selector(searchButtonTapped(sender:)), for: .touchUpInside)
    }
    
    private func configureFavoritesUsersButton() {
        favoriteUsersButton.addTarget(self, action: #selector(toFavoritesUsersTapped(sender:)), for: .touchUpInside)
    }
    
    private func configureFavoriteTweetsButton() {
        favoriteTwitsButton.addTarget(self, action: #selector(toFavoriteTweetsTapped(sender:)), for: .touchUpInside)
    }
    
    
    //MARK: - Layout configuration
    
    private func configureUIElements() {
        twitterLogoImageView.image = Images.twitterLogo
    }
    
    
    private func layoutUI() {
        buttonsArray = [searchButton, favoriteUsersButton, favoriteTwitsButton]
        
        view.addSubview(twitterLogoImageView)
        for button in buttonsArray { view.addSubview(button) }
        twitterLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let paddingUpDown: CGFloat = 20
        
        
        NSLayoutConstraint.activate([
            twitterLogoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            twitterLogoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            twitterLogoImageView.widthAnchor.constraint(equalToConstant: 220),
            twitterLogoImageView.heightAnchor.constraint(equalTo: twitterLogoImageView.widthAnchor),
            
            searchButton.topAnchor.constraint(equalTo: twitterLogoImageView.bottomAnchor, constant: 50),
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 280),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
            
            favoriteUsersButton.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: paddingUpDown),
            favoriteUsersButton.leadingAnchor.constraint(equalTo: searchButton.leadingAnchor, constant: 0),
            favoriteUsersButton.widthAnchor.constraint(equalToConstant: 130),
            favoriteUsersButton.heightAnchor.constraint(equalToConstant: 50),
            
            favoriteTwitsButton.topAnchor.constraint(equalTo: searchButton.bottomAnchor, constant: paddingUpDown),
            favoriteTwitsButton.trailingAnchor.constraint(equalTo: searchButton.trailingAnchor, constant: 0),
            favoriteTwitsButton.widthAnchor.constraint(equalToConstant: 130),
            favoriteTwitsButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

}

