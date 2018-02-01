/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
 
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

#import "MaterialCards.h"
#import "MDCIcons.h"
#import "MaterialIcons+ic_info.h"

@interface MDCCardTests : XCTestCase
@property(nonatomic, strong) MDCCardCollectionCell *cell;
@property(nonatomic, strong) MDCCard *card;
@end

@implementation MDCCardTests

- (void)setUp {
  [super setUp];
  self.cell = [[MDCCardCollectionCell alloc] init];
  self.card = [[MDCCard alloc] init];
}

- (void)testCellSelectAndUnselect {
  [self.cell layoutSubviews];
  XCTAssertEqual([self.cell shadowElevationForState:MDCCardCellStateNormal], 1.f);
  XCTAssertEqual(self.cell.cornerRadius, 4.f);
  XCTAssertEqual(self.cell.inkView.layer.sublayers.count, 1);
  self.cell.selectable = YES;
  self.cell.selected = YES;
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 8.f);
  XCTAssertEqual(self.cell.inkView.layer.sublayers.count, 2);
  XCTAssertEqual(((CAShapeLayer *)self.cell.inkView.layer.sublayers.lastObject).fillColor,
                 self.cell.inkView.inkColor.CGColor);
  self.cell.selected = NO;
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 1.f);
  XCTAssertEqual(self.cell.inkView.layer.sublayers.count, 1);
  self.cell.selected = YES;
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 8.f);
  XCTAssertEqual(self.cell.inkView.layer.sublayers.count, 2);
  XCTAssertEqual(((CAShapeLayer *)self.cell.inkView.layer.sublayers.lastObject).fillColor,
                 self.cell.inkView.inkColor.CGColor);
  XCTAssert(
    CGRectEqualToRect(
      (((CAShapeLayer *)self.cell.inkView.layer.sublayers.firstObject).frame),
      self.cell.inkView.layer.bounds));
  self.cell.selected = NO;
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 1.f);
  XCTAssertEqual(self.cell.cornerRadius, 4.f);
  XCTAssertEqual(self.cell.inkView.layer.sublayers.count, 1);
}

- (void)testCellLongPress {
  NSMutableArray *touchArray = [NSMutableArray new];
  [touchArray addObject:[UITouch new]];
  NSSet *touches = [[NSSet alloc] init];
  [touches setByAddingObjectsFromArray:touchArray];
  UIEvent *event = [[UIEvent alloc] init];
  [self.cell touchesBegan:touches withEvent:event];

  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 8.f);
  XCTAssertEqual(self.cell.inkView.layer.sublayers.count, 2);

  [self.cell touchesEnded:touches withEvent:event];

  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 1.f);
}

- (void)testDefaultShadowElevations {
  [self.cell setShadowElevation:3.5f forState:MDCCardCellStateNormal];
  [self.cell setShadowElevation:7.2f forState:MDCCardCellStateHighlighted];
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 3.5f);
  NSMutableArray *touchArray = [NSMutableArray new];
  [touchArray addObject:[UITouch new]];
  NSSet *touches = [[NSSet alloc] init];
  [touches setByAddingObjectsFromArray:touchArray];
  UIEvent *event = [[UIEvent alloc] init];
  [self.cell touchesBegan:touches withEvent:event];

  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 7.2f);
  XCTAssertEqual(self.cell.inkView.layer.sublayers.count, 2);

  [self.cell touchesEnded:touches withEvent:event];

  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 3.5f);
}

- (void)testShadowForCard {
  [self.card layoutSubviews];
  XCTAssertEqual(((MDCShadowLayer *)self.card.layer).elevation, 1.f);
  [self.card setShadowElevation:8.f forState:UIControlStateNormal];
  XCTAssertEqual(((MDCShadowLayer *)self.card.layer).elevation, 8.f);
}

- (void)testShadowForCell {
  [self.cell layoutSubviews];
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 1.f);
  [self.cell setShadowElevation:8.f forState:MDCCardCellStateNormal];
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 8.f);
}

- (void)testCornerForCard {
  [self.card layoutSubviews];
  XCTAssertEqual(self.card.layer.cornerRadius, 4.f);
  [self.card setCornerRadius:8.f];
  XCTAssertEqual(self.card.layer.cornerRadius, 8.f);
}

- (void)testCornerForCell {
  [self.cell layoutSubviews];
  XCTAssertEqual(self.cell.layer.cornerRadius, 4.f);
  [self.cell setCornerRadius:8.f];
  XCTAssertEqual(self.cell.layer.cornerRadius, 8.f);
}

- (void)testSetSelectionImageColor {
  UIColor *color = [UIColor blueColor];
  [self.cell setSelectedImageTintColor:color];
  XCTAssertEqual(self.cell.selectedImageTintColor, color);
}

- (void)testSetSelectionImage {
  XCTAssertNotNil(self.cell.selectedImage);
  UIImage *img = self.cell.selectedImage;
  [self.cell setSelectedImage:[MDCIcons imageFor_ic_info]];
  XCTAssertNotEqual(img, self.cell.selectedImage);
}

@end
