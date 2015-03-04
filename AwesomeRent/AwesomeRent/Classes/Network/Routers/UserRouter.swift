//
//  UserRouter.swift
//  AwesomeRent
//
//  Created by Ethan Fang on 12/14/14.
//  Copyright (c) 2014 awesomerent. All rights reserved.


import UIKit
import Alamofire

enum UserRouter: URLRequestConvertible {

    static var OAuthToken: String?
    
    case CreateUser([String: AnyObject])
    case ReadUser(String)
    case UpdateUser(String, [String: AnyObject])
    case DestroyUser(String)
    
    
    case SignupUser(String, String)
    case LoginUser(String, String)
    
    var method: Alamofire.Method {
        switch self {
        case .SignupUser:
            return .POST
        case .LoginUser:
            return .POST
        default:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .SignupUser:
            return "/user/signup"
        case .LoginUser:
            return "/user/signin"
        default:
            return ""
        }
    }
    
    //     MARK: URLRequestConvertible
    
    var URLRequest: NSURLRequest {
        let URL = NSURL(string: RouterConstants.baseURLString)!
        var fullPath = URL.URLByAppendingPathComponent(path)
        
        if let URLComponents = NSURLComponents(URL: fullPath, resolvingAgainstBaseURL: false) {
            URLComponents.percentEncodedQuery = (URLComponents.percentEncodedQuery != nil ? URLComponents.percentEncodedQuery! + "&" : "") + "clientId=\(RouterConstants.clientId)"
            fullPath = URLComponents.URL!
        }
        
        let mutableURLRequest = NSMutableURLRequest(URL: fullPath)
        mutableURLRequest.HTTPMethod = method.rawValue
        
        switch self {
        case .SignupUser(let username, let password):
            let parameters = ["username": username, "password": password]
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
        case .LoginUser(let username, let password):
            let parameters = ["username": username, "password": password]
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
        default:
            return mutableURLRequest
        }
    }
}
