//
//  FeedbackSheetPageTableViewController.swift
//  DynamicFeedbackSheets
//
//  Created by Jan Hennings on 10/06/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

import UIKit

@objc protocol FeedbackSheetPageControllerDelegate {
    func feedbackSheetPageController(controller: FeedbackSheetPageTableViewController, submittedWithResponse response: NSDictionary)
    optional func feedbackSheetPageControllerDidDeclineTermsOfService(controller: FeedbackSheetPageTableViewController)
}

class FeedbackSheetPageTableViewController: UITableViewController, ModuleCellDelegate {
    // MARK: Properties
    
    var page: FeedbackSheetPage! {
        didSet {
            tableView.reloadData()
        }
    }
    
    var lastPage: Bool = false {
        didSet {
            if lastPage != oldValue {
                toggleSubmitButton(lastPage)
            }
        }
    }
    
    var sheetTitle: String = "No title" {
        didSet {
            if sheetTitle != oldValue {
                showSheetTitle()
            }
        }
    }
    var responsesDictionary = Dictionary<String, NSObject>()
    var delegate: FeedbackSheetPageControllerDelegate?
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerModuleCells()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Actions
    
    func submit(sender: UIButton) {
        delegate?.feedbackSheetPageController(self, submittedWithResponse: responsesDictionary)
    }
    
    // MARK: UITableViewDataSource
    
    override func numberOfSectionsInTableView(tableView: UITableView!) -> Int  {
        if let count = page?.modulesVisible.count {
            return count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int  {
        return 1
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell!  {
        let module = page.modulesVisible[indexPath.section]
        let type = module.type
        
        let moduleCell = tableView.dequeueReusableCellWithIdentifier(type.toRaw()) as ModuleCell
        moduleCell.delegate = self
        
        switch type {
        case .List:
            if let tempCell = moduleCell as? ListCell {
                tempCell.setModule(module)
            }
        case .LongList:
            if let tempCell = moduleCell as? LongListCell {
                tempCell.setModule(module)
            }
        case .TextField:
            if let tempCell = moduleCell as? TextFieldCell {
                tempCell.setModule(module)
            }
        case .TextArea:
            if let tempCell = moduleCell as? TextAreaCell {
                tempCell.setModule(module)
            }
        case .Checkbox:
            if let tempCell = moduleCell as? CheckboxCell {
                tempCell.setModule(module)
            }
        case .Slider:
            if let tempCell = moduleCell as? SliderCell {
                tempCell.setModule(module)
            }
        case .StarRating:
            if let tempCell = moduleCell as? StarRatingCell {
                // No implementation yet
            }
        case .Date:
            if let tempCell = moduleCell as? DateCell {
                tempCell.setModule(module)
            }
        case .Photo:
            if let tempCell = moduleCell as? PhotoCell {
                tempCell.setModule(module)
            }
        case .ToS:
            if let tempCell = moduleCell as? ToSCell {
                tempCell.setModule(module)
            }
        default:
            println("Error: No matching Cell")
        }
        
        // Reload persisted state
        if let data = responsesDictionary[module.ID] {
            println("ID: \(module.ID) Data: \(data)")
            moduleCell.reloadWithResponseData(data)
        }
        
        return moduleCell
    }
    
    // MARK: ModuleCellDelegate
    
    func moduleCell(cell: ModuleCell, didGetResponse response: NSObject!, forID ID: String) {
        responsesDictionary[ID] = response
        println(responsesDictionary)
        
        if cell.module?.type == FeedbackSheetModuleType.ToS {
            if !(response as Bool) {
                delegate?.feedbackSheetPageControllerDidDeclineTermsOfService?(self);
            }
        }
    }
    
    // MARK: Helper Methods
    
    func registerModuleCells() {
        let nibNames = ["ListCell", "LongListCell", "TextFieldCell", "TextAreaCell", "CheckboxCell", "SliderCell", "StarRatingCell", "DateCell", "PhotoCell", "ToSCell"]
        let identifier = [FeedbackSheetModuleType.List.toRaw(), FeedbackSheetModuleType.LongList.toRaw(), FeedbackSheetModuleType.TextField.toRaw(), FeedbackSheetModuleType.TextArea.toRaw(), FeedbackSheetModuleType.Checkbox.toRaw(), FeedbackSheetModuleType.Slider.toRaw(), FeedbackSheetModuleType.StarRating.toRaw(), FeedbackSheetModuleType.Date.toRaw(), FeedbackSheetModuleType.Photo.toRaw(), FeedbackSheetModuleType.ToS.toRaw()]
        
        for (index, name) in enumerate(nibNames) {
            tableView.registerNib(UINib(nibName: name, bundle: NSBundle.mainBundle()), forCellReuseIdentifier: identifier[index])
        }
    }
    
    func showSheetTitle() {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 80))
        let titleLabel = UILabel()
        headerView.addSubview(titleLabel)
       
        titleLabel.text = sheetTitle
        titleLabel.textAlignment = .Center
        titleLabel.backgroundColor = UIColor.whiteColor()
        headerView.backgroundColor = UIColor.whiteColor()
        titleLabel.sizeToFit()
        
        titleLabel.center = headerView.center
        tableView.tableHeaderView = headerView
    }
    
    func toggleSubmitButton(isLastPage: Bool) {
        if !isLastPage {
            tableView.tableFooterView = nil
        } else {
            let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 80))
            let submitButton = UIButton.buttonWithType(.System) as UIButton
            
            submitButton.layer.borderColor = UIColor.grayColor().CGColor
            submitButton.layer.borderWidth = 1.5
            submitButton.layer.cornerRadius = 5
            submitButton.backgroundColor = UIColor.whiteColor()
            submitButton.frame = CGRect(x: 0, y: 0, width: view.frame.size.width - 40, height: 44)
            
            submitButton.setTitle("Submit", forState: .Normal)
            submitButton.addTarget(self, action: "submit:", forControlEvents: .TouchUpInside)
            submitButton.center = CGPoint(x: footerView.center.x, y: footerView.center.y - 20)
            
            footerView.addSubview(submitButton)
            tableView.tableFooterView = footerView
        }
    }
}
