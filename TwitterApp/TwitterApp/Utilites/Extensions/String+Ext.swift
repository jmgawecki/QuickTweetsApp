//
//  String+Ext.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 23/01/2021.
//

import Foundation

extension String {
    func formatToTwitterPostDate() -> String {
        let date: [String]          = self.components(separatedBy: " ")
        var formattedHour           = date[3]
        formattedHour.removeLast(3)
        let formattedDateString     =  "\(formattedHour) \(date[1]) \(date[2]) \(date[5])"
        return formattedDateString
    }
    
    
    func removeHTTPSfromTweet() -> String {
        let tweet           = self
        var newTweet        = ""
        var tweetComponents = tweet.components(separatedBy: " ")
        let counter         = Int(tweetComponents.count)
        if tweetComponents[counter - 1].contains("https") {
            tweetComponents.removeLast()
        }
        for word in tweetComponents {
            newTweet.append("\(word) ")
        }
        return newTweet
    }
}
