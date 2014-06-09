//
//  TextFieldModuleCell.swift
//  DynamicFeedbackSheets
//
//  Created by Jan Hennings on 09/06/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

import UIKit

class TextFieldCell: ModuleCell, UITextFieldDelegate {
    // MARK: Properties
    
    @IBOutlet var descriptionLabel: UILabel
    @IBOutlet var textField: UITextField
    @IBOutlet var charactersLabel: UILabel
    
    override var module: FeedbackSheetModule? {
    didSet {
        if let textModule = oldValue as? TextModule {
            descriptionLabel.text = textModule.text
            textField.text = nil
            charactersLabel.text = "Remaining characters: \(textModule.characterLimit)"
        }
    }
    }
    
    // MARK: View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()

        textField.layer.borderColor = UIColor.grayColor().CGColor
        textField.layer.borderWidth = 1.5
        textField.layer.cornerRadius = 5
        textField.delegate = self
    }
    
    // MARK: UITextFieldDelegate
    
    func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {
        let newLength = countElements(textField.text!) + countElements(string!) - range.length
        var shouldChange = true
        
        if let textModule = module as? TextModule {
            shouldChange = (newLength < textModule.characterLimit) ? true : false
            if shouldChange {
                charactersLabel.text = "Remaining characters: \(textModule.characterLimit - newLength)"
            }
        }
        
        return shouldChange
    }
    
    func textFieldDidEndEditing(textField: UITextField!) {
        if let textModule = module as? TextModule {
            textModule.responseData = textField.text
            delegate?.moduleCell(self, didGetResponse: textModule.response!)
        }
    }
}