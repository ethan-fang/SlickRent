//
//  ARMainViewController.swift
//  AwesomeRent
//
//  Created by Ethan Fang on 12/20/14.
//  Copyright (c) 2014 awesomerent. All rights reserved.
//

import UIKit

class ARProfileViewController: UIViewController {

    @IBOutlet var userNameLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var accessTokenLabel: UILabel!
    @IBOutlet var userIdLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCancenButton()

        userNameLabel.text = ARUserManager.username()
        passwordLabel.text = ARUserManager.password()
        accessTokenLabel.text = ARUserManager.accessToken()
        userIdLabel.text = ARUserManager.userId()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupCancenButton() {
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "onPressCancelButton:")
        self.navigationItem.rightBarButtonItem = cancelButton
    }
    
    func onPressCancelButton(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
