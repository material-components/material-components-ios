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

@interface MDCCardCollectionCell (MDCCardTests)
- (void)setState:(MDCCardCellState)state animated:(BOOL)animated;
@end

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

- (void)testShadowElevationForCard {
  XCTAssertEqual(((MDCShadowLayer *)self.card.layer).elevation, 1.f);
  XCTAssertEqual([self.card shadowElevationForState:UIControlStateNormal], 1.f);
  [self.card setShadowElevation:8.f forState:UIControlStateNormal];
  XCTAssertEqual(((MDCShadowLayer *)self.card.layer).elevation, 8.f);
  [self.card setShadowElevation:4.f forState:UIControlStateHighlighted];
  XCTAssertEqual([self.card shadowElevationForState:UIControlStateNormal], 8.f);
  XCTAssertEqual([self.card shadowElevationForState:UIControlStateHighlighted], 4.f);
  self.card.highlighted = YES;
  XCTAssertEqual(((MDCShadowLayer *)self.card.layer).elevation, 4.f);
  self.card.highlighted = NO;
  XCTAssertEqual(((MDCShadowLayer *)self.card.layer).elevation, 8.f);
}

- (void)testShadowColorForCard {
  XCTAssertEqual(((MDCShadowLayer *)self.card.layer).shadowColor, [UIColor blackColor].CGColor);
  XCTAssertEqual([self.card shadowColorForState:UIControlStateNormal],
                 [UIColor blackColor]);
  [self.card setShadowColor:[UIColor blueColor] forState:UIControlStateNormal];
  XCTAssertEqual(((MDCShadowLayer *)self.card.layer).shadowColor, [UIColor blueColor].CGColor);
  [self.card setShadowColor:[UIColor greenColor] forState:UIControlStateHighlighted];
  XCTAssertEqual([self.card shadowColorForState:UIControlStateNormal], [UIColor blueColor]);
  XCTAssertEqual([self.card shadowColorForState:UIControlStateHighlighted], [UIColor greenColor]);
  self.card.highlighted = YES;
  XCTAssertEqual(((MDCShadowLayer *)self.card.layer).shadowColor, [UIColor greenColor].CGColor);
  self.card.highlighted = NO;
  XCTAssertEqual(((MDCShadowLayer *)self.card.layer).shadowColor, [UIColor blueColor].CGColor);
}

- (void)testBorderWidthForCard {
  XCTAssertEqual(self.card.layer.borderWidth, 0.f);
  XCTAssertEqual([self.card borderWidthForState:UIControlStateNormal], 0.f);
  [self.card setBorderWidth:1.f forState:UIControlStateNormal];
  XCTAssertEqual(self.card.layer.borderWidth, 1.f);
  [self.card setBorderWidth:3.f forState:UIControlStateHighlighted];
  XCTAssertEqual([self.card borderWidthForState:UIControlStateNormal], 1.f);
  XCTAssertEqual([self.card borderWidthForState:UIControlStateHighlighted], 3.f);
  self.card.highlighted = YES;
  XCTAssertEqual(self.card.layer.borderWidth, 3.f);
  self.card.highlighted = NO;
  XCTAssertEqual(self.card.layer.borderWidth, 1.f);
}

- (void)testBorderColorForCard {
  XCTAssertEqual([self.card borderColorForState:UIControlStateNormal], nil);
  [self.card setBorderColor:[UIColor blueColor] forState:UIControlStateNormal];
  XCTAssertEqual(self.card.layer.borderColor, [UIColor blueColor].CGColor);
  [self.card setBorderColor:[UIColor greenColor] forState:UIControlStateHighlighted];
  XCTAssertEqual([self.card borderColorForState:UIControlStateNormal], [UIColor blueColor]);
  XCTAssertEqual([self.card borderColorForState:UIControlStateHighlighted], [UIColor greenColor]);
  self.card.highlighted = YES;
  XCTAssertEqual(self.card.layer.borderColor, [UIColor greenColor].CGColor);
  self.card.highlighted = NO;
  XCTAssertEqual(self.card.layer.borderColor, [UIColor blueColor].CGColor);
}

- (void)testCornerForCard {
  XCTAssertEqual(self.card.layer.cornerRadius, 4.f);
  self.card.cornerRadius = 8.f;
  XCTAssertEqual(self.card.layer.cornerRadius, 8.f);
}

- (void)testCardInk {
  XCTAssertEqual(self.card.inkView.layer.sublayers.count, 1U);
  self.card.highlighted = YES;
  XCTAssertEqual(self.card.inkView.layer.sublayers.count, 2U);
}

- (void)testCardInteractabilityToggle {
  self.card.interactable = NO;
  self.card.frame = CGRectMake(0, 0, 1000, 1000);
  NSMutableArray *touchArray = [NSMutableArray new];
  [touchArray addObject:[UITouch new]];
  NSSet *touches = [[NSSet alloc] init];
  [touches setByAddingObjectsFromArray:touchArray];
  UIEvent *event = [[UIEvent alloc] init];
  UIView *view = [self.card hitTest:self.card.center withEvent:event];
  XCTAssertNil(view);
}

- (void)testCardEncoding {
  self.card.cornerRadius = 7.5f;
  self.card.bounds = CGRectMake(1, 2, 3, 4);
  [self.card setShadowElevation:2.f forState:UIControlStateNormal];
  [self.card setShadowElevation:4.f forState:UIControlStateHighlighted];
  [self.card setBorderWidth:2.f forState:UIControlStateNormal];
  [self.card setBorderWidth:4.f forState:UIControlStateHighlighted];
  [self.card setShadowColor:[UIColor redColor] forState:UIControlStateNormal];
  [self.card setShadowColor:[UIColor greenColor] forState:UIControlStateHighlighted];
  [self.card setBorderColor:[UIColor redColor] forState:UIControlStateNormal];
  [self.card setBorderColor:[UIColor greenColor] forState:UIControlStateHighlighted];
  self.card.interactable = NO;

  NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:self.card];
  MDCCard *unarchivedCard = [NSKeyedUnarchiver unarchiveObjectWithData:archivedData];

  XCTAssertTrue(CGRectEqualToRect(unarchivedCard.bounds, self.card.bounds));
  XCTAssertEqual(((MDCShadowLayer *)unarchivedCard.layer).shadowColor,
                 ((MDCShadowLayer *)self.card.layer).shadowColor);
  XCTAssertEqual(((MDCShadowLayer *)unarchivedCard.layer).elevation,
                 ((MDCShadowLayer *)self.card.layer).elevation);
  XCTAssertTrue(CGColorEqualToColor(((MDCShadowLayer *)unarchivedCard.layer).borderColor,
                                    ((MDCShadowLayer *)self.card.layer).borderColor));
  XCTAssertEqual(((MDCShadowLayer *)unarchivedCard.layer).borderWidth,
                 ((MDCShadowLayer *)self.card.layer).borderWidth);
  XCTAssertEqual(unarchivedCard.layer.cornerRadius, self.card.layer.cornerRadius);
  XCTAssertEqual([unarchivedCard shadowElevationForState:UIControlStateNormal],
                 [self.card shadowElevationForState:UIControlStateNormal]);
  XCTAssertEqual([unarchivedCard shadowElevationForState:UIControlStateHighlighted],
                 [self.card shadowElevationForState:UIControlStateHighlighted]);
  XCTAssertEqual([unarchivedCard shadowColorForState:UIControlStateNormal],
                 [self.card shadowColorForState:UIControlStateNormal]);
  XCTAssertEqual([unarchivedCard shadowColorForState:UIControlStateHighlighted],
                 [self.card shadowColorForState:UIControlStateHighlighted]);
  XCTAssertEqual([unarchivedCard borderColorForState:UIControlStateNormal],
                 [self.card borderColorForState:UIControlStateNormal]);
  XCTAssertEqual([unarchivedCard borderColorForState:UIControlStateHighlighted],
                 [self.card borderColorForState:UIControlStateHighlighted]);
  XCTAssertEqual([unarchivedCard borderWidthForState:UIControlStateNormal],
                 [self.card borderWidthForState:UIControlStateNormal]);
  XCTAssertEqual([unarchivedCard borderWidthForState:UIControlStateHighlighted],
                 [self.card borderWidthForState:UIControlStateHighlighted]);
  XCTAssertNotNil(unarchivedCard.inkView);
  XCTAssertEqual(unarchivedCard.subviews.count, self.card.subviews.count);
  XCTAssertEqual(unarchivedCard.isInteractable, NO);
}

- (void)testCellSelectAndUnselect {
  [self.cell layoutSubviews];
  XCTAssertEqual([self.cell shadowElevationForState:MDCCardCellStateNormal], 1.f);
  XCTAssertEqual(self.cell.cornerRadius, 4.f);
  XCTAssertEqual(self.cell.inkView.layer.sublayers.count, 1U);
  self.cell.selectable = YES;
  self.cell.selected = YES;
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 8.f);
  XCTAssertEqual(self.cell.inkView.layer.sublayers.count, 2U);
  XCTAssertEqual(((CAShapeLayer *)self.cell.inkView.layer.sublayers.lastObject).fillColor,
                 self.cell.inkView.inkColor.CGColor);
  self.cell.selected = NO;
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 1.f);
  XCTAssertEqual(self.cell.inkView.layer.sublayers.count, 1U);
  self.cell.selected = YES;
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 8.f);
  XCTAssertEqual(self.cell.inkView.layer.sublayers.count, 2U);
  XCTAssertEqual(((CAShapeLayer *)self.cell.inkView.layer.sublayers.lastObject).fillColor,
                 self.cell.inkView.inkColor.CGColor);
  XCTAssert(
    CGRectEqualToRect(
      (((CAShapeLayer *)self.cell.inkView.layer.sublayers.firstObject).frame),
      self.cell.inkView.layer.bounds));
  self.cell.selected = NO;
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 1.f);
  XCTAssertEqual(self.cell.cornerRadius, 4.f);
  XCTAssertEqual(self.cell.inkView.layer.sublayers.count, 1U);
}

- (void)testCellInteractabilityToggle {
  self.cell.interactable = NO;
  self.cell.frame = CGRectMake(0, 0, 1000, 1000);
  NSMutableArray *touchArray = [NSMutableArray new];
  [touchArray addObject:[UITouch new]];
  NSSet *touches = [[NSSet alloc] init];
  [touches setByAddingObjectsFromArray:touchArray];
  UIEvent *event = [[UIEvent alloc] init];
  UIView *view = [self.cell hitTest:self.cell.center withEvent:event];
  XCTAssertNil(view);
}

- (void)testCellLongPress {
  NSMutableArray *touchArray = [NSMutableArray new];
  [touchArray addObject:[UITouch new]];
  NSSet *touches = [[NSSet alloc] init];
  [touches setByAddingObjectsFromArray:touchArray];
  UIEvent *event = [[UIEvent alloc] init];
  [self.cell touchesBegan:touches withEvent:event];

  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 8.f);
  XCTAssertEqual(self.cell.inkView.layer.sublayers.count, 2U);

  [self.cell touchesEnded:touches withEvent:event];

  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 1.f);
}

- (void)testShadowElevationForCell {
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 1.f);
  XCTAssertEqual([self.cell shadowElevationForState:MDCCardCellStateNormal], 1.f);
  [self.cell setShadowElevation:8.f forState:MDCCardCellStateNormal];
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 8.f);
  [self.cell setShadowElevation:4.f forState:MDCCardCellStateHighlighted];
  [self.cell setShadowElevation:12.f forState:MDCCardCellStateSelected];
  XCTAssertEqual([self.cell shadowElevationForState:MDCCardCellStateNormal], 8.f);
  XCTAssertEqual([self.cell shadowElevationForState:MDCCardCellStateHighlighted], 4.f);
  XCTAssertEqual([self.cell shadowElevationForState:MDCCardCellStateSelected], 12.f);
  [self.cell setState:MDCCardCellStateHighlighted animated:NO];
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 4.f);
  [self.cell setState:MDCCardCellStateNormal animated:NO];
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 8.f);
  [self.cell setState:MDCCardCellStateSelected animated:NO];
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 12.f);
  [self.cell setState:MDCCardCellStateNormal animated:NO];
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 8.f);
}

- (void)testShadowColorForCell {
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).shadowColor, [UIColor blackColor].CGColor);
  XCTAssertEqual([self.cell shadowColorForState:MDCCardCellStateNormal],
                 [UIColor blackColor]);
  [self.cell setShadowColor:[UIColor blueColor] forState:MDCCardCellStateNormal];
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).shadowColor, [UIColor blueColor].CGColor);
  [self.cell setShadowColor:[UIColor greenColor] forState:MDCCardCellStateHighlighted];
  [self.cell setShadowColor:[UIColor redColor] forState:MDCCardCellStateSelected];
  XCTAssertEqual([self.cell shadowColorForState:MDCCardCellStateNormal], [UIColor blueColor]);
  XCTAssertEqual([self.cell shadowColorForState:MDCCardCellStateHighlighted], [UIColor greenColor]);
  XCTAssertEqual([self.cell shadowColorForState:MDCCardCellStateSelected], [UIColor redColor]);
  [self.cell setState:MDCCardCellStateHighlighted animated:NO];
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).shadowColor, [UIColor greenColor].CGColor);
  [self.cell setState:MDCCardCellStateNormal animated:NO];
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).shadowColor, [UIColor blueColor].CGColor);
  [self.cell setState:MDCCardCellStateSelected animated:NO];
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).shadowColor, [UIColor redColor].CGColor);
  [self.cell setState:MDCCardCellStateNormal animated:NO];
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).shadowColor, [UIColor blueColor].CGColor);
}

- (void)testBorderWidthForCell {
  XCTAssertEqual(self.cell.layer.borderWidth, 0.f);
  XCTAssertEqual([self.cell borderWidthForState:MDCCardCellStateNormal], 0.f);
  [self.cell setBorderWidth:1.f forState:MDCCardCellStateNormal];
  XCTAssertEqual(self.cell.layer.borderWidth, 1.f);
  [self.cell setBorderWidth:3.f forState:MDCCardCellStateHighlighted];
  [self.cell setBorderWidth:6.f forState:MDCCardCellStateSelected];
  XCTAssertEqual([self.cell borderWidthForState:MDCCardCellStateNormal], 1.f);
  XCTAssertEqual([self.cell borderWidthForState:MDCCardCellStateHighlighted], 3.f);
  XCTAssertEqual([self.cell borderWidthForState:MDCCardCellStateSelected], 6.f);
  [self.cell setState:MDCCardCellStateHighlighted animated:NO];
  XCTAssertEqual(self.cell.layer.borderWidth, 3.f);
  [self.cell setState:MDCCardCellStateNormal animated:NO];
  XCTAssertEqual(self.cell.layer.borderWidth, 1.f);
  [self.cell setState:MDCCardCellStateSelected animated:NO];
  XCTAssertEqual(self.cell.layer.borderWidth, 6.f);
  [self.cell setState:MDCCardCellStateNormal animated:NO];
  XCTAssertEqual(self.cell.layer.borderWidth, 1.f);
}

- (void)testBorderColorForCell {
  XCTAssertEqual([self.cell borderColorForState:MDCCardCellStateNormal], nil);
  [self.cell setBorderColor:[UIColor blueColor] forState:MDCCardCellStateNormal];
  XCTAssertEqual(self.cell.layer.borderColor, [UIColor blueColor].CGColor);
  [self.cell setBorderColor:[UIColor greenColor] forState:MDCCardCellStateHighlighted];
  [self.cell setBorderColor:[UIColor redColor] forState:MDCCardCellStateSelected];
  XCTAssertEqual([self.cell borderColorForState:MDCCardCellStateNormal], [UIColor blueColor]);
  XCTAssertEqual([self.cell borderColorForState:MDCCardCellStateHighlighted], [UIColor greenColor]);
  XCTAssertEqual([self.cell borderColorForState:MDCCardCellStateSelected], [UIColor redColor]);
  [self.cell setState:MDCCardCellStateHighlighted animated:NO];
  XCTAssertEqual(self.cell.layer.borderColor, [UIColor greenColor].CGColor);
  [self.cell setState:MDCCardCellStateNormal animated:NO];
  XCTAssertEqual(self.cell.layer.borderColor, [UIColor blueColor].CGColor);
  [self.cell setState:MDCCardCellStateSelected animated:NO];
  XCTAssertEqual(self.cell.layer.borderColor, [UIColor redColor].CGColor);
  [self.cell setState:MDCCardCellStateNormal animated:NO];
  XCTAssertEqual(self.cell.layer.borderColor, [UIColor blueColor].CGColor);
}

- (void)testCornerForCell {
  XCTAssertEqual(self.cell.layer.cornerRadius, 4.f);
  self.cell.cornerRadius = 8.f;
  XCTAssertEqual(self.cell.layer.cornerRadius, 8.f);
}

- (void)testCellInk {
  XCTAssertEqual(self.cell.inkView.layer.sublayers.count, 1U);
  [self.cell setState:MDCCardCellStateHighlighted animated:NO];
  XCTAssertEqual(self.cell.inkView.layer.sublayers.count, 2U);
  [self.cell setState:MDCCardCellStateSelected animated:NO];
  XCTAssertEqual(self.cell.inkView.layer.sublayers.count, 2U);
  [self.cell setState:MDCCardCellStateNormal animated:NO];
  XCTAssertEqual(self.cell.inkView.layer.sublayers.count, 1U);
}

static UIImage *FakeImage(void) {
  CGSize imageSize = CGSizeMake(24, 24);
  UIGraphicsBeginImageContext(imageSize);
  [UIColor.whiteColor setFill];
  UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

- (void)testSettingImageForCell {
  XCTAssertEqual([self.cell imageForState:MDCCardCellStateNormal], nil);
  [self.cell setImage:FakeImage() forState:MDCCardCellStateNormal];
  XCTAssertNotNil([self.cell imageForState:MDCCardCellStateNormal]);
  [self.cell setImage:FakeImage() forState:MDCCardCellStateHighlighted];
  [self.cell setImage:FakeImage() forState:MDCCardCellStateSelected];
  XCTAssertNotNil([self.cell imageForState:MDCCardCellStateNormal]);
  XCTAssertNotNil([self.cell imageForState:MDCCardCellStateHighlighted]);
  XCTAssertNotNil([self.cell imageForState:MDCCardCellStateSelected]);
  UIImage *img = [self.cell imageForState:MDCCardCellStateHighlighted];
  [self.cell setImage:FakeImage() forState:MDCCardCellStateHighlighted];
  XCTAssertNotEqual(img, [self.cell imageForState:MDCCardCellStateHighlighted]);
}

- (void)testSettingImageTintColorForCell {
  XCTAssertEqual([self.cell imageTintColorForState:MDCCardCellStateNormal], nil);
  [self.cell setImageTintColor:[UIColor blueColor] forState:MDCCardCellStateNormal];
  XCTAssertEqual([self.cell imageTintColorForState:MDCCardCellStateNormal],
                 [UIColor blueColor]);
  [self.cell setImageTintColor:[UIColor greenColor] forState:MDCCardCellStateHighlighted];
  [self.cell setImageTintColor:[UIColor redColor] forState:MDCCardCellStateSelected];
  XCTAssertEqual([self.cell imageTintColorForState:MDCCardCellStateNormal], [UIColor blueColor]);
  XCTAssertEqual([self.cell imageTintColorForState:MDCCardCellStateHighlighted], [UIColor greenColor]);
  XCTAssertEqual([self.cell imageTintColorForState:MDCCardCellStateSelected], [UIColor redColor]);
  UIColor *color = [self.cell imageTintColorForState:MDCCardCellStateHighlighted];
  [self.cell setImageTintColor:[UIColor blueColor] forState:MDCCardCellStateHighlighted];
  XCTAssertNotEqual(color, [self.cell imageTintColorForState:MDCCardCellStateHighlighted]);
}

- (void)testSettingHorizontalImageAlignmentForCell {
  XCTAssertEqual([self.cell horizontalImageAlignmentForState:MDCCardCellStateNormal],
                 MDCCardCellHorizontalImageAlignmentRight);
  [self.cell setHorizontalImageAlignment:MDCCardCellHorizontalImageAlignmentLeft
                                forState:MDCCardCellStateNormal];
  XCTAssertEqual([self.cell horizontalImageAlignmentForState:MDCCardCellStateNormal],
                 MDCCardCellHorizontalImageAlignmentLeft);
  [self.cell setHorizontalImageAlignment:MDCCardCellHorizontalImageAlignmentCenter
                                forState:MDCCardCellStateHighlighted];
  [self.cell setHorizontalImageAlignment:MDCCardCellHorizontalImageAlignmentRight
                                forState:MDCCardCellStateSelected];
  XCTAssertEqual([self.cell horizontalImageAlignmentForState:MDCCardCellStateNormal],
                 MDCCardCellHorizontalImageAlignmentLeft);
  XCTAssertEqual([self.cell horizontalImageAlignmentForState:MDCCardCellStateHighlighted],
                 MDCCardCellHorizontalImageAlignmentCenter);
  XCTAssertEqual([self.cell horizontalImageAlignmentForState:MDCCardCellStateSelected],
                 MDCCardCellHorizontalImageAlignmentRight);
  MDCCardCellHorizontalImageAlignment alignment =
  [self.cell horizontalImageAlignmentForState:MDCCardCellStateHighlighted];
  [self.cell setHorizontalImageAlignment:MDCCardCellHorizontalImageAlignmentLeft
                                forState:MDCCardCellStateHighlighted];
  XCTAssertNotEqual(alignment,
                    [self.cell horizontalImageAlignmentForState:MDCCardCellStateHighlighted]);
}

- (void)testSettingVerticalImageAlignmentForCell {
  XCTAssertEqual([self.cell verticalImageAlignmentForState:MDCCardCellStateNormal],
                 MDCCardCellVerticalImageAlignmentTop);
  [self.cell setVerticalImageAlignment:MDCCardCellVerticalImageAlignmentBottom
                              forState:MDCCardCellStateNormal];
  XCTAssertEqual([self.cell verticalImageAlignmentForState:MDCCardCellStateNormal],
                 MDCCardCellVerticalImageAlignmentBottom);
  [self.cell setVerticalImageAlignment:MDCCardCellVerticalImageAlignmentCenter
                                forState:MDCCardCellStateHighlighted];
  [self.cell setVerticalImageAlignment:MDCCardCellVerticalImageAlignmentTop
                                forState:MDCCardCellStateSelected];
  XCTAssertEqual([self.cell verticalImageAlignmentForState:MDCCardCellStateNormal],
                 MDCCardCellVerticalImageAlignmentBottom);
  XCTAssertEqual([self.cell verticalImageAlignmentForState:MDCCardCellStateHighlighted],
                 MDCCardCellVerticalImageAlignmentCenter);
  XCTAssertEqual([self.cell verticalImageAlignmentForState:MDCCardCellStateSelected],
                 MDCCardCellVerticalImageAlignmentTop);
  MDCCardCellVerticalImageAlignment alignment =
  [self.cell verticalImageAlignmentForState:MDCCardCellStateHighlighted];
  [self.cell setVerticalImageAlignment:MDCCardCellVerticalImageAlignmentBottom
                                forState:MDCCardCellStateHighlighted];
  XCTAssertNotEqual(alignment,
                    [self.cell verticalImageAlignmentForState:MDCCardCellStateHighlighted]);
}

- (void)testCellEncoding {
  self.cell.cornerRadius = 7.5f;
  self.cell.bounds = CGRectMake(1, 2, 3, 4);
  [self.cell setImage:FakeImage() forState:MDCCardCellStateNormal];
  [self.cell setImage:FakeImage() forState:MDCCardCellStateHighlighted];
  [self.cell setImage:FakeImage() forState:MDCCardCellStateSelected];
  [self.cell setImageTintColor:[UIColor blueColor] forState:MDCCardCellStateNormal];
  [self.cell setImageTintColor:[UIColor redColor] forState:MDCCardCellStateHighlighted];
  [self.cell setImageTintColor:[UIColor greenColor] forState:MDCCardCellStateSelected];
  [self.cell setHorizontalImageAlignment:MDCCardCellHorizontalImageAlignmentLeft
                                forState:MDCCardCellStateNormal];
  [self.cell setHorizontalImageAlignment:MDCCardCellHorizontalImageAlignmentCenter
                      forState:MDCCardCellStateHighlighted];
  [self.cell setHorizontalImageAlignment:MDCCardCellHorizontalImageAlignmentRight
                                forState:MDCCardCellStateSelected];
  [self.cell setVerticalImageAlignment:MDCCardCellVerticalImageAlignmentBottom
                              forState:MDCCardCellStateNormal];
  [self.cell setVerticalImageAlignment:MDCCardCellVerticalImageAlignmentCenter
                      forState:MDCCardCellStateHighlighted];
  [self.cell setVerticalImageAlignment:MDCCardCellVerticalImageAlignmentTop
                              forState:MDCCardCellStateSelected];
  [self.cell setShadowElevation:2.f forState:MDCCardCellStateNormal];
  [self.cell setShadowElevation:4.f forState:MDCCardCellStateHighlighted];
  [self.cell setShadowElevation:6.f forState:MDCCardCellStateSelected];
  [self.cell setBorderWidth:2.f forState:MDCCardCellStateNormal];
  [self.cell setBorderWidth:4.f forState:MDCCardCellStateHighlighted];
  [self.cell setBorderWidth:6.f forState:MDCCardCellStateSelected];
  [self.cell setShadowColor:[UIColor redColor] forState:MDCCardCellStateNormal];
  [self.cell setShadowColor:[UIColor greenColor] forState:MDCCardCellStateHighlighted];
  [self.cell setShadowColor:[UIColor blueColor] forState:MDCCardCellStateSelected];
  [self.cell setBorderColor:[UIColor redColor] forState:MDCCardCellStateNormal];
  [self.cell setBorderColor:[UIColor greenColor] forState:MDCCardCellStateHighlighted];
  [self.cell setBorderColor:[UIColor blueColor] forState:MDCCardCellStateSelected];
  self.cell.interactable = NO;

  NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:self.cell];
  MDCCardCollectionCell *unarchivedCell = [NSKeyedUnarchiver unarchiveObjectWithData:archivedData];

  XCTAssertTrue(CGRectEqualToRect(unarchivedCell.bounds, self.cell.bounds));
  XCTAssertEqual(((MDCShadowLayer *)unarchivedCell.layer).shadowColor,
                 ((MDCShadowLayer *)self.cell.layer).shadowColor);
  XCTAssertEqual(((MDCShadowLayer *)unarchivedCell.layer).elevation,
                 ((MDCShadowLayer *)self.cell.layer).elevation);
  XCTAssertTrue(CGColorEqualToColor(((MDCShadowLayer *)unarchivedCell.layer).borderColor,
                                    ((MDCShadowLayer *)self.cell.layer).borderColor));
  XCTAssertEqual(((MDCShadowLayer *)unarchivedCell.layer).borderWidth,
                 ((MDCShadowLayer *)self.cell.layer).borderWidth);
  XCTAssertEqual(unarchivedCell.layer.cornerRadius, self.cell.layer.cornerRadius);
  XCTAssertEqual([unarchivedCell shadowElevationForState:MDCCardCellStateNormal],
                 [self.cell shadowElevationForState:MDCCardCellStateNormal]);
  XCTAssertEqual([unarchivedCell shadowElevationForState:MDCCardCellStateHighlighted],
                 [self.cell shadowElevationForState:MDCCardCellStateHighlighted]);
  XCTAssertEqual([unarchivedCell shadowElevationForState:MDCCardCellStateSelected],
                 [self.cell shadowElevationForState:MDCCardCellStateSelected]);
  XCTAssertEqual([unarchivedCell shadowColorForState:MDCCardCellStateNormal],
                 [self.cell shadowColorForState:MDCCardCellStateNormal]);
  XCTAssertEqual([unarchivedCell shadowColorForState:MDCCardCellStateHighlighted],
                 [self.cell shadowColorForState:MDCCardCellStateHighlighted]);
  XCTAssertEqual([unarchivedCell shadowColorForState:MDCCardCellStateSelected],
                 [self.cell shadowColorForState:MDCCardCellStateSelected]);
  XCTAssertEqual([unarchivedCell borderColorForState:MDCCardCellStateNormal],
                 [self.cell borderColorForState:MDCCardCellStateNormal]);
  XCTAssertEqual([unarchivedCell borderColorForState:MDCCardCellStateHighlighted],
                 [self.cell borderColorForState:MDCCardCellStateHighlighted]);
  XCTAssertEqual([unarchivedCell borderColorForState:MDCCardCellStateSelected],
                 [self.cell borderColorForState:MDCCardCellStateSelected]);
  XCTAssertEqual([unarchivedCell borderWidthForState:MDCCardCellStateNormal],
                 [self.cell borderWidthForState:MDCCardCellStateNormal]);
  XCTAssertEqual([unarchivedCell borderWidthForState:MDCCardCellStateHighlighted],
                 [self.cell borderWidthForState:MDCCardCellStateHighlighted]);
  XCTAssertEqual([unarchivedCell borderWidthForState:MDCCardCellStateSelected],
                 [self.cell borderWidthForState:MDCCardCellStateSelected]);
  XCTAssertNotNil(unarchivedCell.inkView);
  XCTAssertEqual(unarchivedCell.subviews.count, self.cell.subviews.count);
  XCTAssertTrue(
      [UIImagePNGRepresentation([unarchivedCell imageForState:MDCCardCellStateNormal])
          isEqual:UIImagePNGRepresentation([self.cell imageForState:MDCCardCellStateNormal])]
               );
  XCTAssertTrue(
      [UIImagePNGRepresentation([unarchivedCell imageForState:MDCCardCellStateHighlighted])
         isEqual:UIImagePNGRepresentation([self.cell imageForState:MDCCardCellStateHighlighted])]
                );
  XCTAssertTrue(
      [UIImagePNGRepresentation([unarchivedCell imageForState:MDCCardCellStateSelected])
         isEqual:UIImagePNGRepresentation([self.cell imageForState:MDCCardCellStateSelected])]
                );
  XCTAssertEqual([unarchivedCell imageTintColorForState:MDCCardCellStateNormal],
                 [self.cell imageTintColorForState:MDCCardCellStateNormal]);
  XCTAssertEqual([unarchivedCell imageTintColorForState:MDCCardCellStateHighlighted],
                 [self.cell imageTintColorForState:MDCCardCellStateHighlighted]);
  XCTAssertEqual([unarchivedCell imageTintColorForState:MDCCardCellStateSelected],
                 [self.cell imageTintColorForState:MDCCardCellStateSelected]);
  XCTAssertEqual([unarchivedCell horizontalImageAlignmentForState:MDCCardCellStateNormal],
                 [self.cell horizontalImageAlignmentForState:MDCCardCellStateNormal]);
  XCTAssertEqual([unarchivedCell horizontalImageAlignmentForState:MDCCardCellStateHighlighted],
                 [self.cell horizontalImageAlignmentForState:MDCCardCellStateHighlighted]);
  XCTAssertEqual([unarchivedCell horizontalImageAlignmentForState:MDCCardCellStateSelected],
                 [self.cell horizontalImageAlignmentForState:MDCCardCellStateSelected]);
  XCTAssertEqual([unarchivedCell verticalImageAlignmentForState:MDCCardCellStateNormal],
                 [self.cell verticalImageAlignmentForState:MDCCardCellStateNormal]);
  XCTAssertEqual([unarchivedCell verticalImageAlignmentForState:MDCCardCellStateHighlighted],
                 [self.cell verticalImageAlignmentForState:MDCCardCellStateHighlighted]);
  XCTAssertEqual([unarchivedCell verticalImageAlignmentForState:MDCCardCellStateSelected],
                 [self.cell verticalImageAlignmentForState:MDCCardCellStateSelected]);
  XCTAssertEqual(unarchivedCell.isInteractable, NO);
}

@end
