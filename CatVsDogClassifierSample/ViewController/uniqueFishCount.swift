//
//  uniqueFishCount.swift
//  CatVsDogClassifierSample
//
//  Created by Caroline Baillie on 10/15/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import Parse

class uniqueFishCount: NSObject {
    var name : String
    var count : Int
    init (name:String, count:Int) {
        self.name = name
        self.count = count
    }
}
