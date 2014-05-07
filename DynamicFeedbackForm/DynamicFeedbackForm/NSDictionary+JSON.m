//
//  NSDictionary+JSON.m
//  DynamicFeedbackForm
//
//  Created by Wolf Posdorfer on 07.05.14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import "NSDictionary+JSON.h"

@implementation NSDictionary (JSON)



+(NSDictionary*) jsonDictionaryFromData:(NSData*) data
{
    NSError* error;
    
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    
    if(!error)
    {
        if([[result class] isSubclassOfClass:[NSDictionary class]])
        {
            return result;
        }
        else
        {
            [NSException raise:@"NSDictionary+JSON-Exception" format:@"Not a dictionary"];
        }
    }
    else
    {
        [NSException raise:@"NSDictionary+JSON-Exception" format:@"Couldn't create NSDictionary because data is corrupt"];
    }
    return nil;
}

-(NSData*) jsonDataFromDictionary
{
    NSError* error;
    id result = [NSJSONSerialization dataWithJSONObject:self options:kNilOptions error:&error];
    if(!error)
    {
        return result;
    }
    else
    {
        return nil; // this never happens :)
    }
}

@end
