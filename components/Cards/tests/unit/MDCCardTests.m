// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

- (void)tearDown {
  self.cell = nil;
  self.card = nil;
  [super tearDown];
}

- (void)testShadowElevationForCard {
  XCTAssertEqual(((MDCShadowLayer *)self.card.layer).elevation, 1);
  XCTAssertEqual([self.card shadowElevationForState:UIControlStateNormal], 1);
  [self.card setShadowElevation:8 forState:UIControlStateNormal];
  XCTAssertEqual(((MDCShadowLayer *)self.card.layer).elevation, 8);
  [self.card setShadowElevation:4 forState:UIControlStateHighlighted];
  XCTAssertEqual([self.card shadowElevationForState:UIControlStateNormal], 8);
  XCTAssertEqual([self.card shadowElevationForState:UIControlStateHighlighted], 4);
  self.card.highlighted = YES;
  XCTAssertEqual(((MDCShadowLayer *)self.card.layer).elevation, 4);
  self.card.highlighted = NO;
  XCTAssertEqual(((MDCShadowLayer *)self.card.layer).elevation, 8);
}

- (void)testShadowColorForCard {
  XCTAssertEqual(((MDCShadowLayer *)self.card.layer).shadowColor, [UIColor blackColor].CGColor);
  XCTAssertEqual([self.card shadowColorForState:UIControlStateNormal], [UIColor blackColor]);
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
  XCTAssertEqual(self.card.layer.borderWidth, 0);
  XCTAssertEqual([self.card borderWidthForState:UIControlStateNormal], 0);
  [self.card setBorderWidth:1 forState:UIControlStateNormal];
  XCTAssertEqual(self.card.layer.borderWidth, 1);
  [self.card setBorderWidth:3 forState:UIControlStateHighlighted];
  XCTAssertEqual([self.card borderWidthForState:UIControlStateNormal], 1);
  XCTAssertEqual([self.card borderWidthForState:UIControlStateHighlighted], 3);
  self.card.highlighted = YES;
  XCTAssertEqual(self.card.layer.borderWidth, 3);
  self.card.highlighted = NO;
  XCTAssertEqual(self.card.layer.borderWidth, 1);
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
  XCTAssertEqual(self.card.layer.cornerRadius, 4);
  self.card.cornerRadius = 8;
  XCTAssertEqual(self.card.layer.cornerRadius, 8);
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

- (void)testCellSelectAndUnselect {
  [self.cell layoutSubviews];
  XCTAssertEqual([self.cell shadowElevationForState:MDCCardCellStateNormal], 1);
  XCTAssertEqual(self.cell.cornerRadius, 4);
  XCTAssertEqual(self.cell.inkView.layer.sublayers.count, 1U);
  self.cell.selectable = YES;
  self.cell.selected = YES;
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 8);
  XCTAssertEqual(self.cell.inkView.layer.sublayers.count, 2U);
  XCTAssertEqual(((CAShapeLayer *)self.cell.inkView.layer.sublayers.lastObject).fillColor,
                 self.cell.inkView.inkColor.CGColor);
  self.cell.selected = NO;
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 1);
  XCTAssertEqual(self.cell.inkView.layer.sublayers.count, 1U);
  self.cell.selected = YES;
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 8);
  XCTAssertEqual(self.cell.inkView.layer.sublayers.count, 2U);
  XCTAssertEqual(((CAShapeLayer *)self.cell.inkView.layer.sublayers.lastObject).fillColor,
                 self.cell.inkView.inkColor.CGColor);
  XCTAssert(
      CGRectEqualToRect((((CAShapeLayer *)self.cell.inkView.layer.sublayers.firstObject).frame),
                        self.cell.inkView.layer.bounds));
  self.cell.selected = NO;
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 1);
  XCTAssertEqual(self.cell.cornerRadius, 4);
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

  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 8);
  XCTAssertEqual(self.cell.inkView.layer.sublayers.count, 2U);

  [self.cell touchesEnded:touches withEvent:event];

  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 1);
}

- (void)testShadowElevationForCell {
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 1);
  XCTAssertEqual([self.cell shadowElevationForState:MDCCardCellStateNormal], 1);
  [self.cell setShadowElevation:8 forState:MDCCardCellStateNormal];
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 8);
  [self.cell setShadowElevation:4 forState:MDCCardCellStateHighlighted];
  [self.cell setShadowElevation:12 forState:MDCCardCellStateSelected];
  XCTAssertEqual([self.cell shadowElevationForState:MDCCardCellStateNormal], 8);
  XCTAssertEqual([self.cell shadowElevationForState:MDCCardCellStateHighlighted], 4);
  XCTAssertEqual([self.cell shadowElevationForState:MDCCardCellStateSelected], 12);
  [self.cell setState:MDCCardCellStateHighlighted animated:NO];
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 4);
  [self.cell setState:MDCCardCellStateNormal animated:NO];
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 8);
  [self.cell setState:MDCCardCellStateSelected animated:NO];
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 12);
  [self.cell setState:MDCCardCellStateNormal animated:NO];
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).elevation, 8);
}

- (void)testShadowColorForCell {
  XCTAssertEqual(((MDCShadowLayer *)self.cell.layer).shadowColor, [UIColor blackColor].CGColor);
  XCTAssertEqual([self.cell shadowColorForState:MDCCardCellStateNormal], [UIColor blackColor]);
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
  XCTAssertEqual(self.cell.layer.borderWidth, 0);
  XCTAssertEqual([self.cell borderWidthForState:MDCCardCellStateNormal], 0);
  [self.cell setBorderWidth:1 forState:MDCCardCellStateNormal];
  XCTAssertEqual(self.cell.layer.borderWidth, 1);
  [self.cell setBorderWidth:3 forState:MDCCardCellStateHighlighted];
  [self.cell setBorderWidth:6 forState:MDCCardCellStateSelected];
  XCTAssertEqual([self.cell borderWidthForState:MDCCardCellStateNormal], 1);
  XCTAssertEqual([self.cell borderWidthForState:MDCCardCellStateHighlighted], 3);
  XCTAssertEqual([self.cell borderWidthForState:MDCCardCellStateSelected], 6);
  [self.cell setState:MDCCardCellStateHighlighted animated:NO];
  XCTAssertEqual(self.cell.layer.borderWidth, 3);
  [self.cell setState:MDCCardCellStateNormal animated:NO];
  XCTAssertEqual(self.cell.layer.borderWidth, 1);
  [self.cell setState:MDCCardCellStateSelected animated:NO];
  XCTAssertEqual(self.cell.layer.borderWidth, 6);
  [self.cell setState:MDCCardCellStateNormal animated:NO];
  XCTAssertEqual(self.cell.layer.borderWidth, 1);
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
  XCTAssertEqual(self.cell.layer.cornerRadius, 4);
  self.cell.cornerRadius = 8;
  XCTAssertEqual(self.cell.layer.cornerRadius, 8);
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
  XCTAssertEqual([self.cell imageTintColorForState:MDCCardCellStateNormal], [UIColor blueColor]);
  [self.cell setImageTintColor:[UIColor greenColor] forState:MDCCardCellStateHighlighted];
  [self.cell setImageTintColor:[UIColor redColor] forState:MDCCardCellStateSelected];
  XCTAssertEqual([self.cell imageTintColorForState:MDCCardCellStateNormal], [UIColor blueColor]);
  XCTAssertEqual([self.cell imageTintColorForState:MDCCardCellStateHighlighted],
                 [UIColor greenColor]);
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

- (void)testTraitCollectionDidChangeBlockCalledWithExpectedParametersForCard {
  // Given
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"traitCollection"];
  __block UITraitCollection *passedTraitCollection = nil;
  __block MDCCard *passedCard = nil;
  self.card.traitCollectionDidChangeBlock =
      ^(MDCCard *_Nonnull card, UITraitCollection *_Nullable previousTraitCollection) {
        passedTraitCollection = previousTraitCollection;
        passedCard = card;
        [expectation fulfill];
      };
  UITraitCollection *fakeTraitCollection = [UITraitCollection traitCollectionWithDisplayScale:7];

  // When
  [self.card traitCollectionDidChange:fakeTraitCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedCard, self.card);
  XCTAssertEqual(passedTraitCollection, fakeTraitCollection);
}

- (void)testTraitCollectionDidChangeBlockCalledWithExpectedParametersForCardCollectionCell {
  // Given
  XCTestExpectation *expectation =
      [[XCTestExpectation alloc] initWithDescription:@"traitCollection"];
  __block UITraitCollection *passedTraitCollection = nil;
  __block MDCCardCollectionCell *passedCollectionCell = nil;
  self.cell.traitCollectionDidChangeBlock =
      ^(MDCCardCollectionCell *_Nonnull collectionCell,
        UITraitCollection *_Nullable previousTraitCollection) {
        passedTraitCollection = previousTraitCollection;
        passedCollectionCell = collectionCell;
        [expectation fulfill];
      };
  UITraitCollection *fakeTraitCollection = [UITraitCollection traitCollectionWithDisplayScale:7];

  // When
  [self.cell traitCollectionDidChange:fakeTraitCollection];

  // Then
  [self waitForExpectations:@[ expectation ] timeout:1];
  XCTAssertEqual(passedCollectionCell, self.cell);
  XCTAssertEqual(passedTraitCollection, fakeTraitCollection);
}

#pragma mark - MDCElevation

- (void)testCurrentElevationMatchesElevationWhenElevationChangesForCard {
  // When
  [self.card setShadowElevation:4 forState:UIControlStateNormal];

  // Then
  XCTAssertEqualWithAccuracy(self.card.mdc_currentElevation,
                             [self.card shadowElevationForState:UIControlStateNormal], 0.001);
}

- (void)testSettingOverrideBaseElevationReturnsSetValueForCard {
  // Given
  CGFloat expectedBaseElevation = 99;

  // When
  self.card.mdc_overrideBaseElevation = expectedBaseElevation;

  // Then
  XCTAssertEqualWithAccuracy(self.card.mdc_overrideBaseElevation, expectedBaseElevation, 0.001);
}

- (void)testElevationDidChangeBlockCalledWhenElevationChangesValueForCard {
  // Given
  [self.card setShadowElevation:5 forState:UIControlStateNormal];
  __block BOOL blockCalled = NO;
  self.card.mdc_elevationDidChangeBlock = ^(id<MDCElevatable> _, CGFloat elevation) {
    blockCalled = YES;
  };

  // When
  [self.card setShadowElevation:[self.card shadowElevationForState:UIControlStateNormal] + 1
                       forState:UIControlStateNormal];

  // Then
  XCTAssertTrue(blockCalled);
}

- (void)testElevationDidChangeBlockNotCalledWhenElevationIsSetWithoutChangingValueForCard {
  // Given
  [self.card setShadowElevation:5 forState:UIControlStateNormal];
  __block BOOL blockCalled = NO;
  self.card.mdc_elevationDidChangeBlock = ^(id<MDCElevatable> _, CGFloat elevation) {
    blockCalled = YES;
  };

  // When
  [self.card setShadowElevation:[self.card shadowElevationForState:UIControlStateNormal]
                       forState:UIControlStateNormal];

  // Then
  XCTAssertFalse(blockCalled);
}

- (void)testDefaultValueForOverrideBaseElevationIsNegativeForCard {
  // Then
  XCTAssertLessThan(self.card.mdc_overrideBaseElevation, 0);
}

- (void)testCurrentElevationMatchesElevationWhenElevationChangesForCardCell {
  // When
  [self.cell setShadowElevation:4 forState:MDCCardCellStateNormal];

  // Then
  XCTAssertEqualWithAccuracy(self.cell.mdc_currentElevation,
                             [self.cell shadowElevationForState:MDCCardCellStateNormal], 0.001);
}

- (void)testSettingOverrideBaseElevationReturnsSetValueForCardCell {
  // Given
  CGFloat expectedBaseElevation = 99;

  // When
  self.cell.mdc_overrideBaseElevation = expectedBaseElevation;

  // Then
  XCTAssertEqualWithAccuracy(self.cell.mdc_overrideBaseElevation, expectedBaseElevation, 0.001);
}

- (void)testElevationDidChangeBlockCalledWhenElevationChangesValueForCardCell {
  // Given
  [self.cell setShadowElevation:5 forState:MDCCardCellStateNormal];
  __block BOOL blockCalled = NO;
  self.cell.mdc_elevationDidChangeBlock = ^(id<MDCElevatable> _, CGFloat elevation) {
    blockCalled = YES;
  };

  // When
  [self.cell setShadowElevation:[self.cell shadowElevationForState:MDCCardCellStateNormal] + 1
                       forState:MDCCardCellStateNormal];

  // Then
  XCTAssertTrue(blockCalled);
}

- (void)testElevationDidChangeBlockNotCalledWhenElevationIsSetWithoutChangingValueForCardCell {
  // Given
  [self.cell setShadowElevation:5 forState:MDCCardCellStateNormal];
  __block BOOL blockCalled = NO;
  self.cell.mdc_elevationDidChangeBlock = ^(id<MDCElevatable> _, CGFloat elevation) {
    blockCalled = YES;
  };

  // When
  [self.cell setShadowElevation:[self.cell shadowElevationForState:MDCCardCellStateNormal]
                       forState:MDCCardCellStateNormal];

  // Then
  XCTAssertFalse(blockCalled);
}

- (void)testDefaultValueForOverrideBaseElevationIsNegativeForCardCell {
  // Then
  XCTAssertLessThan(self.cell.mdc_overrideBaseElevation, 0);
}

@end
