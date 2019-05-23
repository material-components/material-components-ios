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
    self.recordMode = YES;

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
  self.alertController.mdc_adjustsFontForContentSizeCategory = YES;
  self.alertController.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable = NO;
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

/** Attaches scaled fonts to the @c MDCAlertController. */
- (void)attachScaledFonts {
  MDCFontScaler *titleFontScaler = [MDCFontScaler scalerForMaterialTextStyle:MDCTextStyleSubtitle1];
  UIFont *titleFont = [UIFont systemFontOfSize:14];
  titleFont = [titleFontScaler scaledFontWithFont:titleFont];
  titleFont = [titleFont mdc_scaledFontAtDefaultSize];
  self.alertController.titleFont = titleFont;
  MDCFontScaler *messageFontScaler =
  [MDCFontScaler scalerForMaterialTextStyle:MDCTextStyleSubtitle2];
  UIFont *messageFont = [UIFont systemFontOfSize:15];
  messageFont = [messageFontScaler scaledFontWithFont:messageFont];
  messageFont = [messageFont mdc_scaledFontAtDefaultSize];
  self.alertController.messageFont = messageFont;
  MDCFontScaler *buttonFontScaler = [MDCFontScaler scalerForMaterialTextStyle:MDCTextStyleBody1];
  UIFont *buttonFont = [UIFont systemFontOfSize:16];
  buttonFont = [buttonFontScaler scaledFontWithFont:buttonFont];
  buttonFont = [buttonFont mdc_scaledFontAtDefaultSize];
  self.alertController.buttonFont = buttonFont;
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

/**
 Test when a @c MDCAlertController has a content size of @c UIContentSizeCategorySmall and scaled
 fonts are attached.
 */
- (void)testDynamicTypeWhenScaledFontsAreAttachedForContentSizeCategorySmall {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategorySmall];
  [self attachScaledFonts];

  // When
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

/**
 Test when a @c MDCAlertController has a content size of @c UIContentSizeCategoryMedium and scaled
 fonts are attached.
 */
- (void)testDynamicTypeWhenScaledFontsAreAttachedForContentSizeCategoryMedium {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryMedium];
  [self attachScaledFonts];

  // When
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

/**
 Test when a @c MDCAlertController has a content size of @c UIContentSizeCategoryLarge and scaled
 fonts are attached.
 */
- (void)testDynamicTypeWhenScaledFontsAreAttachedForContentSizeCategoryLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryLarge];
  [self attachScaledFonts];

  // When
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

/**
 Test when a @c MDCAlertController has a content size of @c UIContentSizeCategoryExtraLarge and
 scaled fonts are attached.
 */
- (void)testDynamicTypeWhenScaledFontsAreAttachedForContentSizeCategoryExtraLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryExtraLarge];
  [self attachScaledFonts];

  // When
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

/**
 Test when a @c MDCAlertController has a content size of @c UIContentSizeCategoryExtraExtraLarge
 and scaled fonts are attached.
 */
- (void)testDynamicTypeWhenScaledFontsAreAttachedForContentSizeCategoryExtraExtraLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryExtraExtraLarge];
  [self attachScaledFonts];

  // When
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

/**
 Test when a @c MDCAlertController has a content size of @c
 UIContentSizeCategoryExtraExtraExtraLarge and scaled fonts are attached.
 */
- (void)testDynamicTypeWhenScaledFontsAreAttachedForContentSizeCategoryExtraExtraExtraLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryExtraExtraExtraLarge];
  [self attachScaledFonts];

  // When
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

/**
 Test when a @c MDCAlertController has a content size of @c
 UIContentSizeCategoryAccessibilityMedium and scaled fonts are attached.
 */
- (void)testDynamicTypeWhenScaledFontsAreAttachedForContentSizeCategoryAccessibilityMedium {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityMedium];
  [self attachScaledFonts];

  // When
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

/**
 Test when a @c MDCAlertController has a content size of @c
 UIContentSizeCategoryAccessibilityLarge and scaled fonts are attached.
 */
- (void)testDynamicTypeWhenScaledFontsAreAttachedForContentSizeCategoryAccessibilityLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityLarge];
  [self attachScaledFonts];

  // When
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

/**
 Test when a @c MDCAlertController has a content size of @c
 UIContentSizeCategoryAccessibilityExtraLarge and scaled fonts are attached.
 */
- (void)testDynamicTypeWhenScaledFontsAreAttachedForContentSizeCategoryAccessibilityExtraLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityExtraLarge];
  [self attachScaledFonts];

  // When
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

/**
 Test when a @c MDCAlertController has a content size of @c
 UIContentSizeCategoryAccessibilityExtraLarge and scaled fonts are attached.
 */
- (void)testDynamicTypeWhenScaledFontsAreAttachedForContentSizeCategoryAccessibilityExtraExtraLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:
            UIContentSizeCategoryAccessibilityExtraExtraLarge];
  [self attachScaledFonts];

  // When
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

/**
 Test when a @c MDCAlertController has a content size of @c
 UIContentSizeCategoryAccessibilityExtraLarge and scaled fonts are attached.
 */
- (void)testDynamicTypeWhenScaledFontsAreAttachedForContentSizeCategoryAccessibilityExtraExtraExtraLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:
            UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];
  [self attachScaledFonts];

  // When
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

/**
 Test when a @c MDCAlertController has a content size of @c UIContentSizeCategorySmall and no scaled
 fonts are attached.
 */
- (void)testDynamicTypeWhenNoScaledFontsAreAttachedForContentSizeCategorySmall {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategorySmall];
  
  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];
  
  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

/**
 Test when a @c MDCAlertController has a content size of @c UIContentSizeCategoryMedium and no
 scaled fonts are attached.
 */
- (void)testDynamicTypeWhenNoScaledFontsAreAttachedForContentSizeCategoryMedium {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryMedium];
  
  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];
  
  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

/**
 Test when a @c MDCAlertController has a content size of @c UIContentSizeCategoryLarge and no scaled
 fonts are attached.
 */
- (void)testDynamicTypeWhenNoScaledFontsAreAttachedForContentSizeCategoryLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryLarge];
  
  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];
  
  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

/**
 Test when a @c MDCAlertController has a content size of @c UIContentSizeCategoryExtraLarge and
 scaled fonts are attached.
 */
- (void)testDynamicTypeWhenNoScaledFontsAreAttachedForContentSizeCategoryExtraLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryExtraLarge];
  
  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];
  
  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

/**
 Test when a @c MDCAlertController has a content size of @c UIContentSizeCategoryExtraExtraLarge
 and no scaled fonts are attached.
 */
- (void)testDynamicTypeWhenNoScaledFontsAreAttachedForContentSizeCategoryExtraExtraLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryExtraExtraLarge];
  
  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];
  
  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

/**
 Test when a @c MDCAlertController has a content size of @c
 UIContentSizeCategoryExtraExtraExtraLarge and no scaled fonts are attached.
 */
- (void)testDynamicTypeWhenNoScaledFontsAreAttachedForContentSizeCategoryExtraExtraExtraLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryExtraExtraExtraLarge];
  
  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];
  
  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

/**
 Test when a @c MDCAlertController has a content size of @c
 UIContentSizeCategoryAccessibilityMedium and no scaled fonts are attached.
 */
- (void)testDynamicTypeWhenNoScaledFontsAreAttachedForContentSizeCategoryAccessibilityMedium {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityMedium];
  
  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];
  
  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

/**
 Test when a @c MDCAlertController has a content size of @c
 UIContentSizeCategoryAccessibilityLarge and no scaled fonts are attached.
 */
- (void)testDynamicTypeWhenNoScaledFontsAreAttachedForContentSizeCategoryAccessibilityLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityLarge];
  
  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];
  
  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

/**
 Test when a @c MDCAlertController has a content size of @c
 UIContentSizeCategoryAccessibilityExtraLarge and no scaled fonts are attached.
 */
- (void)testDynamicTypeWhenNoScaledFontsAreAttachedForContentSizeCategoryAccessibilityExtraLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:UIContentSizeCategoryAccessibilityExtraLarge];
  
  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];
  
  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

/**
 Test when a @c MDCAlertController has a content size of @c
 UIContentSizeCategoryAccessibilityExtraLarge and no scaled fonts are attached.
 */
- (void)testDynamicTypeWhenNoScaledFontsAreAttachedForContentSizeCategoryAccessibilityExtraExtraLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:
   UIContentSizeCategoryAccessibilityExtraExtraLarge];
  
  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];
  
  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

/**
 Test when a @c MDCAlertController has a content size of @c
 UIContentSizeCategoryAccessibilityExtraLarge and no scaled fonts are attached.
 */
- (void)testDynamicTypeWhenNoScaledFontsAreAttachedForContentSizeCategoryAccessibilityExtraExtraExtraLarge {
  // Given
  [self setAlertControllerTraitCollectionSizeToSize:
   UIContentSizeCategoryAccessibilityExtraExtraExtraLarge];
  
  // When
  [NSNotificationCenter.defaultCenter
   postNotificationName:UIContentSizeCategoryDidChangeNotification
   object:nil];
  
  // Then
  [self generateSnapshotAndVerifyForView:self.alertController.view];
}

@end
