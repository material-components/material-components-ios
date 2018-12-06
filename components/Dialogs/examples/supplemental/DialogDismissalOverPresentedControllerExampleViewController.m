// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

/* IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to use Material Components for iOS.
 */

#import "DialogDismissalOverPresentedControllerExampleViewController.h"
#import "MaterialButtons.h"
#import "MaterialDialogs.h"

#pragma mark - Helper View Controller

@interface PresentedViewControllerWithDialog : UIViewController

@property(nonatomic, strong) MDCFlatButton *dialogButton;

@property(nonatomic, strong) MDCFlatButton *dismissButton;

@property(nonatomic, strong) UILabel *topLeftLabel;

@property(nonatomic, strong) UILabel *topRightLabel;

@property(nonatomic, strong) UILabel *bottomLeftLabel;

@property(nonatomic, strong) UILabel *bottomRightLabel;

@end

@implementation PresentedViewControllerWithDialog

- (void)viewDidLoad {
  [super viewDidLoad];

  self.navigationItem.title = @"Presented View Controller";

  // Make a layout that displays content in the corners.
  _topLeftLabel = [[UILabel alloc] init];
  _topLeftLabel.text = @"Top Left";
  _topLeftLabel.textAlignment = NSTextAlignmentLeft;
  _topLeftLabel.backgroundColor = [UIColor lightGrayColor];
  _topLeftLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:_topLeftLabel];

  _topRightLabel = [[UILabel alloc] init];
  _topRightLabel.text = @"Top Right";
  _topRightLabel.textAlignment = NSTextAlignmentRight;
  _topRightLabel.backgroundColor = [UIColor whiteColor];
  _topRightLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:_topRightLabel];

  _bottomLeftLabel = [[UILabel alloc] init];
  _bottomLeftLabel.text = @"Bottom Left";
  _bottomLeftLabel.textAlignment = NSTextAlignmentLeft;
  _bottomLeftLabel.backgroundColor = [UIColor whiteColor];
  _bottomLeftLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:_bottomLeftLabel];

  _bottomRightLabel = [[UILabel alloc] init];
  _bottomRightLabel.text = @"Bottom Right";
  _bottomRightLabel.textAlignment = NSTextAlignmentRight;
  _bottomRightLabel.backgroundColor = [UIColor lightGrayColor];
  _bottomRightLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:_bottomRightLabel];

  NSDictionary *views = NSDictionaryOfVariableBindings(_topLeftLabel, _topRightLabel,
                                                       _bottomLeftLabel, _bottomRightLabel);

  NSArray *constraints =
      [NSLayoutConstraint
          constraintsWithVisualFormat:@"H:|[_topLeftLabel][_topRightLabel(_topLeftLabel)]|"
                              options:0
                              metrics:nil
                                views:views];
  [NSLayoutConstraint activateConstraints:constraints];
  constraints =
      [NSLayoutConstraint
          constraintsWithVisualFormat:@"H:|[_bottomLeftLabel][_bottomRightLabel(_bottomLeftLabel)]|"
                              options:0
                              metrics:nil
                                views:views];
  [NSLayoutConstraint activateConstraints:constraints];
  constraints =
      [NSLayoutConstraint
          constraintsWithVisualFormat:@"V:|[_topLeftLabel][_bottomLeftLabel(_topLeftLabel)]|"
                              options:0
                              metrics:nil
                                views:views];
  [NSLayoutConstraint activateConstraints:constraints];
  constraints =
      [NSLayoutConstraint
          constraintsWithVisualFormat:@"V:|[_topRightLabel][_bottomRightLabel(_topRightLabel)]|"
                              options:0
                              metrics:nil
                                views:views];
  [NSLayoutConstraint activateConstraints:constraints];

  // Add a button to show the dialog from this presented view controller.
  _dialogButton = [[MDCFlatButton alloc] init];
  [_dialogButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [_dialogButton setBackgroundColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
  [_dialogButton setTitle:@"Show Dialog" forState:UIControlStateNormal];
  _dialogButton.translatesAutoresizingMaskIntoConstraints = NO;
  [_dialogButton addTarget:self
                     action:@selector(showDialog:)
           forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_dialogButton];

  [[NSLayoutConstraint constraintWithItem:_dialogButton
                                attribute:NSLayoutAttributeCenterX
                                relatedBy:NSLayoutRelationEqual
                                   toItem:self.view
                                attribute:NSLayoutAttributeCenterX
                               multiplier:1
                                 constant:0] setActive:YES];
  [[NSLayoutConstraint constraintWithItem:_dialogButton
                                attribute:NSLayoutAttributeCenterY
                                relatedBy:NSLayoutRelationEqual
                                   toItem:self.view
                                attribute:NSLayoutAttributeCenterY
                               multiplier:1
                                 constant:0] setActive:YES];
}

- (void)showDialog:(UIButton *)sender {
  MDCAlertController *dialog =
      [MDCAlertController  alertControllerWithTitle:@"This is a normal MDCAlertController"
                                            message:@"When this dialog is dismissed, the content"
                                                    " of the view controller underneath should"
                                                    " remain unchanged and all four sections should"
                                                    " continue to be fully visible."];
  [dialog addAction:[MDCAlertAction actionWithTitle:@"Dismiss Me" handler:nil]];
  [self presentViewController:dialog animated:YES completion:nil];
}

@end

#pragma mark - Supplemental View Controller

@interface DialogDismissalOverPresentedControllerExampleViewController ()

@property(nonatomic, strong) MDCFlatButton *presentButton;

@end

@implementation DialogDismissalOverPresentedControllerExampleViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  // Create a way to present a view controller.
  self.view.backgroundColor = [UIColor whiteColor];

  _presentButton = [[MDCFlatButton alloc] init];
  [_presentButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [_presentButton setBackgroundColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
  [_presentButton setTitle:@"Present View Controller" forState:UIControlStateNormal];
  _presentButton.translatesAutoresizingMaskIntoConstraints = NO;
  [_presentButton addTarget:self
                     action:@selector(presentController:)
           forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_presentButton];

  [[NSLayoutConstraint constraintWithItem:_presentButton
                                attribute:NSLayoutAttributeCenterX
                                relatedBy:NSLayoutRelationEqual
                                   toItem:self.view
                                attribute:NSLayoutAttributeCenterX
                               multiplier:1
                                 constant:0] setActive:YES];
  [[NSLayoutConstraint constraintWithItem:_presentButton
                                attribute:NSLayoutAttributeCenterY
                                relatedBy:NSLayoutRelationEqual
                                   toItem:self.view
                                attribute:NSLayoutAttributeCenterY
                               multiplier:1
                                 constant:0] setActive:YES];
}

- (void)presentController:(UIButton *)sender {
  PresentedViewControllerWithDialog *presentedViewController =
      [[PresentedViewControllerWithDialog alloc] init];
  UIBarButtonItem *closeItem =
      [[UIBarButtonItem alloc] initWithTitle:@"Dismiss"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(dismissPresentedViewController)];
  presentedViewController.navigationItem.leftBarButtonItem = closeItem;
  UINavigationController *navController =
      [[UINavigationController alloc] initWithRootViewController:presentedViewController];
  navController.modalPresentationStyle = UIModalPresentationFormSheet;
  [self.navigationController presentViewController:navController
                                          animated:YES
                                        completion:nil];
}

- (void)dismissPresentedViewController {
  [self dismissViewControllerAnimated:YES completion:nil];
}

@end

@implementation DialogDismissalOverPresentedControllerExampleViewController (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs": @[ @"Dialogs", @"Dialog Over Presented View Controller on iPad" ],
    @"primaryDemo": @NO,
    @"presentable": @NO,
  };
}

@end
