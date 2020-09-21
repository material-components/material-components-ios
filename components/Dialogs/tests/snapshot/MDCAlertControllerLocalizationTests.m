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

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

#import "MaterialDialogs.h"
#import "MDCAlertController+Testing.h"
#import "MaterialSnapshot.h"

static NSString *const kTitleUrdu = @"عنوان";
static NSString *const kMessageUrdu =
    @"براہ کرم اپنا نیٹ ورک کنکشن چیک کریں اور دوبارہ کوشش کریں۔براہ کرم اپنا نیٹ ورک کنکشن چیک "
    @"کریں اور دوبارہ کوشش کریں۔";

static NSString *const kActionMediumUrdu = @"درمیانی";
static NSString *const kActionLowUrdu = @"کم";

/**
 Snapshot tests of MDCAlertController for localization.
 */
@interface MDCAlertControllerLocalizationSnapshotTests : MDCSnapshotTestCase

/**
 The alert controller used during testing.
 */
@property(nonatomic, strong) MDCAlertController *alertController;

/**
 The icon image used during testing.
 */
@property(nonatomic, strong) UIImage *iconImage;
@end

@implementation MDCAlertControllerLocalizationSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  // self.recordMode = YES;

  self.iconImage = [[UIImage mdc_testImageOfSize:CGSizeMake(40, 40)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.alertController = [[MDCAlertController alloc] init];
  self.alertController.view.bounds = CGRectMake(0, 0, 300, 300);
}

- (void)tearDown {
  self.alertController = nil;
  self.iconImage = nil;

  [super tearDown];
}

- (void)generateSizedSnapshotAndVerifyForAlert:(MDCAlertController *)alert {
  CGSize preferredContentSize = self.alertController.preferredContentSize;
  [alert sizeToFitContentInBounds:preferredContentSize];
  [self generateSnapshotAndVerifyForView:alert.view];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  [view layoutIfNeeded];

  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

- (void)changeToRTL:(MDCAlertController *)alertController {
  [self changeViewToRTL:alertController.view];
}

#pragma mark - Tests

- (void)testPreferredContentSizeWithNotoNastaliqUrdu {
  // When
  self.alertController.title = kTitleUrdu;
  self.alertController.titleIcon = self.iconImage;
  self.alertController.message = kMessageUrdu;
  NSString *urduFontName = @"NotoNastaliqUrdu";
  UIFont *dialogBodyFont = [UIFont systemFontOfSize:20.0];
  UIFont *dialogButtonFont = [UIFont systemFontOfSize:26.0];
  if (@available(iOS 11, *)) {
    // Noto Nastaliq Urdu was added in iOS 11, and is an extremely tall
    // font for any given nominal point size.
    dialogBodyFont = [UIFont fontWithName:urduFontName size:20.0];
    dialogButtonFont = [UIFont fontWithName:urduFontName size:26.0];
  }
  self.alertController.messageFont = dialogBodyFont;
  self.alertController.buttonFont = dialogButtonFont;
  MDCAlertAction *actionLow = [MDCAlertAction actionWithTitle:kActionLowUrdu
                                                     emphasis:MDCActionEmphasisLow
                                                      handler:nil];
  MDCAlertAction *actionMedium = [MDCAlertAction actionWithTitle:kActionMediumUrdu
                                                        emphasis:MDCActionEmphasisMedium
                                                         handler:nil];
  [self.alertController addAction:actionLow];
  [self.alertController addAction:actionMedium];

  [self changeToRTL:self.alertController];

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alertController];
}

@end
