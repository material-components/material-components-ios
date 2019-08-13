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

#import "MDCFeatureHighlightView+Private.h"
#import "MaterialFeatureHighlight.h"
#import "MaterialTypography.h"

/**
 A @c MDCFeatureHighlightViewController test fake to override the @c traitCollection to test for
 dynamic type.
 */
@interface FeatureHighlightViewControllerTestsFake : MDCFeatureHighlightViewController
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;
@end

@implementation FeatureHighlightViewControllerTestsFake

- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}

@end

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

- (void)testTraitCollectionDidChangeBlockCalledWithExpectedParameters {
  // Given
  MDCFeatureHighlightViewController *controller =
      [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:[[UIView alloc] init]
                                                             andShowView:[[UIView alloc] init]
                                                              completion:nil];
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"traitCollection"];
  __block UITraitCollection *passedTraitCollection = nil;
  __block MDCFeatureHighlightViewController *passedFeatureHighlight = nil;
  controller.traitCollectionDidChangeBlock =
      ^(MDCFeatureHighlightViewController *_Nonnull featureHighlight,
        UITraitCollection *_Nullable previousTraitCollection) {
        passedTraitCollection = previousTraitCollection;
        passedFeatureHighlight = featureHighlight;
        [expectation fulfill];
      };
  UITraitCollection *fakeTraitCollection = [UITraitCollection traitCollectionWithDisplayScale:7];

  // When
  [controller traitCollectionDidChange:fakeTraitCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedFeatureHighlight, controller);
  XCTAssertEqual(passedTraitCollection, fakeTraitCollection);
}

- (void)testFeatureHighlightViewControllerDynamicTypeBehavior {
  if (@available(iOS 10.0, *)) {
    // Given
    FeatureHighlightViewControllerTestsFake *controller =
        [[FeatureHighlightViewControllerTestsFake alloc]
            initWithHighlightedView:[[UIView alloc] init]
                        andShowView:[[UIView alloc] init]
                         completion:nil];
    controller.mdc_adjustsFontForContentSizeCategory = YES;
    MDCFeatureHighlightView *view = (MDCFeatureHighlightView *)controller.view;
    UIFont *font = [UIFont systemFontOfSize:10.0 weight:UIFontWeightRegular];
    MDCFontScaler *fontScaler = [[MDCFontScaler alloc] initForMaterialTextStyle:MDCTextStyleBody2];
    UIFont *scalableFont = [fontScaler scaledFontWithFont:font];
    scalableFont = [scalableFont mdc_scaledFontAtDefaultSize];
    controller.bodyFont = scalableFont;
    CGFloat originalBodyFontSize = view.bodyLabel.font.pointSize;
    controller.titleFont = scalableFont;
    CGFloat originalTitleFontSize = view.titleLabel.font.pointSize;

    // When
    UIContentSizeCategory size = UIContentSizeCategoryExtraExtraLarge;
    UITraitCollection *traitCollection =
        [UITraitCollection traitCollectionWithPreferredContentSizeCategory:size];
    controller.traitCollectionOverride = traitCollection;
    [NSNotificationCenter.defaultCenter
        postNotificationName:UIContentSizeCategoryDidChangeNotification
                      object:nil];

    // Then
    CGFloat actualBodyFontSize = view.bodyLabel.font.pointSize;
    CGFloat actualTitleFontSize = view.titleLabel.font.pointSize;
    XCTAssertGreaterThan(actualTitleFontSize, originalTitleFontSize);
    XCTAssertGreaterThan(actualBodyFontSize, originalBodyFontSize);
  }
}

@end
