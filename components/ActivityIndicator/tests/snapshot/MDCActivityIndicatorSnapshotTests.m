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

#import "MaterialSnapshot.h"

#import "MaterialActivityIndicator.h"

/** Snapshot tests for MDCActivityIndicator. */
@interface MDCActivityIndicatorSnapshotTests : MDCSnapshotTestCase

/** The view being tested. */
@property(nonatomic, strong) MDCActivityIndicator *indicator;

@end

@implementation MDCActivityIndicatorSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.indicator = [[MDCActivityIndicator alloc] initWithFrame:CGRectMake(0, 0, 64, 64)];
  [self.indicator startAnimating];
  self.indicator.layer.speed = 0;
}

- (void)tearDown {
  self.indicator = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  self.indicator.layer.timeOffset = 3000;
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

- (void)changeViewToRTL:(UIView *)view {
  if (@available(iOS 9.0, *)) {
    view.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
    for (UIView *subview in view.subviews) {
      [self changeViewToRTL:subview];
    }
  }
}

#pragma mark - Tests

- (void)testDeterminateProgress000LTR {
  // When
  self.indicator.indicatorMode = MDCActivityIndicatorModeDeterminate;
  [self.indicator setProgress:0 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.indicator];
}

- (void)testDeterminateProgress000RTL {
  // When
  self.indicator.indicatorMode = MDCActivityIndicatorModeDeterminate;
  [self changeViewToRTL:self.indicator];
  [self.indicator setProgress:0 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.indicator];
}

- (void)testDeterminateProgress016LTR {
  // When
  self.indicator.indicatorMode = MDCActivityIndicatorModeDeterminate;
  [self.indicator setProgress:(float)0.16 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.indicator];
}

- (void)testDeterminateProgress016RTL {
  // When
  self.indicator.indicatorMode = MDCActivityIndicatorModeDeterminate;
  [self changeViewToRTL:self.indicator];
  [self.indicator setProgress:(float)0.16 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.indicator];
}

- (void)testDeterminateProgress042LTR {
  // When
  self.indicator.indicatorMode = MDCActivityIndicatorModeDeterminate;
  [self.indicator setProgress:(float)0.42 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.indicator];
}

- (void)testDeterminateProgress042RTL {
  // When
  self.indicator.indicatorMode = MDCActivityIndicatorModeDeterminate;
  [self changeViewToRTL:self.indicator];
  [self.indicator setProgress:(float)0.42 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.indicator];
}

- (void)testDeterminateProgress088LTR {
  // When
  self.indicator.indicatorMode = MDCActivityIndicatorModeDeterminate;
  [self.indicator setProgress:(float)0.88 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.indicator];
}

- (void)testDeterminateProgress088RTL {
  // When
  self.indicator.indicatorMode = MDCActivityIndicatorModeDeterminate;
  [self changeViewToRTL:self.indicator];
  [self.indicator setProgress:(float)0.88 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.indicator];
}

- (void)testDeterminateProgress100LTR {
  // When
  self.indicator.indicatorMode = MDCActivityIndicatorModeDeterminate;
  [self.indicator setProgress:1 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.indicator];
}

- (void)testDeterminateProgress100RTL {
  // When
  self.indicator.indicatorMode = MDCActivityIndicatorModeDeterminate;
  [self changeViewToRTL:self.indicator];
  [self.indicator setProgress:1 animated:NO];

  // Then
  [self generateSnapshotAndVerifyForView:self.indicator];
}

@end
