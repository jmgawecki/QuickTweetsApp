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
        let destVC = SearchTweetsVC()
        destVC.title = ""
        notes()
        destVC.username = usernameSearchTextField.text
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
    
    private func notes() {
        let swifter = SwifterSingleton.shared.swifter
//        var jsonResult: [JSON] = []
//                swifter.getHomeTimeline(count: 10, success: { json in
//                    jsonResult = json.array ?? []
//                    print(jsonResult)
//                }, failure: { error in
//                    print("ERROR")
//                })
        var jsonUser: [JSON] = []
        swifter.searchUsers(using: "jakubgawecki96", page: 1, count: 10, includeEntities: true) { (json) in
            jsonUser = json.array ?? []
            print(jsonUser)
        } failure: { (error) in
            print(error)
        }

    }
    
    
    //MARK: - Layout configuration
    
    private func configureUIElements() {
        twitterLogoImageView.image = TwitterPNGs.twitterLogo
        usernameSearchTextField.delegate = self
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