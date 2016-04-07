/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

#import "ButtonsSimpleExampleViewController.h"

#import "MaterialButtons.h"

@implementation ButtonsSimpleExampleViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = [UIColor whiteColor];

  MDCRaisedButton *raisedButton = [[MDCRaisedButton alloc] init];
  [raisedButton setTitle:@"Raised Button" forState:UIControlStateNormal];
  [raisedButton sizeToFit];
  [raisedButton addTarget:self
                   action:@selector(didTap:)
         forControlEvents:UIControlEventTouchUpInside];
  raisedButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:raisedButton];

  MDCRaisedButton *disabledRaisedButton = [[MDCRaisedButton alloc] init];
  [disabledRaisedButton setTitle:@"Disabled Raised" forState:UIControlStateNormal];
  [disabledRaisedButton sizeToFit];
  [disabledRaisedButton addTarget:self
                           action:@selector(didTap:)
                 forControlEvents:UIControlEventTouchUpInside];
  [disabledRaisedButton setEnabled:NO];
  disabledRaisedButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:disabledRaisedButton];

  MDCFlatButton *flatButton = [[MDCFlatButton alloc] init];
  [flatButton setTitle:@"Flat Button" forState:UIControlStateNormal];
  [flatButton setCustomTitleColor:[UIColor grayColor]];
  [flatButton sizeToFit];
  [flatButton addTarget:self
                 action:@selector(didTap:)
       forControlEvents:UIControlEventTouchUpInside];
  flatButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:flatButton];

  MDCFlatButton *disabledFlatButton = [[MDCFlatButton alloc] init];
  [disabledFlatButton setTitle:@"Disabled Flat" forState:UIControlStateNormal];
  [disabledFlatButton setCustomTitleColor:[UIColor grayColor]];
  [disabledFlatButton sizeToFit];
  [disabledFlatButton addTarget:self
                         action:@selector(didTap:)
               forControlEvents:UIControlEventTouchUpInside];
  [disabledFlatButton setEnabled:NO];
  disabledFlatButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:disabledFlatButton];

  MDCFloatingButton *floatingButton = [[MDCFloatingButton alloc] init];
  [floatingButton setTitle:@"+" forState:UIControlStateNormal];
  [floatingButton sizeToFit];
  [floatingButton addTarget:self
                     action:@selector(didTap:)
           forControlEvents:UIControlEventTouchUpInside];
  floatingButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:floatingButton];

  NSDictionary *views = @{
    @"raised" : raisedButton,
    @"disabledRaised" : disabledRaisedButton,
    @"flat" : flatButton,
    @"disabledFlat" : disabledFlatButton,
    @"floating" : floatingButton,
  };
  NSString *layoutConstraints =
      @"V:[raised]-20-[disabledRaised]-40-[flat]-20-[disabledFlat]-40-[floating]";
  [self.view addConstraint:
                 [NSLayoutConstraint constraintWithItem:flatButton
                                              attribute:NSLayoutAttributeCenterX
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.view
                                              attribute:NSLayoutAttributeCenterX
                                             multiplier:1.f
                                               constant:0.f]];
  [self.view addConstraint:
                 [NSLayoutConstraint constraintWithItem:flatButton
                                              attribute:NSLayoutAttributeCenterY
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:self.view
                                              attribute:NSLayoutAttributeCenterY
                                             multiplier:1.f
                                               constant:0.f]];
  [self.view addConstraints:
                 [NSLayoutConstraint constraintsWithVisualFormat:layoutConstraints
                                                         options:NSLayoutFormatAlignAllCenterX
                                                         metrics:nil
                                                           views:views]];
}

- (void)didTap:(id)sender {
  NSLog(@"%@ was tapped.", NSStringFromClass([sender class]));
}

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Buttons", @"Button Types and States" ];
}

@end
