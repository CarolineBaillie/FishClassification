//
//  signup.swift
//  CatVsDogClassifierSample
//
//  Created by Caroline Baillie on 9/26/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit
import Parse

class signup: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var buttonStyle: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        buttonStyle.layer.cornerRadius = 7
    }
    
    //get rid of keyboard when touch screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //dismiss keyboard
        usernameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        emailTextField.resignFirstResponder()
    }
    
    @IBAction func signupToggled(_ sender: Any) {
        self.showSpinner()
        //check username and password field are not empty / nil
        let user = PFUser()
        user.username = usernameTextField.text!
        user.password = passwordTextField.text!
        user.email = emailTextField.text!
        user.signUpInBackground { (result, error) in
            if error == nil && result == true {
                //successfully loged in
                //next screen
                let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "settings") as! settings
                self.navigationController?.pushViewController(secondViewController, animated: true)
                
            } else {
                //error display error message
            }
        }
    }
    
}
