//
//  FormItemsManager.m
//  DynamicFeedbackForm
//
//  Created by Jan Hennings on 5/6/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import "FormItemsManager.h"

static NSString * const KeyFormTitle = @"title";
static NSString * const KeyFormPages = @"pages";
static NSString * const KeyFormPageElements = @"elements";

static NSString * const KeyFormItemID = @"id";
static NSString * const KeyFormItemType = @"type";
static NSString * const KeyFormItemTitle = @"title";
static NSString * const KeyFormItemDescription = @"text";
static NSString * const KeyFormItemElements = @"elements";
static NSString * const KeyFormItemCharacterLimit = @"length";

static NSString * const KeyFormItemMinValue = @"min";
static NSString * const KeyFormItemMaxValue = @"max";
static NSString * const KeyFormItemStepValue = @"step";

@interface FormItemsManager ()

@property (nonatomic) NSString *formTitle;
@property (nonatomic) NSArray *formPages;
@property (nonatomic) NSArray *pageTitles;

@end

@implementation FormItemsManager

#pragma mark - Properties

- (void)setFormURL:(NSURL *)formURL {
    _formURL = formURL;
    [self setup];
}

#pragma mark - Initialization

- (instancetype)initWithContentsOfURL:(NSURL *)aURL {
    self = [super init];
    if (self) {
        self.formURL = aURL;
        [self setup];
    }
    return self;
}

- (void)setup {
    NSData *formRawData = [[NSData alloc] initWithContentsOfURL:self.formURL];
    NSError* error;
    NSDictionary *formData = [NSJSONSerialization JSONObjectWithData:formRawData options:kNilOptions error:&error];
    
    if (error) {
        NSLog(@"Error occurred: %@", error);
        return;
    }
    
    self.formTitle = formData[KeyFormTitle];
    FormItem *newFormItem;
    NSMutableArray *newFormPagesArray = [NSMutableArray new];
    NSMutableArray *newPageTitlesArray = [NSMutableArray new];
    
    for (NSDictionary *formPageDictionary in formData[KeyFormPages]) {
        NSMutableArray *newFormItemsArray = [NSMutableArray new];
        for (NSDictionary *formItemDictionary in formPageDictionary[KeyFormPageElements]) {
            newFormItem = [[FormItem alloc] initWithID:formItemDictionary[KeyFormItemID]
                                                  type:[self formItemTypeFromString:formItemDictionary[KeyFormItemType]]
                                                 title:formItemDictionary[KeyFormItemTitle]
                                           description:formItemDictionary[KeyFormItemDescription]
                                              elements:formItemDictionary[KeyFormItemElements]
                                        characterLimit:[formItemDictionary[KeyFormItemCharacterLimit] integerValue]];
            
            if (newFormItem.type == FormItemTypeSlider) {
                [newFormItem setSliderMinValue:[formItemDictionary[KeyFormItemMinValue] integerValue]
                                      maxValue:[formItemDictionary[KeyFormItemMaxValue] integerValue]
                                     stepValue:[formItemDictionary[KeyFormItemStepValue] integerValue]];
            }
            
            [newFormItemsArray addObject:newFormItem];
        }
        
        [newPageTitlesArray addObject:formPageDictionary[KeyFormTitle]];
        [newFormPagesArray addObject:[newFormItemsArray copy]];
    }
    
    self.pageTitles = [newPageTitlesArray copy];
    self.formPages = [newFormPagesArray copy];
}

#pragma mark - Helper methods

- (FormItemType)formItemTypeFromString:(NSString *)string {
    // Visible Modules
    if ([string isEqualToString:@"list"]) return FormItemTypeList;
    if ([string isEqualToString:@"long-list"]) return FormItemTypeLongList;
    if ([string isEqualToString:@"textfield"]) return FormItemTypeTextField;
    if ([string isEqualToString:@"textarea"]) return FormItemTypeTextView;
    if ([string isEqualToString:@"checkbox"]) return FormItemTypeSwitch;
    if ([string isEqualToString:@"slider"]) return FormItemTypeSlider;
    if ([string isEqualToString:@"star"]) return FormItemTypeStarRating;
    if ([string isEqualToString:@"date"]) return FormItemTypeDatePicker;
    if ([string isEqualToString:@"photo"]) return FormItemTypePhoto;
    if ([string isEqualToString:@"tos"]) return FormItemTypeTermsOfService;
    
    // Invisible Modules
    if ([string isEqualToString:@"gps"]) return FormItemTypeGPS;
    if ([string isEqualToString:@"accelerometer"]) return FormItemTypeAccelerometer;
    if ([string isEqualToString:@"auto-date"]) return FormItemTypeTimeStamp;
    
    return -1; // Error
}

@end
