//
//  String+Ext.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 16/01/2021.
//

import UIKit

extension String {
    
    func createFormattedSwifterDateString() -> String {
        var stringsArray = self.components(separatedBy: " ")
        let dateString: String!
        stringsArray.remove(at: 4)
        let hourString = stringsArray[3].dropLast(3)
        dateString = "\(hourString) \(stringsArray[2]) \(stringsArray[1]) \(stringsArray[4])"
        return dateString
    }
}
