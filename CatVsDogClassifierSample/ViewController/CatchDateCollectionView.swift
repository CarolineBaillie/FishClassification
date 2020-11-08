//
//  CatchDateCollectionView.swift
//  CatVsDogClassifierSample
//
//  Created by Caroline Baillie on 9/26/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit
import Parse

class CatchDateCollectionView: UICollectionViewController {
    var fish : String?
    var dates = [String]()
    var images = [UIImage]()
    var id : String?
    
    var collectionData : [page]! = []
    var Pages : [page]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set bcolor
        self.collectionView.backgroundColor = UIColor.white
        
        sessionManager.shared.requestGetPage { (success) in
            if success {
                self.collectionData = sessionManager.shared.pageArray
                self.collectionView.reloadData()
            }
        }
        sessionManager.shared.GetFishByType(fishType: fish!) { (success) in
            if success {
                self.Pages = sessionManager.shared.FishByType
            }
        }
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Pages.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCellCollection", for: indexPath) as! CustomCellCollection
        customCell.fishImage.image = Pages[indexPath.row].Image
        customCell.dateField.text = Pages[indexPath.row].catchDate
        return customCell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //change color to white
        if let cell = collectionView.cellForItem(at: indexPath) as? CustomCellCollection {
            cell.backgroundColor = UIColor.white
        }

        // Create an instance of PlayerTableViewController and pass the variable
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let row = indexPath.row
        // Instantiate the desired view controller from the storyboard using the view controllers identifier
        // Cast is as the custom view controller type you created in order to access it's properties and methods
        let customViewController = storyboard.instantiateViewController(withIdentifier: "CatchInfoPage") as! CatchInfoPage
        customViewController.row = row
        self.navigationController?.pushViewController(customViewController, animated: true)
    }
    
}

