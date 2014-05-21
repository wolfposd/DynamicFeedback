//
//  FormItemTextFieldCell.m
//  DynamicFeedbackForm
//
//  Created by Jan Hennings on 5/6/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import "FormItemTextViewCell.h"

@interface FormItemTextViewCell () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *remainingCharactersLabel;

@end

@implementation FormItemTextViewCell

- (void)setFormItem:(FormItem *)formItem {
    [self.textView.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [self.textView.layer setBorderWidth:1.5];
    [self.textView.layer setCornerRadius:5];
    
    [super setFormItem:formItem];
    self.descriptionLabel.text = formItem.description;
    
    // Adds a toolbar with a done button to the keyboard (number pad)
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(toolbarButtonPressed)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 44.f)];
    [toolbar setItems:@[flexibleSpace, doneItem]];
    self.textView.inputAccessoryView = toolbar;
}

- (void)toolbarButtonPressed {
    [self.textView resignFirstResponder];
}

#pragma mark - UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSUInteger newLength = [textView.text length] + [text length] - range.length;
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
