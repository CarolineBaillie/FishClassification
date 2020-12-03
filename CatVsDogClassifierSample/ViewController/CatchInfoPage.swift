//
//  CatchInfoPage.swift
//  CatVsDogClassifierSample
//
//  Created by Caroline Baillie on 9/26/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit
import Parse

class CatchInfoPage: UIViewController {
    
    var row : Int?
    var arrayPage : [page]!
    
    @IBOutlet weak var labelField: UILabel!
    @IBOutlet weak var fishImage: UIImageView!
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var dateField: UILabel!
    @IBOutlet weak var locationField: UILabel!
    @IBOutlet weak var weightField: UILabel!
    @IBOutlet weak var dimensionsField: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.descriptionField.backgroundColor = UIColor.white
        self.arrayPage = sessionManager.shared.FishByType
        self.labelField.text = arrayPage[row!].fishType
        labelField.adjustsFontSizeToFitWidth = labelField.minimumScaleFactor == 0.2
        self.descriptionField.text = arrayPage[row!].desc
        self.dateField.text = arrayPage[row!].catchDate
        self.locationField.text = arrayPage[row!].location
        self.weightField.text = arrayPage[row!].weight
        self.dimensionsField.text = arrayPage[row!].dimensions
        self.fishImage.image = arrayPage[row!].Image
        
    }
}
