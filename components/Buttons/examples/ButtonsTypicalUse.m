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

#import "MaterialButtons.h"
#import "MaterialTypography.h"

@interface ButtonsTypicalUseViewController ()

@end

@implementation ButtonsTypicalUseViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];

  // Raised button

  MDCRaisedButton *raisedButton = [[MDCRaisedButton alloc] init];
  [raisedButton setTitle:@"Button" forState:UIControlStateNormal];
  [raisedButton sizeToFit];
  [raisedButton addTarget:self
                   action:@selector(didTap:)
         forControlEvents:UIControlEventTouchUpInside];
  raisedButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:raisedButton];

  // Disabled raised button

  MDCRaisedButton *disabledRaisedButton = [[MDCRaisedButton alloc] init];
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
  [floatingButton sizeToFit];
  [floatingButton addTarget:self
                     action:@selector(didTap:)
           forControlEvents:UIControlEventTouchUpInside];
  floatingButton.translatesAutoresizingMaskIntoConstraints = NO;

  CGFloat floatingButtonPlusDimension = 24.0f;
  CAShapeLayer *plusShape = [CAShapeLayer layer];
  plusShape.path = [self plusShapePath].CGPath;
  plusShape.fillColor = [UIColor whiteColor].CGColor;
  plusShape.position =
      CGPointMake((floatingButton.frame.size.width - floatingButtonPlusDimension) / 2,
                  (floatingButton.frame.size.height - floatingButtonPlusDimension) / 2);
  [floatingButton.layer addSublayer:plusShape];

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
