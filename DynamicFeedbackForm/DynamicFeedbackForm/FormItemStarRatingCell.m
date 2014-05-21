//
//  FormItemStarRatingCell.m
//  DynamicFeedbackForm
//
//  Created by Jan Hennings on 5/20/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import "FormItemStarRatingCell.h"

@interface FormItemStarRatingCell ()

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *starImageViews;

@end

@implementation FormItemStarRatingCell

- (void)setFormItem:(FormItem *)formItem {
    [super setFormItem:formItem];
    
    self.descriptionLabel.text = formItem.description;
    self.starRating = 0;
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
