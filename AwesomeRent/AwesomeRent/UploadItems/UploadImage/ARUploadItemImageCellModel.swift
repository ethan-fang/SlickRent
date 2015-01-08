//
//  ARUploadItemImageCellModel.swift
//  AwesomeRent
//
//  Created by Ethan Fang on 1/7/15.
//  Copyright (c) 2015 awesomerent. All rights reserved.
//

import UIKit

class ARUploadItemImageCellModel: NSObject {
    var isCamera:Bool!
    var photo:UIImage!
    
    init(isCamera:Bool, photo:UIImage?) {
        self.isCamera = isCamera
        self.photo = photo
    }
}
