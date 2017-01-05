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
 instructions. It is not necessary to import this file to use Material Components iOS.
 */

#import "FlexibleHeaderTopLayoutGuideSupplemental.h"

#import "MaterialFlexibleHeader.h"

@implementation FlexibleHeaderTopLayoutGuideExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Flexible Header", @"Utilizing Top Layout Guide" ];
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end

@implementation FlexibleHeaderTopLayoutGuideExample (Supplemental)

- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}

- (void)setupScrollViewContent {
  UIColor *color =
      [UIColor colorWithRed:(97.0 / 255.0) green:(97.0 / 255.0) blue:(97.0 / 255.0) alpha:1.0];
  UIView *scrollViewContent =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.scrollView.frame.size.width, 700)];
  scrollViewContent.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  UILabel *pullDownLabel = [[UILabel alloc]
      initWithFrame:CGRectMake(20, 150, self.scrollView.frame.size.width - 40, 50)];
  pullDownLabel.textColor = color;
  pullDownLabel.text = @"Pull Down";
  pullDownLabel.textAlignment = NSTextAlignmentCenter;
  pullDownLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth |
                                   UIViewAutoresizingFlexibleLeftMargin |
                                   UIViewAutoresizingFlexibleRightMargin;
  [scrollViewContent addSubview:pullDownLabel];

  UILabel *pushUpLabel = [[UILabel alloc]
      initWithFrame:CGRectMake(20, 225, self.scrollView.frame.size.width - 40, 50)];
  pushUpLabel.textColor = color;
  pushUpLabel.text = @"Push Up";
  pushUpLabel.textAlignment = NSTextAlignmentCenter;
  pushUpLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth |
                                 UIViewAutoresizingFlexibleLeftMargin |
                                 UIViewAutoresizingFlexibleRightMargin;
  [scrollViewContent addSubview:pushUpLabel];

  UILabel *downResultsLabel = [[UILabel alloc]
      initWithFrame:CGRectMake(20, 325, self.scrollView.frame.size.width - 40, 50)];
  downResultsLabel.textColor = color;
  downResultsLabel.text = @"UIView Stays Constrained to TopLayoutGuide of Parent View Controller.";
  downResultsLabel.numberOfLines = 0;
  downResultsLabel.textAlignment = NSTextAlignmentCenter;
  downResultsLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth |
                                      UIViewAutoresizingFlexibleLeftMargin |
                                      UIViewAutoresizingFlexibleRightMargin;
  [scrollViewContent addSubview:downResultsLabel];

  [self.scrollView addSubview:scrollViewContent];
  self.scrollView.contentSize = scrollViewContent.frame.size;
}

@end
