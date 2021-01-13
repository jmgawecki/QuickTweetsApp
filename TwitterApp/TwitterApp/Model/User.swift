//
//  User.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 03/01/2021.
//

import UIKit
import Swifter

struct User {
    
    var idStr:                  String      // id
    var name:                   String      // forename, name
    var screenName:             String

    var profileImageUrl:        String?     // profile picture
    var profileBackgroundUrl:   String?     // BackgroundPicture

    var friendsCount:           Double      // Following
    var followersCount:         Double      // Followers
    var favouritesCount:        Double      // what that is?
    var statusesCount:          Double      // how many posts in total

    var location:               String
    var createdAt:              String
}
