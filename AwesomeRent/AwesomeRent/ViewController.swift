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
        
//        var storyboard : UIStoryboard = UIStoryboard(name: "Test", bundle: nil)
//        var vc : UIViewController = storyboard.instantiateViewControllerWithIdentifier("Main") as UIViewController
//        self.presentViewController(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

