//
//  SwifterSingleton.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 11/01/2021.
//

import UIKit
import Swifter

struct SwifterSingleton {
    
    static let shared = SwifterSingleton()
    
    let swifter = Swifter(consumerKey: APIConsumerKeys.keyApi, consumerSecret: APIConsumerKeys.secretKeyApi)
    
    private init() {}
    
    func getSingleUser(username: String) -> User {
        var user: User!
        
        swifter.searchUsers(using: username, page: 1, count: 1, includeEntities: true) { (json) in
            let userJson = json[0]
            user.idStr                  = userJson["id_str"].string!
            user.name                   = userJson["name"].string!
            user.screenName             = userJson["screen_name"].string!
            user.profileImageUrl        = userJson["profile_image_url"].string!
            user.profileBackgroundUrl   = userJson["profile_background_image_url"].string!
            user.friendsCount           = userJson["friends_count"].string!
            user.followersCount         = userJson["followers_count"].string!
            user.favouritesCount        = userJson["favourites_count"].string!
            user.statusesCount          = userJson["statuses_count"].string!
            user.location               = userJson["location"].string!
            user.createdAt              = userJson["created_at"].string!
        } failure: { (error) in
            print(error)
        }

        return user
    }
 }

