//
//  FormItemPhotoCell.m
//  DynamicFeedbackForm
//
//  Created by Jan Hennings on 5/6/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import "FormItemPhotoCell.h"

@interface FormItemPhotoCell ()


@end

@implementation FormItemPhotoCell

- (void)prepareForReuse {
    [super prepareForReuse];
    self.photoView.image = nil;
}

- (IBAction)choosePhotoButtonPressed:(UIButton *)sender {
    [self.delegate formItemPhotoCellChooseButtonTapped:self];
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
