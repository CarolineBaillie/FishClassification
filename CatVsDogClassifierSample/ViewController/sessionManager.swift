//
//  sessionManager.swift
//  CatVsDogClassifierSample
//
//  Created by Caroline Baillie on 10/15/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import Parse

class sessionManager: NSObject {
    
    static let shared = sessionManager()
    
    var fishCountArray : [uniqueFishCount]! = []
    var fishCountArrayCreate : [uniqueFishCount]! = []
    var pages : [page]! = []
    var pageArray : [page]! = []
    
    //current vars
    var user : currentUser!
    var AllPages : [page]! = []
    var FishByType : [page]! = []
    var GlobalDict = [String : Int]()
    var AllTypes : [String]! = []
    var BrowsePages : [page]! = []
    
    override init() {
        super.init()
    }
    
    //lastimagetaken ->
    
    func requestGetPages (completion:@escaping (_ success:Bool) -> ()) {
        AllPages.removeAll()
        let query = PFQuery(className: "page")
        query.whereKey("userID", equalTo:user.id)
        query.findObjectsInBackground { (objects, error) in
            // no errors
            if error == nil {
                // if there are objects in the array
                if let returnedObjects = objects {
                    // loop through all objects in array
                    for object in returnedObjects {
                        let file = object["Image"] as! PFFileObject
                        file.getDataInBackground { (data, error) in
                            if error == nil {
                                if let imageData = data {
                                    let image = UIImage(data: imageData) //can then display on screen
                                    let fishData = page(fishType: object["fishType"]! as! String, Image: image!, desc: object["description"]! as! String, location: object["location"]! as! String, catchDate: object["catchDate"]! as! String, weight: object["weight"]! as! String, dimensions: object["dimensions"]! as! String)
                                    // print firstname for all objects
                                    self.AllPages.append(fishData)
                                }
                            }
                        }
                        // print firstname for all objects
                    }
                }
                completion(true)
            }
            else {
                //return false completion if fails
                completion(false)
            }
        }
    }
    
    func UpdateFishCat(completion:@escaping (_ success:Bool) -> ()) {
        var types : [String]! = []
        var dictionary = [String : Int]()
        //change to create new copy rather than attached copy
        for page in AllPages {
            let key = page.fishType
            let keyExists = dictionary[key] != nil
            if (keyExists) {
                dictionary[key]! += 1
            } else {
                types.append(key)
                dictionary[key] = 1
            }
        }
        //sort dict
        AllTypes = types
        GlobalDict = dictionary
        completion(true)
    }
    
    func GetFishByType(fishType:String, completion:@escaping (_ success:Bool) -> ()) {
        var Fish : [page]! = []
        //change to create new copy rather than attached copy
        for page in AllPages {
            let key = page.fishType
            if key == fishType {
                Fish.append(page)
            }
        }
        //sort dict
        FishByType = Fish
        completion(true)
    }
    
    func requestCreateNewPage (page:page, completion:@escaping (_ success:Bool) -> ()) {
        let pg = PFObject(className:"page")
        pg["fishType"] = page.fishType
        pg["description"] = page.desc
        pg["location"] = page.location
        pg["catchDate"] = page.catchDate
        pg["userID"] = user.id
        pg["weight"] = page.weight
        pg["dimensions"] = page.dimensions
        
        // reducing image size
        let image = page.Image
        let actualHeight:CGFloat = image.size.height
        let actualWidth:CGFloat = image.size.width
        let imgRatio:CGFloat = actualWidth/actualHeight
        let maxWidth:CGFloat = 1024.0
        let resizedHeight:CGFloat = maxWidth/imgRatio
        let compressionQuality:CGFloat = 0.5
        
        let rect:CGRect = CGRect(x: 0, y: 0, width: maxWidth, height: resizedHeight)
        UIGraphicsBeginImageContext(rect.size)
        image.draw(in: rect)
        let img: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        let imageData:Data = img.jpegData(compressionQuality: compressionQuality)!
        UIGraphicsEndImageContext()
        
        let imageFinal = UIImage(data: imageData)!
        
        // preping to save image
        let imgData = imageFinal.pngData()
        let imageFile = PFFileObject(name:"image.png", data:imgData!)
        pg["Image"] = imageFile

        pg.saveInBackground { (succeeded, error)  in
            if (succeeded) {
//                The object has been saved.
//                save to local array
                self.AllPages.append(page)
                self.UpdateFishCat { (success) in
                    if success {
                        print("updated dictionary")
                    }
                }
                completion(true)
            } else {
                // There was a problem, check error.description
                print("ERROR!")
                completion(false)
            }
        }
    }
    
    func requestGetPagesBrowse (completion:@escaping (_ success:Bool) -> ()) {
        BrowsePages.removeAll()
        let query = PFQuery(className: "page")
        query.whereKey("userID", notEqualTo: user.id)
        query.limit = 20
        query.findObjectsInBackground { (objects, error) in
            // no errors
            if error == nil {
                // if there are objects in the array
                if let returnedObjects = objects {
                    // loop through all objects in array
                    for object in returnedObjects {
                        let file = object["Image"] as! PFFileObject
                        file.getDataInBackground { (data, error) in
                            if error == nil {
                                if let imageData = data {
                                    let image = UIImage(data: imageData) //can then display on screen
                                    let fishData = page(fishType: object["fishType"]! as! String, Image: image!, desc: object["description"]! as! String, location: object["location"]! as! String, catchDate: object["catchDate"]! as! String, weight: object["weight"]! as! String, dimensions: object["dimensions"]! as! String)
                                        //append to array
                                    self.BrowsePages.append(fishData)
                                }
                            }
                            completion(true)
                        }
                    }
                }
            }
            else {
                //return false completion if fails
                completion(false)
            }
        }
    }
}
