//
//  DescriptionModule.swift
//  DynamicFeedbackSheets
//
//  Created by Jan Hennings on 08/06/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

import UIKit

class DescriptionModule: FeedbackSheetModule {
    let text: String
    
    init(moduleType: FeedbackSheetModuleType, ID: Int, text: String) {
        self.text = text
        super.init(moduleType: moduleType, ID: ID)
    }
}
