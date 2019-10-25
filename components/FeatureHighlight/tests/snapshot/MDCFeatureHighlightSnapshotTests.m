// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialFeatureHighlight.h"
#import "MaterialSnapshot.h"

#import <XCTest/XCTest.h>

/**
 An MDCFeatureHighlightViewController subclass that allows the user to override the @c
 traitCollection property.
 */
@interface MDCFeatureHighlightViewControllerWithCustomTraitCollection
    : MDCFeatureHighlightViewController
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;
@end

@implementation MDCFeatureHighlightViewControllerWithCustomTraitCollection
- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}
@end

/** Snapshot tests for MDCFeatureHighlightViewController and MDCFeatureHighlightView. */
@interface MDCFeatureHighlightSnapshotTests : MDCSnapshotTestCase

@property(nonatomic, strong)
    MDCFeatureHighlightViewControllerWithCustomTraitCollection *featureHighlightViewController;

@end

@implementation MDCFeatureHighlightSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  // self.recordMode = YES;
}

- (void)tearDown {
  if (self.featureHighlightViewController.presentingViewController) {
    XCTestExpectation *expectation =
        [[XCTestExpectation alloc] initWithDescription:@"FeatureHighlight is dismissed"];
    [self.featureHighlightViewController dismissViewControllerAnimated:NO
                                                            completion:^{
                                                              [expectation fulfill];
                                                            }];
    [self waitForExpectations:@[ expectation ] timeout:5];
  }
  self.featureHighlightViewController = nil;

  [super tearDown];
}

- (void)testFeatureHighlightWithDefaultPresentationStyleOniOS13 {
  // Given
  UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
  UIViewController *currentViewController = window.rootViewController;
  UILabel *highlightLabel = [[UILabel alloc] init];
  highlightLabel.text = @"Highlight";
  [highlightLabel sizeToFit];
  [currentViewController.view addSubview:highlightLabel];
  highlightLabel.center = currentViewController.view.center;
  self.featureHighlightViewController =
      [[MDCFeatureHighlightViewControllerWithCustomTraitCollection alloc]
          initWithHighlightedView:highlightLabel
                       completion:nil];
  self.featureHighlightViewController.titleText = @"Feature Highlight Title";
  self.featureHighlightViewController.bodyText = @"Feature Highlight Body";
  self.featureHighlightViewController.outerHighlightColor = UIColor.blueColor;
  self.featureHighlightViewController.innerHighlightColor = UIColor.whiteColor;

  // When
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"Bottom sheet is presented"];
  [currentViewController presentViewController:self.featureHighlightViewController
                                      animated:YES
                                    completion:^{
                                      [expectation fulfill];
                                    }];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:5];
  [self snapshotVerifyViewForIOS13:window];

  [highlightLabel removeFromSuperview];
}

- (void)testPreferredFontForAXXXLContentSizeCategory {
  if (@available(iOS 11.0, *)) {
    // Given
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    UIViewController *currentViewController = window.rootViewController;
    UILabel *highlightLabel = [[UILabel alloc] init];
    highlightLabel.text = @"Highlight";
    [highlightLabel sizeToFit];
    [currentViewController.view addSubview:highlightLabel];
    highlightLabel.center = currentViewController.view.center;
    self.featureHighlightViewController =
        [[MDCFeatureHighlightViewControllerWithCustomTraitCollection alloc]
            initWithHighlightedView:highlightLabel
                         completion:nil];
    self.featureHighlightViewController.titleText = @"Feature Highlight Title";
    self.featureHighlightViewController.bodyText = @"Feature Highlight Body";
    UITraitCollection *xsTraitCollection = [UITraitCollection
        traitCollectionWithPreferredContentSizeCategory:UIContentSizeCategoryExtraSmall];
    self.featureHighlightViewController.traitCollectionOverride = xsTraitCollection;
    UIFontMetrics *bodyMetrics = [UIFontMetrics metricsForTextStyle:UIFontTextStyleBody];
    UIFont *originalFont = [bodyMetrics scaledFontForFont:[UIFont fontWithName:@"Zapfino" size:12]];
    self.featureHighlightViewController.titleFont = originalFont;
    self.featureHighlightViewController.bodyFont = originalFont;
    self.featureHighlightViewController.adjustsFontForContentSizeCategory = YES;

    // When
    UITraitCollection *aXXXLTraitCollection =
        [UITraitCollection traitCollectionWithPreferredContentSizeCategory:
                               UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];
    self.featureHighlightViewController.traitCollectionOverride = aXXXLTraitCollection;
    XCTestExpectation *expectation =
        [[XCTestExpectation alloc] initWithDescription:@"Feature highlight is presented"];
    [currentViewController presentViewController:self.featureHighlightViewController
                                        animated:YES
                                      completion:^{
                                        [expectation fulfill];
                                      }];

    // Then
    [self waitForExpectations:@[ expectation ] timeout:5];
    [self snapshotVerifyView:window];
  }
}

- (void)testPreferredFontForXSContentSizeCategory {
  if (@available(iOS 11.0, *)) {
    // Given
    UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
    UIViewController *currentViewController = window.rootViewController;
    UILabel *highlightLabel = [[UILabel alloc] init];
    highlightLabel.text = @"Highlight";
    [highlightLabel sizeToFit];
    [currentViewController.view addSubview:highlightLabel];
    highlightLabel.center = currentViewController.view.center;
    self.featureHighlightViewController =
        [[MDCFeatureHighlightViewControllerWithCustomTraitCollection alloc]
            initWithHighlightedView:highlightLabel
                         completion:nil];
    self.featureHighlightViewController.titleText = @"Feature Highlight Title";
    self.featureHighlightViewController.bodyText = @"Feature Highlight Body";
    UITraitCollection *aXXXLTraitCollection =
        [UITraitCollection traitCollectionWithPreferredContentSizeCategory:
                               UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];
    self.featureHighlightViewController.traitCollectionOverride = aXXXLTraitCollection;
    UIFontMetrics *bodyMetrics = [UIFontMetrics metricsForTextStyle:UIFontTextStyleBody];
    UIFont *originalFont = [bodyMetrics scaledFontForFont:[UIFont fontWithName:@"Zapfino" size:12]];
    self.featureHighlightViewController.titleFont = originalFont;
    self.featureHighlightViewController.bodyFont = originalFont;
    self.featureHighlightViewController.adjustsFontForContentSizeCategory = YES;

    // When
    UITraitCollection *xsTraitCollection = [UITraitCollection
        traitCollectionWithPreferredContentSizeCategory:UIContentSizeCategoryExtraSmall];
    self.featureHighlightViewController.traitCollectionOverride = xsTraitCollection;
    XCTestExpectation *expectation =
        [[XCTestExpectation alloc] initWithDescription:@"Feature highlight is presented"];
    [currentViewController presentViewController:self.featureHighlightViewController
                                        animated:YES
                                      completion:^{
                                        [expectation fulfill];
                                      }];

    // Then
    [self waitForExpectations:@[ expectation ] timeout:5];
    [self snapshotVerifyView:window];
  }
}

@end
