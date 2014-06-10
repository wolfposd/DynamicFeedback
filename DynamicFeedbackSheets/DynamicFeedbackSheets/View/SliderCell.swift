//
//  SliderCell.swift
//  DynamicFeedbackSheets
//
//  Created by Jan Hennings on 09/06/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

import UIKit

class SliderCell: ModuleCell {
    // MARK: Properties
    
    @IBOutlet var descriptionLabel: UILabel
    @IBOutlet var slider: UISlider
    
    override var module: FeedbackSheetModule? {
    willSet {
        if let sliderModule = newValue as? SliderModule {
            descriptionLabel.text = sliderModule.text
            
            slider.minimumValue = CFloat(sliderModule.minValue)
            slider.minimumValue = CFloat(sliderModule.maxValue)
            slider.value = CFloat(sliderModule.minValue)
        }
    }
    }
    
    // MARK: Testing, current Bug in Xcode (Ambiguous use of module)
    
    func setModule(module: FeedbackSheetModule) {
        self.module = module
    }
    
    // MARK: IBActions
    
    @IBAction func moveSlider(sender: UISlider) {
        if let sliderModule = module as? SliderModule {
//            let steps = roundf((sender.value) / CFloat(sliderModule.stepValue))
//            let newValue = steps * CFloat(sliderModule.stepValue)
//            
//            slider.value = newValue
            sliderModule.responseData = NSNumber(float: slider.value)
            delegate?.moduleCell(self, didGetResponse: sliderModule.responseData, forID: sliderModule.ID)
        }
    }
}
