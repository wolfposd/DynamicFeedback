//
//  FormItemLongListCell.m
//  DynamicFeedbackForm
//
//  Created by Jan Hennings on 5/15/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import "FormItemLongListCell.h"

@interface FormItemLongListCell () <UIPickerViewDataSource, UIPickerViewDelegate>

@end

@implementation FormItemLongListCell

- (void)setFormItem:(FormItem *)formItem {
    [self.longListTextField.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [self.longListTextField.layer setBorderWidth:1.5];
    [self.longListTextField.layer setCornerRadius:5];
    
    [super setFormItem:formItem];
    
    // Adds a toolbar with a done button to the keyboard (number pad)
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(toolbarButtonPressed)];
    UIBarButtonItem *flexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 44.f)];
    [toolbar setItems:@[flexibleSpace, doneItem]];
    
    UIPickerView *listPicker = [[UIPickerView alloc] init];
    listPicker.delegate = self;
    
    self.longListTextField.inputView = listPicker;
}

- (void)toolbarButtonPressed {
    [self.longListTextField resignFirstResponder];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.formItem.elements count];
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.longListTextField.text = self.formItem.elements[row];
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
