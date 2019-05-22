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

#import "MaterialFeatureHighlight+FeatureHighlightAccessibilityMutator.h"
#import "MaterialFeatureHighlight.h"

#import <XCTest/XCTest.h>

static NSArray<UIColor *> *testColors() {
  return @[
    [UIColor whiteColor], [UIColor blackColor], [UIColor redColor], [UIColor orangeColor],
    [UIColor greenColor], [UIColor blueColor], [UIColor grayColor]
  ];
}

@interface FeatureHighlightTitleBodyAccessibilityMutatorTests : XCTestCase
@property(nonatomic, strong) UIView *highlightedView;
@property(nonatomic, strong) UIView *showView;
@end

@implementation FeatureHighlightTitleBodyAccessibilityMutatorTests

- (void)setUp {
  [super setUp];
  self.showView = [[UIView alloc] init];
  self.highlightedView = [[UIView alloc] init];
  [self.showView addSubview:self.highlightedView];
}

- (void)tearDown {
  for (UIView *subview in self.showView.subviews) {
    [subview removeFromSuperview];
  }
  self.showView = nil;
  self.highlightedView = nil;
  [super tearDown];
}

- (void)testMutatorChangesTextColor {
  for (UIColor *color in testColors()) {
    MDCFeatureHighlightViewController *featureHighlightViewController =
        [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:self.highlightedView
                                                               andShowView:self.showView
                                                                completion:nil];

    // Making the background color the same as the title/body color.
    featureHighlightViewController.outerHighlightColor = color;
    featureHighlightViewController.titleColor = color;
    featureHighlightViewController.bodyColor = color;
    [MDCFeatureHighlightAccessibilityMutator mutate:featureHighlightViewController];

    XCTAssertNotNil(featureHighlightViewController.titleColor);
    XCTAssertNotNil(featureHighlightViewController.bodyColor);
    XCTAssertNotEqualObjects(featureHighlightViewController.titleColor, color);
    XCTAssertNotEqualObjects(featureHighlightViewController.bodyColor, color);
  }
}

/**
 * This test could fail even when our mutator is returning accessible color. In case MDF is
 * returning a new accessible color
 */
- (void)testMutatorChangesTextColorToExpectedColor {
  MDCFeatureHighlightViewController *featureHighlightViewController =
      [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:self.highlightedView
                                                             andShowView:self.showView
                                                              completion:nil];

  // Making the background color the same as the title/body color.
  featureHighlightViewController.outerHighlightColor = [UIColor whiteColor];
  featureHighlightViewController.titleColor = [UIColor whiteColor];
  featureHighlightViewController.bodyColor = [UIColor whiteColor];
  [MDCFeatureHighlightAccessibilityMutator mutate:featureHighlightViewController];

  XCTAssertNotNil(featureHighlightViewController.titleColor);
  XCTAssertNotNil(featureHighlightViewController.bodyColor);

  // Hard coded values, if this test fails it only means that we could mean that we changed the
  // accessible color we are returning.
  XCTAssertEqualObjects(featureHighlightViewController.titleColor,
                        [UIColor colorWithWhite:0 alpha:(CGFloat)0.87]);
  XCTAssertEqualObjects(featureHighlightViewController.bodyColor,
                        [UIColor colorWithWhite:0 alpha:(CGFloat)0.54]);
}

- (void)testMutatorKeepsAccessibleTextColor {
  NSDictionary *colors = @{[UIColor redColor] : [UIColor blackColor]};
  for (UIColor *color in colors) {
    MDCFeatureHighlightViewController *featureHighlightViewController =
        [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:self.highlightedView
                                                               andShowView:self.showView
                                                                completion:nil];
    // Making the background color accessible with title/body color.
    featureHighlightViewController.outerHighlightColor = colors[color];
    featureHighlightViewController.titleColor = color;
    featureHighlightViewController.bodyColor = color;

    [MDCFeatureHighlightAccessibilityMutator mutate:featureHighlightViewController];

    XCTAssertEqualObjects(featureHighlightViewController.titleColor, color);
    XCTAssertEqualObjects(featureHighlightViewController.bodyColor, color);
  }
}

- (void)testMutatorSelectsTheRightColorWhenThereIsNoColorSet {
  MDCFeatureHighlightViewController *featureHighlightViewController =
      [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:self.highlightedView
                                                             andShowView:self.showView
                                                              completion:nil];

  // Making the background color accessible with title/body color.
  featureHighlightViewController.outerHighlightColor = [UIColor blackColor];

  [MDCFeatureHighlightAccessibilityMutator mutate:featureHighlightViewController];

  XCTAssertNotNil(featureHighlightViewController.titleColor);
  XCTAssertNotNil(featureHighlightViewController.bodyColor);
  XCTAssertNotEqualObjects(featureHighlightViewController.titleColor, [UIColor clearColor]);
  XCTAssertNotEqualObjects(featureHighlightViewController.bodyColor, [UIColor clearColor]);
  XCTAssertNotEqualObjects(featureHighlightViewController.titleColor, [UIColor blackColor]);
  XCTAssertNotEqualObjects(featureHighlightViewController.bodyColor, [UIColor blackColor]);
}

@end
