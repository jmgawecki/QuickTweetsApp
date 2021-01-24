//
//  FavoriteTweet.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 24/01/2021.
//

import UIKit

struct FavoriteTweet: Encodable, Decodable, Hashable {
    var twitsId:                  String
    
    var name:                     String
    var tweetText:                String
    
    var profileImageUrl:          String?
    var urlToExpandWithSafari:    String?
    
    var likesCounter:             Double
    var retweetCounter:           Double
    var createdAt:                String
}

