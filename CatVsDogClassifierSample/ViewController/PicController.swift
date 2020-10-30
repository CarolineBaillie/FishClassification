//
//  PicController.swift
//  CatVsDogClassifierSample
//
//  Created by Caroline Baillie on 9/22/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit
import Parse

class PicController: UIViewController {
    

    @IBOutlet weak var img: UIImageView!
    
    let pickerController = UIImagePickerController()
    
    private var modelDataHandler: ModelDataHandler? =
    ModelDataHandler(modelFileInfo: MobileNet.modelInfo)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        pickerController.sourceType = UIImagePickerController.SourceType.camera
        pickerController.delegate = self
        guard modelDataHandler != nil else {
          fatalError("Model set up failed")
        }
        
    }

    @IBAction func onClickTakePic(_ sender: Any) {
        present(pickerController, animated: true, completion: nil)
    }
}

extension PicController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
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
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        //close out (camera has been closed)
    }
}
