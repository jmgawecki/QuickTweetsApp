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
    
    func getSingleUser(username: String, completed: @escaping(User) -> Void) {
        var user = User(idStr: "",
                        name: "",
                        screenName: "",
                        profileImageUrl: "",
                        profileBackgroundUrl: "",
                        friendsCount: 0,
                        followersCount: 0,
                        favouritesCount: 0,
                        statusesCount: 0,
                        location: "",
                        createdAt: "")
        
        swifter.showUser(UserTag.screenName(username), includeEntities: false) { (json) in
            let userJson = json
            
            user.idStr                  = userJson["id_str"].string!
            user.name                   = userJson["name"].string!
            user.screenName             = userJson["screen_name"].string!
            user.profileImageUrl        = userJson["profile_image_url"].string
            user.profileBackgroundUrl   = userJson["profile_background_image_url"].string
            user.friendsCount           = userJson["friends_count"].double!
            user.followersCount         = userJson["followers_count"].double!
            user.favouritesCount        = userJson["favourites_count"].double!
            user.statusesCount          = userJson["statuses_count"].double!
            user.location               = userJson["location"].string!
            user.createdAt              = userJson["created_at"].string!
            completed(user)
            
        } failure: { (error) in
            print(error)
        }
        
    }
}

