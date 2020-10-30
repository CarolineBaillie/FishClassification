//
//  page.swift
//  CatVsDogClassifierSample
//
//  Created by Caroline Baillie on 10/15/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit
import Parse

class page : NSObject {
    var fishType:String
    var desc: String
    var location:String
    var catchDate:String
    var weight:String
    var dimensions:String
    var Image:UIImage
    
    init(fishType:String, Image:UIImage, desc:String, location:String, catchDate:String, weight:String, dimensions:String) {
        self.fishType = fishType
        self.Image = Image
        self.desc = desc
        self.weight = weight
        self.dimensions = dimensions
        self.location = location
        self.catchDate = catchDate
    }
}
