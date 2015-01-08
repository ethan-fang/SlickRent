//
//  ARUploadImageService.swift
//  AwesomeRent
//
//  Created by Ethan Fang on 1/6/15.
//  Copyright (c) 2015 awesomerent. All rights reserved.
//

import UIKit
import Alamofire

class ARUploadImageService: NSObject {
    class func uploadImage(image:UIImage) {
        let imageData = UIImagePNGRepresentation(image)
        
        Alamofire.upload(ImageRouter.UploadImage(), dataFromImageData(imageData))
            .progress { (bytesWritten, totalBytesWritten, totalBytesExpectedToWrite) in
                println("\(totalBytesWritten) / \(totalBytesExpectedToWrite)")
            }
            .responseJSON { (request, response, JSON, error) in
                println("REQUEST \(request)")
                println("RESPONSE \(response)")
                println("JSON \(JSON)")
                println("ERROR \(error)")
                
        }
    }
    
    class func dataFromImageData(imageData:NSData) -> NSData {
        // create upload data to send
        let uploadData = NSMutableData()
        
        // add image
        let boundaryConstant = "myRandomBoundary12345";
        uploadData.appendData("--\(boundaryConstant)\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        uploadData.appendData("Content-Disposition: form-data; name=\"file\"; filename=\"file.png\"\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        uploadData.appendData("Content-Type: image/png\r\n\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)
        uploadData.appendData(imageData)
        uploadData.appendData("\r\n--\(boundaryConstant)--\r\n".dataUsingEncoding(NSUTF8StringEncoding)!)

        return uploadData
    }
}
