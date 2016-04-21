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

/** IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to implement any Material Design Components.
 */

#import <Foundation/Foundation.h>

#import "FlexibleHeaderTypicalUseInstructionsView.h"
#import "FlexibleHeaderTypicalUseSupplemental.h"

@implementation FlexibleHeaderTypicalUseViewController (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Flexible Header", @"Flexible Header" ];
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

+ (NSString *)catalogDescription {
  return @"The Flexible Header is a container view whose height and vertical offset react to"
          " UIScrollViewDelegate events.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

@end

@implementation FlexibleHeaderTypicalUseViewController (Rotation)

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
  [self.exampleView setNeedsDisplay];
}

@end

@implementation FlexibleHeaderTypicalUseViewController (Supplemental)

- (void)setupExampleViews {
  self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;

  NSDictionary *viewBindings = @{ @"scrollView" : self.scrollView };
  NSMutableArray<__kindof NSLayoutConstraint *> *arrayOfConstraints = [NSMutableArray array];
  [arrayOfConstraints addObjectsFromArray:[NSLayoutConstraint
                                              constraintsWithVisualFormat:@"H:|[scrollView]|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:viewBindings]];
  [arrayOfConstraints addObjectsFromArray:[NSLayoutConstraint
                                              constraintsWithVisualFormat:@"V:|[scrollView]|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:viewBindings]];

  [self.view addConstraints:arrayOfConstraints];

  self.exampleView = [[FlexibleHeaderTypicalUseInstructionsView alloc]
      initWithFrame:self.scrollView.bounds];
  [self.scrollView addSubview:self.exampleView];

  self.exampleView.translatesAutoresizingMaskIntoConstraints = NO;

  NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.exampleView
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view
                                                           attribute:NSLayoutAttributeHeight
                                                          multiplier:1
                                                            constant:0];

  NSLayoutConstraint *centerX = [self.exampleView.centerXAnchor
      constraintEqualToAnchor:self.view.centerXAnchor];
  NSLayoutConstraint *top = [self.exampleView.topAnchor
      constraintEqualToAnchor:self.scrollView.topAnchor];
  NSLayoutConstraint *bottom = [self.exampleView.bottomAnchor
      constraintEqualToAnchor:self.scrollView.bottomAnchor];
  NSLayoutConstraint *leading = [self.exampleView.leadingAnchor
      constraintEqualToAnchor:self.scrollView.leadingAnchor];
  NSLayoutConstraint *trailing = [self.exampleView.trailingAnchor
      constraintEqualToAnchor:self.scrollView.trailingAnchor];

  [self.view addConstraints:@[ width, centerX, top, bottom, leading, trailing ]];
}

@end
