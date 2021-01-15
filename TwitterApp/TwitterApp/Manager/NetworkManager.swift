//
//  NetworkManager.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 11/01/2021.
//

import UIKit
import Swifter

struct NetworkManager {
    
    static let shared = NetworkManager()
   
    
    let swifter = Swifter(consumerKey: APIConsumerKeys.keyApi, consumerSecret: APIConsumerKeys.secretKeyApi)
    
    private init() {}
    
    func getSingleUser(username: String, completed: @escaping(Result<User, Error>) -> Void) {
        swifter.showUser(UserTag.screenName(username), includeEntities: false) { (json) in
            let userJson = json
            let user = User(idStr:                  userJson["id_str"].string!,
                            name:                   userJson["name"].string!,
                            screenName:             userJson["screen_name"].string!,
                            profileImageUrl:        userJson["profile_image_url_https"].string,
                            profileBackgroundUrl:   userJson["profile_background_image_url_https"].string,
                            friendsCount:           userJson["friends_count"].double!,
                            followersCount:         userJson["followers_count"].double!,
                            favouritesCount:        userJson["favourites_count"].double!,
                            statusesCount:          userJson["statuses_count"].double!,
                            location:               userJson["location"].string!,
                            createdAt:              userJson["created_at"].string!)
            completed(.success(user))
            
        } failure: { (error) in
            completed(.failure(error))
        }
    }
    
    func getSingleUsersTweets(userId: String, completed: @escaping([SearchUserTweet]) -> Void) {
        swifter.getTimeline(for: UserTag.id(userId), customParam: [:], count: 40, sinceID: nil, maxID: nil, trimUser: true, excludeReplies: true, includeRetweets: true, contributorDetails: true, includeEntities: true, tweetMode: .default) { (json) in
            let result = json.array ?? []
            var searchedUserTweets = [SearchUserTweet]()
            for tweet in result {
                let tweetObject = SearchUserTweet(twitsId: tweet["id_str"].string!,
                                                  user: tweet["user"]["id_str"].string!,
                                                  repliedToUserId: tweet["in_reply_to_user_id_str"].string,
                                                  repliedToStatus: tweet["in_reply_to_status_id_str"].string,
                                                  urlToExpandWithSafari: tweet["entities"]["urls"][0]["url"].string,
                                                  likesCounter: tweet["favorite_count"].double!,
                                                  retweetCounter: tweet["retweet_count"].double!,
                                                  createdAt: tweet["created_at"].string!,
                                                  repliedToScreenName: tweet["in_reply_to_screen_name"].string,
                                                  tweetText: tweet["text"].string!)
                searchedUserTweets.append(tweetObject)
            }
            completed(searchedUserTweets)
        } failure: { (error) in
            print(error)
        }
    }
    
    func downloadImage(from urlString: String, completed: @escaping(UIImage?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard error == nil,
                  let _ = response as? HTTPURLResponse,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            completed(image)
        }
        task.resume()
    }
}


