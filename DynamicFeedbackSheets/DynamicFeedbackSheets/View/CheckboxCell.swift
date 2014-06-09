//
//  CheckboxCell.swift
//  DynamicFeedbackSheets
//
//  Created by Jan Hennings on 09/06/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

import UIKit

class CheckboxCell: ModuleCell {
    // MARK: Properties
    
    @IBOutlet var descriptionLabel: UILabel
    
    override var module: FeedbackSheetModule? {
    didSet {
        if let checkbox = oldValue as? DescriptionModule {
            descriptionLabel.text = checkbox.text
        }
    }
    }
    
    // MARK: IBActions
    
    @IBAction func toggleCheckbox(sender: UISwitch) {
        if let checkbox = module as? DescriptionModule {
            checkbox.responseData = sender.enabled
            delegate?.moduleCell(self, didGetResponse: checkbox.response!)
        }
    }
}
