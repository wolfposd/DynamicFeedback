//
//  FormItemsManager.h
//  DynamicFeedbackForm
//
//  Created by Jan Hennings on 5/6/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FormItem.h"

@interface FormItemsManager : NSObject

@property (nonatomic, readonly) NSString *formTitle;

// Array (sections) of Arrays (rows), each array in the array holds FormItems
@property (nonatomic, readonly) NSArray *formPages;

// Array of NSStrings, each string represents a page title
@property (nonatomic, readonly) NSArray *pageTitles;

// Setting this property will refetch data.
@property (nonatomic) NSURL *formURL;


- (instancetype)initWithContentsOfURL:(NSURL *)aURL;

@end
