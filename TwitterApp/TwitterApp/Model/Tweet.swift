//
//  Tweet.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 14/01/2021.
//

import UIKit

struct Tweet: Encodable, Decodable, Hashable {
    var twitsId:                        String
    var user:                           String
    var repliedToUserId:                String?
    var repliedToStatus:                String?
    
    var urlToExpandWithSafari:          String?
    
    var likesCounter:                   Double
    var retweetCounter:                 Double
    
    var createdAt:                      String
    
    
    var repliedToScreenName:            String?
    
    var tweetText:                      String
}

