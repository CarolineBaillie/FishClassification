//
//  DisplayController.swift
//  CatVsDogClassifierSample
//
//  Created by Caroline Baillie on 9/22/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit
import Parse

class DisplayController: UIViewController {
    
    @IBOutlet weak var imageFish: UIImageView!
    @IBOutlet weak var FishType: UILabel!
    
    var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let query = PFQuery(className:"page")
        
        query.getFirstObjectInBackground { (object, error) in
            if error == nil {
                if let profile = object {
                    let label = object?["fishType"]
                    self.FishType.text = label as! String
                    let file = profile["Image"] as! PFFileObject
                    file.getDataInBackground { (data, error) in
                    if error == nil {
                        if let imageData = data {
                            let image = UIImage(data: imageData) //can then display on screen
                            self.imageFish.image = image
                        }
                    }
                }
                }
            }
        }
        
        
    }
    
//    FishType.text = "Hello"

    
}
