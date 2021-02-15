//
//  User.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 03/01/2021.
//

import UIKit
import Swifter

struct User: Encodable, Decodable, Hashable {
    
    var idStr:                  String      
    var name:                   String      
    var screenName:             String

    var profileImageUrl:        String?     
    var profileBackgroundUrl:   String?     

    var friendsCount:           Double      
    var followersCount:         Double      
    var followingCount:         Double      
    var statusesCount:          Double      

    var location:               String
    var createdAt:              String
}
