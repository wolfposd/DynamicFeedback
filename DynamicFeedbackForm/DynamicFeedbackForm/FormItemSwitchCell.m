//
//  FormItemSwitchCell.m
//  DynamicFeedbackForm
//
//  Created by Jan Hennings on 5/6/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import "FormItemSwitchCell.h"

@interface FormItemSwitchCell ()

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation FormItemSwitchCell

- (void)setFormItem:(FormItem *)formItem {
    [super setFormItem:formItem];
    self.descriptionLabel.text = formItem.description;
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
