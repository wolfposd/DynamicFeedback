//
//  StartupViewController.m
//  DynamicFeedbackForm
//
//  Created by Jan Hennings on 5/6/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import "StartupViewController.h"
#import "FormItemsTableViewController.h"

@interface StartupViewController ()

@end

@implementation StartupViewController

#pragma mark - View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    UIButton *feedbackButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [feedbackButton setTitle:@"Give feedback" forState:UIControlStateNormal];
    [feedbackButton sizeToFit];
    feedbackButton.center = self.view.center;
    
    [feedbackButton addTarget:self action:@selector(feedbackButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:feedbackButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

- (void)feedbackButtonPress:(UIButton *)sender {
    FormItemsTableViewController *formItemsTVC = [[FormItemsTableViewController alloc] initWithStyle:UITableViewStyleGrouped];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:formItemsTVC];
    
    [self presentViewController:navigationController animated:YES completion:NULL];
}



/*
 
 BASIC USAGE OF REST-SERVICE
 
#import "RESTService.h"
#import "NSDictionary+JSON.h"
@interface StartupViewController ()<RESTDelegate>
    @property (nonatomic,retain) RESTService* restService;
@end

 
#pragma mark - RESTDelegate


-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    self.restService = [RESTService new];
    self.restService.delegate = self;
    
    [self.restService get_SheetWithId:@"3"];
    
    NSMutableDictionary* dict = [NSMutableDictionary new];
    [dict setObject:@"bullshit" forKey:@"textfield1"];
    [dict setObject:@"bullshit" forKey:@"photo1"];
    [dict setObject:@"bullshit" forKey:@"list1"];

    [self.restService post_SheetWithId:@"3" andFormData:dict];
    
}

-(void)restservice:(id)rest hasFetchedSheetWithData:(NSData *)data
{
    NSDictionary* dict = [NSDictionary jsonDictionaryFromData:data];
    NSLog(@"RESTService: sheetresponse: %@", dict);
}

-(void) restservice:(id)rest hasPostedSheetWithSuccess:(BOOL)successfull
{
    NSLog(@"RESTService: succesfull: %@", successfull ? @"YES" : @"NO");
}

-(void) restservice:(id)rest hasFailedWith:(NSError *)error andResponse:(NSURLResponse *)response
{
    NSLog(@"RESTService: error:%@", error);
    NSLog(@"RESTService: response:%@", response);
}
*/
@end
