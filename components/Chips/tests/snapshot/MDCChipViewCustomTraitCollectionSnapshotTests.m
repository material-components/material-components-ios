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

#import "MaterialAvailability.h"
#import "MaterialChips.h"
#import "MaterialChips+Theming.h"

/**
 An MDCChipView subclass that allows the user to override the @c traitCollection property.
 */
@interface MDCChipViewWithCustomTraitCollection : MDCChipView
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;
@end

@implementation MDCChipViewWithCustomTraitCollection
- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}
@end

/**
 A Snapshot test case for testing MDCChipViewWithCustomTraitCollection
 */
@interface MDCChipViewCustomTraitCollectionSnapshotTests : MDCSnapshotTestCase

@property(nonatomic, strong) MDCContainerScheme *containerScheme;
@property(nonatomic, strong) MDCChipViewWithCustomTraitCollection *chip;

@end

@implementation MDCChipViewCustomTraitCollectionSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //          self.recordMode = YES;

  self.chip = [[MDCChipViewWithCustomTraitCollection alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
  self.containerScheme = [[MDCContainerScheme alloc] init];
  self.containerScheme.colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
}

- (void)tearDown {
  self.chip = nil;
  self.containerScheme = nil;

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

- (void)testDynamicColorSupport {
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13.0, *)) {
    // Given
    UIColor *dynamicShadowColor =
        [UIColor colorWithDynamicProvider:^(UITraitCollection *traitCollection) {
          if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
            return UIColor.magentaColor;
          } else {
            return UIColor.greenColor;
          }
        }];
    UIColor *dynamicBackgroundColor =
        [UIColor colorWithDynamicProvider:^(UITraitCollection *traitCollection) {
          if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
            return UIColor.orangeColor;
          } else {
            return UIColor.redColor;
          }
        }];
    UIColor *dynamicBorderColor =
        [UIColor colorWithDynamicProvider:^(UITraitCollection *traitCollection) {
          if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
            return UIColor.yellowColor;
          } else {
            return UIColor.brownColor;
          }
        }];

    [self.chip setBorderWidth:3 forState:UIControlStateHighlighted];
    [self.chip setShadowColor:dynamicShadowColor forState:UIControlStateHighlighted];
    [self.chip setBorderColor:dynamicBorderColor forState:UIControlStateHighlighted];
    [self.chip setBackgroundColor:dynamicBackgroundColor forState:UIControlStateHighlighted];
    self.chip.highlighted = YES;

    // When
    self.chip.traitCollectionOverride =
        [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleDark];

    // Then
    [self.chip sizeToFit];
    UIView *snapshotView = [self.chip mdc_addToBackgroundView];
    [self snapshotVerifyViewForIOS13:snapshotView];
  }
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)
}

- (void)testPreferredFontForAXXXLContentSizeCategory {
  // Given
  [self.chip applyThemeWithScheme:self.containerScheme];
  UITraitCollection *xsTraitCollection = [UITraitCollection
      traitCollectionWithPreferredContentSizeCategory:UIContentSizeCategoryExtraSmall];
  UIFont *originalFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody
                             compatibleWithTraitCollection:xsTraitCollection];
  self.chip.traitCollectionOverride = xsTraitCollection;
  UITraitCollection *aXXXLTraitCollection =
      [UITraitCollection traitCollectionWithPreferredContentSizeCategory:
                             UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];
  self.chip.titleLabel.text = @"Title";
  self.chip.titleLabel.font = originalFont;
  self.chip.titleLabel.adjustsFontForContentSizeCategory = YES;

  // When
  self.chip.traitCollectionOverride = aXXXLTraitCollection;
  // Force the Dynamic Type system to update the button's font.
  [self.chip drawViewHierarchyInRect:self.chip.bounds afterScreenUpdates:YES];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

- (void)testPreferredFontForXSContentSizeCategory {
  // Given
  [self.chip applyThemeWithScheme:self.containerScheme];
  UITraitCollection *aXXXLTraitCollection =
      [UITraitCollection traitCollectionWithPreferredContentSizeCategory:
                             UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];
  UIFont *originalFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody
                             compatibleWithTraitCollection:aXXXLTraitCollection];
  self.chip.traitCollectionOverride = aXXXLTraitCollection;
  self.chip.titleLabel.text = @"Title";
  self.chip.titleLabel.font = originalFont;
  self.chip.titleLabel.adjustsFontForContentSizeCategory = YES;

  // When
  UITraitCollection *xsTraitCollection = [UITraitCollection
      traitCollectionWithPreferredContentSizeCategory:UIContentSizeCategoryExtraSmall];

  self.chip.traitCollectionOverride = xsTraitCollection;
  // Force the Dynamic Type system to update the button's font.
  [self.chip drawViewHierarchyInRect:self.chip.bounds afterScreenUpdates:YES];

  // Then
  [self generateSnapshotAndVerifyForView:self.chip];
}

@end
