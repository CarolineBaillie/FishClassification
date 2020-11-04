//
//  settings.swift
//  CatVsDogClassifierSample
//
//  Created by Caroline Baillie on 9/26/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit
import Parse

class settings: UIViewController, UINavigationControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sessionManager.shared.requestGetPages { (success) in
            if success {
                self.removeSpinner()
            }
        }
        
        var objVC: UIViewController? = storyboard!.instantiateViewController(withIdentifier: "settings")
        var aObjNavi = UINavigationController(rootViewController: objVC!)
        
        let newBackButton = UIBarButtonItem(title: "Logout", style: UIBarButtonItem.Style.plain, target: self, action: #selector(settings.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    @objc func back(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
