//
//  TwitterMainVC.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 28/12/2020.
//

import UIKit
import Swifter


final class FavoritesVC: UIViewController {
    
    let swifter             = NetworkManager.shared.swifter
    
    let logoImgView         = TwitImageView(frame: .zero)
   
    let favUsersButton      = TwitButton(backgroundColor: ColorsTwitter.twitterBlue, fontSize: 20, message: "Users")
    let favTwitsButton      = TwitButton(backgroundColor: ColorsTwitter.twitterBlue, fontSize: 20, message: "Tweets")
    
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
                    
                }, failure: { error in
                })
            }
        }
    }
    
    private func configureVC() {
        view.backgroundColor    = .systemBackground
        let isLargeScreen: Bool = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? false : true
        navigationController?.navigationBar.prefersLargeTitles = isLargeScreen
    }
    
    private func configureButtons() {
        favUsersButton.addTarget(self, action: #selector(toFavoritesUsersTapped(sender:)), for: .touchUpInside)
        favTwitsButton.addTarget(self, action: #selector(toFavoriteTweetsTapped(sender:)), for: .touchUpInside)
    }
    
    
    //MARK: - Layout configuration
    
    private func configureUIElements() {
        logoImgView.image = Images.twitterLogo
    }
    
    
    private func layoutUI() {
        view.addSubviews(favUsersButton, favTwitsButton, logoImgView)
        
        
        NSLayoutConstraint.activate([
            logoImgView.topAnchor.constraint        (equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            logoImgView.centerXAnchor.constraint    (equalTo: view.centerXAnchor),
            logoImgView.heightAnchor.constraint     (equalToConstant: 220),
            logoImgView.widthAnchor.constraint      (equalTo: logoImgView.heightAnchor),
            
            favUsersButton.topAnchor.constraint     (equalTo: logoImgView.bottomAnchor, constant: 10),
            favUsersButton.centerXAnchor.constraint (equalTo: view.centerXAnchor, constant: 0),
            favUsersButton.heightAnchor.constraint  (equalToConstant: 50),
            favUsersButton.widthAnchor.constraint   (equalToConstant: 240),
            
            favTwitsButton.topAnchor.constraint     (equalTo: favUsersButton.bottomAnchor, constant: 20),
            favTwitsButton.centerXAnchor.constraint (equalTo: view.centerXAnchor, constant: 0),
            favTwitsButton.heightAnchor.constraint  (equalToConstant: 50),
            favTwitsButton.widthAnchor.constraint   (equalToConstant: 240),
        ])
    }

}

