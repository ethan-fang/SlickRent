//
//  ARUploadItemAttributeListItemCell.swift
//  AwesomeRent
//
//  Created by Ethan Fang on 1/6/15.
//  Copyright (c) 2015 awesomerent. All rights reserved.
//

import UIKit

class ARUploadItemAttributeListItemCell: UICollectionViewCell {
        
    let kUncheckImageName:NSString   =   "check_mark_0"
    let kCheckImageName:NSString     =   "check_mark_1"
    
    @IBOutlet var checkImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var detailsLabel: UILabel!
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    var model:ARUploadItemAttributeListItemCellModel! {
        didSet {
            let imageName = model.isChecked == true ? kCheckImageName : kUncheckImageName
            checkImageView.image = UIImage(named: imageName)
            titleLabel.text = model.title
            detailsLabel.text = model.details
            
            self.layoutIfNeeded()
            self.updatePreferredMaxLayoutWidth()
            self.layoutIfNeeded()
        }
    }

    func updatePreferredMaxLayoutWidth() {
        let titleWidth = self.titleLabel.frame.size.width
        self.titleLabel.preferredMaxLayoutWidth = titleWidth
        
        let detailsWidth = self.detailsLabel.frame.size.width
        self.detailsLabel.preferredMaxLayoutWidth = detailsWidth
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let contentViewIsAutosized = CGSizeEqualToSize(self.frame.size, self.contentView.frame.size)
        if !contentViewIsAutosized {
            var contentViewFrame:CGRect = self.contentView.frame
            contentViewFrame = CGRectMake(contentViewFrame.origin.x, contentViewFrame.origin.y, self.contentView.frame.size.width, self.contentView.frame.size.height)
            self.contentView.frame = contentViewFrame
        }
    }
    
    func cellHeight() -> CGFloat {
        let height = self.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
        
        println("titleLabel:\(titleLabel.frame)")
        println("detailsLabel:\(detailsLabel.frame)")
        println("Height:\(height)")
        return height;
    }
}
