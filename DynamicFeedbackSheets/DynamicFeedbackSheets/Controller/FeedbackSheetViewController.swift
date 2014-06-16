//
//  FeedbackSheetViewController.swift
//  DynamicFeedbackSheets
//
//  Created by Jan Hennings on 10/06/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

import UIKit
import QuartzCore

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
    var pageIndex = 0
    let pageIndicatorLabel = UILabel()
    var pageTVC: FeedbackSheetPageTableViewController!
    var nextPageButton: UIBarButtonItem!
    var lastPageButton: UIBarButtonItem!
    var delegate: FeedbackSheetViewControllerDelegate?
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController.condensesBarsOnSwipe = true
        navigationController.condensesBarsWhenKeyboardAppears = true
        
        setupPageIndicatorLabel()
        
        // Add pageControl UIBarButtonItems
        nextPageButton = UIBarButtonItem(image: UIImage(named: "ArrowNextPage"), style: .Bordered, target: self, action: ("nextPage"))
        lastPageButton = UIBarButtonItem(image: UIImage(named: "ArrowLastPage"), style: .Bordered, target: self, action: ("lastPage"))
        
        togglePageButtons()
        navigationItem.rightBarButtonItems = [nextPageButton, lastPageButton]
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        showPageIndicator()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
    func nextPage() {
        pageTVC.page = pages[++pageIndex]
        togglePageButtons()
        showPageIndicator()
    }
    
    func lastPage() {
        pageTVC.page = pages[--pageIndex]
        togglePageButtons()
        showPageIndicator()
    }
    
    func togglePageButtons() {
        if pageIndex >= pages.count - 1 {
            nextPageButton.enabled = false
        } else {
            nextPageButton.enabled = true
        }
        
        if pageIndex == 0 {
            lastPageButton.enabled = false
        } else {
            lastPageButton.enabled = true
        }
    }
    
    // MARK: FeedbackSheetPageControllerDelegate
    
    func feedbackSheetPageController(controller: FeedbackSheetPageTableViewController, submittedWithResponse response: NSDictionary) {
        delegate?.feedbackSheetViewController(self, finishedWithResponse: response)
    }
    
    func feedbackSheetPageControllerDidDeclineTermsOfService(controller: FeedbackSheetPageTableViewController) {
        // delegate Error
    }
    
    // MARK: Helper Methods
    
    func setupPageIndicatorLabel() {
        pageIndicatorLabel.textColor = UIColor.lightTextColor()
        pageIndicatorLabel.backgroundColor = UIColor.darkGrayColor()
        pageIndicatorLabel.textAlignment = .Center
        pageIndicatorLabel.layer.masksToBounds = true
        pageIndicatorLabel.layer.cornerRadius = 5
        pageIndicatorLabel.alpha = 0.0
        pageIndicatorLabel.hidden = true
        
        view.addSubview(pageIndicatorLabel)
    }
    
    func showPageIndicator() {
        pageIndicatorLabel.text = "\(pageIndex + 1) / \(pages.count)"
        pageIndicatorLabel.sizeToFit()
        pageIndicatorLabel.frame.size.width += 5
        pageIndicatorLabel.center = CGPoint(x: view.center.x, y: view.frame.height - 20)
        
        if pageIndicatorLabel.hidden {
            pageIndicatorLabel.hidden = false
            
            UIView.animateWithDuration(0.8, animations: {
                self.pageIndicatorLabel.alpha = 1.0
                }) { finished in self.hidePageIndicator() }
        }
    }
    
    func hidePageIndicator() {
        UIView.animateWithDuration(0.8, delay: 0.3, options: nil, animations: {
            self.pageIndicatorLabel.alpha = 0.0
            }) { finished in self.pageIndicatorLabel.hidden = true }
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
