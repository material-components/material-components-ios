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

#import "MaterialButtons.h"
#import "MaterialShadowElevations.h"

@interface MDCFloatingButton (Testing)
@property(nonatomic, assign) MDCFloatingButtonMode mode;
@property(nonatomic, assign) MDCFloatingButtonImageLocation imageLocation;
@property(nonatomic, assign) CGFloat imageTitleSpacing;
@end

@interface FloatingButtonsTests : XCTestCase
@end

@implementation FloatingButtonsTests

- (void)testExpandedLayout {
  // Given
  MDCFloatingButton *button =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeDefault];
  button.mode = MDCFloatingButtonModeExpanded;
  [button setTitle:@"A very long title that can never fit" forState:UIControlStateNormal];
  [button setImage:[UIImage imageNamed:@"Plus"] forState:UIControlStateNormal];
  button.maximumSize = CGSizeMake(100, 48);
  button.imageTitleSpacing = 12;

  // When
  [button sizeToFit];

  // Then
  CGRect buttonBounds = CGRectStandardize(button.bounds);
  CGRect imageFrame = CGRectStandardize(button.imageView.frame);
  CGRect titleFrame = CGRectStandardize(button.titleLabel.frame);
  XCTAssertEqualWithAccuracy(imageFrame.origin.x, 16, 1);
  XCTAssertEqualWithAccuracy(CGRectGetMaxX(titleFrame), buttonBounds.size.width - 24, 1);
  XCTAssertEqualWithAccuracy(titleFrame.origin.x,
                             CGRectGetMaxX(imageFrame) + button.imageTitleSpacing, 1);
}

- (void)testExpandedLayoutWithNonZeroContentEdgeInsets {
  // Given
  MDCFloatingButton *button = [[MDCFloatingButton alloc] initWithFrame:CGRectZero
                                                                 shape:MDCFloatingButtonShapeMini];
  button.mode = MDCFloatingButtonModeExpanded;
  [button setTitle:@"A very long title that can never fit" forState:UIControlStateNormal];
  [button setImage:[UIImage imageNamed:@"Plus"] forState:UIControlStateNormal];
  button.maximumSize = CGSizeMake(100, 48);
  button.minimumSize = CGSizeMake(100, 48);
  button.contentEdgeInsets = UIEdgeInsetsMake(4, -4, 8, -8);

  // When
  [button sizeToFit];

  // Then
  CGRect buttonBounds = CGRectStandardize(button.bounds);
  CGRect imageFrame = CGRectStandardize(button.imageView.frame);
  CGRect titleFrame = CGRectStandardize(button.titleLabel.frame);
  XCTAssertEqualWithAccuracy(imageFrame.origin.x, 12, 1);
  XCTAssertEqualWithAccuracy(CGRectGetMaxX(titleFrame), buttonBounds.size.width - 16, 1);
  XCTAssertEqualWithAccuracy(titleFrame.origin.x,
                             CGRectGetMaxX(imageFrame) + button.imageTitleSpacing, 1);
}

- (void)testEncoding {
  // Given
  MDCFloatingButton *button = [[MDCFloatingButton alloc] initWithFrame:CGRectMake(1, 2, 3, 4)
                                                                 shape:MDCFloatingButtonShapeMini];
  button.mode = MDCFloatingButtonModeExpanded;
  button.imageLocation = MDCFloatingButtonImageLocationTrailing;
  [button setImage:[UIImage imageNamed:@"Plus"] forState:UIControlStateNormal];
  [button setTitle:@"Title" forState:UIControlStateNormal];

  // When
  NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:button];
  MDCFloatingButton *unarchivedButton = [NSKeyedUnarchiver unarchiveObjectWithData:archivedData];
  [button sizeToFit];
  [button layoutIfNeeded];
  [unarchivedButton sizeToFit];
  [unarchivedButton layoutIfNeeded];

  // Then
  XCTAssertTrue(CGRectEqualToRect(button.bounds, unarchivedButton.bounds));
  XCTAssertEqual(button.mode, unarchivedButton.mode);
  XCTAssertEqual(button.imageLocation, unarchivedButton.imageLocation);
  XCTAssertEqualObjects(button.currentTitle, unarchivedButton.currentTitle);
}

- (void)testShapeMigrationFromLargeIcon {
  // Given
  MDCFloatingButton *button = [[MDCFloatingButton alloc] initWithFrame:CGRectZero
                                                                 shape:MDCFloatingButtonShapeMini];
  [button setValue:@(2) forKey:@"shape"];
  [button sizeToFit];

  // When
  NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:button];
  MDCFloatingButton *unarchivedButton = [NSKeyedUnarchiver unarchiveObjectWithData:archivedData];
  [unarchivedButton sizeToFit];

  // Then
  XCTAssertTrue(CGRectEqualToRect(unarchivedButton.bounds, CGRectMake(0, 0, 56, 56)));
  XCTAssertEqualObjects([unarchivedButton valueForKey:@"shape"], @(0));
}

- (void)testDefaultElevationsForState {
  // Given
  MDCFloatingButton *button = [MDCFloatingButton appearance];

  // Then
  XCTAssertEqual([button elevationForState:UIControlStateNormal], MDCShadowElevationFABResting);
  XCTAssertEqual([button elevationForState:UIControlStateHighlighted],
                 MDCShadowElevationFABPressed);
  XCTAssertEqual([button elevationForState:UIControlStateDisabled], MDCShadowElevationNone);
}

- (void)testCollapseExpandRestoresIdentityTransform {
  // Given
  MDCFloatingButton *button = [[MDCFloatingButton alloc] init];
  CGAffineTransform transform = CGAffineTransformIdentity;
  button.transform = transform;

  // When
  [button collapse:NO completion:nil];
  [button expand:NO completion:nil];

  // Then
  XCTAssertTrue(
      CGAffineTransformEqualToTransform(button.transform, transform),
      @"Collapse and expand did not restore the original transform.\nExpected: %@\nReceived: %@",
      NSStringFromCGAffineTransform(transform), NSStringFromCGAffineTransform(button.transform));
}

- (void)testCollapseExpandRestoresTransform {
  // Given
  MDCFloatingButton *button = [[MDCFloatingButton alloc] init];
  CGAffineTransform transform = CGAffineTransformRotate(button.transform, M_PI_2);
  button.transform = transform;

  // When
  [button collapse:NO completion:nil];
  [button expand:NO completion:nil];

  // Then
  XCTAssertTrue(
      CGAffineTransformEqualToTransform(button.transform, transform),
      @"Collapse and expand did not restore the original transform.\nExpected: %@\nReceived: %@",
      NSStringFromCGAffineTransform(transform), NSStringFromCGAffineTransform(button.transform));
}

- (void)testCollapseExpandAnimatedRestoresTransform {
  // Given
  MDCFloatingButton *button = [[MDCFloatingButton alloc] init];
  CGAffineTransform transform = CGAffineTransformMakeTranslation(10, -77.1);
  button.transform = transform;
  XCTestExpectation *expectation = [self expectationWithDescription:@"Collapse animation complete"];

  // When
  [button collapse:YES
        completion:^{
          [expectation fulfill];
        }];

  // Then
  // Collapse should take around 200ms in total
  [self waitForExpectationsWithTimeout:1 handler:nil];

  XCTAssertFalse(CGAffineTransformEqualToTransform(button.transform, transform),
                 @"Collapse did not modify the original transform.\nOriginal: %@\nReceived: %@",
                 NSStringFromCGAffineTransform(transform),
                 NSStringFromCGAffineTransform(button.transform));

  expectation = [self expectationWithDescription:@"Expand animation complete"];

  [button expand:YES
      completion:^{
        [expectation fulfill];
      }];

  // Expand should take around 200ms in total
  [self waitForExpectationsWithTimeout:1 handler:nil];

  XCTAssertTrue(
      CGAffineTransformEqualToTransform(button.transform, transform),
      @"Collapse and expand did not restore the original transform.\nExpected: %@\nReceived: %@",
      NSStringFromCGAffineTransform(transform), NSStringFromCGAffineTransform(button.transform));
}

- (void)testSizeThatFits {
  // Given
  MDCFloatingButton *miniButton =
      [MDCFloatingButton floatingButtonWithShape:MDCFloatingButtonShapeMini];
  MDCFloatingButton *defaultButton =
      [MDCFloatingButton floatingButtonWithShape:MDCFloatingButtonShapeDefault];

  // When
  CGSize miniSize = [miniButton sizeThatFits:CGSizeZero];
  CGSize defaultSize = [defaultButton sizeThatFits:CGSizeZero];

  // Then
  XCTAssertTrue(CGSizeEqualToSize(CGSizeMake(40, 40), miniSize));
  XCTAssertTrue(CGSizeEqualToSize(CGSizeMake(56, 56), defaultSize));
}

- (void)testIntrinsicContentSize {
  // Given
  MDCFloatingButton *miniButton =
      [MDCFloatingButton floatingButtonWithShape:MDCFloatingButtonShapeMini];
  MDCFloatingButton *defaultButton =
      [MDCFloatingButton floatingButtonWithShape:MDCFloatingButtonShapeDefault];

  // When
  CGSize miniSize = [miniButton intrinsicContentSize];
  CGSize defaultSize = [defaultButton intrinsicContentSize];

  // Then
  XCTAssertTrue(CGSizeEqualToSize(CGSizeMake(40, 40), miniSize));
  XCTAssertTrue(CGSizeEqualToSize(CGSizeMake(56, 56), defaultSize));
}

- (void)testContentEdgeInsets {
  // Given
  MDCFloatingButton *miniButton =
      [MDCFloatingButton floatingButtonWithShape:MDCFloatingButtonShapeMini];
  MDCFloatingButton *defaultButton =
      [MDCFloatingButton floatingButtonWithShape:MDCFloatingButtonShapeDefault];

  // When
  UIEdgeInsets miniInsets = [miniButton contentEdgeInsets];
  UIEdgeInsets defaultInsets = [defaultButton contentEdgeInsets];

  // Then
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, miniInsets));
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, defaultInsets));
}

- (void)testDefaultHitAreaInsets {
  // Given
  MDCFloatingButton *defaultButton =
      [MDCFloatingButton floatingButtonWithShape:MDCFloatingButtonShapeDefault];
  MDCFloatingButton *miniButton =
      [MDCFloatingButton floatingButtonWithShape:MDCFloatingButtonShapeMini];

  // Then
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, defaultButton.hitAreaInsets));
  XCTAssertTrue(
      UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsMake(-4, -4, -4, -4), miniButton.hitAreaInsets));
}

- (void)testHitAreaInsetsSurviveSizeThatFits {
  // Given
  MDCFloatingButton *defaultButton =
      [MDCFloatingButton floatingButtonWithShape:MDCFloatingButtonShapeDefault];
  MDCFloatingButton *miniButton =
      [MDCFloatingButton floatingButtonWithShape:MDCFloatingButtonShapeMini];

  // When
  [defaultButton sizeThatFits:CGSizeZero];
  [miniButton sizeThatFits:CGSizeZero];

  // Then
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, defaultButton.hitAreaInsets));
  XCTAssertTrue(
      UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsMake(-4, -4, -4, -4), miniButton.hitAreaInsets));
}

- (void)testCornerRadius {
  // Given
  MDCFloatingButton *button =
      [MDCFloatingButton floatingButtonWithShape:MDCFloatingButtonShapeDefault];
  [button sizeToFit];
  [button layoutIfNeeded];

  // Then
  XCTAssertNotEqualWithAccuracy(CGRectGetHeight(button.bounds), 0, 0.0001);
  XCTAssertEqualWithAccuracy(button.layer.cornerRadius, CGRectGetHeight(button.bounds) / 2, 0.0001);
}

@end
