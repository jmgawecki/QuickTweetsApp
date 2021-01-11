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
    
    func getUserInfo(with username: String, to user: User) -> JSON {
        var jsonUserArray: [JSON] = []
        var jsonUser: JSON!
        swifter.searchUsers(using: username, page: 1, count: 1, includeEntities: true) { (json) in
            jsonUserArray = json.array ?? []
            print(jsonUserArray)
            jsonUser = jsonUserArray[0]
            
        } failure: { (error) in
            print(error)
        }
        let user = jsonUser.string
        print(user)
    
        return jsonUser
    }
}

/*

*/
