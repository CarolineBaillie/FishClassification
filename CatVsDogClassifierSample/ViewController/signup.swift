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
        usernameTextField.layer.borderColor = UIColor.lightGray.cgColor
        emailTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        usernameTextField.layer.borderWidth = 1
        passwordTextField.layer.borderWidth = 1
        emailTextField.layer.borderWidth = 1
        emailTextField.layer.cornerRadius = 7
        usernameTextField.layer.cornerRadius = 7
        passwordTextField.layer.cornerRadius = 7
        usernameTextField.attributedPlaceholder = NSAttributedString(string:usernameTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        passwordTextField.attributedPlaceholder = NSAttributedString(string:passwordTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        emailTextField.attributedPlaceholder = NSAttributedString(string:emailTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        
        usernameTextField.textColor = UIColor.black
        passwordTextField.textColor = UIColor.black
        emailTextField.textColor = UIColor.black
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
