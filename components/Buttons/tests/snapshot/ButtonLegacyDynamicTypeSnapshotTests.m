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

#import "MaterialButtons.h"
#import "MaterialTypography.h"

/** A @c MDCButton test fake to override the @c traitCollection to test for dynamic type. */
@interface ButtonLegacyDynamicTypeSnapshotTestFakeButton : MDCButton
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;
@end

@implementation ButtonLegacyDynamicTypeSnapshotTestFakeButton

- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}

@end

/**
 Used to test visual differences in the legacy dynamic type behavior on @c MDCButton based on
 different @c UIContentSizeCategory values.
 */
@interface ButtonLegacyDynamicTypeSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong, nullable) ButtonLegacyDynamicTypeSnapshotTestFakeButton *button;
@end

@implementation ButtonLegacyDynamicTypeSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.button = [[ButtonLegacyDynamicTypeSnapshotTestFakeButton alloc] init];
  [self.button setTitle:@"Material" forState:UIControlStateNormal];
  self.button.mdc_adjustsFontForContentSizeCategory = YES;
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

  self.button.traitCollectionOverride = traitCollection;
}

/** Test when a @c MDCButton has a content size of @c UIContentSizeCategorySmall. */
- (void)testLegacyDynamicTypeContentSizeCategorySmall {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategorySmall];

  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/** Test when a @c MDCButton has a content size of @c UIContentSizeCategoryMedium. */
- (void)testLegacyDynamicTypeContentSizeCategoryMedium {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryMedium];

  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/** Test when a @c MDCButton has a content size of @c UIContentSizeCategoryLarge. */
- (void)testLegacyDynamicTypeContentSizeCategoryLarge {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryLarge];

  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/** Test when a @c MDCButton has a content size of @c UIContentSizeCategoryExtraLarge. */
- (void)testLegacyDynamicTypeContentSizeCategoryExtraLarge {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryExtraLarge];

  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/** Test when a @c MDCButton has a content size of @c UIContentSizeCategoryExtraExtraLarge. */
- (void)testLegacyDynamicTypeContentSizeCategoryExtraExtraLarge {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryExtraExtraLarge];

  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/** Test when a @c MDCButton has a content size of @c UIContentSizeCategoryExtraExtraExtraLarge. */
- (void)testLegacyDynamicTypeContentSizeCategoryExtraExtraExtraLarge {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryExtraExtraExtraLarge];

  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/** Test when a @c MDCButton has a content size of @c UIContentSizeCategoryAccessibilityMedium. */
- (void)testLegacyDynamicTypeContentSizeCategoryAccessibilityMedium {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityMedium];

  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/** Test when a @c MDCButton has a content size of @c UIContentSizeCategoryAccessibilityLarge. */
- (void)testLegacyDynamicTypeContentSizeCategoryAccessibilityLarge {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityLarge];

  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/**
 Test when a @c MDCButton has a content size of @c UIContentSizeCategoryAccessibilityExtraLarge.
 */
- (void)testLegacyDynamicTypeContentSizeCategoryAccessibilityExtraLarge {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityExtraLarge];

  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/**
 Test when a @c MDCButton has a content size of @c UIContentSizeCategoryAccessibilityExtraLarge.
 */
- (void)testLegacyDynamicTypeContentSizeCategoryAccessibilityExtraExtraLarge {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityExtraExtraLarge];

  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/**
 Test when a @c MDCButton has a content size of @c UIContentSizeCategoryAccessibilityExtraLarge.
 */
- (void)testLegacyDynamicTypeContentSizeCategoryAccessibilityExtraExtraExtraLarge {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];

  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/** Test when a @c MDCButton has a content size of @c UIContentSizeCategorySmall. */
- (void)testLegacyDynamicTypeOffContentSizeCategorySmall {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategorySmall];
  self.button.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/** Test when a @c MDCButton has a content size of @c UIContentSizeCategoryMedium. */
- (void)testLegacyDynamicTypeOffContentSizeCategoryMedium {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryMedium];
  self.button.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/** Test when a @c MDCButton has a content size of @c UIContentSizeCategoryLarge. */
- (void)testLegacyDynamicTypeOffContentSizeCategoryLarge {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryLarge];
  self.button.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/** Test when a @c MDCButton has a content size of @c UIContentSizeCategoryExtraLarge. */
- (void)testLegacyDynamicTypeOffContentSizeCategoryExtraLarge {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryExtraLarge];
  self.button.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/** Test when a @c MDCButton has a content size of @c UIContentSizeCategoryExtraExtraLarge. */
- (void)testLegacyDynamicTypeOffContentSizeCategoryExtraExtraLarge {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryExtraExtraLarge];
  self.button.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/** Test when a @c MDCButton has a content size of @c UIContentSizeCategoryExtraExtraExtraLarge. */
- (void)testLegacyDynamicTypeOffContentSizeCategoryExtraExtraExtraLarge {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryExtraExtraExtraLarge];
  self.button.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/** Test when a @c MDCButton has a content size of @c UIContentSizeCategoryAccessibilityMedium. */
- (void)testLegacyDynamicTypeOffContentSizeCategoryAccessibilityMedium {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityMedium];
  self.button.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/** Test when a @c MDCButton has a content size of @c UIContentSizeCategoryAccessibilityLarge. */
- (void)testLegacyDynamicTypeOffContentSizeCategoryAccessibilityLarge {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityLarge];
  self.button.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/**
 Test when a @c MDCButton has a content size of @c UIContentSizeCategoryAccessibilityExtraLarge.
 */
- (void)testLegacyDynamicTypeOffContentSizeCategoryAccessibilityExtraLarge {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityExtraLarge];
  self.button.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/**
 Test when a @c MDCButton has a content size of @c UIContentSizeCategoryAccessibilityExtraLarge.
 */
- (void)testLegacyDynamicTypeOffContentSizeCategoryAccessibilityExtraExtraLarge {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityExtraExtraLarge];
  self.button.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

/**
 Test when a @c MDCButton has a content size of @c UIContentSizeCategoryAccessibilityExtraLarge.
 */
- (void)testLegacyDynamicTypeOffContentSizeCategoryAccessibilityExtraExtraExtraLarge {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];
  self.button.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

@end
