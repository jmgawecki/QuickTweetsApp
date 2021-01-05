//
//  URLs.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 03/01/2021.
//

import UIKit

struct URLs {
    static let baseUrlWithToken = "curl --location --request GET -H \"Authorization: Bearer AAAAAAAAAAAAAAAAAAAAACOxKwEAAAAAiYCwNb6rvaPjJXFeA1YmSD5NFng%3DKQXGHVxsXPbHE4nsBVb3jLCjGoGmCln6z9bP83ta5Cth8kHJtl\" "
    static let endUrlReturnUserInfo = "'https://api.twitter.com/2/users/by?usernames=jakubgawecki96&user.fields=created_at,description,entities,id,location,name,pinned_tweet_id,profile_image_url,protected,url,username,verified,withheld&expansions=pinned_tweet_id&tweet.fields=attachments,author_id,conversation_id,created_at,entities,geo,id,in_reply_to_user_id,lang,possibly_sensitive,referenced_tweets,source,text,withheld'"
}
