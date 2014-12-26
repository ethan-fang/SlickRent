//
//  UserManager.swift
//  AwesomeRent
//
//  Created by Ethan Fang on 12/20/14.
//  Copyright (c) 2014 awesomerent. All rights reserved.
//

import UIKit

enum ARUserManager {
    static let kUserName = "username"
    static let kAccessToken = "accessToken"
    static let kPassword = "password"
    static let kUserId = "userId"
    
    static func saveUser(userInfo:ARUserInfo) {
        var userDefaults = NSUserDefaults.standardUserDefaults()
        userDefaults.setValue(userInfo.username, forKey: ARUserManager.kUserName)
        userDefaults.setValue(userInfo.accessToken, forKey: ARUserManager.kAccessToken)
        userDefaults.setValue(userInfo.password, forKey: ARUserManager.kPassword)
        userDefaults.setValue(userInfo.userId, forKey: ARUserManager.kUserId)
        userDefaults.synchronize()
    }
    
    static func isUserAuthenticated() -> Bool {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        return userDefaults.valueForKey(ARUserManager.kUserName)?.length > 0
    }
    
    static func username() -> String {
        return NSUserDefaults.standardUserDefaults().valueForKey(ARUserManager.kUserName) as String
    }

    static func accessToken() -> String {
        return NSUserDefaults.standardUserDefaults().valueForKey(ARUserManager.kAccessToken) as String
    }
    
    static func password() -> String {
        return NSUserDefaults.standardUserDefaults().valueForKey(ARUserManager.kPassword) as String
    }
    
    static func userId() -> String {
        return NSUserDefaults.standardUserDefaults().valueForKey(ARUserManager.kUserId) as String
    }
}
