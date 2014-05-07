//
//  FormItemListCell.m
//  DynamicFeedbackForm
//
//  Created by Jan Hennings on 5/6/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import "FormItemListCell.h"

@interface FormItemListCell ()

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation FormItemListCell

#pragma mark - Properties

- (void)setFormItem:(FormItem *)formItem {
    [super setFormItem:formItem];
    self.descriptionLabel.text = formItem.description;
    [self.listSegmentedControl removeAllSegments];
    
    int idx = 0;
    for (NSString *segmentTitle in formItem.elements) {
        [self.listSegmentedControl insertSegmentWithTitle:segmentTitle atIndex:idx animated:NO];
        idx++;
    }
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
