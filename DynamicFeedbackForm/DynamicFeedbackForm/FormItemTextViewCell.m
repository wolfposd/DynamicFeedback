//
//  FormItemTextFieldCell.m
//  DynamicFeedbackForm
//
//  Created by Jan Hennings on 5/6/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import "FormItemTextViewCell.h"

@interface FormItemTextViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

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

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
