//
//  FormItemsTableViewController.m
//  DynamicFeedbackForm
//
//  Created by Jan Hennings on 5/6/14.
//  Copyright (c) 2014 Jan Hennings. All rights reserved.
//

#import "FormItemsTableViewController.h"
#import "FormItemsManager.h"
#import "FormItemCells.h"

@interface FormItemsTableViewController () <FormItemPhotoCellDelegate , UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (nonatomic) FormItemsManager *formItemsManager;

@property (nonatomic) UIButton *submitButton;
@property (nonatomic) FormItemPhotoCell *tempFormItemPhotoCell;

@end

@implementation FormItemsTableViewController

#pragma mark - View Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Fetch form data (asynchronously).
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSURL *fetchURL = [NSURL URLWithString:@"http://beeqn.informatik.uni-hamburg.de/feedback/index.php?id=3"];
        self.formItemsManager = [[FormItemsManager alloc] initWithContentsOfURL:fetchURL];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.title = self.formItemsManager.formTitle;
            [self.tableView reloadData];
        });
    });
    
    // Add submit button to the bottom of the table view.
    UIView* footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 80)];
    self.submitButton = [UIButton buttonWithType:UIButtonTypeSystem];

    [self.submitButton.layer setBorderColor:[[UIColor grayColor] CGColor]];
    [self.submitButton.layer setBorderWidth:1.5];
    [self.submitButton.layer setCornerRadius:5];
    [self.submitButton setBackgroundColor:[UIColor whiteColor]];
    self.submitButton.frame = CGRectMake(0, 0, self.view.frame.size.width - 40, 44);
    
    [self.submitButton setTitle:@"Submit" forState:UIControlStateNormal];
    [self.submitButton addTarget:self action:@selector(submitButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.submitButton.center = CGPointMake(footerView.center.x, footerView.center.y - 20);
    
    [footerView addSubview:self.submitButton];
    self.tableView.tableFooterView = footerView;
    
    [self registerFormItemCellNibs];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.formItemsManager.formPages count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.formItemsManager.formPages[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.formItemsManager.pageTitles[section];
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    FormItem *formItem = self.formItemsManager.formPages[indexPath.section][indexPath.row];
    
    switch (formItem.type) {
        case FormItemTypeList: return 100;
        case FormItemTypePhoto: return 100;
        case FormItemTypeTextView: return 200;
        case FormItemTypeSlider: return 100;
        default: return 44;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FormItem *formItem = self.formItemsManager.formPages[indexPath.section][indexPath.row];
    FormItemCell *formItemCell;
    
    switch (formItem.type) {
        case FormItemTypePlainText:
            formItemCell = [tableView dequeueReusableCellWithIdentifier:@"plainText" forIndexPath:indexPath];
            break;
        case FormItemTypeList:
            formItemCell = [tableView dequeueReusableCellWithIdentifier:@"list" forIndexPath:indexPath];
            break;
        case FormItemTypePhoto:
            formItemCell = [tableView dequeueReusableCellWithIdentifier:@"photo" forIndexPath:indexPath];
            ((FormItemPhotoCell *)formItemCell).delegate = self;
            break;
        case FormItemTypeTextField:
            formItemCell = [tableView dequeueReusableCellWithIdentifier:@"textField" forIndexPath:indexPath];
            break;
        case FormItemTypeTextView:
            formItemCell = [tableView dequeueReusableCellWithIdentifier:@"textView" forIndexPath:indexPath];
            break;
        case FormItemTypeSwitch:
            formItemCell = [tableView dequeueReusableCellWithIdentifier:@"switch" forIndexPath:indexPath];
            break;
        case FormItemTypeSlider:
            formItemCell = [tableView dequeueReusableCellWithIdentifier:@"slider" forIndexPath:indexPath];
            break;
    }
    
    formItemCell.formItem = formItem;
    formItemCell.indexPath = indexPath;
    return formItemCell;
}

#pragma mark - FormItemPhotoCellDelegate

- (void)formItemPhotoCellChooseButtonTapped:(FormItemPhotoCell *)sender {
    UIActionSheet *photoActionSheet = [[UIActionSheet alloc] initWithTitle:@"Choose:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Library", nil];
    [photoActionSheet showInView:self.view];
    
    self.tempFormItemPhotoCell = sender;
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    self.tempFormItemPhotoCell.photoView.image = info[UIImagePickerControllerOriginalImage];
    self.tempFormItemPhotoCell = nil;
    [self dismissViewControllerAnimated:YES completion: NULL];
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"%ld", (long)buttonIndex);
    if (buttonIndex == actionSheet.cancelButtonIndex) return;
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    
    if (buttonIndex == 0) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) return;
        imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    
    [self.navigationController presentViewController:imagePickerController animated:YES completion:NULL];
}

#pragma mark - Helper Methods

- (void)registerFormItemCellNibs {
    NSArray *nibNames = @[@"PlainTextCell", @"ListCell", @"PhotoCell", @"TextFieldCell", @"TextViewCell", @"SwitchCell", @"SliderCell"];
    NSArray *identifier = @[@"plainText", @"list", @"photo", @"textField", @"textView", @"switch", @"slider"];
    
    for (int i = 0; i < [nibNames count]; i++) {
        UINib *nib = [UINib nibWithNibName:nibNames[i] bundle:[NSBundle mainBundle]];
        [[self tableView] registerNib:nib forCellReuseIdentifier:identifier[i]];
    }
}

#pragma mark - Navigation

- (void)submitButtonPressed:(UIButton *)sender {
    
}

@end
