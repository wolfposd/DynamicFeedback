//
//  FormItemTextFieldCell.m
//  DynamicFeedbackForm
//
//  Created by Jan Hennings on 5/7/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import "FormItemTextFieldCell.h"

@implementation FormItemTextFieldCell

- (void)setFormItem:(FormItem *)formItem {
    [super setFormItem:formItem];
    self.textField.placeholder = formItem.description;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
