// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "M3CButton.h"

NS_ASSUME_NONNULL_BEGIN

@interface M3CButtonInsetsTests : XCTestCase
@property(nonatomic, strong, nullable) M3CButton *button;
@property(nonatomic, strong, nullable) UIImage *image;
@property(nonatomic, strong, nullable) NSString *title;
@property(nonatomic, assign) UIEdgeInsets edgeInsetsForImageAndTitle;
@property(nonatomic, assign) UIEdgeInsets edgeInsetsForTitleOnly;
@property(nonatomic, assign) UIEdgeInsets edgeInsetsForImageOnly;
@property(nonatomic, assign) UIEdgeInsets imageEdgeInsetsForImageAndTitle;
@end

@implementation M3CButtonInsetsTests

- (void)setUp {
  [super setUp];

  self.button = [[M3CButton alloc] init];
  self.image = [UIImage systemImageNamed:@"plus"];
  self.title = @"some title";
  self.imageEdgeInsetsForImageAndTitle = UIEdgeInsetsMake(424, 625, 42, 31);
  self.edgeInsetsForImageAndTitle = UIEdgeInsetsMake(4, 65, 2342, 3);
  self.edgeInsetsForImageOnly = UIEdgeInsetsMake(49, 675, 23842, 73);
  self.edgeInsetsForTitleOnly = UIEdgeInsetsMake(48, 765, 29342, 93);
}

- (void)tearDown {
  self.button = nil;

  [super tearDown];
}

- (void)testEdgeInsetsWithImageAndTitle {
  // Given
  [self.button setTitle:self.title forState:UIControlStateNormal];
  [self.button setImage:self.image forState:UIControlStateNormal];

  // When
  [self.button setEdgeInsetsWithImageAndTitle:self.edgeInsetsForImageAndTitle];
  [self.button setImageEdgeInsetsWithImageAndTitle:self.imageEdgeInsetsForImageAndTitle];

  // Then
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(self.button.contentEdgeInsets, self.edgeInsetsForImageAndTitle));
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(self.button.imageEdgeInsets, self.imageEdgeInsetsForImageAndTitle));
}

- (void)testEdgeInsetsWithImage {
  // Given
  [self.button setImage:self.image forState:UIControlStateNormal];

  // When
  [self.button setEdgeInsetsWithImageOnly:self.edgeInsetsForImageOnly];

  // Then
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(self.button.contentEdgeInsets, self.edgeInsetsForImageOnly));
}

- (void)testEdgeInsetsWithTitle {
  // Given
  [self.button setTitle:self.title forState:UIControlStateNormal];

  // When
  [self.button setEdgeInsetsWithTitleOnly:self.edgeInsetsForTitleOnly];

  // Then
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(self.button.contentEdgeInsets, self.edgeInsetsForTitleOnly));
}

- (void)testEdgeInsetsWithImageAndTitle_removeImage {
  // Given
  [self.button setTitle:self.title forState:UIControlStateNormal];
  [self.button setImage:self.image forState:UIControlStateNormal];
  [self.button setEdgeInsetsWithImageAndTitle:self.edgeInsetsForImageAndTitle];
  [self.button setImageEdgeInsetsWithImageAndTitle:self.imageEdgeInsetsForImageAndTitle];
  [self.button setEdgeInsetsWithImageOnly:self.edgeInsetsForImageOnly];
  [self.button setEdgeInsetsWithTitleOnly:self.edgeInsetsForTitleOnly];

  // When
  [self.button setImage:nil forState:UIControlStateNormal];

  // Then
  XCTAssertTrue(
      UIEdgeInsetsEqualToEdgeInsets(self.button.contentEdgeInsets, self.edgeInsetsForTitleOnly));
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(self.button.imageEdgeInsets, UIEdgeInsetsZero));
}

- (void)testEdgeInsetsWithImageAndTitle_removeTitle {
  // Given
  [self.button setTitle:self.title forState:UIControlStateNormal];
  [self.button setImage:self.image forState:UIControlStateNormal];
  [self.button setEdgeInsetsWithImageAndTitle:self.edgeInsetsForImageAndTitle];
  [self.button setImageEdgeInsetsWithImageAndTitle:self.imageEdgeInsetsForImageAndTitle];
  [self.button setEdgeInsetsWithImageOnly:self.edgeInsetsForImageOnly];
  [self.button setEdgeInsetsWithTitleOnly:self.edgeInsetsForTitleOnly];

  // When
  [self.button setTitle:nil forState:UIControlStateNormal];

  // Then
  XCTAssertTrue(
      UIEdgeInsetsEqualToEdgeInsets(self.button.contentEdgeInsets, self.edgeInsetsForImageOnly));
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(self.button.imageEdgeInsets, UIEdgeInsetsZero));
}

- (void)testEdgeInsetsWithImageAndTitle_setSelected {
  // Given
  [self.button setTitle:self.title forState:UIControlStateNormal];
  [self.button setImage:self.image forState:UIControlStateNormal];
  [self.button setEdgeInsetsWithImageAndTitle:self.edgeInsetsForImageAndTitle];
  [self.button setImageEdgeInsetsWithImageAndTitle:self.imageEdgeInsetsForImageAndTitle];
  [self.button setEdgeInsetsWithImageOnly:self.edgeInsetsForImageOnly];
  [self.button setEdgeInsetsWithTitleOnly:self.edgeInsetsForTitleOnly];

  // We are trying to ensure that we are updating the edges when state changes.
  // However setting non UIControlStateNormal values to nil just falls back to UIControlStateNormal.
  [self.button setTitle:nil forState:UIControlStateNormal];
  [self.button setTitle:@"Selected" forState:UIControlStateSelected];
  [self.button setSelected:YES];

  // When
  self.button.selected = NO;

  // Then
  XCTAssertTrue(
      UIEdgeInsetsEqualToEdgeInsets(self.button.contentEdgeInsets, self.edgeInsetsForImageOnly));
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(self.button.imageEdgeInsets, UIEdgeInsetsZero));
}

@end

NS_ASSUME_NONNULL_END
