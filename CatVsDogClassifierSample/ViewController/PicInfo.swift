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

class PicInfo : UIViewController, UITextFieldDelegate {
    
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
        
//        weightField.delegate = self
        //setup stuff to look nice
        self.descriptionField.backgroundColor = UIColor.white
        locationField.layer.borderColor = UIColor.lightGray.cgColor
        dateField.layer.borderColor = UIColor.lightGray.cgColor
        weightField.layer.borderColor = UIColor.lightGray.cgColor
        dimensionsField.layer.borderColor = UIColor.lightGray.cgColor
        locationField.layer.borderWidth = 1
        dateField.layer.borderWidth = 1
        weightField.layer.borderWidth = 1
        dimensionsField.layer.borderWidth = 1
        locationField.layer.cornerRadius = 7
        dateField.layer.cornerRadius = 7
        weightField.layer.cornerRadius = 7
        dimensionsField.layer.cornerRadius = 7
        locationField.attributedPlaceholder = NSAttributedString(string:locationField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        dateField.attributedPlaceholder = NSAttributedString(string:dateField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        weightField.attributedPlaceholder = NSAttributedString(string:weightField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        dimensionsField.attributedPlaceholder = NSAttributedString(string:dimensionsField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        locationField.textColor = UIColor.black
        dateField.textColor = UIColor.black
        weightField.textColor = UIColor.black
        dimensionsField.textColor = UIColor.black
        
        //date selction thing
        datePicker = UIDatePicker()
        datePicker?.frame = CGRect(x: 0, y: 0, width: 320, height: 90);
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
        self.showSpinner()
        //create new page
        var newPage = page(fishType: inference, Image: image, desc: descriptionField.text, location: locationField.text!, catchDate: dateField.text!, weight:weightField.text!, dimensions: dimensionsField.text!)
        sessionManager.shared.requestCreateNewPage(page: newPage) { (success) in
            if success {
                //go to diff viewController
                let customViewController = self.storyboard?.instantiateViewController(withIdentifier: "CatchTypeTable") as! CatchTypeTable
                self.navigationController?.pushViewController(customViewController, animated: true)
            }
            else {
                //error
                print("failed")
            }
        }
    }
    
    func weightUpdated() {
        
    }
    
    
}
