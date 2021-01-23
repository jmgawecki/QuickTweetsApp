//
//  String+Ext.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 22/01/2021.
//

import Foundation

extension Double {
    func convertToKMFormattedString() -> String {
        if self < 1_000 {
            return String(self)
        } else if self < 1_000_000 {
            let number = self / 1_000
            return String(format: "%.1fK", number)
        } else {
            let number = self / 1_000_000
            return String(format: "%.1fM", number)
        }
    }
}
