//
//  ViewController.swift
//  AwesomeRent
//
//  Created by Ethan Fang on 12/13/14.
//  Copyright (c) 2014 awesomerent. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        var loginVC = ARLoginViewController(nibName: "ARLoginViewController", bundle: nil)
        self.presentViewController(loginVC, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

