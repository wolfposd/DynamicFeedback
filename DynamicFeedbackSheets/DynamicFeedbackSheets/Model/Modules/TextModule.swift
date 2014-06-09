//
//  TextModule.swift
//  DynamicFeedbackSheets
//
//  Created by Jan Hennings on 08/06/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

import UIKit

class TextModule: DescriptionModule {
    let characterLimit = 140
    
    init(moduleType: FeedbackSheetModuleType, ID: String, text: String?, characterLimit: Int?) {
        if characterLimit {
            self.characterLimit = characterLimit!
        }
        super.init(moduleType: moduleType, ID: ID, text: text)
    }
}
