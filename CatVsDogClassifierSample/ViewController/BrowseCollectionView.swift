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

class BrowseCollectionView: UICollectionViewController {
    
    var Pages : [page]! = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.backgroundColor = UIColor.white
        sessionManager.shared.requestGetPagesBrowse { (success) in
            if (success) {
                self.Pages = sessionManager.shared.BrowsePages
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Pages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let customCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCellCollection", for: indexPath) as! CustomCellCollection
        customCell.fishImage.image = Pages[indexPath.row].Image
        customCell.dateField.text = Pages[indexPath.row].fishType
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
        let customViewController = storyboard.instantiateViewController(withIdentifier: "CatchInfoPageBrowse") as! CatchInfoPageBrowse
        customViewController.row = row
        self.navigationController?.pushViewController(customViewController, animated: true)
    }
    
}


