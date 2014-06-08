//
//  SliderModule.swift
//  DynamicFeedbackSheets
//
//  Created by Jan Hennings on 08/06/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

import UIKit

class SliderModule: DescriptionModule {
    let minValue: Double
    let maxValue: Double
    let stepValue: Double
    
    init(moduleType: FeedbackSheetModuleType, ID: Int, text: String, minValue: Double, maxValue: Double, stepValue: Double) {
        self.minValue = minValue
        self.maxValue = maxValue
        self.stepValue = stepValue
        super.init(moduleType: moduleType, ID: ID, text: text)
    }
}
