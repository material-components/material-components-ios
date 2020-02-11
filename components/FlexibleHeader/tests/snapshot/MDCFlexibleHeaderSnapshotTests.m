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

#import <UIKit/UIKit.h>

#import "MaterialFlexibleHeader.h"
#import "MaterialShadowLayer.h"

/** Fake subclass of MDCFlexibleHeaderView to override the @c traitCollection. */
@interface MDCFlexibleHeaderTraitCollectionTestView : MDCFlexibleHeaderView
@property(nonatomic, strong) UITraitCollection *traitCollectionOverride;
@end

@implementation MDCFlexibleHeaderTraitCollectionTestView

- (UITraitCollection *)traitCollection {
  return self.traitCollectionOverride ?: [super traitCollection];
}

@end

@interface MDCFlexibleHeaderSnapshotTests : MDCSnapshotTestCase
@end

@implementation MDCFlexibleHeaderSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  // self.recordMode = YES;
}

- (void)testTraitCollectionDidChangeColorForShadow {
#if defined(__IPHONE_13_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0)
  if (@available(iOS 13.0, *)) {
    // Given
    MDCFlexibleHeaderTraitCollectionTestView *flexibleHeader =
        [[MDCFlexibleHeaderTraitCollectionTestView alloc] init];
    flexibleHeader.bounds = CGRectMake(0, 0, 500, 200);
    UIColor *dynamicColor =
        [UIColor colorWithDynamicProvider:^(UITraitCollection *traitCollection) {
          if (traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight) {
            return UIColor.blueColor;
          } else {
            return UIColor.redColor;
          }
        }];
    flexibleHeader.backgroundColor = UIColor.whiteColor;
    flexibleHeader.shadowLayer = [[MDCShadowLayer alloc] init];
    MDCShadowLayer *shadowLayer = (MDCShadowLayer *)flexibleHeader.shadowLayer;
    shadowLayer.elevation = 20;
    flexibleHeader.shadowColor = dynamicColor;

    // When
    flexibleHeader.traitCollectionOverride =
        [UITraitCollection traitCollectionWithUserInterfaceStyle:UIUserInterfaceStyleDark];
    [flexibleHeader layoutIfNeeded];

    // Then
    [flexibleHeader sizeToFit];
    UIView *snapshotView =
        [flexibleHeader mdc_addToBackgroundViewWithInsets:UIEdgeInsetsMake(50, 50, 50, 50)];
    [self snapshotVerifyViewForIOS13:snapshotView];
  }
#endif
}

- (void)testShadowColor {
  // Given
  MDCFlexibleHeaderTraitCollectionTestView *flexibleHeader =
      [[MDCFlexibleHeaderTraitCollectionTestView alloc] init];
  flexibleHeader.bounds = CGRectMake(0, 0, 500, 200);
  UIColor *shadowColor = UIColor.redColor;
  flexibleHeader.backgroundColor = UIColor.whiteColor;
  flexibleHeader.shadowLayer = [[MDCShadowLayer alloc] init];
  MDCShadowLayer *shadowLayer = (MDCShadowLayer *)flexibleHeader.shadowLayer;
  shadowLayer.elevation = 20;

  // When
  flexibleHeader.shadowColor = shadowColor;

  // Then
  [flexibleHeader sizeToFit];
  UIView *snapshotView =
      [flexibleHeader mdc_addToBackgroundViewWithInsets:UIEdgeInsetsMake(50, 50, 50, 50)];
  [self snapshotVerifyView:snapshotView];
}

- (void)testHairlineVisibility {
  // Given
  MDCFlexibleHeaderViewController *fhvc = [[MDCFlexibleHeaderViewController alloc] init];
  fhvc.view.frame = CGRectMake(0, 0, 500, 200);
  fhvc.view.backgroundColor = UIColor.whiteColor;

  // When
  fhvc.showsHairline = YES;

  // Then
  UIView *snapshotView =
      [fhvc.view mdc_addToBackgroundViewWithInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
  [self snapshotVerifyView:snapshotView];
}

- (void)testHairlineColor {
  // Given
  MDCFlexibleHeaderViewController *fhvc = [[MDCFlexibleHeaderViewController alloc] init];
  fhvc.view.frame = CGRectMake(0, 0, 500, 200);
  fhvc.view.backgroundColor = UIColor.whiteColor;
  fhvc.showsHairline = YES;

  // When
  fhvc.hairlineColor = [UIColor redColor];

  // Then
  UIView *snapshotView =
      [fhvc.view mdc_addToBackgroundViewWithInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
  [self snapshotVerifyView:snapshotView];
}

@end
