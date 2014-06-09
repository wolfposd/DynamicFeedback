//
//  ListModuleCell.swift
//  DynamicFeedbackSheets
//
//  Created by Jan Hennings on 09/06/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

import UIKit

class ListCell: ModuleCell {
    // MARK: Properties
    
    @IBOutlet var descriptionLabel: UILabel
    @IBOutlet var listControl: UISegmentedControl
    
    override var module: FeedbackSheetModule? {
    didSet {
        listControl.removeAllSegments()
        descriptionLabel.text = nil
        
        if let list = oldValue as? ListModule {
            descriptionLabel.text = list.text
            
            for (index, segmentTitle) in enumerate(list.elements) {
                listControl.insertSegmentWithTitle(segmentTitle, atIndex: index, animated: true)
            }
        }
    }
    }
    
    // MARK: IBActions
    
    @IBAction func selectSegment(sender: UISegmentedControl) {
        if let list = module as? ListModule {
            list.responseData = list.elements[sender.selectedSegmentIndex]
            delegate?.moduleCell(self, didGetResponse: list.response!)
        }
    }
}
