//
//  PicInfo.swift
//  CatVsDogClassifierSample
//
//  Created by Caroline Baillie on 9/30/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit
import Parse

class PicInfo : UIViewController {
    
    @IBOutlet weak var descriptionField: UITextView!
    @IBOutlet weak var imageTaken: UIImageView!
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var dateField: UITextField!
    @IBOutlet weak var weightField: UITextField!
    @IBOutlet weak var dimensionsField: UITextField!
    
    //date picker stuff
    private var datePicker: UIDatePicker?
    
    var image : UIImage!
    var inference : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(PicInfo.dateChanged(datePicker:)), for: .valueChanged)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(PicInfo.viewTapped(gestureRecognizer:)))
        view.addGestureRecognizer(tapGesture)
        dateField.inputView = datePicker
    }
    @objc func viewTapped(gestureRecognizer:UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        //force first responder to dismiss itself
        dateField.text = dateFormatter.string(from: datePicker.date)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.imageTaken.image = image
    }
    
    //get rid of keyboard when touch screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //dismiss keyboard
        descriptionField.resignFirstResponder()
    }
    
    @IBAction func submitToggled(_ sender: Any) {
        //lower image size in swift
        var newPage = page(fishType: inference, Image: image, desc: descriptionField.text, location: locationField.text!, catchDate: dateField.text!, weight:weightField.text!, dimensions: dimensionsField.text!)
        sessionManager.shared.requestCreatePage(page: newPage) { (success) in
            if success {
                print("worked")
                //go to diff viewController
            }
            else {
                //error
                print("failed")
            }
        }
        
        
        //get count from db? Best way to do?
        let count = 0
        var newTC = uniqueFishCount(name:inference, count:count+1)
        sessionManager.shared.requestCreateTypesCount(tc: newTC) { (success) in
            if success {
                print("worked")
                //go to diff viewController
            }
            else {
                //error
                print("failed")
            }
        }
    }
    
    
}
