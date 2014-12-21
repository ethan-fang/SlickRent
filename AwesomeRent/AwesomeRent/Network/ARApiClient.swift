//
//  ARApiClient.swift
//  AwesomeRent
//
//  Created by Ethan Fang on 12/14/14.
//  Copyright (c) 2014 awesomerent. All rights reserved.
//

import UIKit
import Alamofire

public class ARApiClient: NSObject {
    var counter = 0
    
    private var baseURL: String
    
    let clientId = "e7568b2c-2c0f-480e-9e34-08f9a4b807dc"
    
    class var sharedInstance : ARApiClient {
        struct Singleton {
            static let instance = ARApiClient()
        }
        return Singleton.instance
    }
    
    override init() {
        baseURL = "http://ec2-54-173-114-114.compute-1.amazonaws.com:8080"
    }
    
    public func login(username:String, password:String, handleSuccess:(Dictionary<String, AnyObject>)->Void, handleFailure:(String?)->Void) {
        Alamofire.request(UserRouter.LoginUser(username, password)).responseJSON {(request, response, JSON, error) in
            if let jsonResult = JSON as? Dictionary<String, AnyObject> {
                println(JSON)
                if (jsonResult["error"] != nil) {
                    handleFailure(jsonResult["error"] as? String)
                } else {
                    handleSuccess(jsonResult)
                }
            }
        }
    }
    
    public func signup() {
        
    }
}
