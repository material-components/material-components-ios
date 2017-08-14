/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <XCTest/XCTest.h>
#import "MDCAppBarButtonBarBuilder.h"
#import "MaterialButtonBar.h"
#import "MaterialButtons.h"

@interface MDCAppBarButtonBarBuilder (UnitTests)
+ (void)configureButton:(MDCButton *)destinationButton
         fromButtonItem:(UIBarButtonItem *)sourceButtonItem;
@end

@interface ButtonBarBuilderTests : XCTestCase

@end

@implementation ButtonBarBuilderTests

- (void)testConfigureButtonFromNilItem {
  // Given
  MDCButton *destinationButton = [[MDCButton alloc] initWithFrame:CGRectZero];
  NSString *defaultTitle = [destinationButton titleForState:UIControlStateNormal];
  UIColor *defaultTintColor = destinationButton.tintColor;
  UIImage *defaultImage = [destinationButton imageForState:UIControlStateNormal];
  MDCInkStyle defaultInkStyle = destinationButton.inkStyle;
  NSInteger defaultTag = destinationButton.tag;

  // When
  [MDCAppBarButtonBarBuilder configureButton:destinationButton fromButtonItem:nil];

  // Then
  XCTAssertEqualObjects([destinationButton titleForState:UIControlStateNormal], defaultTitle);
  XCTAssertEqualObjects([destinationButton imageForState:UIControlStateNormal], defaultImage);
  XCTAssertEqualObjects(destinationButton.tintColor, defaultTintColor);
  XCTAssertEqual(destinationButton.inkStyle, defaultInkStyle);
  XCTAssertEqual(destinationButton.tag, defaultTag);
}

- (void)testConfigureButtonFromButtonItemWithTitle {
  // Given
  UIBarButtonItem *itemWithTitle = [[UIBarButtonItem alloc] initWithTitle:@"Title"
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:nil
                                                                   action:nil];
  itemWithTitle.tag = 0x02468ace;
  itemWithTitle.tintColor = [UIColor colorWithRed:0.5 green:0.25 blue:0.75 alpha:0.125];
  MDCButton *destinationButton = [[MDCButton alloc] initWithFrame:CGRectZero];

  // When
  [MDCAppBarButtonBarBuilder configureButton:destinationButton fromButtonItem:itemWithTitle];

  // Then
  NSString *expectedTitle = destinationButton.isUppercaseTitle
                                ? [itemWithTitle.title uppercaseString]
                                : itemWithTitle.title;
  XCTAssertEqualObjects(
      [destinationButton titleForState:UIControlStateNormal], expectedTitle,
      @"The MDC button should have a normal state title equal to the UIBarButtonItem's title.");
  XCTAssertEqualObjects(destinationButton.tintColor, itemWithTitle.tintColor,
                        @"The MDC button should have the same tint as the UIBarButtonItem");
  XCTAssertNil([destinationButton imageForState:UIControlStateNormal],
               @"The MDC button should not receive a normal state image if the UIBarButtonItem did "
               @"not have one.");
  XCTAssertEqual(destinationButton.inkStyle, MDCInkStyleBounded,
                 @"MDC buttons with text should use bounded ink when used within a button bar.");
  XCTAssertEqual(destinationButton.tag, itemWithTitle.tag,
                 @"The MDC button should have the same tag as the UIBarButtonItem.");
}

- (void)testConfigureButtonFromButtonItemWithImage {
  // Given
  UIBarButtonItem *itemWithImage = [[UIBarButtonItem alloc] initWithImage:[[UIImage alloc] init]
                                                                    style:UIBarButtonItemStylePlain
                                                                   target:nil
                                                                   action:nil];
  itemWithImage.tag = 0x13579bdf;
  itemWithImage.tintColor = [UIColor colorWithRed:0.75 green:0.5 blue:0.125 alpha:0.25];
  MDCButton *destinationButton = [[MDCButton alloc] initWithFrame:CGRectZero];

  // When
  [MDCAppBarButtonBarBuilder configureButton:destinationButton fromButtonItem:itemWithImage];

  // Then
  XCTAssertNil(
      [destinationButton titleForState:UIControlStateNormal],
      @"The MDC button should have no title in the normal state if the UIBarButtonItem had none.");
  XCTAssertEqualObjects(destinationButton.tintColor, itemWithImage.tintColor,
                        @"The MDC button should have the same tint as the UIBarButtonItem");
  XCTAssertEqualObjects(
      [destinationButton imageForState:UIControlStateNormal], itemWithImage.image,
      @"The MDC button should have a normal state image equal to the UIBarButtonItem's image.");
  XCTAssertEqual(
      destinationButton.inkStyle, MDCInkStyleUnbounded,
      @"MDC buttons with only an image should use unbounded ink when used within a button bar.");
  XCTAssertEqual(destinationButton.tag, itemWithImage.tag,
                 @"The MDC button should have the same tag as the UIBarButtonItem.");
}

- (void)testConfigureButtonFromButtonItemWithTitleAndImage {
  // Given
  UIBarButtonItem *itemWithTitleAndImage =
      [[UIBarButtonItem alloc] initWithImage:[[UIImage alloc] init]
                                       style:UIBarButtonItemStylePlain
                                      target:nil
                                      action:nil];
  itemWithTitleAndImage.title = @"Title";
  itemWithTitleAndImage.tag = 0x13579bdf;
  itemWithTitleAndImage.tintColor = [UIColor colorWithRed:0.25 green:0.75 blue:0.625 alpha:0.5];
  MDCButton *destinationButton = [[MDCButton alloc] initWithFrame:CGRectZero];

  // When
  [MDCAppBarButtonBarBuilder configureButton:destinationButton
                              fromButtonItem:itemWithTitleAndImage];

  // Then
  NSString *expectedTitle = destinationButton.isUppercaseTitle
                                ? [itemWithTitleAndImage.title uppercaseString]
                                : itemWithTitleAndImage.title;
  XCTAssertEqualObjects(
      [destinationButton titleForState:UIControlStateNormal], expectedTitle,
      @"The MDC button should have a normal state title equal to the UIBarButtonItem's title.");
  XCTAssertEqualObjects(destinationButton.tintColor, itemWithTitleAndImage.tintColor,
                        @"The MDC button should have the same tint as the UIBarButtonItem");
  XCTAssertEqualObjects(
      [destinationButton imageForState:UIControlStateNormal], itemWithTitleAndImage.image,
      @"The MDC button should have a normal state image equal to the UIBarButtonItem's image.");
  XCTAssertEqual(destinationButton.inkStyle, MDCInkStyleBounded,
                 @"MDC buttons with a title should use bounded ink when used within a button bar.");
  XCTAssertEqual(destinationButton.tag, itemWithTitleAndImage.tag,
                 @"The MDC button should have the same tag as the UIBarButtonItem.");
}

@end
