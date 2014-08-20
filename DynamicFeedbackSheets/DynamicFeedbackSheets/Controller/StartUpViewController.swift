//
//  StartUpViewController.swift
//  DynamicFeedbackSheets
//
//  Created by Jan Hennings on 09/06/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

import UIKit

class StartUpViewController: UIViewController, FeedbackSheetManagerDelegate, FeedbackSheetViewControllerDelegate {
    // MARK: Properties
    
    let manager = FeedbackSheetManager(baseURL: "http://beeqn.informatik.uni-hamburg.de/feedback/rest.php/")
    let sheetID = "3"
    
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
        performSegueWithIdentifier("presentFeedbackSheet", sender: sheet)
    }
    
    func feedbackSheetManager(manager: FeedbackSheetManager, didPostSheetWithSuccess success: Bool) {
        println("Posting successful")
    }
    
    func feedbackSheetManager(manager: FeedbackSheetManager, didFailWithError error: NSError) {
        println("Error (feedbackSheetManager didFailWithError) \(error)")
        
    }
    
    // MARK: FeedbackSheetViewControllerDelegate
    
    func feedbackSheetViewController(controller: FeedbackSheetViewController, finishedWithResponse response: NSDictionary!) {
        // next step: posting response
        println("posting \(response)")
        manager.postResponseWithSheetID(sheetID, response: response)
    }
    
    func feedbackSheetViewController(controller: FeedbackSheetViewController, didFailWithError error: NSError) {
        // Error handling
    }
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!)  {
        if segue.identifier == "presentFeedbackSheet" {
            if let navigationController = segue.destinationViewController as? UINavigationController {
                if let sheetViewController = navigationController.topViewController as? FeedbackSheetViewController {
                    sheetViewController.sheet = sender as FeedbackSheet
                    sheetViewController.delegate = self
                }
            }
        }
    }
    
}
