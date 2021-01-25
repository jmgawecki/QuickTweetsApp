//
//  Constants.swift
//  TwitterApp
//
//  Created by Jakub Gawecki on 09/01/2021.
//

import UIKit

enum SFSymbolsAsImg {
    static let followers                = UIImage(systemName: "heart")
    static let following                = UIImage(systemName: "person.2")
    static let shares                   = UIImage(systemName: "square.and.arrow.up")
    static let likes                    = UIImage(systemName: "hand.thumbsup")
    static let plus                     = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
    static let checkmark                = UIImage(systemName: "checkmark", withConfiguration: UIImage.SymbolConfiguration(scale: .large))
    static let refresh                  = UIImage(systemName: "arrow.clockwise")
}

enum SFSymbolsAsStr {
    static let refresh = "arrow.clockwise"
}


enum Images {
    static let twitterLogo              = UIImage(named: "Twitter_Logo_Blue")
    static let twitterLogoBlueOnWhite   = UIImage(named: "Twitter_Logo_WhiteOnBlue")
    static let minus                    = UIImage(systemName: "minus")
}

enum TweetStrings {
    static let inFavorites              = "In Favorites"
    static let addToFavorites           = "Add to Favorites"
    static let removeFromFav            = "Remove"
    static let sthWentWrong             = "Something went wrong, please try again."
    static let seeFull                  = "See Full"
    static let following                = "Following"
    static let followers                = "Followers"
    static let emptyString              = ""
    static let emptyStateMessage        = "Looks like... \nYou have no favorite Users 🧐 \n\nTime to change that!"
    
}

enum ScreenSize {
    static let width                    = UIScreen.main.bounds.size.width
    static let height                   = UIScreen.main.bounds.size.height
    static let maxLength                = max(ScreenSize.width, ScreenSize.height)
    static let minLength                = min(ScreenSize.width, ScreenSize.height)
}


enum DeviceTypes {
    static let idiom                    = UIDevice.current.userInterfaceIdiom
    static let nativeScale              = UIScreen.main.nativeScale
    static let scale                    = UIScreen.main.scale

    static let isiPhoneSE               = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard    = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed      = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiPhoneX                = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr       = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad                   = idiom == .pad && ScreenSize.maxLength >= 1024.0

    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
}

enum ColorsTwitter {
    static let twitterBlue              = UIColor(red: 0.11, green: 0.63, blue: 0.95, alpha: 1.00)
    static let twitterBlack             = UIColor(red: 0.08, green: 0.09, blue: 0.10, alpha: 1.00)
    static let twitterDarkGray          = UIColor(red: 0.40, green: 0.47, blue: 0.53, alpha: 1.00)
    static let twitterLighGray          = UIColor(red: 0.67, green: 0.72, blue: 0.76, alpha: 1.00)
    static let twitterExtraLightGray    = UIColor(red: 0.88, green: 0.91, blue: 0.93, alpha: 1.00)
    static let twitter2ExtraLightGray   = UIColor(red: 0.96, green: 0.97, blue: 0.98, alpha: 1.00)
}

enum APIConsumerKeys {
    
    static let keyApi = "gdmq5546abS5qhfqpBP3Aq3HQ"
    
    static let secretKeyApi = "zxoogfGZrhSAxTvPAaWYBsl3LTj9OENWBg31aUzRSajd1GLXvR"
    
    static let bearerToken = "AAAAAAAAAAAAAAAAAAAAACRSLgEAAAAAB9w8ASqIfczVwqkdcnCMrANdVrE%3DuWCw7fxPon9BkDSsSX3SmBgwkVvIyYCPzDAvACOPHMFpvb6gBB"
    
}

enum TwitterErrors: String, Error {
    case wrongUrl           = "Error with the url"
    case error              = "Error with the error"
    case response           = "Invalid response"
    case data               = "Invalid data"
    case saveUsersPM        = "saveUsersPMError"
    case saveTweetsPM       = "saveTweetsPMError"
    case retrieveUserPM     = "retrievePMError User"
    case userAlreadyinFav   = "That username is already"
    case retrieveTweetPM    = "retrievePMError Tweet"
    case tweetAlreadyinFav  = "That tweet is already"
}

