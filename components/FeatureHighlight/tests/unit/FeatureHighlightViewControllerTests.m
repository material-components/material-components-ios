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

#import <XCTest/XCTest.h>

#import "MaterialFeatureHighlight.h"

@interface FeatureHighlightViewControllerTests : XCTestCase

@end

@implementation FeatureHighlightViewControllerTests

- (void)testFeatureHighlightViewIsNotLoadedWhenSettingProperties {
  UIView *view = [[UIView alloc] init];
  UIView *view2 = [[UIView alloc] init];
  MDCFeatureHighlightViewController *controller =
      [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:view
                                                             andShowView:view2
                                                              completion:nil];
  controller.titleFont = [UIFont systemFontOfSize:2];
  controller.bodyFont = [UIFont systemFontOfSize:2];
  controller.titleColor = [UIColor redColor];
  controller.bodyColor = [UIColor redColor];
  controller.innerHighlightColor = [UIColor redColor];
  controller.outerHighlightColor = [UIColor redColor];
  controller.titleText = @"test";
  controller.bodyText = @"testBody";

  XCTAssertFalse(controller.isViewLoaded);
}

@end
