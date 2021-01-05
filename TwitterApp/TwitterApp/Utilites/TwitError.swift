//
//  TwitError.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 03/01/2021.
//

import UIKit

enum TwitError: String, Error {
    case wrongUrl = "Error with the url"
    case error = "Error with the error"
    case response = "Invalid response"
    case data = "Invalid data"
}
