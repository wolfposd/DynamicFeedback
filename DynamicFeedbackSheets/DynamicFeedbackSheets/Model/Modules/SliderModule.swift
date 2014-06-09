//
//  SliderModule.swift
//  DynamicFeedbackSheets
//
//  Created by Jan Hennings on 08/06/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

import UIKit

class SliderModule: DescriptionModule {
    let minValue = 0.0
    let maxValue = 1.0
    let stepValue = 0.2
    
    init(moduleType: FeedbackSheetModuleType, ID: String, text: String?, minValue: Double?, maxValue: Double?, stepValue: Double?) {
        if minValue {
            self.minValue = minValue!
        }
        if maxValue {
            self.maxValue = maxValue!
        }
        if stepValue {
            self.stepValue = stepValue!
        }
        super.init(moduleType: moduleType, ID: ID, text: text)
    }
}
