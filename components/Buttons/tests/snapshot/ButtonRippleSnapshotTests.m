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

@interface ButtonRippleSnapshotTest : MDCSnapshotTestCase
@property(nonatomic, strong, nullable) MDCButton *button;
@end

@implementation ButtonRippleSnapshotTest

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  // self.recordMode = YES;

  self.button = [[MDCButton alloc] initWithFrame:CGRectMake(0, 0, 64, 36)];
  self.button.backgroundColor = UIColor.whiteColor;
  self.button.inkColor = UIColor.blueColor;
  [self.button setTitle:@"ABC" forState:UIControlStateNormal];
  [self.button setTitleColor:UIColor.blueColor forState:UIControlStateNormal];
  self.button.enableRippleBehavior = YES;
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

- (void)testButtonHighlighted {
  // When
  self.button.highlighted = YES;
  self.button.inkColor = UIColor.greenColor;

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

- (void)testButtonTouchesBegan {
  // Given
  self.button.layer.speed = 100;

  // When
  [self.button touchesBegan:[NSSet setWithObject:[[UITouch alloc] init]]
                  withEvent:UIEventTypeTouches];
  self.button.layer.timeOffset = 1000;

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

@end
