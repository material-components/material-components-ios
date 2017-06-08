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

#import "ButtonsTypicalUseSupplemental.h"

#import "MDCButtonColorThemer.h"
#import "MaterialButtons.h"
#import "MaterialThemes.h"
#import "MaterialTypography.h"

@interface ButtonsTypicalUseViewController ()

@end

@implementation ButtonsTypicalUseViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1.0];
  UIColor *titleColor = [UIColor whiteColor];

  // Raised button

  MDCRaisedButton *raisedButton = [[MDCRaisedButton alloc] init];
  [raisedButton setTitleColor:titleColor forState:UIControlStateNormal];
  [raisedButton setTitle:@"Button" forState:UIControlStateNormal];
  [raisedButton sizeToFit];
  [raisedButton addTarget:self
                   action:@selector(didTap:)
         forControlEvents:UIControlEventTouchUpInside];
  raisedButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:raisedButton];

  // Disabled raised button

  MDCRaisedButton *disabledRaisedButton = [[MDCRaisedButton alloc] init];
  [disabledRaisedButton setTitleColor:titleColor forState:UIControlStateNormal];
  [disabledRaisedButton setTitle:@"Button" forState:UIControlStateNormal];
  [disabledRaisedButton sizeToFit];
  [disabledRaisedButton addTarget:self
                           action:@selector(didTap:)
                 forControlEvents:UIControlEventTouchUpInside];
  [disabledRaisedButton setEnabled:NO];
  disabledRaisedButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:disabledRaisedButton];

  // Flat button

  MDCFlatButton *flatButton = [[MDCFlatButton alloc] init];
  [flatButton setTitle:@"Button" forState:UIControlStateNormal];
  [flatButton setCustomTitleColor:[UIColor grayColor]];
  [flatButton sizeToFit];
  [flatButton addTarget:self
                 action:@selector(didTap:)
       forControlEvents:UIControlEventTouchUpInside];
  flatButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:flatButton];

  // Disabled flat

  MDCFlatButton *disabledFlatButton = [[MDCFlatButton alloc] init];
  [disabledFlatButton setTitle:@"Button" forState:UIControlStateNormal];
  [disabledFlatButton setCustomTitleColor:[UIColor grayColor]];
  [disabledFlatButton sizeToFit];
  [disabledFlatButton addTarget:self
                         action:@selector(didTap:)
               forControlEvents:UIControlEventTouchUpInside];
  [disabledFlatButton setEnabled:NO];
  disabledFlatButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:disabledFlatButton];

  // Floating action button

  MDCFloatingButton *floatingButton = [[MDCFloatingButton alloc] init];
  [floatingButton setTitleColor:titleColor forState:UIControlStateNormal];
  [floatingButton sizeToFit];
  [floatingButton addTarget:self
                     action:@selector(didTap:)
           forControlEvents:UIControlEventTouchUpInside];
  floatingButton.translatesAutoresizingMaskIntoConstraints = NO;

  UIImage *plusImage = [UIImage imageNamed:@"Plus"];
  [floatingButton setImage:plusImage forState:UIControlStateNormal];
  [self.view addSubview:floatingButton];

  NSDictionary *views = @{
    @"raised" : raisedButton,
    @"disabledRaised" : disabledRaisedButton,
    @"flat" : flatButton,
    @"disabledFlat" : disabledFlatButton,
    @"floating" : floatingButton
  };

  self.views = [NSMutableDictionary dictionary];
  [self.views addEntriesFromDictionary:views];

  [self setupExampleViews];
}

- (void)didTap:(id)sender {
  NSLog(@"%@ was tapped.", NSStringFromClass([sender class]));
}

@end
