//
//  TwitterErrors.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 03/01/2021.
//

import UIKit

enum TwitterErrors: String, Error {
    case wrongUrl       = "Error with the url"
    case error          = "Error with the error"
    case response       = "Invalid response"
    case data           = "Invalid data"
    case saveUsersPM    = "saveUsersPMError"
    case saveTweetsPM    = "saveTweetsPMError"
    case retrieveUserPM     = "retrievePMError User"
    case userAlreadyinFav   = "That username is already"
    case retrieveTweetPM     = "retrievePMError Tweet"
    case tweetAlreadyinFav   = "That tweet is already"
}
