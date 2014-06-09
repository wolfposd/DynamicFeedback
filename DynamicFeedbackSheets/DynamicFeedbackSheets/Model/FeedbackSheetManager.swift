//
//  FeedbackSheetManager.swift
//  DynamicFeedbackSheets
//
//  Created by Jan Hennings on 08/06/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

import Foundation

protocol FeedbackSheetManagerDelegate {
    func feedbackSheetManager(manager: FeedbackSheetManager, didFinishFetchingSheet sheet: FeedbackSheet)
    func feedbackSheetManager(manager: FeedbackSheetManager, didFailWithError error: NSError)
    func feedbackSheetManager(manager: FeedbackSheetManager, didPostSheetWithSuccess success: Bool)
}

class FeedbackSheetManager {
    var baseURL: String
    var delegate: FeedbackSheetManagerDelegate?
    
    init(baseURL: String) {
        self.baseURL = baseURL
    }
    
    func startFetchingSheetWithID(sheetID: String) {
        let fetchURL = NSURL(string: "\(baseURL)sheet/id/\(sheetID)")
        var request = NSMutableURLRequest(URL: fetchURL)
        request.HTTPMethod = "GET"
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) {
                response, data, error in
            if error {
                self.delegate?.feedbackSheetManager(self, didFailWithError: error)
            } else {
                if let jsonData = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? Dictionary<String, Any> {
                    if let sheet = self.feedbackSheetFromDictionary(jsonData) {
                        self.delegate?.feedbackSheetManager(self, didFinishFetchingSheet: sheet)
                    } else {
                        let sheetCreationError = NSError(domain: nil, code: -1, userInfo: [NSLocalizedDescriptionKey : "Couldn't create Feedback Sheet", NSLocalizedFailureReasonErrorKey : "No title or no ID or no modules"])
                        self.delegate?.feedbackSheetManager(self, didFailWithError: sheetCreationError)
                    }
                } else {
                    let jsonDataError = NSError(domain: nil, code: -1, userInfo: [NSLocalizedDescriptionKey : "Couldn't create JSONDictionary", NSLocalizedFailureReasonErrorKey : "No server response data"])
                    self.delegate?.feedbackSheetManager(self, didFailWithError: jsonDataError)
                }
            }
            
        }
    }
    
    func postSheetWithID(sheetID: Int, responses: Dictionary<String, Any>) {
        
        let fetchURL = NSURL(string: "\(baseURL)sheet/id/\(sheetID)")
        let request = NSMutableURLRequest(URL: fetchURL)
        request.HTTPMethod = "PUT"
        
        var error: NSError?
        let jsonData = NSJSONSerialization.dataWithJSONObject(responses, options: nil, error: &error)

        request.HTTPBody = jsonData
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue()) {
            response, data, error in
            if error {
                self.delegate?.feedbackSheetManager(self, didFailWithError: error)
            } else {
                // success
            }
        }
    }
    
    func feedbackSheetFromDictionary(dict: Dictionary<String, Any>) -> FeedbackSheet? {
        let title = dict["title"] as? String
        let ID = dict["id"] as? Int
        
        if !(title && ID) {
            return nil
        }
        
        var pages = FeedbackSheetPage[]()
        
        if let pagesArray = dict["pages"] as? Array<Dictionary<String, Any>> {
            for pageDict in pagesArray {
                if let page = feedbackSheetPageFromDictionary(pageDict) {
                    pages += page
                }
            }
        }
        
        if pages.count > 0 {
            return FeedbackSheet(title: title!, ID: ID!, pages: pages)
        } else {
            return nil
        }
    }
    
    func feedbackSheetPageFromDictionary(dict: Dictionary<String, Any>) -> FeedbackSheetPage? {
        let title = dict["title"] as? String
        var modules = FeedbackSheetModule[]()
        
        if let modulesArray = dict["elements"] as? Array<Dictionary<String, Any>> {
            for moduleDict in modulesArray {
                if let module = feedbackSheetModuleFromDictionary(moduleDict) {
                    modules += module
                }
            }
        }
        
        if modules.count > 0 {
            return FeedbackSheetPage(title: title, modules: modules)
        } else {
            return nil
        }
    }
    
    func feedbackSheetModuleFromDictionary(dict: Dictionary<String, Any>) -> FeedbackSheetModule? {
        var type:FeedbackSheetModuleType?
        
        if let typeString = dict["type"] as? String {
            type = FeedbackSheetModuleType.fromRaw(dict["type"] as String)
        } else {
            return nil
        }
        
        let ID = dict["id"] as? String
        if !ID {
            return nil
        }
        
        let text = dict["text"] as? String
        let elements = dict["elements"] as? Array<String>
        let length = dict["length"] as? Int
        let min = dict["min"] as? Double
        let max = dict["max"] as? Double
        let step = dict["step"] as? Double
        let title = dict["title"] as? String
        
        var module: FeedbackSheetModule?
        
        switch type! {
        case .List, .LongList:
            module = ListModule(moduleType: type!, ID: ID!, text: text, elements: elements)
        case .TextField, .TextArea:
            module = TextModule(moduleType: type!, ID: ID!, text: text, characterLimit: length)
        case .Checkbox, .StarRating, .Date, .Photo:
            module = DescriptionModule(moduleType: type!, ID: ID!, text: text)
        case .ToS:
            module = ToSModule(moduleType: type!, ID: ID!, text: text, title: title)
        case .GPS, .Accelerometer, .TimeStamp:
            module = FeedbackSheetModule(moduleType: type!, ID: ID!)
        default:
            module = nil
        }
        
        return module
    }
}






