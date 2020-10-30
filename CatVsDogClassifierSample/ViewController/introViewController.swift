//
//  introViewController.swift
//  CatVsDogClassifierSample
//
//  Created by Caroline Baillie on 9/26/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit
import Parse

class introViewController: UIViewController {
    
    @IBOutlet weak var signup: UIButton!
    @IBOutlet weak var login: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signup.layer.cornerRadius = 7
        login.layer.cornerRadius = 7
    }
}
