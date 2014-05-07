//
//  FormItemCell.h
//  DynamicFeedbackForm
//
//  Created by Jan Hennings on 5/6/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FormItem.h"

// ABSTRACT CLASS
@interface FormItemCell : UITableViewCell

@property (nonatomic) FormItem *formItem;
@property (nonatomic) NSIndexPath *indexPath;

@end
