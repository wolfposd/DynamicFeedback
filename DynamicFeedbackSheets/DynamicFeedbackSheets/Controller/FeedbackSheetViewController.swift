//
//  FeedbackSheetViewController.swift
//  DynamicFeedbackSheets
//
//  Created by Jan Hennings on 10/06/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

import UIKit

@objc protocol FeedbackSheetViewControllerDelegate {
    func feedbackSheetViewController(controller: FeedbackSheetViewController, finishedWithResponse response: NSDictionary!)
    @optional func feedbackSheetViewController(controller: FeedbackSheetViewController, didFailWithError error: NSError)
}

class FeedbackSheetViewController: UIViewController, FeedbackSheetPageControllerDelegate {
    // MARK: Properties
    
    var sheet: FeedbackSheet! {
    willSet {
        self.title = newValue.title
        var newPages = FeedbackSheetPage[]()
        for page in newValue.pages {
            newPages += page
        }
        pages = newPages
    }
    }
    
    var pages: FeedbackSheetPage[]!
    var pageIndex = 3
    var pageTVC: FeedbackSheetPageTableViewController!
    var delegate: FeedbackSheetViewControllerDelegate?
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: FeedbackSheetPageControllerDelegate
    
    func feedbackSheetPageController(controller: FeedbackSheetPageTableViewController, submittedWithResponse response: NSDictionary) {
        delegate?.feedbackSheetViewController(self, finishedWithResponse: response)
    }
    
    func feedbackSheetPageControllerDidDeclineTermsOfService(controller: FeedbackSheetPageTableViewController) {
        // delegate Error
    }
    
    // MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        if segue.identifier == "presentPageTableViewController" {
            if let pageTVC = segue.destinationViewController as? FeedbackSheetPageTableViewController {
                if pages.count > 0 {
                    pageTVC.page = pages[pageIndex]
                }
                pageTVC.delegate = self
                self.pageTVC = pageTVC
            }
        }
    }
}
