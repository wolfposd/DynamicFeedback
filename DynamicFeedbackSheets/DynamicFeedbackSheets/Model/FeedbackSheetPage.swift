//
//  FeedbackSheetPage.swift
//  DynamicFeedbackSheets
//
//  Created by Jan Hennings on 08/06/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

import Foundation

class FeedbackSheetPage {
    let title = "No Title"
    let modules: FeedbackSheetModule[]
    
    init(title: String?, modules: FeedbackSheetModule[]) {
        if title {
            self.title = title!
        }
        self.modules = modules
    }
}