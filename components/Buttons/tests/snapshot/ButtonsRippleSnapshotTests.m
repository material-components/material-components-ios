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
#import "MaterialRipple.h"

@interface MDCButton (Testing)
@property(nonatomic, strong, readonly, nonnull) MDCStatefulRippleView *rippleView;
@end

/** Snapshot tests for @c MDCButton when @c enableRippleBehavior is @c YES. */
@interface ButtonsRippleSnapshotTests : MDCSnapshotTestCase
@property(nonatomic, strong) MDCButton *button;
@end

@implementation ButtonsRippleSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.button = [[MDCButton alloc] init];
  self.button.enableRippleBehavior = YES;
  UIImage *testImage = [[UIImage mdc_testImageOfSize:CGSizeMake(24, 24)]
      imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [self.button setImage:testImage forState:UIControlStateNormal];
  self.button.inkColor = [UIColor.magentaColor colorWithAlphaComponent:0.25];
  [self.button sizeToFit];
  [self configureButton:self.button
               forState:UIControlStateNormal
              withTitle:@"Red"
                    red:1
                  green:0
                   blue:0];
  [self configureButton:self.button
               forState:UIControlStateSelected
              withTitle:@"Green"
                    red:0
                  green:1
                   blue:0];
  [self configureButton:self.button
               forState:UIControlStateHighlighted
              withTitle:@"Blue"
                    red:0
                  green:0
                   blue:1];
  [self configureButton:self.button
               forState:UIControlStateDisabled
              withTitle:@"Disabled"
                    red:1
                  green:1
                   blue:0];
  [self configureButton:self.button
               forState:(UIControlStateHighlighted | UIControlStateSelected)
              withTitle:@"H + S"
                    red:0
                  green:1
                   blue:1];
}

- (void)configureButton:(MDCButton *)button
               forState:(UIControlState)state
              withTitle:(NSString *)title
                    red:(CGFloat)red
                  green:(CGFloat)green
                   blue:(CGFloat)blue {
  [button setTitleColor:[UIColor colorWithRed:(CGFloat)(0.5 * red)
                                        green:(CGFloat)(0.5 * green)
                                         blue:(CGFloat)(0.5 * blue)
                                        alpha:1]
               forState:state];
  [button setTitle:title forState:state];
  [button setBackgroundColor:[UIColor colorWithRed:red green:green blue:blue alpha:1]
                    forState:state];
  [button setImageTintColor:[UIColor colorWithRed:(CGFloat)(0.25 * red)
                                            green:(CGFloat)(0.25 * green)
                                             blue:(CGFloat)(0.25 * blue)
                                            alpha:1]
                   forState:state];
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

#pragma mark - Tests

- (void)testNormalStateGeneratesCorrectImage {
  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

- (void)testHighlightedStateGeneratesCorrectImage {
  // When
  self.button.highlighted = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

- (void)testSelectedStateGeneratesCorrectImage {
  // When
  self.button.selected = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

- (void)testDisabledStateGeneratesCorrectImage {
  // When
  self.button.enabled = NO;

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

- (void)testHighlightedSelectedStateGeneratesCorrectImage {
  // When
  self.button.highlighted = YES;
  self.button.selected = YES;

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

- (void)testButtonWhenRippleTouchDownAtPointIsCalledGeneratesCorrectImage {
  // When
  [self.button.rippleView beginRippleTouchDownAtPoint:self.button.center
                                             animated:NO
                                           completion:nil];

  // Then
  [self generateSnapshotAndVerifyForView:self.button];
}

@end
