//
//  RESTService.h
//  DynamicFeedbackForm
//
//  Created by Wolf Posdorfer on 07.05.14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 *  Delegate Protocol for RESTService
 */
@protocol RESTDelegate <NSObject>
@optional
/**
 *  service has posted the sheet-answers with a success or failure
 *
 *  @param rest        the service instance
 *  @param successfull YES if successfull, otherwise NO
 */
-(void) restservice:(id) rest hasPostedSheetWithSuccess:(BOOL) successfull;

/**
 *  service has successfully fetched a new question-sheet from the server
 *
 *  @param rest the service instance
 *  @param data the data fetched from server, comes in JSON-format
 */
-(void) restservice:(id) rest hasFetchedSheetWithData:(NSData*) data;

/**
 *  the service has failed to execute its last task
 *
 *  @param rest     the service instance
 *  @param error    the error received
 *  @param response the response received from the server
 */
-(void) restservice:(id) rest hasFailedWith:(NSError*) error andResponse:(NSURLResponse*) response;

@end

/**
 *  Service provides connection to REST-API
 */
@interface RESTService : NSObject
/**
 *  Delegate to be notified about stuff
 */
@property (nonatomic) id<RESTDelegate> delegate;

/**
 *  Should the RestService respond on the main (UI) thread? default is YES
 */
@property (nonatomic) BOOL respondOnMainThread;

/**
 *  Fetches a questionsheet with specified ID from server
 *
 *  @param sheetid the sheed-id to use
 */
-(void) get_SheetWithId:(NSString*) sheetid;

/**
 *  Posts the answers of a questionsheed to the server
 *
 *  @param sheetid           the sheet-id concerning these answers
 *  @param filledOutFormData the answers to every single sheet-element
 */
-(void) post_SheetWithId:(NSString*) sheetid andFormData:(NSDictionary*) filledOutFormData;

@end
