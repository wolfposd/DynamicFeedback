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
@property (nonatomic) NSString *description;
@property (nonatomic) NSArray *elements;

@end

@implementation FormItem

- (instancetype)initWithID:(NSString *)aID type:(FormItemType)aType description:(NSString *)aDescription elements:(NSArray *)elements {
    self = [super init];
    if (self) {
        _ID = aID;
        _type = aType;
        _description = aDescription;
        _elements = elements;
    }
    
    return self;
}

@end
