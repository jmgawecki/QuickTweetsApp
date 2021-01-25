//
//  UserSearchVC.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 28/12/2020.
//

import UIKit
import Swifter

final class UserSearchVC: TwetLoadingDataVC {
    
    let logoImgView        = TwitImageView(frame: .zero)
    let searchTextField    = TwitTextField(frame: .zero)
    let searchButton       = TwitButton(backgroundColor: ColorsTwitter.twitterBlue, fontSize: 20, message: "Search for user!")
    
    var isUsernameEntered: Bool { return !searchTextField.text!.isEmpty }
    let isNavigationHidden: Bool = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? true : false
    let isTitleLarge: Bool       = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? false : true
    var user: User!
    
    
    //MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        layoutUI()
        configureUI()
        configureSearchButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(isNavigationHidden, animated: true)
    }
    
    
    //MARK: - @Objective functions
    
    @objc func searchButtonTapped(sender: UIView) {
        self.animateButtonsView(sender)
        guard isUsernameEntered else { return }
        let username = searchTextField.text
        getSingleUser(username: username!)
    }
    
    
    //MARK: - Private Functions
    
    private func getSingleUser(username: String) {
        showLoadingView()
        NetworkManager.shared.getSingleUser(username: username) { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let user):
                self.user               = user
                let destVC              = SearchTweetsVC(user: user)
                destVC.title            = ""
                destVC.username         = "jakubgawecki96"
                self.navigationController?.pushViewController(destVC, animated: true)
                self.searchTextField.text    = ""
            case .failure(_):
                self.presentAlertVCOnMainThread(title: "Oops!", message: "There is no username with that name. Please try again.", buttonTitle: "Ok")
            }
        }
    }
    
    
    private func configureSearchButton() {
        searchButton.addTarget(self, action: #selector(searchButtonTapped(sender:)), for: .touchUpInside)
    }
    
    
    private func keyboardReturnButtonTapped() {
        guard isUsernameEntered else { return }
        let username = searchTextField.text
        getSingleUser(username: username!)
    }
    
    
    //MARK: - Layout configuration
    
    private func configureVC() {
        view.backgroundColor                                    = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles  = isTitleLarge
        navigationController?.setNavigationBarHidden(isNavigationHidden, animated: true)
    }
    
    
    private func configureUI() {
        logoImgView.image          = Images.twitterLogo
        searchTextField.delegate    = self
    }
    
    
    private func layoutUI() {
        view.addSubviews(logoImgView, searchTextField, searchButton)
        
        let imgTopPadding: CGFloat      = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -25 : 25
        let searchTextFPadding: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -25 : 10
        
        NSLayoutConstraint.activate([
            logoImgView.topAnchor.constraint        (equalTo: view.safeAreaLayoutGuide.topAnchor, constant: imgTopPadding),
            logoImgView.centerXAnchor.constraint    (equalTo: view.centerXAnchor),
            logoImgView.heightAnchor.constraint     (equalToConstant: 220),
            logoImgView.widthAnchor.constraint      (equalTo: logoImgView.heightAnchor),
            
            searchTextField.topAnchor.constraint    (equalTo: logoImgView.bottomAnchor, constant: searchTextFPadding),
            searchTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            searchTextField.heightAnchor.constraint (equalToConstant: 46),
            searchTextField.widthAnchor.constraint  (equalToConstant: 240),
            
            searchButton.topAnchor.constraint       (equalTo: searchTextField.bottomAnchor, constant: 20),
            searchButton.centerXAnchor.constraint   (equalTo: view.centerXAnchor, constant: 0),
            searchButton.heightAnchor.constraint    (equalToConstant: 46),
            searchButton.widthAnchor.constraint     (equalToConstant: 240),
        ])
    }
}


//MARK:- Extensions

extension UserSearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        keyboardReturnButtonTapped()
        return true
    }
}
