//
//  login.swift
//  CatVsDogClassifierSample
//
//  Created by Caroline Baillie on 9/26/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit
import Parse

class login: UIViewController {
    
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
    }
    
    @IBAction func loginToggled(_ sender: Any) {
        PFUser.logInWithUsername(inBackground:usernameTextField.text!, password:passwordTextField.text!) {
          (user, error) -> Void in
          if user != nil {
            var cUser = currentUser(username: user?["username"] as! String, id: user?.objectId as! String)
            sessionManager.shared.user = cUser
            // Do stuff after successful login.
            let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "settings") as! settings
            self.navigationController?.pushViewController(secondViewController, animated: true)
          } else {
            // The login failed. Check error to see why.
            print("incorrect username or password")
          }
        }
    }
    
}
