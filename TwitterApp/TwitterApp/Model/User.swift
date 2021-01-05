//
//  User.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 03/01/2021.
//

import UIKit

struct User: Codable {
    var createdAt: Date
    var id: Int
    var name: String
    var location: String
    var description: String
    var profileImageUrl: String
    var verified: Bool
    var protected: Bool
    var username: String
}
