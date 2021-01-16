//
//  Double+Ext.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 16/01/2021.
//

import UIKit

extension Double {
    func converToKFormatString() -> String {
        if self < 1000 {
            return String(Int(self))
        } else {
            var stringedNumber = String(Int(self))
            stringedNumber.removeLast(2)
            let last = stringedNumber.last
            stringedNumber.removeLast()
            let kFormattedString = "\(stringedNumber).\(last ?? Character(""))k"
            return kFormattedString
        }
    }
}
