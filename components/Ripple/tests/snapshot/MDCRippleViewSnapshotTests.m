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

#import "MDCRippleView.h"

#import <CoreGraphics/CoreGraphics.h>

#import "MDCAvailability.h"
#import "UIColor+MaterialDynamic.h"
#import "MDCSnapshotTestCase.h"
#import "UIView+MDCSnapshot.h"

/**
 Creates a fake MDCRippleView that has its traitCollection overridden.
 */
@interface MDCRippleViewSnaphotTestRippleViewFake : MDCRippleView
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;
@end

@implementation MDCRippleViewSnaphotTestRippleViewFake
- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}
@end

/**
 Snapshot tests for the MDCRippleView class.
 */
@interface MDCRippleViewSnapshotTests : MDCSnapshotTestCase

@property(nonatomic, strong) MDCRippleViewSnaphotTestRippleViewFake *rippleView;
@property(nonatomic, strong) UIView *view;

@end

@implementation MDCRippleViewSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //   self.recordMode = YES;

  self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
  self.rippleView =
      [[MDCRippleViewSnaphotTestRippleViewFake alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
  [self.view addSubview:self.rippleView];
}

- (void)tearDown {
  self.view = nil;
  self.rippleView = nil;

  [super tearDown];
}

#pragma mark - Helpers

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

- (void)generateSnapshotForIOS13AndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyViewForIOS13:snapshotView];
}

#pragma mark - Tests

- (void)testDefaultRippleView {
  // Given
  [self.rippleView beginRippleTouchDownAtPoint:CGPointZero animated:NO completion:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.view];
}

- (void)testLayoutChange {
  // Given
  [self.rippleView beginRippleTouchDownAtPoint:CGPointZero animated:NO completion:nil];

  // When
  self.view.bounds = CGRectMake(0, 0, 180, 20);

  // Then
  [self generateSnapshotAndVerifyForView:self.view];
}

- (void)testMaximumRadius {
  // Given
  self.rippleView.rippleStyle = MDCRippleStyleUnbounded;
  self.rippleView.maximumRadius = 20;

  // When
  [self.rippleView beginRippleTouchDownAtPoint:self.rippleView.center animated:NO completion:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.view];
}

- (void)testRippleColorRespondsToDynamicColorBeforeRippleBegan {
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13.0, *)) {
    // Given
    self.rippleView.rippleColor = [UIColor colorWithUserInterfaceStyleDarkColor:UIColor.redColor
                                                                   defaultColor:UIColor.blueColor];

    // When
    self.rippleView.traitCollectionOverride =
        [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleDark];
    [self.rippleView beginRippleTouchDownAtPoint:self.rippleView.center animated:NO completion:nil];

    // Then
    [self generateSnapshotForIOS13AndVerifyForView:self.view];
  }
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)
}

- (void)testRippleColorRespondsToDynamicColorAfterRippleBegan {
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13.0, *)) {
    // Given
    self.rippleView.rippleColor = [UIColor colorWithUserInterfaceStyleDarkColor:UIColor.redColor
                                                                   defaultColor:UIColor.blueColor];

    // When
    [self.rippleView beginRippleTouchDownAtPoint:self.rippleView.center animated:NO completion:nil];
    self.rippleView.traitCollectionOverride =
        [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleDark];
    [self.rippleView layoutIfNeeded];

    // Then
    [self generateSnapshotForIOS13AndVerifyForView:self.view];
  }
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)
}

@end
