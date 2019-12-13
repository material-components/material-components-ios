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

#import "MaterialBottomAppBar.h"

@interface MDCBottomAppBarSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong) MDCBottomAppBarView *appBar;
@end

@implementation MDCBottomAppBarSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.appBar = [[MDCBottomAppBarView alloc] init];
  UIBarButtonItem *leading1 = [[UIBarButtonItem alloc] initWithTitle:@"L1"
                                                               style:UIBarButtonItemStylePlain
                                                              target:nil
                                                              action:NULL];
  UIImage *leadingImage2 = [[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  UIBarButtonItem *leading2 = [[UIBarButtonItem alloc] initWithImage:leadingImage2
                                                               style:UIBarButtonItemStylePlain
                                                              target:nil
                                                              action:NULL];

  UIImage *trailingImage1 = [[UIImage mdc_testImageOfSize:CGSizeMake(40, 40)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
  UIBarButtonItem *trailing1 = [[UIBarButtonItem alloc] initWithImage:trailingImage1
                                                                style:UIBarButtonItemStylePlain
                                                               target:nil
                                                               action:NULL];
  UIBarButtonItem *trailing2 = [[UIBarButtonItem alloc] initWithTitle:@"T2"
                                                                style:UIBarButtonItemStylePlain
                                                               target:nil
                                                               action:NULL];

  self.appBar.leadingBarButtonItems = @[ leading1, leading2 ];
  self.appBar.trailingBarButtonItems = @[ trailing1, trailing2 ];
}

- (void)tearDown {
  self.appBar = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  CGSize aSize = [view sizeThatFits:CGSizeMake(360, INFINITY)];
  view.bounds = CGRectMake(0, 0, aSize.width, aSize.height);
  [view layoutIfNeeded];

  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Tests

- (void)testFloatingButtonCenterLTR {
  // Then
  [self generateSnapshotAndVerifyForView:self.appBar];
}

- (void)testFloatingButtonCenterRTL {
  // When
  [self changeViewToRTL:self.appBar];

  // Then
  [self generateSnapshotAndVerifyForView:self.appBar];
}

- (void)testFloatingButtonLeadingLTR {
  // When
  self.appBar.floatingButtonPosition = MDCBottomAppBarFloatingButtonPositionLeading;

  // Then
  [self generateSnapshotAndVerifyForView:self.appBar];
}

- (void)testFloatingButtonLeadingRTL {
  // When
  self.appBar.floatingButtonPosition = MDCBottomAppBarFloatingButtonPositionLeading;
  [self changeViewToRTL:self.appBar];

  // Then
  [self generateSnapshotAndVerifyForView:self.appBar];
}

- (void)testFloatingButtonTrailingLTR {
  // When
  self.appBar.floatingButtonPosition = MDCBottomAppBarFloatingButtonPositionTrailing;

  // Then
  [self generateSnapshotAndVerifyForView:self.appBar];
}

- (void)testFloatingButtonTrailingRTL {
  // When
  self.appBar.floatingButtonPosition = MDCBottomAppBarFloatingButtonPositionTrailing;
  [self changeViewToRTL:self.appBar];

  // Then
  [self generateSnapshotAndVerifyForView:self.appBar];
}

- (void)testFloatingButtonHiddenLTR {
  // When
  self.appBar.floatingButtonHidden = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.appBar];
}

- (void)testFloatingButtonHiddenRTL {
  // When
  self.appBar.floatingButtonHidden = YES;
  [self changeViewToRTL:self.appBar];

  // Then
  [self generateSnapshotAndVerifyForView:self.appBar];
}

- (void)testFloatingButtonElevationSecondaryLTR {
  // When
  self.appBar.floatingButtonElevation = MDCBottomAppBarFloatingButtonElevationSecondary;

  // Then
  [self generateSnapshotAndVerifyForView:self.appBar];
}

- (void)testFloatingButtonElevationSecondaryRTL {
  // When
  self.appBar.floatingButtonElevation = MDCBottomAppBarFloatingButtonElevationSecondary;
  [self changeViewToRTL:self.appBar];

  // Then
  [self generateSnapshotAndVerifyForView:self.appBar];
}

- (void)testDynamicColorSupportOniOS13AndAbove {
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
  if (@available(iOS 13.0, *)) {
    // Given
    UIColor *barTintDynamicColor =
        [UIColor colorWithDynamicProvider:^(UITraitCollection *traitCollection) {
          if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
            return UIColor.blackColor;
          } else {
            return UIColor.purpleColor;
          }
        }];
    UIColor *shadowDynamicColor =
        [UIColor colorWithDynamicProvider:^(UITraitCollection *traitCollection) {
          if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
            return UIColor.blackColor;
          } else {
            return UIColor.blueColor;
          }
        }];
    self.appBar.barTintColor = barTintDynamicColor;
    self.appBar.shadowColor = shadowDynamicColor;

    // When
    self.appBar.overrideUserInterfaceStyle = UIUserInterfaceStyleDark;

    // Then
    CGSize aSize = [self.appBar sizeThatFits:CGSizeMake(360, INFINITY)];
    self.appBar.bounds = CGRectMake(0, 0, aSize.width, aSize.height);
    [self.appBar layoutIfNeeded];
    UIView *snapshotView =
        [self.appBar mdc_addToBackgroundViewWithInsets:UIEdgeInsetsMake(50, 50, 50, 50)];
    [self snapshotVerifyViewForIOS13:snapshotView];
  }
#endif
}

- (void)testIntrinsicHeight {
  // Given
  self.appBar.translatesAutoresizingMaskIntoConstraints = NO;
  UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 100)];
  containerView.backgroundColor = [UIColor whiteColor];
  [containerView addSubview:self.appBar];

  [NSLayoutConstraint activateConstraints:@[
    [self.appBar.leadingAnchor constraintEqualToAnchor:containerView.leadingAnchor],
    [self.appBar.trailingAnchor constraintEqualToAnchor:containerView.trailingAnchor],
    [self.appBar.bottomAnchor constraintEqualToAnchor:containerView.bottomAnchor],
  ]];

  // When
  [containerView layoutIfNeeded];

  // Then
  [self snapshotVerifyView:containerView];
}

@end
