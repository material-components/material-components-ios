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
#import "MaterialCards.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"

/**
 An MDCCard subclass that allows the user to override the @c traitCollection property.
 */
@interface MDCCardWithCustomTraitCollection : MDCCard
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;
@end

@implementation MDCCardWithCustomTraitCollection
- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}
@end

/**
 A Snapshot test case for testing MDCCardWithCustomTraitCollection   the @c traitCollection
 property.
 */
@interface MDCCardCustomTraitCollectionSnapshotTests : MDCSnapshotTestCase

@property(nonatomic, strong) MDCContainerScheme *containerScheme;
@property(nonatomic, strong) MDCCardWithCustomTraitCollection *card;

@end

@implementation MDCCardCustomTraitCollectionSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //      self.recordMode = YES;

  self.card = [[MDCCardWithCustomTraitCollection alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
  self.containerScheme = [[MDCContainerScheme alloc] init];
  self.containerScheme.colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
}

- (void)tearDown {
  self.card = nil;
  self.containerScheme = nil;

  [super tearDown];
}

#pragma mark - Helpers

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

- (void)testShadowColorRespondsToDynamicColor {
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13.0, *)) {
    // Given
    UIColor *dynamicColor =
        [UIColor colorWithDynamicProvider:^(UITraitCollection *traitCollection) {
          if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
            return UIColor.magentaColor;
          } else {
            return UIColor.greenColor;
          }
        }];
    [self.card setShadowColor:dynamicColor forState:UIControlStateNormal];

    // When
    self.card.traitCollectionOverride =
        [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleDark];
    [self.card layoutIfNeeded];

    // Then
    [self.card sizeToFit];
    UIView *snapshotView = [self.card mdc_addToBackgroundView];
    [self snapshotVerifyViewForIOS13:snapshotView];
  }
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)
}

@end
