//
//  CatchTypeTable.swift
//  CatVsDogClassifierSample
//
//  Created by Caroline Baillie on 9/26/20.
//  Copyright © 2020 Y Media Labs. All rights reserved.
//

import Foundation
import UIKit
import Parse

class CatchTypeTable: UITableViewController {

    var tableData : [uniqueFishCount]! = []
    var tableD = [String : Int]()
    var Ftypes = [String]()
    
    override func viewDidLoad() {
        self.removeSpinner()
        super.viewDidLoad()
        sessionManager.shared.UpdateFishCat { (success) in }
        self.tableD = sessionManager.shared.GlobalDict
        self.Ftypes = sessionManager.shared.AllTypes
        
        //go back only to settings
        let newBackButton = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(CatchTypeTable.back(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
    }
    
    @objc func back(sender: UIBarButtonItem) {
        if let firstViewController = self.navigationController?.viewControllers[2] {
            self.navigationController?.popToViewController(firstViewController, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableD.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let customCell = tableView.dequeueReusableCell(withIdentifier: "CustomCell") as! CustomCell
        let fish = Ftypes[indexPath.row]
        customCell.cellLabel.text = fish
        customCell.cellCount.text = "\(tableD[fish]!)"
        return customCell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Create a variable that you want to send based on the destination view controller
        // You can get a reference to the data by using indexPath shown below
        let fish = Ftypes[indexPath.row]

        // Create an instance of PlayerTableViewController and pass the variable
        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        // Instantiate the desired view controller from the storyboard using the view controllers identifier
        // Cast is as the custom view controller type you created in order to access it's properties and methods
        let customViewController = storyboard.instantiateViewController(withIdentifier: "CatchDateCollectionView") as! CatchDateCollectionView
        customViewController.fish = fish
        self.navigationController?.pushViewController(customViewController, animated: true)
    }
    
}
