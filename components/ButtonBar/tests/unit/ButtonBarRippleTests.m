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

#import <XCTest/XCTest.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprivate-header"
#import "MDCAppBarButtonBarBuilder.h"
#pragma clang diagnostic pop
#import "MDCButtonBar.h"
#import "MDCButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface MDCAppBarButtonBarBuilder (UnitTests)
+ (void)configureButton:(MDCButton *)destinationButton
         fromButtonItem:(UIBarButtonItem *)sourceButtonItem;
@end

@interface MDCButtonBar (RippleTesting)
- (void)reloadButtonViews;
@end

/**
 This class confirms behavior of @c MDCButtonBar when used with Ripple.
 */
@interface ButtonBarRippleTests : XCTestCase

@property(nonatomic, strong, nullable) MDCButtonBar *buttonBar;

@end

@implementation ButtonBarRippleTests

- (void)setUp {
  [super setUp];

  self.buttonBar = [[MDCButtonBar alloc] init];
  self.buttonBar.items = @[ [[UIBarButtonItem alloc] initWithTitle:@"Test"
                                                             style:UIBarButtonItemStylePlain
                                                            target:nil
                                                            action:nil] ];
}

- (void)tearDown {
  self.buttonBar = nil;

  [super tearDown];
}

/**
 Test to confirm behavior of initializing a @c MDCButtonBar without any customization.
 */
- (void)testRippleIsDisabledForButtonsAndRippleColorIsNil {
  // Then
  XCTAssertFalse(self.buttonBar.enableRippleBehavior);
  for (UIView *view in self.buttonBar.subviews) {
    if ([view isKindOfClass:[MDCButton class]]) {
      MDCButton *button = (MDCButton *)view;
      XCTAssertFalse(button.enableRippleBehavior);
      XCTAssertEqualObjects(button.inkColor, [UIColor colorWithWhite:1 alpha:(CGFloat)0.2]);
    }
  }
}

/**
 Test to confirm behavior of initializing a @c MDCButtonBar with Ripple enabled.
 */
- (void)testRippleIsEnabledForButtonsAndRippleColorIsNilWhenRippleBehaviorIsEnabled {
  // When
  self.buttonBar.enableRippleBehavior = YES;

  // Then
  XCTAssertTrue(self.buttonBar.enableRippleBehavior);
  XCTAssertEqualObjects(self.buttonBar.rippleColor, nil);
  for (UIView *view in self.buttonBar.subviews) {
    if ([view isKindOfClass:[MDCButton class]]) {
      MDCButton *button = (MDCButton *)view;
      XCTAssertTrue(button.enableRippleBehavior);
      XCTAssertEqualObjects(button.inkColor, [UIColor colorWithWhite:1 alpha:(CGFloat)0.2]);
    }
  }
}

- (void)testRippleColorPropagatesToEveryButtonRippleColor {
  // When
  self.buttonBar.enableRippleBehavior = YES;
  self.buttonBar.rippleColor = UIColor.redColor;

  // Then
  XCTAssertTrue(self.buttonBar.enableRippleBehavior);
  XCTAssertEqualObjects(self.buttonBar.rippleColor, UIColor.redColor);
  for (UIView *view in self.buttonBar.subviews) {
    if ([view isKindOfClass:[MDCButton class]]) {
      MDCButton *button = (MDCButton *)view;
      XCTAssertTrue(button.enableRippleBehavior);
      XCTAssertEqualObjects(button.inkColor, UIColor.redColor);
    }
  }
}

- (void)testDefaultButtonBarBuilderPassesThroughRippleBehaviorProperty {
  // Given
  NSArray<__kindof UIView *> *_buttonViews = [self.buttonBar valueForKey:@"_buttonViews"];

  // When
  [self.buttonBar reloadButtonViews];

  // Then
  for (UIView *viewObj in _buttonViews) {
    if ([viewObj isKindOfClass:[MDCButton class]]) {
      MDCButton *buttonView = (MDCButton *)viewObj;
      XCTAssertFalse(buttonView.enableRippleBehavior);
    }
  }
}

- (void)testButtonBarBuilderPassesThroughRippleBehaviorPropertyWithRippleEnabled {
  // Given
  NSArray<__kindof UIView *> *_buttonViews = [self.buttonBar valueForKey:@"_buttonViews"];

  // When
  self.buttonBar.enableRippleBehavior = YES;
  [self.buttonBar reloadButtonViews];

  // Then
  for (UIView *viewObj in _buttonViews) {
    if ([viewObj isKindOfClass:[MDCButton class]]) {
      MDCButton *buttonView = (MDCButton *)viewObj;
      XCTAssertTrue(buttonView.enableRippleBehavior);
    }
  }
}

@end

NS_ASSUME_NONNULL_END
