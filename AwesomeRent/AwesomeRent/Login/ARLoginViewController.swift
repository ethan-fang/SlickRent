//
//  ARLoginViewController.swift
//  AwesomeRent
//
//  Created by Ethan Fang on 12/13/14.
//  Copyright (c) 2014 awesomerent. All rights reserved.
//

import UIKit

class ARLoginViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func onPressLogIn(sender: UIButton) {
        println("Login \(self.emailTextField.text)");
        
        ARLoginService.login(emailTextField.text, password: passwordTextField.text, handleSuccess: { () -> Void in
            let profileVC = ARProfileViewController(nibName: "ARProfileViewController", bundle: nil)
            let navigationVC = UINavigationController(rootViewController: profileVC)
            self.presentViewController(navigationVC, animated: true, completion: nil)
        }, handleFailure: { (errorString) -> Void in
            ARAlertUtils.showAlert("login fails", message: errorString!)
        })
    }
    
    
    @IBAction func onPressSignUp(sender: UIButton) {
        println("Sign up");
    }

    

}
