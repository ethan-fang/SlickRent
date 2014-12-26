//
//  ARCameraUtils.swift
//  AwesomeRent
//
//  Created by Ethan Fang on 12/24/14.
//  Copyright (c) 2014 awesomerent. All rights reserved.
//

import UIKit
import MobileCoreServices

class ARCameraUtils: NSObject {
    class func isCameraAvailable() -> Bool{
        return UIImagePickerController.isSourceTypeAvailable(.Camera)
    }
    
    class func cameraSupportsMedia(mediaType: String,
        sourceType: UIImagePickerControllerSourceType) -> Bool{
            
            let availableMediaTypes =
            UIImagePickerController.availableMediaTypesForSourceType(sourceType) as
                [String]?
            
            if let types = availableMediaTypes{
                for type in types{
                    if type == mediaType{
                        return true
                    }
                }
            }
            
            return false
    }
    
    class func doesCameraSupportShootingVideos() -> Bool{
        return cameraSupportsMedia(kUTTypeMovie as NSString, sourceType: .Camera)
    }
    
    class func doesCameraSupportTakingPhotos() -> Bool{
        return cameraSupportsMedia(kUTTypeImage as NSString, sourceType: .Camera)
    }
    
    class func isFrontCameraAvailable() -> Bool{
        return UIImagePickerController.isCameraDeviceAvailable(.Front)
    }
    
    class func isRearCameraAvailable() -> Bool{
        return UIImagePickerController.isCameraDeviceAvailable(.Rear)
    }
    
    class func isFlashAvailableOnFrontCamera() -> Bool{
        return UIImagePickerController.isFlashAvailableForCameraDevice(.Front)
    }
    
    class func isFlashAvailableOnRearCamera() -> Bool{
        return UIImagePickerController.isFlashAvailableForCameraDevice(.Front)
    }
}
