//
//  ModuleCell.swift
//  DynamicFeedbackSheets
//
//  Created by Jan Hennings on 09/06/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

import UIKit

protocol ModuleCellDelegate {
    func moduleCell(cell: ModuleCell, didGetResponse response: (key: String, value: Any))
}

class ModuleCell: UITableViewCell {
    // MARK: Properties
    
    var module: FeedbackSheetModule?
    var delegate: ModuleCellDelegate?

    // MARK: View Life Cycle
    
    override func prepareForReuse() {
        module = nil
    }
}
