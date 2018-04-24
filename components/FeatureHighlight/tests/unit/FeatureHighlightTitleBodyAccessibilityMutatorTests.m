/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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


#import "MaterialFeatureHighlight+FeatureHighlightAccessibilityMutator.h"
#import "MaterialFeatureHighlight.h"

#import <XCTest/XCTest.h>

static NSArray<UIColor *> *testColors(){
  return @[[UIColor whiteColor], [UIColor blackColor], [UIColor redColor], [UIColor orangeColor],
           [UIColor greenColor], [UIColor blueColor], [UIColor grayColor]];
}


@interface FeatureHighlightTitleBodyAccessibilityMutatorTests : XCTestCase
@property (nonatomic, strong) UIView *highlightedView;
@property (nonatomic, strong) UIView *showView;
@end

@implementation FeatureHighlightTitleBodyAccessibilityMutatorTests

- (void)setUp {
  [super setUp];
  self.showView = [[UIView alloc] init];
  self.highlightedView = [[UIView alloc] init];
  [self.showView addSubview:self.highlightedView];
}

- (void)tearDown {
  [super tearDown];
  self.showView = nil;
  self.highlightedView = nil;
}

- (void)testMutatorChangesTextColor {
  for (UIColor *color in testColors()) {
    MDCFeatureHighlightViewController *featureHighlightViewController =
        [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:self.highlightedView
                                                               andShowView:self.showView
                                                                completion:nil];
    MDCFeatureHighlightView *featureHighlightView =
        (MDCFeatureHighlightView *)featureHighlightViewController.view;

    // Making the background color the same as the title/body color.
    featureHighlightView.outerHighlightColor = color;
    featureHighlightView.titleColor = color;
    featureHighlightView.bodyColor = color;
    [MDCFeatureHighlightAccessibilityMutator mutate:featureHighlightViewController];

    XCTAssertNotNil(featureHighlightView.titleColor);
    XCTAssertNotNil(featureHighlightView.bodyColor);
    XCTAssertNotEqualObjects(featureHighlightView.titleColor, color);
    XCTAssertNotEqualObjects(featureHighlightView.bodyColor, color);
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
  MDCFeatureHighlightView *featureHighlightView =
      (MDCFeatureHighlightView *)featureHighlightViewController.view;

  // Making the background color the same as the title/body color.
  featureHighlightView.outerHighlightColor = [UIColor whiteColor];
  featureHighlightView.titleColor = [UIColor whiteColor];
  featureHighlightView.bodyColor = [UIColor whiteColor];
  [MDCFeatureHighlightAccessibilityMutator mutate:featureHighlightViewController];

  XCTAssertNotNil(featureHighlightView.titleColor);
  XCTAssertNotNil(featureHighlightView.bodyColor);

  // Hard coded values, if this test fails it only means that we could mean that we changed the
  // accessible color we are returning.
  XCTAssertEqualObjects(featureHighlightView.titleColor,
                        [UIColor colorWithWhite:0 alpha:0.87000000476837158]);
  XCTAssertEqualObjects(featureHighlightView.bodyColor,
                        [UIColor colorWithWhite:0 alpha:0.54000002145767212]);
}

- (void)testMutatorKeepsAccessibleTextColor {
  NSDictionary* colors = @{ [UIColor redColor]: [UIColor blackColor]};
  for (UIColor *color in colors) {
    MDCFeatureHighlightViewController *featureHighlightViewController =
        [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:self.highlightedView
                                                               andShowView:self.showView
                                                                completion:nil];
    MDCFeatureHighlightView *featureHighlightView =
        (MDCFeatureHighlightView *)featureHighlightViewController.view;

    // Making the background color accessible with title/body color.
    featureHighlightView.outerHighlightColor = colors[color];
    featureHighlightView.titleColor = color;
    featureHighlightView.bodyColor = color;

    [MDCFeatureHighlightAccessibilityMutator mutate:featureHighlightViewController];

    XCTAssertEqualObjects(featureHighlightView.titleColor, color);
    XCTAssertEqualObjects(featureHighlightView.bodyColor, color);
  }
}

- (void)testMutatorSelectsTheRightColorWhenThereIsNoColorSet {
  MDCFeatureHighlightViewController *featureHighlightViewController =
      [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:self.highlightedView
                                                             andShowView:self.showView
                                                              completion:nil];
  MDCFeatureHighlightView *featureHighlightView =
      (MDCFeatureHighlightView *)featureHighlightViewController.view;

  // Making the background color accessible with title/body color.
  featureHighlightView.outerHighlightColor = [UIColor blackColor];

  [MDCFeatureHighlightAccessibilityMutator mutate:featureHighlightViewController];

  XCTAssertNotNil(featureHighlightView.titleColor);
  XCTAssertNotNil(featureHighlightView.bodyColor);
  XCTAssertNotEqualObjects(featureHighlightView.titleColor, [UIColor clearColor]);
  XCTAssertNotEqualObjects(featureHighlightView.bodyColor, [UIColor clearColor]);
  XCTAssertNotEqualObjects(featureHighlightView.titleColor, [UIColor blackColor]);
  XCTAssertNotEqualObjects(featureHighlightView.bodyColor, [UIColor blackColor]);
}

@end
