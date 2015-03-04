//
//  ARAlertUtils.swift
//  AwesomeRent
//
//  Created by Ethan Fang on 12/20/14.
//  Copyright (c) 2014 awesomerent. All rights reserved.
//

import UIKit

class ARAlertUtils: NSObject {
    class func showAlert(title:String, message:String) {
        let alert = UIAlertView()
        alert.title = title
        alert.message = message
        alert.addButtonWithTitle("OK")
        alert.show()
    }

}

