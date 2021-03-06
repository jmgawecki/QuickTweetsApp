//
//  TweetAlertVC.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 24/01/2021.
//

import UIKit

final class TweetAlertVC: UIViewController {
    //MARK: - Declarations
    

    let containerView   = AlertContainerView()
    let titleLabel      = TwitInfoHeaderTitleLabel()
    let messageLabel    = TwitInfoHeaderBodyLabel(textAlignment: .center)
    let actionButton    = TwitButton(backgroundColor: ColorsTwitter.twitterBlue, fontSize: 15, message: "Ok")
    
    var alertTitle:     String?
    var message:        String?
    var buttonTitle:    String?
    
    let padding:        CGFloat = 20
    
    
    //MARK: - Initialisers
    
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle     = title
        self.message        = message
        self.buttonTitle    = buttonTitle
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layoutUI()
        configureUIElements()
    }
    
    
    //MARK: - Objectives
    
    
    @objc func dismissVC() { dismiss(animated: true) }
    
    
    //MARK: - Layout configurations
    
    
    private func configureUIElements() {
        view.backgroundColor        = UIColor.black.withAlphaComponent(0.75)
        titleLabel.text             = alertTitle ?? "Something went wrong"
        messageLabel.text           = message ?? "Unable to complete request"
        messageLabel.numberOfLines  = 4
        
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
    }
    
    
    private func layoutUI() {
        view.addSubviews(containerView, titleLabel, actionButton, messageLabel)
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint  (equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint  (equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint    (equalToConstant: 280),
            containerView.heightAnchor.constraint   (equalToConstant: 220),
            
            titleLabel.topAnchor.constraint         (equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint     (equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint    (equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint      (equalToConstant: 28),
            
            actionButton.bottomAnchor.constraint    (equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint   (equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint  (equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint    (equalToConstant: 44),
            
            messageLabel.topAnchor.constraint       (equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint   (equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint  (equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint    (equalTo: actionButton.topAnchor, constant: -12)
        ])
    }
}
