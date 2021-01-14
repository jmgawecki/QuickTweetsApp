//
//  UserSearchVC.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 28/12/2020.
//

import UIKit
import Swifter

class UserSearchVC: UIViewController {
    
    let twitterLogoImageView        = TwitImageView(frame: .zero)
    let usernameSearchTextField     = TwitTextField(frame: .zero)
    let searchButton                = TwitButton(backgroundColor: ColorsTwitter.twitterBlue, fontSize: 20, message: "Search for user!")
    
    var isUsernameEntered: Bool { return !usernameSearchTextField.text!.isEmpty }
    var user: User!
    
    
    //MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        layoutUI()
        configureUIElements()
        configureSearchButton()
        
    }
    
    
    //MARK: - @Objective functions
    
    @objc func searchButtonTapped() {
        guard isUsernameEntered else { return }
        let username = usernameSearchTextField.text
        getSingleUser(username: username!)
    }
    
    
    //MARK: - Private Functions
    
    private func getSingleUser(username: String) {
        NetworkManager.shared.getSingleUser(username: username) { (user) in
            
        }
        NetworkManager.shared.getSingleUser(username: username) { (result) in
            switch result {
            case .success(let user):
                self.user               = user
                let destVC              = SearchTweetsVC(user: user)
                destVC.title            = ""
                destVC.username         = "jakubgawecki96"
                self.navigationController?.pushViewController(destVC, animated: true)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func configureVC() {
        view.backgroundColor                                    = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles  = true
    }
    
    private func configureSearchButton() {
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    
    //MARK: - Layout configuration
    
    private func configureUIElements() {
        twitterLogoImageView.image          = TwitterPNGs.twitterLogo
        usernameSearchTextField.delegate    = self
    }
    
    private func layoutUI() {
        view.addSubview(twitterLogoImageView)
        view.addSubview(usernameSearchTextField)
        view.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            twitterLogoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            twitterLogoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            twitterLogoImageView.heightAnchor.constraint(equalToConstant: 220),
            twitterLogoImageView.widthAnchor.constraint(equalTo: twitterLogoImageView.heightAnchor),
            
            usernameSearchTextField.topAnchor.constraint(equalTo: twitterLogoImageView.bottomAnchor, constant: 10),
            usernameSearchTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            usernameSearchTextField.heightAnchor.constraint(equalToConstant: 46),
            usernameSearchTextField.widthAnchor.constraint(equalToConstant: 240),
            
            searchButton.topAnchor.constraint(equalTo: usernameSearchTextField.bottomAnchor, constant: 20),
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
            searchButton.widthAnchor.constraint(equalToConstant: 240),
        ])
    }
}

extension UserSearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchButtonTapped()
        return true
    }
}
