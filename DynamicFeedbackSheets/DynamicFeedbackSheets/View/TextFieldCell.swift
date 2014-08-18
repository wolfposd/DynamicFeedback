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
    
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var textField: UITextField!
    @IBOutlet var charactersLabel: UILabel!
    
    override var module: FeedbackSheetModule? {
    willSet {
        if let textModule = newValue as? TextModule {
            descriptionLabel.text = textModule.text
            textField.text = nil
            charactersLabel.text = "Remaining characters: \(textModule.characterLimit)"
        }
    }
    }
    
    // MARK: Testing, current Bug in Xcode (Ambiguous use of module)
    
    func setModule(module: FeedbackSheetModule) {
        self.module = module
    }
    
    // MARK: View Life Cycle
    
    override func awakeFromNib() {
        super.awakeFromNib()

        textField.layer.borderColor = UIColor.grayColor().CGColor
        textField.layer.borderWidth = 1.5
        textField.layer.cornerRadius = 5
        textField.delegate = self
    }
    
    // MARK: Actions
    
    override func reloadWithResponseData(responseData: AnyObject) {
        let text = responseData as String
        let textLength = countElements(text)
        var shouldChange = true
        textField.text = text
        
        if let textModule = module as? TextModule {
            shouldChange = (textLength <= textModule.characterLimit) ? true : false
            if shouldChange {
                charactersLabel.text = "Remaining characters: \(textModule.characterLimit - textLength)"
            }
        }
    }
    
    // MARK: UITextFieldDelegate
    
    func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {
        let newLength = countElements(textField.text!) + countElements(string!) - range.length
        var shouldChange = true
        
        if let textModule = module as? TextModule {
            shouldChange = (newLength <= textModule.characterLimit) ? true : false
            if shouldChange {
                charactersLabel.text = "Remaining characters: \(textModule.characterLimit - newLength)"
            }
        }
        
        return shouldChange
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(textField: UITextField!) {
        if let textModule = module as? TextModule {
            textModule.responseData = textField.text
            delegate?.moduleCell(self, didGetResponse: textModule.responseData, forID: textModule.ID)
        }
    }
}