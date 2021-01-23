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
}

/// Mon Mar 05 22:08:25 +0000 2007
