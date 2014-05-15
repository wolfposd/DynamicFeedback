//
//  FormItem.h
//  DynamicFeedbackForm
//
//  Created by Jan Hennings on 5/6/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, FormItemType) {
    // Visible Modules
    FormItemTypeList,
    FormItemTypeLongList,
    FormItemTypeTextField,
    FormItemTypeTextView,
    FormItemTypeSwitch,
    FormItemTypeSlider,
    FormItemTypeStarRating,
    FormItemTypeDatePicker,
    FormItemTypePhoto,
    FormItemTypeTermsOfService,
    
    // Invisible Modules
    FormItemTypeGPS,
    FormItemTypeAccelerometer,
    FormItemTypeTimeStamp
};

@interface FormItem : NSObject

@property (nonatomic, readonly) NSString *ID;
@property (nonatomic, readonly) FormItemType type;
@property (nonatomic, readonly) NSString *title;
@property (nonatomic, readonly) NSString *description;
@property (nonatomic, readonly) NSArray *elements;
@property (nonatomic, readonly) NSUInteger characterLimit; // 0 = no limit

- (instancetype)initWithID:(NSString *)aID type:(FormItemType)aType title:(NSString *)aTitle description:(NSString *)aDescription  elements:(NSArray *)elements characterLimit:(NSUInteger)aCharacterLimit;

// Slider module
@property (nonatomic, readonly) double minValue;
@property (nonatomic, readonly) double maxValue;
@property (nonatomic, readonly) double stepValue;

- (void)setSliderMinValue:(double)min maxValue:(double)max stepValue:(double)step;

@end
