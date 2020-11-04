//
//  UploadController.swift
//  CatVsDogClassifierSample
//
//  Created by Caroline Baillie on 9/28/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit
import Parse

class UploadController: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    
    var imagePicker = UIImagePickerController()
    
    private var modelDataHandler: ModelDataHandler? =
    ModelDataHandler(modelFileInfo: MobileNet.modelInfo)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        guard modelDataHandler != nil else {
            print(modelDataHandler)
          fatalError("Model set up failed")
        }
    }
    
    @IBAction func uploadPic(_ sender: Any) {
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
}

extension UploadController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            img.image = image
            dismiss(animated: true, completion: nil)
            let pixelBuffer = image.pixelBuffer()!
            let inferenceResults = modelDataHandler?.runModel(onFrame: pixelBuffer)
            guard let inference = inferenceResults?.first else {
                return
            }
            print(inference.label)
            
            //save inference and image to database
            let VC = self.storyboard?.instantiateViewController(withIdentifier: "PicInfo") as! PicInfo
            //sm.shared.lastimagetaken = image
            VC.image = image
            VC.inference = inference.label
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
}
