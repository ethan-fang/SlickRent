//
//  ARSignupViewController.swift
//  AwesomeRent
//
//  Created by Ethan Fang on 12/24/14.
//  Copyright (c) 2014 awesomerent. All rights reserved.
//

import UIKit

class ARSignupViewController: UIViewController {
    
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCancenButton()
    }
    
    func setupCancenButton() {
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .Plain, target: self, action: "onPressCancelButton:")
        self.navigationItem.rightBarButtonItem = cancelButton
    }
    
    func onPressCancelButton(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onPressSignup(sender: UIButton) {
        ARSignupService.signup(usernameTextField.text, password: passwordTextField.text, handleSuccess: { () -> Void in
            let profileVC = ARProfileViewController(nibName: "ARProfileViewController", bundle: nil)
            let navigationVC = UINavigationController(rootViewController: profileVC)
            self.presentViewController(navigationVC, animated: true, completion: nil)
            }, handleFailure: { (errorString) -> Void in
                ARAlertUtils.showAlert("login fails", message: errorString!)
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
