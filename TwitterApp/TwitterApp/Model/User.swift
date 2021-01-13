//
//  User.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 03/01/2021.
//

import UIKit
import Swifter

struct User {
    
    var idStr:                  String       // id
    var name:                   String      // forename, name
    var screenName:             String

    var profileImageUrl:        String      // profile picture
    var profileBackgroundUrl:   String      // BackgroundPicture

    var friendsCount:           String      // Following
    var followersCount:         String      // Followers
    var favouritesCount:        String      // what that is?
    var statusesCount:          String      // how many posts in total

    var location:               String
    var createdAt:              String
//
//    let description:        String
//
//    let verified:           String       // Wether profile was verified or nah
    
}
//
//struct TweetApiResponse {
//    var singleUser = [User]()
//}
//
//extension TweetApiResponse {
//    init?(json: JSON) {
//        guard let idStr             = json["id_str"].string,                        // good
//            let name                = json["name"].string,                          // good
//            let screenName          = json["screen_name"].string,                   // good
//            let profileImageUrl     = json["profile_image_url"].string,             // good
//            let profileBannerUrl    = json["profile_background_image_url"].string,  // good
//            let friendsCount        = json["friends_count"].string,                 // good
//            let followersCount      = json["followers_count"].string,               // good
//            let favouritesCount     = json["favourites_count"].string,              // good
//            let statusesCount       = json["statuses_count"].string,                // good
//            let location            = json["location"].string,                      // good
//            let createdAt           = json["created_at"].string                     // good
////            let verified            = json["verified"].string,                      // good
////            let bio                 = json["description"].string
//        else {
//            return nil
//        }
//        
//        let user = User(idStr: idStr,
//                        name: name,
//                        screenName: screenName,
//                        profileImageUrl: profileImageUrl,
//                        profileBannerUrl: profileBannerUrl,
//                        friendsCount: friendsCount,
//                        followersCount: followersCount,
//                        favouritesCount: favouritesCount,
//                        statusesCount: statusesCount,
//                        location: location,
//                        createdAt: createdAt)
//        singleUser.append(user)
//    }
//}


