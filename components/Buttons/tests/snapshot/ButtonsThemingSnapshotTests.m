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

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

#import "MaterialButtons+Theming.h"
#import "MaterialButtons.h"
#import "MaterialContainerScheme.h"

@interface MDCThemingDynamicTypeSnapshotButtonFake : MDCButton
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;
@end

@implementation MDCThemingDynamicTypeSnapshotButtonFake

- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}

@end

@interface MDCThemingDynamicTypeSnapshotFABFake : MDCFloatingButton
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;
@end

@implementation MDCThemingDynamicTypeSnapshotFABFake

- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}

@end

/** Snapshot tests for @c MDCButton when a theming extension has been applied. */
@interface ButtonsThemingSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong, nullable) MDCButton *button;
@property(nonatomic, strong, nullable) MDCThemingDynamicTypeSnapshotButtonFake *dynamicTypeButton;
@property(nonatomic, strong, nullable) MDCContainerScheme *containerScheme;
@property(nonatomic, strong, nullable) MDCTypographyScheme *dynamicTypeTypographyScheme;
@end

@implementation ButtonsThemingSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.button = [[MDCButton alloc] init];
  [self.button setTitle:@"Material" forState:UIControlStateNormal];
  UIImage *buttonImage = [[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [self.button setImage:buttonImage forState:UIControlStateNormal];
  self.dynamicTypeButton = [[MDCThemingDynamicTypeSnapshotButtonFake alloc] init];
  [self.dynamicTypeButton setTitle:@"Material" forState:UIControlStateNormal];
  [self.dynamicTypeButton setImage:buttonImage forState:UIControlStateNormal];
  self.containerScheme = [[MDCContainerScheme alloc] init];
  self.dynamicTypeTypographyScheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201902];
  self.dynamicTypeTypographyScheme.useCurrentContentSizeCategoryWhenApplied = YES;
}

- (void)tearDown {
  self.button = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  [view sizeToFit];
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

/**
 Used to set the @c UIContentSizeCategory on an @c MDCButton.

 @note On iOS 9 or below this method has no impact.
 */
- (void)setButtonTraitCollectionSizeToSize:(UIContentSizeCategory)sizeCategory {
  UITraitCollection *traitCollection = [[UITraitCollection alloc] init];
  if (@available(iOS 10.0, *)) {
    traitCollection =
        [UITraitCollection traitCollectionWithPreferredContentSizeCategory:sizeCategory];
  }

  self.dynamicTypeButton.traitCollectionOverride = traitCollection;
}

#pragma mark - Tests

/** Test a @c MDCButton being themed with @c applyTextThemeWithScheme:. */
- (void)testTextThemedButton {
  // When
  [self.button applyTextThemeWithScheme:self.containerScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/** Test a @c MDCButton being themed with @c applyContainedThemeWithScheme:. */
- (void)testContainedThemedButton {
  // When
  [self.button applyContainedThemeWithScheme:self.containerScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/** Test a @c MDCButton being themed with @c applyOutlinedThemeWithScheme:. */
- (void)testOutlineThemedButton {
  // When
  [self.button applyOutlinedThemeWithScheme:self.containerScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

#pragma mark - Dynamic type test

- (void)testTextThemedButtonWithContentSizeSmall {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategorySmall];
  self.containerScheme.typographyScheme = self.dynamicTypeTypographyScheme;

  // When
  [self.dynamicTypeButton applyTextThemeWithScheme:self.containerScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.dynamicTypeButton];
}

- (void)testTextThemedButtonWithContentSizeAccessibilityExtraExtraExtraLarge {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];
  self.containerScheme.typographyScheme = self.dynamicTypeTypographyScheme;

  // When
  [self.dynamicTypeButton applyTextThemeWithScheme:self.containerScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.dynamicTypeButton];
}

- (void)testContainedThemedButtonContentSizeSmall {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategorySmall];
  self.containerScheme.typographyScheme = self.dynamicTypeTypographyScheme;

  // When
  [self.dynamicTypeButton applyContainedThemeWithScheme:self.containerScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.dynamicTypeButton];
}

- (void)testContainedThemedButtonWithContentSizeAccessibilityExtraExtraExtraLarge {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];
  self.containerScheme.typographyScheme = self.dynamicTypeTypographyScheme;

  // When
  [self.dynamicTypeButton applyContainedThemeWithScheme:self.containerScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.dynamicTypeButton];
}

- (void)testOutlinedThemedButtonContentSizeSmall {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategorySmall];
  self.containerScheme.typographyScheme = self.dynamicTypeTypographyScheme;

  // When
  [self.dynamicTypeButton applyOutlinedThemeWithScheme:self.containerScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.dynamicTypeButton];
}

- (void)testOutlinedThemedButtonWithContentSizeAccessibilityExtraExtraExtraLarge {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];
  self.containerScheme.typographyScheme = self.dynamicTypeTypographyScheme;

  // When
  [self.dynamicTypeButton applyOutlinedThemeWithScheme:self.containerScheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.dynamicTypeButton];
}

- (void)testSecondaryFABThemedButtonWithContentSizeSmall {
  // Given
  MDCThemingDynamicTypeSnapshotFABFake *dynamicTypeFAB =
      [[MDCThemingDynamicTypeSnapshotFABFake alloc] init];
  [dynamicTypeFAB setTitle:@"Material" forState:UIControlStateNormal];
  [dynamicTypeFAB setImage:[[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)]
                               imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                  forState:UIControlStateNormal];
  self.containerScheme.typographyScheme = self.dynamicTypeTypographyScheme;
  if (@available(iOS 10.0, *)) {
    dynamicTypeFAB.traitCollectionOverride = [UITraitCollection
        traitCollectionWithPreferredContentSizeCategory:UIContentSizeCategorySmall];
  }

  // When
  [dynamicTypeFAB applySecondaryThemeWithScheme:self.containerScheme];

  // Then
  [self generateSnapshotAndVerifyForView:dynamicTypeFAB];
}

- (void)testSecondaryFABThemedButtonWithContentSizeAccessibilityExtraExtraExtraLarge {
  // Given
  MDCThemingDynamicTypeSnapshotFABFake *dynamicTypeFAB =
      [[MDCThemingDynamicTypeSnapshotFABFake alloc] init];
  [dynamicTypeFAB setTitle:@"Material" forState:UIControlStateNormal];
  [dynamicTypeFAB setImage:[[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)]
                               imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]
                  forState:UIControlStateNormal];
  self.containerScheme.typographyScheme = self.dynamicTypeTypographyScheme;
  if (@available(iOS 10.0, *)) {
    dynamicTypeFAB.traitCollectionOverride =
        [UITraitCollection traitCollectionWithPreferredContentSizeCategory:
                               UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];
  }

  // When
  [dynamicTypeFAB applySecondaryThemeWithScheme:self.containerScheme];

  // Then
  [self generateSnapshotAndVerifyForView:dynamicTypeFAB];
}

@end
