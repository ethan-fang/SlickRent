//
//  ARLoginService.swift
//  AwesomeRent
//
//  Created by Ethan Fang on 12/20/14.
//  Copyright (c) 2014 awesomerent. All rights reserved.
//

import UIKit
import Alamofire

class ARLoginService: NSObject {
    
    class func login(username:String, password:String, handleSuccess:()->Void, handleFailure:(String?)->Void) {
        Alamofire.request(UserRouter.LoginUser(username, password)).responseJSON {(request, response, JSON, error) in
            if let jsonResult = JSON as? Dictionary<String, AnyObject> {
                println(JSON)
                if (jsonResult["error"] != nil) {
                    handleFailure(jsonResult["error"] as? String)
                } else {
                    let userDic: Dictionary<String, String> = jsonResult["user"] as Dictionary<String, String>
                    let userInfo = ARUserInfo(username: userDic["username"]!, password: userDic["password"]!, accessToken: userDic["accessToken"]!, userId: userDic["id"]!)
                    ARUserManager.saveUser(userInfo)
                    handleSuccess()
                }
            }
        }
    }
}
