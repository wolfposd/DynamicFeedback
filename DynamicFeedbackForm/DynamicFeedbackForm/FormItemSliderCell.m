//
//  FormItemSliderCell.m
//  DynamicFeedbackForm
//
//  Created by Jan Hennings on 5/6/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import "FormItemSliderCell.h"

@interface FormItemSliderCell ()

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation FormItemSliderCell

- (void)setFormItem:(FormItem *)formItem {
    [super setFormItem:formItem];
    self.descriptionLabel.text = formItem.description;
    
    // Set slider properties
    self.slider.minimumValue = self.formItem.minValue;
    self.slider.maximumValue = self.formItem.maxValue;
    self.slider.value = 0.0;
}

#pragma mark - IBActions

- (IBAction)movedSlider:(UISlider *)sender {
    float newStep = roundf((sender.value) / self.formItem.stepValue);
    self.slider.value = newStep * self.formItem.stepValue;
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
