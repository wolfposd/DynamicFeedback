//
//  FormItem.h
//  DynamicFeedbackForm
//
//  Created by Jan Hennings on 5/6/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, FormItemType) {
    FormItemTypePlainText,
    FormItemTypeList,
    FormItemTypePhoto,
    FormItemTypeTextField,
    FormItemTypeTextView,
    FormItemTypeSwitch,
    FormItemTypeSlider
};

@interface FormItem : NSObject

@property (nonatomic, readonly) NSString *ID;
@property (nonatomic, readonly) FormItemType type;
@property (nonatomic, readonly) NSString *description;
@property (nonatomic, readonly) NSArray *elements;

- (instancetype)initWithID:(NSString *)aID type:(FormItemType)aType description:(NSString *)aDescription elements:(NSArray *)elements;

@end
