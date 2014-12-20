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
        
        ARApiClient.sharedInstance.login(emailTextField.text, password:passwordTextField.text)
    }
    
    
    @IBAction func onPressSignUp(sender: UIButton) {
        println("Sign up");
    }

    

}
