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
#import "MDCCardView+Private.h"

@interface MDCCardTests : XCTestCase
@property(nonatomic, strong) MDCCollectionViewCardCell *cell;
@property(nonatomic, strong) MDCCardView *card;
@end

@implementation MDCCardTests

- (void)setUp {
  [super setUp];
  self.cell = [[MDCCollectionViewCardCell alloc] init];
  self.card = [[MDCCardView alloc] init];
}

- (void)testCellSelectAndUnselect {
  XCTAssertEqual([self.cell.cardView shadowElevationForState:MDCCardViewStateNormal], 1.f);
  XCTAssertEqual(self.cell.cornerRadius, 4.f);
  XCTAssertEqual(self.cell.cardView.inkView.layer.sublayers.count, 1);
  self.cell.selecting = YES;
  self.cell.selected = YES;
  XCTAssertEqual(((MDCShadowLayer *)self.cell.cardView.layer).elevation, 1.f);
  XCTAssertEqual(self.cell.cardView.inkView.layer.sublayers.count, 2);
  XCTAssertEqual(((CAShapeLayer *)self.cell.cardView.inkView.layer.sublayers.lastObject).fillColor,
                 self.cell.cardView.inkView.inkColor.CGColor);
  self.cell.selected = NO;
  XCTAssertEqual(((MDCShadowLayer *)self.cell.cardView.layer).elevation, 1.f);
  XCTAssertEqual(self.cell.cardView.inkView.layer.sublayers.count, 1);
  self.cell.selected = YES;
  XCTAssertEqual(((MDCShadowLayer *)self.cell.cardView.layer).elevation, 1.f);
  XCTAssertEqual(self.cell.cardView.inkView.layer.sublayers.count, 2);
  XCTAssertEqual(((CAShapeLayer *)self.cell.cardView.inkView.layer.sublayers.lastObject).fillColor,
                 self.cell.cardView.inkView.inkColor.CGColor);
  XCTAssert(
    CGRectEqualToRect(
      (((CAShapeLayer *)self.cell.cardView.inkView.layer.sublayers.firstObject).frame),
      self.cell.cardView.inkView.layer.bounds));
  self.cell.selected = NO;
  XCTAssertEqual(((MDCShadowLayer *)self.cell.cardView.layer).elevation, 1.f);
  XCTAssertEqual(self.cell.cornerRadius, 4.f);
  XCTAssertEqual(self.cell.cardView.inkView.layer.sublayers.count, 1);
}

- (void)testCellLongPress {
  NSMutableArray *touchArray = [NSMutableArray new];
  [touchArray addObject:[UITouch new]];
  NSSet *touches = [[NSSet alloc] init];
  [touches setByAddingObjectsFromArray:touchArray];
  UIEvent *event = [[UIEvent alloc] init];
  [self.cell touchesBegan:touches withEvent:event];

  XCTAssertEqual(((MDCShadowLayer *)self.cell.cardView.layer).elevation, 8.f);
  XCTAssertEqual(self.cell.cardView.inkView.layer.sublayers.count, 2);

  [self.cell touchesEnded:touches withEvent:event];

  XCTAssertEqual(((MDCShadowLayer *)self.cell.cardView.layer).elevation, 1.f);
}

- (void)testDefaultShadowElevations {
  [self.cell.cardView setShadowElevation:3.5f forState:MDCCardViewStateNormal];
  [self.cell.cardView setShadowElevation:7.2f forState:MDCCardViewStateHighlighted];
  XCTAssertEqual(((MDCShadowLayer *)self.cell.cardView.layer).elevation, 3.5f);
  NSMutableArray *touchArray = [NSMutableArray new];
  [touchArray addObject:[UITouch new]];
  NSSet *touches = [[NSSet alloc] init];
  [touches setByAddingObjectsFromArray:touchArray];
  UIEvent *event = [[UIEvent alloc] init];
  [self.cell touchesBegan:touches withEvent:event];

  XCTAssertEqual(((MDCShadowLayer *)self.cell.cardView.layer).elevation, 7.2f);
  XCTAssertEqual(self.cell.cardView.inkView.layer.sublayers.count, 2);

  [self.cell touchesEnded:touches withEvent:event];

  XCTAssertEqual(((MDCShadowLayer *)self.cell.cardView.layer).elevation, 3.5f);
}

- (void)testShadowForCard {
  [self.card layoutSubviews];
  XCTAssertEqual(((MDCShadowLayer *)self.card.layer).elevation, 1.f);
  [self.card setShadowElevation:8.f forState:MDCCardViewStateNormal];
  XCTAssertEqual(((MDCShadowLayer *)self.card.layer).elevation, 8.f);
}

- (void)testCornerForCard {
  XCTAssertEqual(self.card.layer.cornerRadius, 4.f);
  [self.card setCornerRadius:8.f];
  XCTAssertEqual(self.card.layer.cornerRadius, 8.f);
}

- (void)testCornerForCell {
  XCTAssertEqual(self.cell.cardView.layer.cornerRadius, 4.f);
  XCTAssertEqual(self.cell.layer.cornerRadius, 4.f);
  [self.cell setCornerRadius:8.f];
  XCTAssertEqual(self.cell.cardView.layer.cornerRadius, 8.f);
  XCTAssertEqual(self.cell.layer.cornerRadius, 8.f);
}

- (void)testSetSelectionImageColor {
  [self.cell setBackgroundColor:[UIColor blackColor]];
  XCTAssertEqual(self.cell.selectedImageTintColor, [UIColor whiteColor]);
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
