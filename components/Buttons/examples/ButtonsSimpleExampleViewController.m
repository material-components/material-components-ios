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

  MDCRaisedButton *raisedButton = [MDCRaisedButton new];
  [raisedButton setTitle:@"Raised Button" forState:UIControlStateNormal];
  [raisedButton sizeToFit];
  [raisedButton addTarget:self
                   action:@selector(didTap:)
         forControlEvents:UIControlEventTouchUpInside];
  raisedButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:raisedButton];

  MDCFlatButton *flatButton = [MDCFlatButton new];
  [flatButton setTitle:@"Flat Button" forState:UIControlStateNormal];
  [flatButton setCustomTitleColor:[UIColor grayColor]];
  [flatButton sizeToFit];
  [flatButton addTarget:self
                 action:@selector(didTap:)
       forControlEvents:UIControlEventTouchUpInside];
  flatButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:flatButton];

  MDCFloatingButton *floatingButton = [MDCFloatingButton new];
  [floatingButton setTitle:@"+" forState:UIControlStateNormal];
  [floatingButton sizeToFit];
  [floatingButton addTarget:self
                     action:@selector(didTap:)
           forControlEvents:UIControlEventTouchUpInside];
  floatingButton.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:floatingButton];

  NSDictionary *views = @{
    @"raised" : raisedButton,
    @"flat" : flatButton,
    @"floating" : floatingButton,
  };
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
                 [NSLayoutConstraint constraintsWithVisualFormat:@"V:[raised]-40-[flat]-40-[floating]"
                                                         options:NSLayoutFormatAlignAllCenterX
                                                         metrics:nil
                                                           views:views]];
}

- (void)didTap:(id)sender {
  NSLog(@"%@ was tapped.", NSStringFromClass([sender class]));
}

+ (NSArray *)catalogHierarchy {
  return @[ @"Buttons", @"3 kinds of buttons" ];
}

@end
