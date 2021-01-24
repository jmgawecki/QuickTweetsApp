//
//  PersistenceManager.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 14/01/2021.
//

import UIKit

enum PersisenceAction {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let users          = "users"
        static let tweets         = "tweets"
        static let favoriteTweets = "favoriteTweets"
    }
    
    static func updateWithUsers(favoriteUser: User, persistenceAction: PersisenceAction, completed: @escaping(TwitterErrors?) -> Void) {
        retrieveFavoritesUsers { (result) in
            switch result {
            case .success(var users):
                switch persistenceAction {
                case .add:
                    let filterUser = users.filter { $0.idStr == favoriteUser.idStr }
                    guard filterUser.isEmpty else {
                        completed(.userAlreadyinFav)
                        return
                    }
                    
                    users.append(favoriteUser)
                    
                case .remove:
                    users.removeAll() { $0.idStr == favoriteUser.idStr }
                }
                
                completed(saveUsers(favoriteUsers: users))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveFavoritesUsers(completed: @escaping(Result<[User],TwitterErrors>) -> Void) {
        guard let favUsersData = defaults.object(forKey: Keys.users) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let favoriteUsers = try decoder.decode([User].self, from: favUsersData)
            completed(.success(favoriteUsers))
        } catch {
            completed(.failure(.retrieveUserPM))
        }
    }
    
    static func saveUsers(favoriteUsers: [User]) -> TwitterErrors? {
        do {
            let encoder             = JSONEncoder()
            let encodedFavorites    = try encoder.encode(favoriteUsers)
            defaults.set(encodedFavorites, forKey: Keys.users)
            return nil
        } catch {
            return .saveUsersPM
        }
    }
    
    static func updateWithTweets(favoriteTweet: FavoriteTweet, persistenceAction: PersisenceAction, completed: @escaping(TwitterErrors?) -> Void) {
        retrieveFavoritesTweets { (result) in
            switch result {
            case .success(var tweets):
                switch persistenceAction {
                case .add:
                    let filterTweets = tweets.filter { $0.twitsId == favoriteTweet.twitsId }
                    guard filterTweets.isEmpty else {
                        completed(.tweetAlreadyinFav)
                        return
                    }
                    
                    tweets.append(favoriteTweet)
                    
                case .remove:
                    tweets.removeAll() { $0.twitsId == favoriteTweet.twitsId }
                }
                
                completed(saveTweets(favoriteUsers: tweets))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveFavoritesTweets(completed: @escaping(Result<[FavoriteTweet],TwitterErrors>) -> Void) {
        guard let favTweetsData = defaults.object(forKey: Keys.favoriteTweets) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder = JSONDecoder()
            let favoriteTweets = try decoder.decode([FavoriteTweet].self, from: favTweetsData)
            completed(.success(favoriteTweets))
        } catch {
            completed(.failure(.retrieveTweetPM))
        }
    }
    
    static func saveTweets(favoriteUsers: [FavoriteTweet]) -> TwitterErrors? {
        do {
            let encoder             = JSONEncoder()
            let encodedFavorites    = try encoder.encode(favoriteUsers)
            defaults.set(encodedFavorites, forKey: Keys.favoriteTweets)
            return nil
        } catch {
            return .saveTweetsPM
        }
    }
}
