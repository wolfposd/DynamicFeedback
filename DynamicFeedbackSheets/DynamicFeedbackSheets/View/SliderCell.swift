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
    didSet {
        if let sliderModule = module as? SliderModule {
            descriptionLabel.text = sliderModule.text
            
            slider.minimumValue = CFloat(sliderModule.minValue)
            slider.minimumValue = CFloat(sliderModule.maxValue)
            slider.value = 0.0
        }
    }
    }
    
    // MARK: IBActions
    
    @IBAction func moveSlider(sender: UISlider) {
        if let sliderModule = module as? SliderModule {
            let steps = roundf((sender.value) / CFloat(sliderModule.stepValue))
            let newValue = steps * CFloat(sliderModule.stepValue)
            
            slider.value = newValue
            sliderModule.responseData = newValue
            delegate?.moduleCell(self, didGetResponse: sliderModule.response!)
        }
    }
}
