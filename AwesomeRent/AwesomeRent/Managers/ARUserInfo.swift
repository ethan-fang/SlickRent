//
//  ARUserInfo.swift
//  AwesomeRent
//
//  Created by Ethan Fang on 12/20/14.
//  Copyright (c) 2014 awesomerent. All rights reserved.
//

import UIKit

class ARUserInfo: NSObject {
    var username: String = ""
    var password: String = ""
    var accessToken: String = ""
    var userId: String = ""
    
    init(username:String, password:String, accessToken:String, userId:String) {
        self.username = username;
        self.password = password;
        self.accessToken = accessToken
        self.userId = userId
    }
}
