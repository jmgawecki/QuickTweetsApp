//
//  SearchUserVC.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 28/12/2020.
//

import UIKit

class SearchUserVC: UIViewController {
    
    let twitterLogo     = TwitImageView(frame: .zero)
    let searchTextField = TwitTextField(frame: .zero)
    let searchButton    = TwitButton(backgroundColor: .systemBlue, fontSize: 20, message: "Search for user")
    
    let twitterImage    = UIImage(named: "TwitterLogo")
    var isUsernameEntered: Bool { return !searchTextField.text!.isEmpty }
    
    
    //MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        layoutUI()
        configureSearchButton()
    }
    
    
    //MARK: - @Objective functions
    
    @objc func searchButtonTapped() {
        guard isUsernameEntered else { return }
        let destVC = UserTwitsVC()
        destVC.title = ""
        destVC.username = searchTextField.text
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
    
    
    //MARK: - Layout configuration
    
    private func layoutUI() {
        view.addSubview(twitterLogo)
        view.addSubview(searchTextField)
        view.addSubview(searchButton)
    
        twitterLogo.image = twitterImage
        
        NSLayoutConstraint.activate([
            twitterLogo.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            twitterLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            twitterLogo.heightAnchor.constraint(equalToConstant: 200),
            twitterLogo.widthAnchor.constraint(equalToConstant: 200),
            
            searchTextField.topAnchor.constraint(equalTo: twitterLogo.bottomAnchor, constant: 20),
            searchTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            searchTextField.heightAnchor.constraint(equalToConstant: 50),
            searchTextField.widthAnchor.constraint(equalToConstant: 200),
            
            searchButton.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            searchButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            searchButton.heightAnchor.constraint(equalToConstant: 50),
            searchButton.widthAnchor.constraint(equalToConstant: 200),
        ])
    }
    
}
