// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialCollectionCells.h"

@interface CollectionViewTextCellsReuseTests : XCTestCase
@end

@implementation CollectionViewTextCellsReuseTests

- (void)testPrepareForReuse {
  // Given
  MDCCollectionViewTextCell *textCell =
      [[MDCCollectionViewTextCell alloc] initWithFrame:CGRectZero];

  UIFont *textLabelFont = textCell.textLabel.font;
  UIColor *textLabelTextColor = textCell.textLabel.textColor;
  CGSize textLabelShadowOffset = textCell.textLabel.shadowOffset;
  NSTextAlignment textLabelAlignment = textCell.textLabel.textAlignment;
  NSLineBreakMode textLabelLineBreakMode = textCell.textLabel.lineBreakMode;
  NSInteger textLabelNumberOfLines = textCell.textLabel.numberOfLines;

  UIFont *detailTextLabelFont = textCell.detailTextLabel.font;
  UIColor *detailTextLabelTextColor = textCell.detailTextLabel.textColor;
  CGSize detailTextLabelShadowOffset = textCell.detailTextLabel.shadowOffset;
  NSTextAlignment detailTextLabelAlignment = textCell.detailTextLabel.textAlignment;
  NSLineBreakMode detailTextLabelLineBreakMode = textCell.detailTextLabel.lineBreakMode;
  NSInteger detailTextLabelNumberOfLines = textCell.detailTextLabel.numberOfLines;

  textCell.textLabel.text = @"Text label";
  textCell.textLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  textCell.textLabel.textColor = [UIColor redColor];
  textCell.textLabel.shadowColor = [UIColor blueColor];
  textCell.textLabel.shadowOffset = CGSizeMake(3, 5);
  textCell.textLabel.textAlignment = NSTextAlignmentJustified;
  textCell.textLabel.lineBreakMode = NSLineBreakByClipping;
  textCell.textLabel.numberOfLines = 7;

  textCell.detailTextLabel.text = @"Detail text label";
  textCell.detailTextLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
  textCell.detailTextLabel.textColor = [UIColor redColor];
  textCell.detailTextLabel.shadowColor = [UIColor blueColor];
  textCell.detailTextLabel.shadowOffset = CGSizeMake(3, 5);
  textCell.detailTextLabel.textAlignment = NSTextAlignmentJustified;
  textCell.detailTextLabel.lineBreakMode = NSLineBreakByClipping;
  textCell.detailTextLabel.numberOfLines = 7;

  textCell.imageView.image = [UIImage imageNamed:@"Plus"];

  // When
  [textCell prepareForReuse];

  // Then
  // Main text label
  XCTAssertNil(textCell.textLabel.text,
               @"Reusing the cell should remove any text in the textLabel");
  XCTAssertEqualObjects(textLabelFont, textCell.textLabel.font,
                        @"Reusing the cell should reset the textLabel font.");
  XCTAssertEqualObjects(textLabelTextColor, textCell.textLabel.textColor,
                        @"Reusing the cell should reset the textLabel textColor.");
  XCTAssertNil(textCell.textLabel.shadowColor,
               @"Reusing the cell should remove the textLabel shadowColor.");
  XCTAssert(CGSizeEqualToSize(textLabelShadowOffset, textCell.textLabel.shadowOffset),
            @"Reusing the cell should reset the textLabel shadowOffset.");
  XCTAssertEqual(textLabelAlignment, textCell.textLabel.textAlignment,
                 @"Reusing the cell should reset the textLabel textAlignment.");
  XCTAssertEqual(textLabelLineBreakMode, textCell.textLabel.lineBreakMode,
                 @"Reusing the cell should reset the textLabel lineBreakMode.");
  XCTAssertEqual(textLabelNumberOfLines, textCell.textLabel.numberOfLines,
                 @"Reusing the cell should reset the textLabel numberOfLines.");

  // Detail text label
  XCTAssertNil(textCell.detailTextLabel.text,
               @"Reusing the cell should remove any text in the detailTextLabel");
  XCTAssertEqualObjects(detailTextLabelFont, textCell.detailTextLabel.font,
                        @"Reusing the cell should reset the detailTextLabel font.");
  XCTAssertEqualObjects(detailTextLabelTextColor, textCell.detailTextLabel.textColor,
                        @"Reusing the cell should reset the detailTextLabel textColor.");
  XCTAssertNil(textCell.detailTextLabel.shadowColor,
               @"Reusing the cell should remove the detailTextLabel shadowColor.");
  XCTAssert(CGSizeEqualToSize(detailTextLabelShadowOffset, textCell.detailTextLabel.shadowOffset),
            @"Reusing the cell should reset the detailTextLabel shadowOffset.");
  XCTAssertEqual(detailTextLabelAlignment, textCell.detailTextLabel.textAlignment,
                 @"Reusing the cell should reset the detailTextLabel textAlignment.");
  XCTAssertEqual(detailTextLabelLineBreakMode, textCell.detailTextLabel.lineBreakMode,
                 @"Reusing the cell should reset the detailTextLabel lineBreakMode.");
  XCTAssertEqual(detailTextLabelNumberOfLines, textCell.detailTextLabel.numberOfLines,
                 @"Reusing the cell should reset the detailTextLabel numberOfLines.");
  // Image view
  XCTAssertNil(textCell.imageView.image, @"Reusing the cell should remove the imageView image.");
}

@end
