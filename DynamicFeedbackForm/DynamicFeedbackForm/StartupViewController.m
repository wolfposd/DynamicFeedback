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

@end
