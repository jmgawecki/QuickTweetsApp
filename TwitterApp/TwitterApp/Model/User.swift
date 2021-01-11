//
//  User.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 03/01/2021.
//

import UIKit

struct User: Codable {
    
    let idStr:              String      // id
    let screenName:         String      // username
    var name:               String?     // forename, name
    
    var profileImageUrl:    String?     // profile picture
    var profileBannerUrl:   String?     // BackgroundPicture
    
    let friendsCount:       Double      // Following
    let followersCount:     Double      // Followers
    let favouritesCount:    Double      // what that is?
    let statusesCount:      Double      // how many posts in total
    
    var location:           String?
    let createdAt:          Date
}
