//
//  ToSModule.swift
//  DynamicFeedbackSheets
//
//  Created by Jan Hennings on 08/06/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

import UIKit

class ToSModule: DescriptionModule {
    let title: String
    
    init(moduleType: FeedbackSheetModuleType, ID: Int, text: String, title: String) {
        self.title = title
        super.init(moduleType: moduleType, ID: ID, text: text)
    }
}
