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

#import "MaterialDialogs.h"
#import "MaterialTypography.h"

/** A @c MDCAlertController test fake to override the @c traitCollection to test for dynamic type.
 */
@interface AlertControllerDynamicTypeSnapshotTestFake : MDCAlertController
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;
@end

@implementation AlertControllerDynamicTypeSnapshotTestFake

- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}

@end

@interface MDCAlertControllerDynamicTypeTests : MDCSnapshotTestCase
@property(nonatomic, strong, nullable) AlertControllerDynamicTypeSnapshotTestFake *alertController;
@end

@implementation MDCAlertControllerDynamicTypeTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.alertController = [[AlertControllerDynamicTypeSnapshotTestFake alloc] init];
  self.alertController.title = @"Material";
  self.alertController.message =
      @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt "
      @"ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation "
      @"ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in "
      @"reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur "
      @"sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id "
      @"est laborum.";
  MDCAlertAction *fakeAction = [MDCAlertAction actionWithTitle:@"Foo"
                                                       handler:^(MDCAlertAction *action){
                                                       }];
  [self.alertController addAction:fakeAction];
<<<<<<< HEAD
  self.alertController.mdc_adjustsFontForContentSizeCategory = YES;
  self.alertController.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;
=======
>>>>>>> 98c7e5a8bddf8e9d639b8e8742c8ace84e2e3705
  MDCFontScaler *titleFontScaler = [MDCFontScaler scalerForMaterialTextStyle:MDCTextStyleSubtitle1];
  UIFont *titleFont = [UIFont systemFontOfSize:14];
  titleFont = [titleFontScaler scaledFontWithFont:titleFont];
  titleFont = [titleFont mdc_scaledFontAtDefaultSize];
  self.alertController.titleFont = titleFont;
<<<<<<< HEAD
  MDCFontScaler *messageFontScaler =
      [MDCFontScaler scalerForMaterialTextStyle:MDCTextStyleSubtitle2];
=======
  MDCFontScaler *messageFontScaler = [MDCFontScaler scalerForMaterialTextStyle:MDCTextStyleBody2];
>>>>>>> 98c7e5a8bddf8e9d639b8e8742c8ace84e2e3705
  UIFont *messageFont = [UIFont systemFontOfSize:15];
  messageFont = [messageFontScaler scaledFontWithFont:messageFont];
  messageFont = [messageFont mdc_scaledFontAtDefaultSize];
  self.alertController.messageFont = messageFont;
<<<<<<< HEAD
  MDCFontScaler *buttonFontScaler = [MDCFontScaler scalerForMaterialTextStyle:MDCTextStyleBody1];
  UIFont *buttonFont = [UIFont systemFontOfSize:15];
=======
  MDCFontScaler *buttonFontScaler = [MDCFontScaler scalerForMaterialTextStyle:MDCTextStyleButton];
  UIFont *buttonFont = [UIFont systemFontOfSize:16];
>>>>>>> 98c7e5a8bddf8e9d639b8e8742c8ace84e2e3705
  buttonFont = [buttonFontScaler scaledFontWithFont:buttonFont];
  buttonFont = [buttonFont mdc_scaledFontAtDefaultSize];
  self.alertController.buttonFont = buttonFont;
  self.alertController.view.bounds = CGRectMake(0, 0, 300, 300);
}

- (void)tearDown {
  self.alertController = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  [view layoutIfNeeded];
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

/**
 Used to set the @c UIContentSizeCategory on an @c MDCAlertController.

 @note On iOS 9 or below this method has no impact.
 */
- (void)setAlertControllerTraitCollectionSizeToSize:(UIContentSizeCategory)sizeCategory {
  UITraitCollection *traitCollection = [[UITraitCollection alloc] init];
  if (@available(iOS 10.0, *)) {
    traitCollection =
        [UITraitCollection traitCollectionWithPreferredContentSizeCategory:sizeCategory];
  }

  self.alertController.traitCollectionOverride = traitCollection;
}

<<<<<<< HEAD
/** Test when a @c MDCAlertController has a content size of @c UIContentSizeCategorySmall. */
- (void)testScaledFontDynamicTypeForContentSizeCategorySmall {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategorySmall];

  // When
=======
- (void)testScaledFontDynamicTypeForContentSizeCategorySmall {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategorySmall];
  self.alertController.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  self.alertController.mdc_adjustsFontForContentSizeCategory = YES;
>>>>>>> 98c7e5a8bddf8e9d639b8e8742c8ace84e2e3705
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

<<<<<<< HEAD
/** Test when a @c MDCAlertController has a content size of @c UIContentSizeCategoryMedium. */
- (void)testScaledFontDynamicTypeForContentSizeCategoryMedium {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryMedium];

  // When
=======
- (void)testScaledFontDynamicTypeForContentSizeCategoryMedium {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryMedium];
  self.alertController.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  self.alertController.mdc_adjustsFontForContentSizeCategory = YES;
>>>>>>> 98c7e5a8bddf8e9d639b8e8742c8ace84e2e3705
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

<<<<<<< HEAD
/** Test when a @c MDCAlertController has a content size of @c UIContentSizeCategoryLarge. */
- (void)testScaledFontDynamicTypeForContentSizeCategoryLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryLarge];

  // When
=======
- (void)testScaledFontDynamicTypeForContentSizeCategoryLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryLarge];
  self.alertController.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  self.alertController.mdc_adjustsFontForContentSizeCategory = YES;
>>>>>>> 98c7e5a8bddf8e9d639b8e8742c8ace84e2e3705
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

<<<<<<< HEAD
/** Test when a @c MDCAlertController has a content size of @c UIContentSizeCategoryExtraLarge. */
- (void)testScaledFontDynamicTypeForContentSizeCategoryExtraLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryExtraLarge];

  // When
=======
- (void)testScaledFontDynamicTypeForContentSizeCategoryExtraLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryExtraLarge];
  self.alertController.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  self.alertController.mdc_adjustsFontForContentSizeCategory = YES;
>>>>>>> 98c7e5a8bddf8e9d639b8e8742c8ace84e2e3705
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

<<<<<<< HEAD
/** Test when a @c MDCAlertController has a content size of @c UIContentSizeCategoryExtraExtraLarge.
 */
- (void)testScaledFontDynamicTypeForContentSizeCategoryExtraExtraLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryExtraExtraLarge];

  // When
=======
- (void)testScaledFontDynamicTypeForContentSizeCategoryExtraExtraLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryExtraExtraLarge];
  self.alertController.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  self.alertController.mdc_adjustsFontForContentSizeCategory = YES;
>>>>>>> 98c7e5a8bddf8e9d639b8e8742c8ace84e2e3705
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

<<<<<<< HEAD
/** Test when a @c MDCAlertController has a content size of @c
 * UIContentSizeCategoryExtraExtraExtraLarge. */
- (void)testScaledFontDynamicTypeForContentSizeCategoryExtraExtraExtraLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryExtraExtraExtraLarge];

  // When
=======
- (void)testScaledFontDynamicTypeForContentSizeCategoryExtraExtraExtraLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryExtraExtraExtraLarge];
  self.alertController.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  self.alertController.mdc_adjustsFontForContentSizeCategory = YES;
>>>>>>> 98c7e5a8bddf8e9d639b8e8742c8ace84e2e3705
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

<<<<<<< HEAD
/** Test when a @c MDCAlertController has a content size of @c
 * UIContentSizeCategoryAccessibilityMedium. */
- (void)testScaledFontDynamicTypeForContentSizeCategoryAccessibilityMedium {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityMedium];

  // When
=======
- (void)testScaledFontDynamicTypeForContentSizeCategoryAccessibilityMedium {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityMedium];
  self.alertController.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  self.alertController.mdc_adjustsFontForContentSizeCategory = YES;
>>>>>>> 98c7e5a8bddf8e9d639b8e8742c8ace84e2e3705
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

<<<<<<< HEAD
/** Test when a @c MDCAlertController has a content size of @c
 * UIContentSizeCategoryAccessibilityLarge. */
- (void)testScaledFontDynamicTypeForContentSizeCategoryAccessibilityLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityLarge];

  // When
=======
- (void)testScaledFontDynamicTypeForContentSizeCategoryAccessibilityLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityLarge];
  self.alertController.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  self.alertController.mdc_adjustsFontForContentSizeCategory = YES;
>>>>>>> 98c7e5a8bddf8e9d639b8e8742c8ace84e2e3705
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

<<<<<<< HEAD
/**
 Test when a @c MDCAlertController has a content size of @c
 UIContentSizeCategoryAccessibilityExtraLarge.
 */
- (void)testScaledFontDynamicTypeForContentSizeCategoryAccessibilityExtraLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityExtraLarge];

  // When
=======
- (void)testScaledFontDynamicTypeForContentSizeCategoryAccessibilityExtraLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityExtraLarge];
  self.alertController.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  self.alertController.mdc_adjustsFontForContentSizeCategory = YES;
>>>>>>> 98c7e5a8bddf8e9d639b8e8742c8ace84e2e3705
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

<<<<<<< HEAD
/**
 Test when a @c MDCAlertController has a content size of @c
 UIContentSizeCategoryAccessibilityExtraLarge.
 */
=======
>>>>>>> 98c7e5a8bddf8e9d639b8e8742c8ace84e2e3705
- (void)testScaledFontDynamicTypeForContentSizeCategoryAccessibilityExtraExtraLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:
            UIContentSizeCategoryAccessibilityExtraExtraLarge];
<<<<<<< HEAD

  // When
=======
  self.alertController.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  self.alertController.mdc_adjustsFontForContentSizeCategory = YES;
>>>>>>> 98c7e5a8bddf8e9d639b8e8742c8ace84e2e3705
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

<<<<<<< HEAD
/**
 Test when a @c MDCAlertController has a content size of @c
 UIContentSizeCategoryAccessibilityExtraLarge.
 */
=======
>>>>>>> 98c7e5a8bddf8e9d639b8e8742c8ace84e2e3705
- (void)testScaledFontDynamicTypeForContentSizeCategoryAccessibilityExtraExtraExtraLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:
            UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];
<<<<<<< HEAD

  // When
=======
  self.alertController.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;

  // When
  self.alertController.mdc_adjustsFontForContentSizeCategory = YES;
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)testScaledFontDynamicTypeForContentSizeCategoryExtraSmallAndLegacyDisabled {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryExtraSmall];
  self.alertController.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = YES;

  // When
  self.alertController.mdc_adjustsFontForContentSizeCategory = YES;
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

- (void)
    testScaledFontDynamicTypeForContentSizeCategoryAccessibilityExtraExtraExtraLargeAndLegacyDisabled {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:
            UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];
  self.alertController.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = YES;

  // When
  self.alertController.mdc_adjustsFontForContentSizeCategory = YES;
>>>>>>> 98c7e5a8bddf8e9d639b8e8742c8ace84e2e3705
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

@end
