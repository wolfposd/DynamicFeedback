//
//  FormItemTextFieldCell.m
//  DynamicFeedbackForm
//
//  Created by Jan Hennings on 5/7/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import "FormItemTextFieldCell.h"

@interface FormItemTextFieldCell () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainingCharactersLabel;

@end

@implementation FormItemTextFieldCell

- (void)setFormItem:(FormItem *)formItem {
    [super setFormItem:formItem];
    self.descriptionLabel.text = formItem.description;
}


#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    BOOL shouldChange = (newLength > self.formItem.characterLimit) ? NO : YES;
    
    if (shouldChange) {
        self.remainingCharactersLabel.text = [NSString stringWithFormat:@"Remaining characters: %lu", (unsigned long)newLength];
    }
    
    return shouldChange;
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
