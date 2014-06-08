//
//  ListModule.swift
//  DynamicFeedbackSheets
//
//  Created by Jan Hennings on 08/06/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

import UIKit

class ListModule: DescriptionModule {
    let elements: String[]
    
    init(moduleType: FeedbackSheetModuleType, ID: Int, text: String, elements: String[]) {
        self.elements = elements
        super.init(moduleType: moduleType, ID: ID, text: text)
    }
}
