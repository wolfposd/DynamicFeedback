//
//  FormItem.m
//  DynamicFeedbackForm
//
//  Created by Jan Hennings on 5/6/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import "FormItem.h"

@interface FormItem ()

@property (nonatomic) NSString *ID;
@property (nonatomic) FormItemType type;
@property (nonatomic) NSString *title;
@property (nonatomic) NSString *description;
@property (nonatomic) NSArray *elements;
@property (nonatomic) NSUInteger characterLsimit; // 0 = no limit

//Slider module
@property (nonatomic) float minValue;
@property (nonatomic) float maxValue;
@property (nonatomic) float stepValue;

@end

@implementation FormItem

- (instancetype)initWithID:(NSString *)aID type:(FormItemType)aType title:(NSString *)aTitle description:(NSString *)aDescription  elements:(NSArray *)elements characterLimit:(NSUInteger)aCharacterLimit {
    self = [super init];
    if (self) {
        _ID = aID;
        _type = aType;
        _title = aTitle;
        _description = aDescription;
        _elements = elements;
        _characterLimit = aCharacterLimit;
    }
    
    return self;
}

// Slider module
- (void)setSliderMinValue:(float)min maxValue:(float)max stepValue:(float)step {
    self.minValue = min;
    self.maxValue = max;
    self.stepValue = step;
}
@end
