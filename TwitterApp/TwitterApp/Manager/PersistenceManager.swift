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
    
    
    
    /// Uses function retreiveFavoritesUsers() to retreive an  array of object from the User Default. Then, append/remove passed object to/from the array and uses function saveUsers() to upload the updated array to User Default
    /// - Parameters:
    ///   - favoriteUser: Specified favorite users that is going to be added/removed to/from Favorites
    ///   - persistenceAction: Specifies wether speicifed user is going to be added or retreived
    ///   - completed: upon completion saves updated users array or return user readable error
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
    
    
    /// Retreive an array of object from User Default
    static func retrieveFavoritesUsers(completed: @escaping(Result<[User],TwitterErrors>) -> Void) {
        guard let favUsersData = defaults.object(forKey: Keys.users) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder         = JSONDecoder()
            let favoriteUsers   = try decoder.decode([User].self, from: favUsersData)
            
            completed(.success(favoriteUsers))
        } catch {
            completed(.failure(.retrieveUserPM))
        }
    }
    
    
    /// Saves array of object to User Default
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
    
    
    /// Uses function retreiveFavoritesTweets() to retreive an  array of object from the User Default. Then, append/remove passed object to/from the array and uses function saveTweets() to upload the updated array to User Default
    /// - Parameters:
    ///   - favoriteTweet: Specified favorite Tweet that is going to be added/removed to/from Favorites
    ///   - persistenceAction: Specifies wether speicifed tweet is going to be added or retreived
    ///   - completed: upon completion saves updated users array or return user readable error
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
    
    
    /// Retreive an array of object from User Default
    static func retrieveFavoritesTweets(completed: @escaping(Result<[FavoriteTweet],TwitterErrors>) -> Void) {
        guard let favTweetsData = defaults.object(forKey: Keys.favoriteTweets) as? Data else {
            completed(.success([]))
            return
        }
        do {
            let decoder         = JSONDecoder()
            let favoriteTweets  = try decoder.decode([FavoriteTweet].self, from: favTweetsData)
            
            completed(.success(favoriteTweets))
        } catch {
            completed(.failure(.retrieveTweetPM))
        }
    }
    
    
    /// Saves array of object to User Default
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
