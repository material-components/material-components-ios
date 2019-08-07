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

/** Snapshot tests for Buttons in different UIControlStates */
@interface ButtonsFlippedImageRenderingSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong) MDCButton *button;
@end

@implementation ButtonsFlippedImageRenderingSnapshotTests

- (void)setUp {
  [super setUp];
  self.button = [[MDCButton alloc] init];
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

// This test exists to exercise a bug in iOS 13 (Xcode 11 betas 1-4) where setting contentEdgeInsets
// before a horizontally flipped UIImage causes the image to render outside of the UIImageView's
// frame.
- (void)testHorizontallyFlippedImageWithContentInsets {
  // Given
  if (@available(iOS 10.0, *)) {
    // When
    self.button.contentEdgeInsets = UIEdgeInsetsMake(10, 20, 10, 20);
    UIImage *testImage =
        [[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)] imageWithHorizontallyFlippedOrientation];
    [self.button setImage:testImage forState:UIControlStateNormal];
  } else {
    // Fallback on earlier versions
  }

  // Then
  [self.button sizeToFit];
  [self snapshotVerifyViewForIOS13:self.button];
}

@end
