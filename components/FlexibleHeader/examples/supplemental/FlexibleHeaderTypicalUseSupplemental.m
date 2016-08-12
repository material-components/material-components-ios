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

/** IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to use Material Components for iOS.
 */

#import <Foundation/Foundation.h>

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

@implementation FlexibleHeaderTypicalUseViewController (Supplemental)

- (void)setupExampleViews {
  NSBundle *bundle = [NSBundle bundleForClass:[self class]];
  [bundle loadNibNamed:@"FlexibleHeaderTypicalUseInstructionsView" owner:self options:nil];

  self.imageView.image =
      [self.imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [self.scrollView addSubview:self.exampleView];

  self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidLayoutSubviews {
  [super viewDidLayoutSubviews];

  self.exampleView.frame = self.view.bounds;
  self.scrollView.contentSize = self.view.bounds.size;
}

@end
