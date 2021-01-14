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
        swifter.showUser(UserTag.screenName(username), includeEntities: false) { (json) in
            let userJson = json
            let user = User(idStr:                  userJson["id_str"].string!,
                            name:                   userJson["name"].string!,
                            screenName:             userJson["screen_name"].string!,
                            profileImageUrl:        userJson["profile_image_url"].string,
                            profileBackgroundUrl:   userJson["profile_background_image_url"].string,
                            friendsCount:           userJson["friends_count"].double!,
                            followersCount:         userJson["followers_count"].double!,
                            favouritesCount:        userJson["favourites_count"].double!,
                            statusesCount:          userJson["statuses_count"].double!,
                            location:               userJson["location"].string!,
                            createdAt:              userJson["created_at"].string!)
            completed(user)
            
        } failure: { (error) in
            print(error)
        }
    }
    
    func getSingleUsersTweets(userId: String) {
        swifter.getTimeline(for: UserTag.id(userId), customParam: [:], count: 30, sinceID: nil, maxID: nil, trimUser: true, excludeReplies: true, includeRetweets: true, contributorDetails: true, includeEntities: true, tweetMode: .default) { (json) in
            let result = json.array
            print(result)
        } failure: { (error) in
            print(error)
        }

    }
    
    
}

