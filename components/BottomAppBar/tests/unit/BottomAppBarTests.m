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

#import "MaterialBottomAppBar.h"

#import <CoreGraphics/CoreGraphics.h>
#import <XCTest/XCTest.h>

#import "../../src/private/MDCBottomAppBarLayer.h"
#import "MaterialNavigationBar.h"

@interface MDCBottomAppBarLayer (Testing)
- (UIBezierPath *)drawWithPathToCut:(UIBezierPath *)bottomBarPath
                            yOffset:(CGFloat)yOffset
                              width:(CGFloat)width
                             height:(CGFloat)height
                          arcCenter:(CGPoint)arcCenter
                          arcRadius:(CGFloat)arcRadius
                         startAngle:(CGFloat)startAngle
                           endAngle:(CGFloat)endAngle;
- (UIBezierPath *)drawWithPlainPath:(UIBezierPath *)bottomBarPath
                            yOffset:(CGFloat)yOffset
                              width:(CGFloat)width
                             height:(CGFloat)height
                          arcCenter:(CGPoint)arcCenter
                          arcRadius:(CGFloat)arcRadius;
@end

@interface MDCBottomAppBarView (Testing)
@property(nonatomic, strong) MDCNavigationBar *navBar;
@end

@interface BottomAppBarTests : XCTestCase
@property(nonatomic, strong) MDCBottomAppBarView *bottomAppBar;
@end

@implementation BottomAppBarTests

- (void)setUp {
  [super setUp];
  self.bottomAppBar = [[MDCBottomAppBarView alloc] init];
}

- (void)tearDown {
  self.bottomAppBar = nil;
  [super tearDown];
}

#pragma mark - Color

- (void)testLeadingBarItemTintColorDefault {
  // Then
  XCTAssertEqualObjects(self.bottomAppBar.leadingBarItemsTintColor, UIColor.blackColor);
}

- (void)testLeadingBarItemTintColorAppliesToNavigationBar {
  // When
  self.bottomAppBar.leadingBarItemsTintColor = UIColor.cyanColor;

  // Then
  XCTAssertEqualObjects(self.bottomAppBar.navBar.leadingBarItemsTintColor, UIColor.cyanColor);
}

- (void)testTrailingBarItemTintColorDefault {
  // Then
  XCTAssertEqualObjects(self.bottomAppBar.trailingBarItemsTintColor, UIColor.blackColor);
}

- (void)testTrailingBarItemTintColorAppliesToNavigationBar {
  // When
  self.bottomAppBar.trailingBarItemsTintColor = UIColor.purpleColor;

  // Then
  XCTAssertEqualObjects(self.bottomAppBar.navBar.trailingBarItemsTintColor, UIColor.purpleColor);
}

#pragma mark - Floating Button

- (void)testCustomizedFloatingButtonVerticalHeight {
  CGFloat veriticalOffset = 5.0f;
  self.bottomAppBar.floatingButtonVerticalOffset = veriticalOffset;
  [self.bottomAppBar layoutSubviews];
  CGPoint floatingButtonPosition = self.bottomAppBar.floatingButton.center;
  CGPoint navigationBarPosition = self.bottomAppBar.navBar.frame.origin;
  XCTAssertEqualWithAccuracy(floatingButtonPosition.y + veriticalOffset, navigationBarPosition.y,
                             0.001f);
}

#pragma mark - Path test

- (void)testPathToAndFromEqualNumberOfPoints {
  // Given
  MDCBottomAppBarLayer *bottomAppLayer = [[MDCBottomAppBarLayer alloc] init];
  UIBezierPath *fakeToPath = [[UIBezierPath alloc] init];
  UIBezierPath *fakeFromPath = [[UIBezierPath alloc] init];
  CGFloat fakeYOffset = 38;
  CGFloat fakeWidth = 414;
  CGFloat fakeHeight = 130;
  CGFloat fakeArcRadius = 32;
  CGPoint fakeCenter = CGPointMake(207, 38);

  // When
  fakeToPath = [bottomAppLayer drawWithPathToCut:fakeToPath
                                         yOffset:fakeYOffset
                                           width:fakeWidth
                                          height:fakeHeight
                                       arcCenter:fakeCenter
                                       arcRadius:fakeArcRadius
                                      startAngle:M_PI
                                        endAngle:M_PI_2];
  fakeFromPath = [bottomAppLayer drawWithPlainPath:fakeFromPath
                                           yOffset:fakeYOffset
                                             width:fakeWidth
                                            height:fakeHeight
                                         arcCenter:fakeCenter
                                         arcRadius:fakeArcRadius];

  // Then
  XCTAssertEqual([self numberOfPointsInPath:fakeToPath], [self numberOfPointsInPath:fakeFromPath]);
}

- (int)numberOfPointsInPath:(UIBezierPath *)bezierPath {
  __block int numberOfPoints = 0;
  CGPathApplyWithBlock(bezierPath.CGPath, ^(const CGPathElement *_Nonnull element) {
    switch (element->type) {
      case kCGPathElementMoveToPoint:
        numberOfPoints = numberOfPoints + 1;
        break;
      case kCGPathElementAddLineToPoint:
        numberOfPoints = numberOfPoints + 1;
        break;
      case kCGPathElementAddCurveToPoint:
        numberOfPoints = numberOfPoints + 3;
        break;
      case kCGPathElementAddQuadCurveToPoint:
        numberOfPoints = numberOfPoints + 2;
        break;
      case kCGPathElementCloseSubpath:
        break;
      default:
        break;
    }
  });
  return numberOfPoints;
}

@end
