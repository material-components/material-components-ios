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

#import "MaterialDialogs.h"

#import "MDCAlertController+ButtonForAction.h"
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
  CGSize size = [self.alertView calculatePreferredContentSizeForBounds:self.alertView.bounds.size];
  self.alertView.bounds = CGRectMake(0.f, 0.f, size.width, size.height);
  [self.alertView layoutIfNeeded];

  // Then
  XCTAssertEqual(self.alertView.titleInsets.bottom, 20.f);
  CGFloat titleViewHeight = CGRectGetHeight(self.alertView.titleScrollView.bounds);
  CGFloat titleBottom = CGRectGetMaxY(self.alertView.titleLabel.frame);
  XCTAssertEqual(titleViewHeight - titleBottom, self.alertView.titleInsets.bottom);
}

- (void)testAlertBottomInsetMatchesCustomInsets {
  // Given
  [self.alertView layoutIfNeeded];

  // When
  self.alertView.titleInsets = UIEdgeInsetsMake(14.f, 14.f, 14.f, 14.f);
  CGSize size = [self.alertView calculatePreferredContentSizeForBounds:self.alertView.bounds.size];
  self.alertView.bounds = CGRectMake(0.f, 0.f, size.width, size.height);
  [self.alertView layoutIfNeeded];

  // Then
  XCTAssertEqual(self.alertView.titleInsets.bottom, 14.f);
  CGFloat titleViewHeight = CGRectGetHeight(self.alertView.titleScrollView.bounds);
  CGFloat titleBottom = CGRectGetMaxY(self.alertView.titleLabel.frame);
  XCTAssertEqual(titleViewHeight - titleBottom, self.alertView.titleInsets.bottom);
}

- (void)testAlertFramesAdjustsToTitleIconInsets {
  // Given
  CGSize size = [self.alertView calculatePreferredContentSizeForBounds:self.alertView.bounds.size];
  self.alertView.bounds = CGRectMake(0.f, 0.f, size.width, size.height);
  self.alert.titleIcon = TestImage(CGSizeMake(24, 24));

  // When
  self.alertView.titleIconInsets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
  [self.alertView layoutIfNeeded];

  // Then
  CGSize iconSize = self.alert.titleIcon.size;
  CGRect iconRect = self.alertView.titleIconImageView.frame;

  XCTAssertTrue(
      CGRectEqualToRect(iconRect, CGRectMake(10.0f, 10.0f, iconSize.width, iconSize.height)));
}

- (void)testAlertFramesAdjustsToTitleInsets {
  // Given
  CGSize size = [self.alertView calculatePreferredContentSizeForBounds:self.alertView.bounds.size];
  self.alertView.bounds = CGRectMake(0.f, 0.f, size.width, size.height);

  // When
  self.alertView.titleInsets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
  [self.alertView layoutIfNeeded];

  // Then
  CGRect titleRect = self.alertView.titleScrollView.frame;

  XCTAssertTrue(CGRectEqualToRect(
      self.alertView.titleLabel.frame,
      CGRectMake(10.0f, 10.0f, titleRect.size.width - 20.f, titleRect.size.height - 20.f)));
}

- (void)testAlertFramesAdjustsToContentInsets {
  // Given
  CGSize size = [self.alertView calculatePreferredContentSizeForBounds:self.alertView.bounds.size];
  self.alertView.bounds = CGRectMake(0.f, 0.f, size.width, size.height);

  // When
  self.alertView.contentInsets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
  [self.alertView layoutIfNeeded];

  // Then
  CGRect contentRect = self.alertView.contentScrollView.frame;

  XCTAssertTrue(CGRectEqualToRect(
      self.alertView.messageLabel.frame,
      CGRectMake(10.0f, 0.0f, contentRect.size.width - 20.f, contentRect.size.height - 10.f)));
}

- (void)testAlertFramesAdjustsToActionsInsets {
  // Given
  CGSize size = [self.alertView calculatePreferredContentSizeForBounds:self.alertView.bounds.size];
  self.alertView.bounds = CGRectMake(0.f, 0.f, size.width, size.height);
  MDCButton *button = [self.alert buttonForAction:self.alertView.actionManager.actions.firstObject];

  // When
  self.alertView.actionsInsets = UIEdgeInsetsMake(10.0f, 10.0f, 10.0f, 10.0f);
  [self.alertView layoutIfNeeded];

  // Then
  CGRect contentRect = self.alertView.actionsScrollView.frame;
  CGRect buttonFrame =
      CGRectMake(CGRectGetWidth(contentRect) - CGRectGetWidth(button.frame) - 10.0f, 10.0f,
                 CGRectGetWidth(button.frame), CGRectGetHeight(button.frame));
  XCTAssertTrue(CGRectEqualToRect(button.frame, buttonFrame));
}

@end
