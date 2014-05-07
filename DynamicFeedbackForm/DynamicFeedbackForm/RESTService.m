//
//  RESTService.m
//  DynamicFeedbackForm
//
//  Created by Wolf Posdorfer on 07.05.14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import "RESTService.h"
#import "NSDictionary+JSON.h"



@implementation RESTService


static NSString* const BASE_URL = @"http://beeqn.informatik.uni-hamburg.de/feedback/rest.php/";


-(id)init
{
    self = [super init];
    if(self)
    {
        self.respondOnMainThread = YES;
    }
    return self;
}

-(void) get_SheetWithId:(NSString*) sheetid
{
    NSString* modifiedURL = [NSString stringWithFormat:@"%@sheet/id/%@",BASE_URL, sheetid];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:modifiedURL]];
    
    [request setHTTPMethod:@"GET"];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:
     ^(NSURLResponse* respone, NSData* data, NSError* error){
         if(!error)
         {
             [self notifyDelegateFoundSheetData:data];
         }
         else
         {
             [self notifyDelegateError:error andResponse:respone];
         }
    }];
}

-(void) post_SheetWithId:(NSString*) sheetid andFormData:(NSDictionary*) filledOutFormData
{
    NSString* modifiedURL = [NSString stringWithFormat:@"%@sheet/id/%@",BASE_URL, sheetid];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:modifiedURL]];
    
    [request setHTTPMethod:@"PUT"];
    [request setHTTPBody:[filledOutFormData jsonDataFromDictionary]];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc] init] completionHandler:
     ^(NSURLResponse* respone, NSData* data, NSError* error){
         if(!error)
         {
             [self notifyDelegatePostedSheetWithSuccess:data];
         }
         else
         {
             [self notifyDelegateError:error andResponse:respone];
         }
     }];
}



#pragma mark - Delegate Notification


-(void) notifyDelegateFoundSheetData:(NSData*) data
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(restservice:hasFetchedSheetWithData:)])
    {
        if(self.respondOnMainThread)
        {
            dispatch_async(dispatch_get_main_queue(), ^(){
                [self.delegate restservice:self hasFetchedSheetWithData:data];
            } );
        }
        else
        {
            [self.delegate restservice:self hasFetchedSheetWithData:data];
        }
    }
}

-(void) notifyDelegatePostedSheetWithSuccess:(NSData*)data
{
    NSString* response = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    BOOL successfull = [response rangeOfString:@"success"].location != NSNotFound;
   
    if(self.delegate && [self.delegate respondsToSelector:@selector(restservice:hasPostedSheetWithSuccess:)])
    {
        if(self.respondOnMainThread)
        {
            dispatch_async(dispatch_get_main_queue(), ^(){
                [self.delegate restservice:self hasPostedSheetWithSuccess:successfull];
            });
        }
        else
        {
            [self.delegate restservice:self hasPostedSheetWithSuccess:successfull];
        }
    }
}

-(void) notifyDelegateError:(NSError*) error andResponse:(NSURLResponse*) respone
{
    if(self.delegate && [self.delegate respondsToSelector:@selector(restservice:hasFailedWith:andResponse:)])
    {
        if(self.respondOnMainThread)
        {
            dispatch_async(dispatch_get_main_queue(), ^(){
                [self.delegate restservice:self hasFailedWith:error andResponse:respone];
            });
        }
        else
        {
            [self.delegate restservice:self hasFailedWith:error andResponse:respone];
        }
    }
}


@end
