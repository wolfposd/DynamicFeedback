//
//  StartUpViewController.swift
//  DynamicFeedbackSheets
//
//  Created by Jan Hennings on 09/06/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

import UIKit

class StartUpViewController: UIViewController, FeedbackSheetManagerDelegate {
    // MARK: Properties
    
    let manager = FeedbackSheetManager(baseURL: "http://beeqn.informatik.uni-hamburg.de/feedback/rest.php/")
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: IBActions
    
    @IBAction func startFetch(sender: UIButton) {
        manager.startFetchingSheetWithID("3")
    }
    
    // MARK: FeedbackSheetManagerDelegate
    
    func feedbackSheetManager(manager: FeedbackSheetManager, didFinishFetchingSheet sheet: FeedbackSheet) {
        println("Fetch callback")
        performSegueWithIdentifier("presentFeedbackSheet", sender: sheet)
    }
    
    func feedbackSheetManager(manager: FeedbackSheetManager, didPostSheetWithSuccess success: Bool) {
        
    }
    
    func feedbackSheetManager(manager: FeedbackSheetManager, didFailWithError error: NSError) {
        println("Error \(error)")
        
    }
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!)  {
        if segue.identifier == "presentFeedbackSheet" {
            if let sheetViewController = segue.destinationViewController as? FeedbackSheetTableViewController {
                sheetViewController.sheet = sender as FeedbackSheet
            }
        }
    }
    
}
