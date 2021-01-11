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
}
