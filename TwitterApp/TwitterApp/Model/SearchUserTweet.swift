//
//  SearchUserTweet.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 14/01/2021.
//

import UIKit

struct SearchUserTweet: Hashable {
    var user:                           String  // ["user"]["id_str"]
    var repliedToUserId:                String? // ["in_reply_to_user_id_str"]
    var repliedToStatus:                String? // ["in_reply_to_status_id_str"]
    
    var urlToExpandWithSafari:          String? // ["entities"]["urls"]["url"]
    
   
    
    var likesCounter:                   Double // ["favorite_count"]
    var retweetCounter:                 Double // ["retweet_count"]
    
    var createdAt:                      String // ["created_at"]
    
    
    var repliedToScreenName:            String? // in_reply_to_screen_name
    
    var tweetText:                      String // ["text"]
    
//    var usersMentions:                  SearchUserTweetUsersMentions?
}

struct SearchUserTweetUsersMentions {
    var idStr:                          String // ["entities"]["user_mentions"]["id_str"]
    var screenName:                     String // ["entities"]["user_mentions"]["screen_name"]
    var foreName:                       String // ["entities"]["user_mentions"]["name"]
}


/* Optional([{
  "in_reply_to_status_id_str" : null,
  "user" : {
    "id_str" : "4833435755",
    "id" : 4833435755.0
  },
  "in_reply_to_user_id_str" : null,
  "created_at" : "Tue Sep 29 16:20:30 +0000 2020",
  "id_str" : "1310977762564472832",
  "lang" : "en",
  "favorite_count" : 0.0,
  "entities" : {
    "hashtags" : [

    ],
    "symbols" : [

    ],
    "urls" : [
      {
        "indices" : [
          117.0,
          140.0
        ],
        "display_url" : "twitter.com/i/web/status/1…",
        "url" : "https://t.co/8Bu4PJDuzH",
        "expanded_url" : "https://twitter.com/i/web/status/1310977762564472832"
      }
    ],
    "user_mentions" : [
      {
        "id_str" : "186663189",
        "screen_name" : "seanallen_dev",
        "id" : 186663189.0,
        "indices" : [
          3.0,
          17.0
        ],
        "name" : "Sean Allen"
      }
    ]
  },
  "id" : 1.3109777625644728e+18,
  "retweeted" : false,
  "source" : "<a href=\"https://mobile.twitter.com\" rel=\"nofollow\">Twitter Web App</a>",
  "text" : "Hi @seanallen_dev. I am currently following the iOS online course (BSc level dip.) on one of the platforms. Not ent… https://t.co/8Bu4PJDuzH",
  "favorited" : false,
  "coordinates" : null,
  "geo" : null,
  "contributors" : null,
  "retweet_count" : 0.0,
  "place" : null,
  "in_reply_to_screen_name" : null,
  "truncated" : true,
  "in_reply_to_status_id" : null,
  "is_quote_status" : false,
  "in_reply_to_user_id" : null
}])
*/

