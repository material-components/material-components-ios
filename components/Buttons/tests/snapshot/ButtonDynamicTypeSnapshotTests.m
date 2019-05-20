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

@interface FakeMDCButton : MDCButton
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;
@end

@implementation FakeMDCButton

- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}

@end

NS_AVAILABLE_IOS(10_0) @interface ButtonDynamicTypeSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong, nullable) FakeMDCButton *button;
@end

@implementation ButtonDynamicTypeSnapshotTests

- (void)setUp {
  [super setUp];

  self.recordMode = YES;
  self.button = [[FakeMDCButton alloc] init];
  [self.button setTitle:@"Material" forState:UIControlStateNormal];
  self.button.mdc_adjustsFontForContentSizeCategory = YES;
  self.button.mdc_legacyFontScaling = NO;
  MDCFontScaler *fontScaler = [MDCFontScaler scalerForMaterialTextStyle:MDCTextStyleHeadline1];
  UIFont *buttonFont = [self.button titleFontForState:UIControlStateNormal];
  buttonFont = [fontScaler scaledFontWithFont:buttonFont];
  buttonFont = [buttonFont mdc_scaledFontAtDefaultSize];
  [self.button setTitleFont:buttonFont forState:UIControlStateNormal];
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

- (void)setButtonTraitCollectionSizeToSize:(UIContentSizeCategory)sizeCategory {
  UITraitCollection *traitCollection =
      [UITraitCollection traitCollectionWithPreferredContentSizeCategory:sizeCategory];
  self.button.traitCollectionOverride = traitCollection;
}

- (void)testSmallContentSizeCategory {
  // Given
  [self setButtonTraitCollectionSizeToSize:UIContentSizeCategorySmall];

  // When
  [NSNotificationCenter.defaultCenter
      postNotificationName:UIContentSizeCategoryDidChangeNotification
                    object:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

@end
