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

#import "MaterialChips+Theming.h"
#import "MaterialChips.h"
#import "MaterialSnapshot.h"

/** A test fake for @c MDCChipView that allows overriding some read-only properties. */
@interface MDCChipViewSnapshotTestsChipFake : MDCChipView

/** Override value for the Chip's @c traitCollection. */
@property(nonatomic, assign) UITraitCollection *traitCollectionOverride;

@end

@implementation MDCChipViewSnapshotTestsChipFake

- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}

@end

@interface MDCChipViewSnapshotTests : MDCSnapshotTestCase

@property(nonatomic, strong) MDCContainerScheme *scheme;
@property(nonatomic, strong) MDCChipViewSnapshotTestsChipFake *chip;

@end

@implementation MDCChipViewSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.chip = [[MDCChipViewSnapshotTestsChipFake alloc] init];
  self.chip.titleLabel.text = @"A Chip";
  self.scheme = [[MDCContainerScheme alloc] init];
}

- (void)tearDown {
  self.chip = nil;

  [super tearDown];
}

#pragma mark - Helpers

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  CGSize aSize = [view sizeThatFits:CGSizeMake(300, INFINITY)];
  view.bounds = CGRectMake(0, 0, aSize.width, aSize.height);
  [view layoutIfNeeded];

  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

- (UIImage *)leadingImage {
  NSBundle *bundle = [NSBundle bundleForClass:[MDCChipViewSnapshotTests class]];
  UIImage *image = [UIImage imageNamed:@"ic_mask"
                              inBundle:bundle
         compatibleWithTraitCollection:nil];
  return image;
}

- (UIButton *)deleteButton {
  NSBundle *bundle = [NSBundle bundleForClass:[MDCChipViewSnapshotTests class]];
  UIImage *image = [UIImage imageNamed:@"ic_cancel"
                              inBundle:bundle
         compatibleWithTraitCollection:nil];
  image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

  UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
  button.tintColor = [UIColor colorWithWhite:0 alpha:(CGFloat)0.7];
  [button setImage:image forState:UIControlStateNormal];

  return button;
}

#pragma mark - Tests

- (void)testDefaultChip {
  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testBaselineThemedChip {
  // When
  [self.chip applyThemeWithScheme:self.scheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testOutlinedThemedChip {
  // When
  [self.chip applyOutlinedThemeWithScheme:self.scheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

#pragma mark - With Leading Image

- (void)testDefaultChipWithImage {
  // When
  self.chip.imageView.image = [self leadingImage];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testBaselineThemedChipWithImageLTR {
  // When
  self.chip.imageView.image = [self leadingImage];
  [self.chip applyThemeWithScheme:self.scheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testBaselineThemedChipWithImageRTL {
  // Given
  if (@available(iOS 10.0, *)) {
    self.chip.traitCollectionOverride = [UITraitCollection
        traitCollectionWithLayoutDirection:UITraitEnvironmentLayoutDirectionRightToLeft];
  }

  // When
  self.chip.imageView.image = [self leadingImage];
  [self.chip applyThemeWithScheme:self.scheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testOutlinedThemedChipWithImageLTR {
  // When
  self.chip.imageView.image = [self leadingImage];
  [self.chip applyOutlinedThemeWithScheme:self.scheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testOutlinedThemedChipWithImageRTL {
  // Given
  if (@available(iOS 10.0, *)) {
    self.chip.traitCollectionOverride = [UITraitCollection
        traitCollectionWithLayoutDirection:UITraitEnvironmentLayoutDirectionRightToLeft];
  }

  // When
  self.chip.imageView.image = [self leadingImage];
  [self.chip applyOutlinedThemeWithScheme:self.scheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

#pragma mark - With Accessory View

- (void)testDefaultChipWithAccessoryView {
  // When
  self.chip.accessoryView = [self deleteButton];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testDefaultChipWithAccessoryViewAndPositiveTopLeftAccessoryPaddingLTR {
  // Given
  self.chip.accessoryView = [self deleteButton];

  // When
  self.chip.accessoryPadding = UIEdgeInsetsMake(10, 10, 0, 0);

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testDefaultChipWithAccessoryViewAndPositiveTopLeftAccessoryPaddingRTL {
  // Given
  self.chip.accessoryView = [self deleteButton];
  if (@available(iOS 10.0, *)) {
    self.chip.traitCollectionOverride = [UITraitCollection
        traitCollectionWithLayoutDirection:UITraitEnvironmentLayoutDirectionRightToLeft];
  }

  // When
  self.chip.accessoryPadding = UIEdgeInsetsMake(10, 10, 0, 0);

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testDefaultChipWithAccessoryViewAndPositiveBottomRightAccessoryPaddingLTR {
  // Given
  self.chip.accessoryView = [self deleteButton];

  // When
  self.chip.accessoryPadding = UIEdgeInsetsMake(0, 0, 10, 10);

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testDefaultChipWithAccessoryViewAndPositiveBottomRightAccessoryPaddingRTL {
  // Given
  self.chip.accessoryView = [self deleteButton];
  if (@available(iOS 10.0, *)) {
    self.chip.traitCollectionOverride = [UITraitCollection
        traitCollectionWithLayoutDirection:UITraitEnvironmentLayoutDirectionRightToLeft];
  }

  // When
  self.chip.accessoryPadding = UIEdgeInsetsMake(0, 0, 10, 10);

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testDefaultChipWithAccessoryViewAndNegativeTopLeftAccessoryPaddingLTR {
  // Given
  self.chip.accessoryView = [self deleteButton];

  // When
  self.chip.accessoryPadding = UIEdgeInsetsMake(-6, -6, 0, 0);

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testDefaultChipWithAccessoryViewAndNegativeTopLeftAccessoryPaddingRTL {
  // Given
  self.chip.accessoryView = [self deleteButton];
  if (@available(iOS 10.0, *)) {
    self.chip.traitCollectionOverride = [UITraitCollection
        traitCollectionWithLayoutDirection:UITraitEnvironmentLayoutDirectionRightToLeft];
  }

  // When
  self.chip.accessoryPadding = UIEdgeInsetsMake(-6, -6, 0, 0);

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testDefaultChipWithAccessoryViewAndNegativeBottomRightAccessoryPaddingLTR {
  // Given
  self.chip.accessoryView = [self deleteButton];

  // When
  self.chip.accessoryPadding = UIEdgeInsetsMake(0, 0, -6, -6);

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testDefaultChipWithAccessoryViewAndNegativeBottomRightAccessoryPaddingRTL {
  // Given
  self.chip.accessoryView = [self deleteButton];
  if (@available(iOS 10.0, *)) {
    self.chip.traitCollectionOverride = [UITraitCollection
        traitCollectionWithLayoutDirection:UITraitEnvironmentLayoutDirectionRightToLeft];
  }

  // When
  self.chip.accessoryPadding = UIEdgeInsetsMake(0, 0, -6, -6);

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testBaselineThemedChipWithAccessoryViewLTR {
  // When
  self.chip.accessoryView = [self deleteButton];
  [self.chip applyThemeWithScheme:self.scheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testBaselineThemedChipWithAccessoryViewRTL {
  // Given
  if (@available(iOS 10.0, *)) {
    self.chip.traitCollectionOverride = [UITraitCollection
        traitCollectionWithLayoutDirection:UITraitEnvironmentLayoutDirectionRightToLeft];
  }

  // When
  self.chip.accessoryView = [self deleteButton];
  [self.chip applyThemeWithScheme:self.scheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testOutlinedThemedChipWithAccessoryViewLTR {
  // When
  self.chip.accessoryView = [self deleteButton];
  [self.chip applyOutlinedThemeWithScheme:self.scheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testOutlinedThemedChipWithAccessoryViewRTL {
  // Given
  if (@available(iOS 10.0, *)) {
    self.chip.traitCollectionOverride = [UITraitCollection
        traitCollectionWithLayoutDirection:UITraitEnvironmentLayoutDirectionRightToLeft];
  }

  // When
  self.chip.accessoryView = [self deleteButton];
  [self.chip applyOutlinedThemeWithScheme:self.scheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

#pragma mark - With Leading Image and Accessory View

- (void)testDefaultChipWithImageAndAccessoryView {
  // When
  self.chip.imageView.image = [self leadingImage];
  self.chip.accessoryView = [self deleteButton];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testBaselineThemedChipWithImageAndAccessoryViewLTR {
  // When
  self.chip.imageView.image = [self leadingImage];
  self.chip.accessoryView = [self deleteButton];
  [self.chip applyThemeWithScheme:self.scheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testBaselineThemedChipWithImageAndAccessoryViewRTL {
  // Given
  if (@available(iOS 10.0, *)) {
    self.chip.traitCollectionOverride = [UITraitCollection
        traitCollectionWithLayoutDirection:UITraitEnvironmentLayoutDirectionRightToLeft];
  }

  // When
  self.chip.imageView.image = [self leadingImage];
  self.chip.accessoryView = [self deleteButton];
  [self.chip applyThemeWithScheme:self.scheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testOutlinedThemedChipWithImageAndAccessoryViewLTR {
  // When
  self.chip.imageView.image = [self leadingImage];
  self.chip.accessoryView = [self deleteButton];
  [self.chip applyOutlinedThemeWithScheme:self.scheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testOutlinedThemedChipWithImageAndAccessoryViewRTL {
  // Given
  if (@available(iOS 10.0, *)) {
    self.chip.traitCollectionOverride = [UITraitCollection
        traitCollectionWithLayoutDirection:UITraitEnvironmentLayoutDirectionRightToLeft];
  }

  // When
  self.chip.imageView.image = [self leadingImage];
  self.chip.accessoryView = [self deleteButton];
  [self.chip applyOutlinedThemeWithScheme:self.scheme];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

#pragma mark - State Changes

- (void)testDefaultChipWithHighlightedState {
  // When
  self.chip.highlighted = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testDefaultChipWithSelectedState {
  // When
  self.chip.selected = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testDefaultChipWithDisabledState {
  // When
  self.chip.enabled = NO;

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testDefaultChipWithHighlightedAndSelectedState {
  // When
  self.chip.highlighted = YES;
  self.chip.selected = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testBaselineChipWithHighlightedState {
  // When
  [self.chip applyThemeWithScheme:self.scheme];
  self.chip.highlighted = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testBaselineChipWithSelectedState {
  // When
  [self.chip applyThemeWithScheme:self.scheme];
  self.chip.selected = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testBaselineChipWithDisabledState {
  // When
  [self.chip applyThemeWithScheme:self.scheme];
  self.chip.enabled = NO;

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testBaselineChipWithHighlightedAndSelectedState {
  // When
  [self.chip applyThemeWithScheme:self.scheme];
  self.chip.highlighted = YES;
  self.chip.selected = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testOutlinedChipWithHighlightedState {
  // When
  [self.chip applyOutlinedThemeWithScheme:self.scheme];
  self.chip.highlighted = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testOutlinedChipWithSelectedState {
  // When
  [self.chip applyOutlinedThemeWithScheme:self.scheme];
  self.chip.selected = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testOutlinedChipWithDisabledState {
  // When
  [self.chip applyOutlinedThemeWithScheme:self.scheme];
  self.chip.enabled = NO;

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testOutlinedChipWithHighlightedAndSelectedState {
  // When
  [self.chip applyOutlinedThemeWithScheme:self.scheme];
  self.chip.highlighted = YES;
  self.chip.selected = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testDefaultChipWithRippleEnabledInHighlightedState {
  // When
  self.chip.enableRippleBehavior = YES;
  self.chip.highlighted = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testDefaultChipWithRippleEnabledInSelectedState {
  // When
  self.chip.enableRippleBehavior = YES;
  self.chip.selected = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testDefaultChipWithRippleEnabledInDisabledState {
  // When
  self.chip.enableRippleBehavior = YES;
  self.chip.enabled = NO;

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testDefaultChipWithRippleEnabledInHighlightedAndSelectedState {
  // When
  self.chip.enableRippleBehavior = YES;
  self.chip.highlighted = YES;
  self.chip.selected = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testBaselineChipWithRippleEnabledInHighlightedState {
  // When
  self.chip.enableRippleBehavior = YES;
  [self.chip applyThemeWithScheme:self.scheme];
  self.chip.highlighted = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testBaselineChipWithRippleEnabledInSelectedState {
  // When
  self.chip.enableRippleBehavior = YES;
  [self.chip applyThemeWithScheme:self.scheme];
  self.chip.selected = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testBaselineChipWithRippleEnabledInDisabledState {
  // When
  self.chip.enableRippleBehavior = YES;
  [self.chip applyThemeWithScheme:self.scheme];
  self.chip.enabled = NO;

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testBaselineChipWithRippleEnabledInHighlightedAndSelectedState {
  // When
  self.chip.enableRippleBehavior = YES;
  [self.chip applyThemeWithScheme:self.scheme];
  self.chip.highlighted = YES;
  self.chip.selected = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testOutlinedChipWithRippleEnabledInHighlightedState {
  // When
  self.chip.enableRippleBehavior = YES;
  [self.chip applyOutlinedThemeWithScheme:self.scheme];
  self.chip.highlighted = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testOutlinedChipWithRippleEnabledInSelectedState {
  // When
  self.chip.enableRippleBehavior = YES;
  [self.chip applyOutlinedThemeWithScheme:self.scheme];
  self.chip.selected = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testOutlinedChipWithRippleEnabledInDisabledState {
  // When
  self.chip.enableRippleBehavior = YES;
  [self.chip applyOutlinedThemeWithScheme:self.scheme];
  self.chip.enabled = NO;

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testOutlinedChipWithRippleEnabledInHighlightedAndSelectedState {
  // When
  self.chip.enableRippleBehavior = YES;
  [self.chip applyOutlinedThemeWithScheme:self.scheme];
  self.chip.highlighted = YES;
  self.chip.selected = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

@end
