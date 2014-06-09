//
//  ToSCell.swift
//  DynamicFeedbackSheets
//
//  Created by Jan Hennings on 09/06/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

import UIKit

class ToSCell: ModuleCell {
    // MARK: Properties
    
    @IBOutlet var titleLabel: UILabel
    @IBOutlet var textView: UITextView
    @IBOutlet var acceptButton: UIButton
    @IBOutlet var declineButton: UIButton
    
    override var module: FeedbackSheetModule? {
    didSet {
        if let toS = module as? ToSModule {
            titleLabel.text = toS.title
            textView.text = toS.text
            acceptButton.enabled = true
            declineButton.enabled = true
        }
    }
    }

    // MARK: View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        acceptButton.layer.cornerRadius = 3
        declineButton.layer.cornerRadius = 3
    }
    
    // MARK: IBActions
    
    @IBAction func accept(sender: UIButton) {
        if let toS = module as? ToSModule {
            toS.responseData = true
            delegate?.moduleCell(self, didGetResponse: toS.response!)
        }
    }
    
    @IBAction func decline(sender: UIButton) {
        if let toS = module as? ToSModule {
            toS.responseData = false
            delegate?.moduleCell(self, didGetResponse: toS.response!)
        }
    }
}
