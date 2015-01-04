//
//  ARUploadItemImageCellCollectionViewCell.swift
//  AwesomeRent
//
//  Created by Ethan Fang on 1/3/15.
//  Copyright (c) 2015 awesomerent. All rights reserved.
//

import UIKit

class ARUploadItemImageCellCollectionViewCell: UICollectionViewCell {

    @IBOutlet var imageView: UIImageView!
    var image:UIImage?;
    
    func setImage(newImage:UIImage) {
        image = newImage
        imageView.image = image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
