// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialButtons.h"
#import "MaterialDialogs.h"

#import "MDCAlertController+ButtonForAction.h"
#import "MDCAlertController+Testing.h"
#import "MDCAlertActionManager.h"
#import "MDCAlertControllerView+Private.h"

#import <XCTest/XCTest.h>

static inline UIImage *TestImage(CGSize size) {
  CGFloat scale = [UIScreen mainScreen].scale;
  UIGraphicsBeginImageContextWithOptions(size, false, scale);
  [UIColor.redColor setFill];
  CGRect fillRect = CGRectZero;
  fillRect.size = size;
  UIRectFill(fillRect);
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

static NSString *const kTitle = @"Title";
static NSString *const kMessageLatin = @"Lorem ipsum dolor sit amet, consul docendi indoctum id "
                                       @"quo, ad unum suavitate incorrupte sea.";

@interface MDCAlertControllerInsetsTests : XCTestCase

@property(nonatomic, nullable, strong) MDCAlertController *alert;
@property(nonatomic, nullable, weak) MDCAlertControllerView *alertView;

@end

@implementation MDCAlertControllerInsetsTests {
}

- (void)setUp {
  [super setUp];
  self.alert = [MDCAlertController alertControllerWithTitle:kTitle message:kMessageLatin];
  [self.alert addAction:[MDCAlertAction actionWithTitle:@"Accept"
                                               emphasis:MDCActionEmphasisMedium
                                                handler:nil]];
  self.alertView = (MDCAlertControllerView *)self.alert.view;
}

- (void)tearDown {
  [super tearDown];
  self.alert = nil;
  self.alertView = nil;
}

#pragma mark - Tests

- (void)testAlertBottomInsetMatchesDefaultInsets {
  // Given
  [self.alert sizeToFitContentInBounds:CGSizeMake(300.0f, 300.0f)];

  // Then
  XCTAssertEqual(self.alertView.titleInsets.bottom, 20.f);
  CGFloat titleViewHeight = CGRectGetHeight(self.alertView.titleScrollView.bounds);
  CGFloat titleBottom = CGRectGetMaxY(self.alertView.titleLabel.frame);
  XCTAssertEqual(titleViewHeight - titleBottom, self.alertView.titleInsets.bottom);
}

- (void)testAlertBottomInsetMatchesCustomInsets {
  // When
  self.alertView.titleInsets = UIEdgeInsetsMake(14.f, 14.f, 14.f, 14.f);
  [self.alert sizeToFitContentInBounds:CGSizeMake(300.0f, 300.0f)];

  // Then
  XCTAssertEqual(self.alertView.titleInsets.bottom, 14.f);
  CGFloat titleViewHeight = CGRectGetHeight(self.alertView.titleScrollView.bounds);
  CGFloat titleBottom = CGRectGetMaxY(self.alertView.titleLabel.frame);
  XCTAssertEqual(titleViewHeight - titleBottom, self.alertView.titleInsets.bottom);
}

- (void)testAlertFramesAdjustsToTitleIconInsets {
  // Given
  self.alert.titleIcon = TestImage(CGSizeMake(24, 24));

  // When
  self.alertView.titleIconInsets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
  [self.alert sizeToFitContentInBounds:CGSizeMake(300.0f, 300.0f)];

  // Then
  CGSize iconSize = self.alert.titleIcon.size;
  CGRect iconRect = self.alertView.titleIconImageView.frame;

  XCTAssertTrue(
      CGRectEqualToRect(iconRect, CGRectMake(10.0f, 10.0f, iconSize.width, iconSize.height)));
}

- (void)testAlertFramesAdjustsToTitleInsets {
  // When
  self.alertView.titleInsets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
  [self.alert sizeToFitContentInBounds:CGSizeMake(300.0f, 300.0f)];

  // Then
  CGRect titleRect = self.alertView.titleScrollView.frame;

  XCTAssertTrue(CGRectEqualToRect(
      self.alertView.titleLabel.frame,
      CGRectMake(10.0f, 10.0f, titleRect.size.width - 20.f, titleRect.size.height - 20.f)));
}

// TODO(b/153457451): Re-enable this test.
//
// This test is failing with the following error:
//
// components/Dialogs/tests/unit/MDCAlertControllerInsetsTests.m:144: error:
// -[MDCAlertControllerInsetsTests testAlertFramesAdjustsToContentInsets] :
// ((CGRectEqualToRect( self.alertView.messageTextView.frame,
//                      CGRectMake(10.0f, 0.0f, contentRect.size.width - 20.f,
//                                 contentRect.size.height - 10.f))) is true) failed
// Test Case '-[MDCAlertControllerInsetsTests testAlertFramesAdjustsToContentInsets]'
// failed (0.115 seconds).
- (void)disabled_testAlertFramesAdjustsToContentInsets {
  // When
  self.alertView.contentInsets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
  [self.alert sizeToFitContentInBounds:CGSizeMake(300.0f, 300.0f)];

  // Then
  CGRect contentRect = self.alertView.contentScrollView.frame;

  XCTAssertTrue(CGRectEqualToRect(
      self.alertView.messageTextView.frame,
      CGRectMake(10.0f, 0.0f, contentRect.size.width - 20.f, contentRect.size.height - 10.f)));
}

- (void)testAlertFramesAdjustsToActionsInsets {
  // Given
  MDCButton *button = [self.alert buttonForAction:self.alertView.actionManager.actions.firstObject];

  // When
  self.alertView.actionsInsets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
  [self.alert sizeToFitContentInBounds:CGSizeMake(300.0f, 300.0f)];

  // Then
  UIEdgeInsets visibleAreaInsets = button.visibleAreaInsets;
  CGRect visibleButtonFrame = UIEdgeInsetsInsetRect(button.frame, visibleAreaInsets);
  CGRect contentRect = self.alertView.actionsScrollView.frame;
  CGRect buttonFrame =
      CGRectMake(CGRectGetWidth(contentRect) - CGRectGetWidth(visibleButtonFrame) - 10.0f, 10.0f,
                 CGRectGetWidth(visibleButtonFrame), CGRectGetHeight(visibleButtonFrame));
  XCTAssertTrue(CGRectEqualToRect(visibleButtonFrame, buttonFrame));
}

@end
