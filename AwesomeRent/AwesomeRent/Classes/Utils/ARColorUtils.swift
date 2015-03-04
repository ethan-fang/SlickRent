//
//  ARColorUtils.swift
//  AwesomeRent
//
//  Created by Ethan Fang on 1/7/15.
//  Copyright (c) 2015 awesomerent. All rights reserved.
//

import UIKit

class ARColorUtils: NSObject {
    class func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }

}
