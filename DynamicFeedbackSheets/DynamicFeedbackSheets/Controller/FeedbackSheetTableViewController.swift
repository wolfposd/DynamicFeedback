//
//  FeedbackSheetTableViewController.swift
//  DynamicFeedbackSheets
//
//  Created by Jan Hennings on 09/06/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

import UIKit

class FeedbackSheetTableViewController: UITableViewController, ModuleCellDelegate {
    // MARK: Properties
    
    var sheet: FeedbackSheet!

    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int  {
        return sheet.pages.count
    }

    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int  {
        return sheet.pages[section].modulesVisible.count
    }

    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!  {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell

        // Configure the cell...
        cell.textLabel.text = "awesome"

        return cell
    }
    
    // MARK: ModuleCellDelegate
    
    func moduleCell(cell: ModuleCell, didGetResponse response: (key: String, value: Any)) {
        println("Cell Response: \(response)")
    }
}
