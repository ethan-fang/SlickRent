//
//  ImageRouter.swift
//  AwesomeRent
//
//  Created by Ethan Fang on 1/5/15.
//  Copyright (c) 2015 awesomerent. All rights reserved.
//

import Foundation
import Alamofire

public enum ImageRouter:URLRequestConvertible {
    case UploadImage();
    
    var method: Alamofire.Method {
        switch self {
        case UploadImage:
            return .POST
        default:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case UploadImage:
            return "/image"
        default:
            return "/"
        }
    }
    
    public var URLRequest: NSURLRequest {
        let URL = NSURL(string: RouterConstants.baseURLString)!
        var fullPath = URL.URLByAppendingPathComponent(path)
        
        if let URLComponents = NSURLComponents(URL: fullPath, resolvingAgainstBaseURL: false) {
            URLComponents.percentEncodedQuery = (URLComponents.percentEncodedQuery != nil ? URLComponents.percentEncodedQuery! + "&" : "") + "clientId=\(RouterConstants.clientId)"
            fullPath = URLComponents.URL!
        }
        
        let mutableURLRequest = NSMutableURLRequest(URL: fullPath)
        mutableURLRequest.HTTPMethod = method.rawValue
        
        switch self {
        case .UploadImage():
            let URL = NSURL(string: RouterConstants.baseURLString)!
            var fullPath = URL.URLByAppendingPathComponent(path)
            
            if let URLComponents = NSURLComponents(URL: fullPath, resolvingAgainstBaseURL: false) {
                URLComponents.percentEncodedQuery = (URLComponents.percentEncodedQuery != nil ? URLComponents.percentEncodedQuery! + "&" : "") + "clientId=\(RouterConstants.clientId)"
                fullPath = URLComponents.URL!
            }
            let mutableURLRequest = NSMutableURLRequest(URL: fullPath)
            mutableURLRequest.HTTPMethod = method.rawValue
            
            let boundaryConstant = "myRandomBoundary12345";
            let contentType = "multipart/form-data;boundary="+boundaryConstant
            mutableURLRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
            
            
            // return URLRequestConvertible and NSData
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: nil).0
        default:
            return mutableURLRequest
        }
    }
}
