//
//  NSDictionary+JSON.h
//  DynamicFeedbackForm
//
//  Created by Wolf Posdorfer on 07.05.14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  JSON additions to NSDictionary
 */
@interface NSDictionary (JSON)

/**
 *  Creates an NSDictionary from the given data.
 *
 *  Throws an NSException when errors occur,
 *  for instance if the Data is corrupt or does not contain an NSDictionary
 *
 *  @param data the data to be converted to NSDictionary
 *
 *  @return converted NSDictionary
 */
+(NSDictionary*) jsonDictionaryFromData:(NSData*) data;

/**
 *  Creates a JSON-Representation of this NSDictionary
 *
 *  @return JSON-Data
 */
-(NSData*) jsonDataFromDictionary;

@end
