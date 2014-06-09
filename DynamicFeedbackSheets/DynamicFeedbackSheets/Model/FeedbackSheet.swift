//
//  FeedbackSheet.swift
//  DynamicFeedbackSheets
//
//  Created by Jan Hennings on 08/06/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

import Foundation

class FeedbackSheet {
    let title = "No Title"
    let ID: Int
    let pages: FeedbackSheetPage[]
    let fetchDate = NSDate()
    
    init(title: String, ID: Int, pages: FeedbackSheetPage[]) {
        self.title = title
        self.ID = ID
        self.pages = pages
    }
}