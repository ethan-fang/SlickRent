//
//  ARUploadItemAttributeListItemCellModel.swift
//  AwesomeRent
//
//  Created by Ethan Fang on 1/6/15.
//  Copyright (c) 2015 awesomerent. All rights reserved.
//

import UIKit

class ARUploadItemAttributeListItemCellModel: NSObject {
    var isChecked:Bool!
    var title:String!
    var details:String!

    init(isChecked:Bool, title:String?, details:String?) {
        self.isChecked = isChecked
        self.title = title
        self.details = details
    }
}
