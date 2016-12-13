/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

/* IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to use Material Components for iOS.
 */

#import <Foundation/Foundation.h>

#import "DialogsTypicalUseSupplemental.h"
#import "MaterialButtons.h"
#import "MaterialDialogs.h"
#import "MaterialTypography.h"

#pragma mark - DialogsTypicalUseViewController

@implementation DialogsTypicalUseViewController (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Dialogs", @"Dialogs" ];
}

+ (NSString *)catalogDescription {
  return @"Dialogs includes a presentation controller that displays your modal interfaces in a"
          " material spec defined context.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

+ (NSString *)catalogStoryboardName {
  return @"DialogsTypicalUseViewController";
}

@end

@interface ProgrammaticViewController ()

@property(nonatomic, strong) MDCRaisedButton *dismissButton;

@end

@implementation ProgrammaticViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor whiteColor];

  _dismissButton = [[MDCRaisedButton alloc] init];
  _dismissButton.autoresizingMask =
      UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin |
      UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
  [_dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
  [_dismissButton sizeToFit];
  [_dismissButton addTarget:self
                     action:@selector(dismiss:)
           forControlEvents:UIControlEventTouchUpInside];

  [self.view addSubview:_dismissButton];
  _dismissButton.center = self.view.center;
}

- (CGSize)preferredContentSize {
  return CGSizeMake(200.0, 140.0);
}

- (IBAction)dismiss:(id)sender {
  [self.presentingViewController dismissViewControllerAnimated:YES completion:NULL];
}

@end
