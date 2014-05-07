//
//  FormItemPhotoCell.h
//  DynamicFeedbackForm
//
//  Created by Jan Hennings on 5/6/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import "FormItemCell.h"

@protocol FormItemPhotoCellDelegate;

@interface FormItemPhotoCell : FormItemCell

@property (nonatomic) id<FormItemPhotoCellDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIImageView *photoView;

@end

@protocol FormItemPhotoCellDelegate <NSObject>

- (void)formItemPhotoCellChooseButtonTapped:(FormItemPhotoCell *) sender;

@end