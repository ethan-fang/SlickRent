//
//  ARUploadItemImageCellCollectionViewCell.swift
//  AwesomeRent
//
//  Created by Ethan Fang on 1/3/15.
//  Copyright (c) 2015 awesomerent. All rights reserved.
//

import UIKit

class ARUploadItemImageCellCollectionViewCell: UICollectionViewCell {

    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var cameraImageView: UIImageView!
    
    let kEmptyPhotoBkgColor = ARColorUtils.UIColorFromRGB(0xF0EEEC)
    let kPhotoBkgColor = ARColorUtils.UIColorFromRGB(0x374047)
    let kCameraBkgColor = ARColorUtils.UIColorFromRGB(0xF7F7F7)
    
    var model:ARUploadItemImageCellModel! {
        didSet{
            photoImageView.hidden = model.isCamera
            cameraImageView.hidden = !model.isCamera
            photoImageView.image = model.photo
            
            self.backgroundColor = model.isCamera == true ? kCameraBkgColor : (model.photo == nil ? kEmptyPhotoBkgColor : kPhotoBkgColor)
        }
    }
    
}
