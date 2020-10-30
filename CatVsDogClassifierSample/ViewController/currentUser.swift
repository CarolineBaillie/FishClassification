//
//  currentUser.swift
//  CatVsDogClassifierSample
//
//  Created by Caroline Baillie on 10/27/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit
import Parse

class currentUser : NSObject {
    var username:String
    var id:String
    
    init(username:String, id:String) {
        self.username = username
        self.id = id
    }
}
