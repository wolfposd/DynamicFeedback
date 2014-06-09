//
//  TextAreaCell.swift
//  DynamicFeedbackSheets
//
//  Created by Jan Hennings on 09/06/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

import UIKit

class TextAreaCell: ModuleCell, UITextViewDelegate {
    // MARK: Properties
    
    @IBOutlet var descriptionLabel: UILabel
    @IBOutlet var textView: UITextView
    @IBOutlet var charactersLabel: UILabel
    
    override var module: FeedbackSheetModule? {
    didSet {
        if let textModule = oldValue as? TextModule {
            descriptionLabel.text = textModule.text
            textView.text = nil
            charactersLabel.text = "Remaining characters: \(textModule.characterLimit)"
        }
    }
    }
    
    // MARK: View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()

        textView.layer.borderColor = UIColor.grayColor().CGColor
        textView.layer.borderWidth = 1.5
        textView.layer.cornerRadius = 5
        textView.delegate = self
    }
    
    // MARK: UITextViewDelegate
    
    func textView(textView: UITextView!, shouldChangeTextInRange range: NSRange, replacementText text: String!) -> Bool {
        let newLength = countElements(textView.text!) + countElements(text!) - range.length
        var shouldChange = true
        
        if let textModule = module as? TextModule {
            shouldChange = (newLength < textModule.characterLimit) ? true : false
            if shouldChange {
                charactersLabel.text = "Remaining characters: \(textModule.characterLimit - newLength)"
            }
        }
        
        return shouldChange
    }
    
    func textViewDidEndEditing(textView: UITextView!) {
        if let textModule = module as? TextModule {
            textModule.responseData = textView.text
            delegate?.moduleCell(self, didGetResponse: textModule.response!)
        }
    }
    
}
