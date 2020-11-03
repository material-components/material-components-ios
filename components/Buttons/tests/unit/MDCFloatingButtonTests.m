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

#import "MaterialButtons.h"
#import "MaterialShadowElevations.h"

static UIImage *fakeImage(void) {
  CGSize imageSize = CGSizeMake(24, 24);
  UIGraphicsBeginImageContext(imageSize);
  [UIColor.whiteColor setFill];
  UIRectFill(CGRectMake(0, 0, imageSize.width, imageSize.height));
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

@interface FakeFloatingButton : MDCFloatingButton
@property(nonatomic, assign) BOOL intrinsicContentSizeCalled;
@property(nonatomic, assign) BOOL invalidateIntrinsicContentSizeCalled;
@property(nonatomic, assign) BOOL sizeThatFitsCalled;
@property(nonatomic, assign) BOOL layoutSubviewsCalled;

- (void)reset;
@end

@implementation FakeFloatingButton

- (void)reset {
  self.intrinsicContentSizeCalled = NO;
  self.invalidateIntrinsicContentSizeCalled = NO;
  self.layoutSubviewsCalled = NO;
  self.sizeThatFitsCalled = NO;
}

- (CGSize)intrinsicContentSize {
  self.intrinsicContentSizeCalled = YES;
  return [super intrinsicContentSize];
}

- (void)invalidateIntrinsicContentSize {
  self.invalidateIntrinsicContentSizeCalled = YES;
  [super invalidateIntrinsicContentSize];
}

- (CGSize)sizeThatFits:(CGSize)size {
  self.sizeThatFitsCalled = YES;
  return [super sizeThatFits:size];
}

- (void)layoutSubviews {
  self.layoutSubviewsCalled = YES;
  [super layoutSubviews];
}

@end

@interface MDCFloatingButtonsTests : XCTestCase
@end

@implementation MDCFloatingButtonsTests

#pragma mark - setHitAreaInsets:forShape:inMode:

- (void)testDefaultHitAreaInsetsValues {
  // Given
  MDCFloatingButton *defaultButtonNormal =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeDefault];
  MDCFloatingButton *defaultButtonExpanded =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeDefault];
  defaultButtonExpanded.mode = MDCFloatingButtonModeExpanded;
  MDCFloatingButton *miniButtonNormal =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];
  MDCFloatingButton *miniButtonExpanded =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];
  miniButtonExpanded.mode = MDCFloatingButtonModeExpanded;

  // Then
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, defaultButtonNormal.hitAreaInsets));
  XCTAssertTrue(
      UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, defaultButtonExpanded.hitAreaInsets));
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsMake(-4, -4, -4, -4),
                                              miniButtonNormal.hitAreaInsets));
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, miniButtonExpanded.hitAreaInsets));
}

- (void)testSetHitAreaInsetsForShapeInNormalMode {
  // Given
  MDCFloatingButton *defaultButton = [[MDCFloatingButton alloc] init];  // Default shape
  defaultButton.mode = MDCFloatingButtonModeExpanded;
  MDCFloatingButton *miniButton =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];
  miniButton.mode = MDCFloatingButtonModeExpanded;

  // When
  [defaultButton setHitAreaInsets:UIEdgeInsetsMake(1, 2, 3, 4)
                         forShape:MDCFloatingButtonShapeDefault
                           inMode:MDCFloatingButtonModeNormal];
  defaultButton.mode = MDCFloatingButtonModeNormal;
  [miniButton setHitAreaInsets:UIEdgeInsetsMake(9, 8, 7, 6)
                      forShape:MDCFloatingButtonShapeMini
                        inMode:MDCFloatingButtonModeNormal];
  miniButton.mode = MDCFloatingButtonModeNormal;

  // Then
  XCTAssertTrue(
      UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsMake(1, 2, 3, 4), defaultButton.hitAreaInsets));
  XCTAssertTrue(
      UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsMake(9, 8, 7, 6), miniButton.hitAreaInsets));
}

- (void)testSetHitAreaInsetsForShapeInExpandedMode {
  // Given
  MDCFloatingButton *defaultButton = [[MDCFloatingButton alloc] init];  // Default shape
  MDCFloatingButton *miniButton =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];

  // When
  [defaultButton setHitAreaInsets:UIEdgeInsetsMake(1, 2, 3, 4)
                         forShape:MDCFloatingButtonShapeDefault
                           inMode:MDCFloatingButtonModeExpanded];
  defaultButton.mode = MDCFloatingButtonModeExpanded;
  [miniButton setHitAreaInsets:UIEdgeInsetsMake(9, 8, 7, 6)
                      forShape:MDCFloatingButtonShapeMini
                        inMode:MDCFloatingButtonModeExpanded];
  miniButton.mode = MDCFloatingButtonModeExpanded;

  // Then
  XCTAssertTrue(
      UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsMake(1, 2, 3, 4), defaultButton.hitAreaInsets));
  XCTAssertTrue(
      UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsMake(9, 8, 7, 6), miniButton.hitAreaInsets));
}

- (void)testChangingHitAreaInsetsWontTriggerResizing {
  // Given
  FakeFloatingButton *button = [[FakeFloatingButton alloc] init];  // Default shape
  [button reset];

  // When
  [button setHitAreaInsets:UIEdgeInsetsMake(17, 21, 25, 29)
                  forShape:MDCFloatingButtonShapeDefault
                    inMode:MDCFloatingButtonModeNormal];

  // Then
  XCTAssertFalse(button.intrinsicContentSizeCalled);
  XCTAssertFalse(button.invalidateIntrinsicContentSizeCalled);
  XCTAssertFalse(button.sizeThatFitsCalled);
  XCTAssertFalse(button.layoutSubviewsCalled);
}

#pragma mark - setContentEdgeInsets:forShape:inMode:

- (void)testDefaultContentEdgeInsetsValues {
  // Given
  MDCFloatingButton *defaultButtonNormal =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeDefault];
  MDCFloatingButton *defaultButtonExpanded =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeDefault];
  defaultButtonExpanded.mode = MDCFloatingButtonModeExpanded;
  MDCFloatingButton *miniButtonNormal =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];
  MDCFloatingButton *miniButtonExpanded =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];
  miniButtonExpanded.mode = MDCFloatingButtonModeExpanded;

  // Then
  XCTAssertTrue(
      UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, defaultButtonNormal.contentEdgeInsets));
  XCTAssertTrue(
      UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, defaultButtonExpanded.contentEdgeInsets));
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsMake(8, 8, 8, 8),
                                              miniButtonNormal.contentEdgeInsets));
  XCTAssertTrue(
      UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, miniButtonExpanded.contentEdgeInsets));
}

- (void)testSetContentEdgeInsetsForShapeInNormalMode {
  // Given
  MDCFloatingButton *defaultButton = [[MDCFloatingButton alloc] init];  // Default shape
  defaultButton.mode = MDCFloatingButtonModeExpanded;
  MDCFloatingButton *miniButton =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];
  miniButton.mode = MDCFloatingButtonModeExpanded;

  // When
  [defaultButton setContentEdgeInsets:UIEdgeInsetsMake(1, 2, 3, 4)
                             forShape:MDCFloatingButtonShapeDefault
                               inMode:MDCFloatingButtonModeNormal];
  defaultButton.mode = MDCFloatingButtonModeNormal;
  [miniButton setContentEdgeInsets:UIEdgeInsetsMake(9, 8, 7, 6)
                          forShape:MDCFloatingButtonShapeMini
                            inMode:MDCFloatingButtonModeNormal];
  miniButton.mode = MDCFloatingButtonModeNormal;

  // Then
  XCTAssertTrue(
      UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsMake(1, 2, 3, 4), defaultButton.contentEdgeInsets));
  XCTAssertTrue(
      UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsMake(9, 8, 7, 6), miniButton.contentEdgeInsets));
}

- (void)testSetContentEdgeInsetsForShapeInExpandedMode {
  // Given
  MDCFloatingButton *defaultButton = [[MDCFloatingButton alloc] init];  // Default shape
  MDCFloatingButton *miniButton =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];

  // When
  [defaultButton setContentEdgeInsets:UIEdgeInsetsMake(1, 2, 3, 4)
                             forShape:MDCFloatingButtonShapeDefault
                               inMode:MDCFloatingButtonModeExpanded];
  defaultButton.mode = MDCFloatingButtonModeExpanded;
  [miniButton setContentEdgeInsets:UIEdgeInsetsMake(9, 8, 7, 6)
                          forShape:MDCFloatingButtonShapeMini
                            inMode:MDCFloatingButtonModeExpanded];
  miniButton.mode = MDCFloatingButtonModeExpanded;

  // Then
  XCTAssertTrue(
      UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsMake(1, 2, 3, 4), defaultButton.contentEdgeInsets));
  XCTAssertTrue(
      UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsMake(9, 8, 7, 6), miniButton.contentEdgeInsets));
}

- (void)testSettingContentEdgeInsetsInvalidatesIntrinsicContentSize {
  // Given
  FakeFloatingButton *button = [[FakeFloatingButton alloc] init];  // Default shape
  [button reset];

  // When
  [button setContentEdgeInsets:UIEdgeInsetsMake(9, 8, 7, 7)
                      forShape:MDCFloatingButtonShapeDefault
                        inMode:MDCFloatingButtonModeNormal];

  // Then
  XCTAssertFalse(button.intrinsicContentSizeCalled);
  XCTAssertTrue(button.invalidateIntrinsicContentSizeCalled);
  XCTAssertFalse(button.sizeThatFitsCalled);
  XCTAssertFalse(button.layoutSubviewsCalled);
}

#pragma mark - setMaximumSize:forShape:inMode:

- (void)testDefaultMaximumSizeForShapeInNormalModeSizeToFit {
  // Given
  MDCFloatingButton *defaultButton = [[MDCFloatingButton alloc] init];  // Default shape
  [defaultButton setTitle:@"a very long title" forState:UIControlStateNormal];
  MDCFloatingButton *miniButton =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];
  [miniButton setTitle:@"a very long title" forState:UIControlStateNormal];

  // When
  [defaultButton sizeToFit];
  [miniButton sizeToFit];

  // Then
  XCTAssertLessThanOrEqual(defaultButton.bounds.size.width, [MDCFloatingButton defaultDimension]);
  XCTAssertLessThanOrEqual(defaultButton.bounds.size.height, [MDCFloatingButton defaultDimension]);
  XCTAssertLessThanOrEqual(miniButton.bounds.size.width, [MDCFloatingButton miniDimension]);
  XCTAssertLessThanOrEqual(miniButton.bounds.size.height, [MDCFloatingButton miniDimension]);
}

- (void)testDefaultMaximumSizeForShapeInExpandedModeSizeToFit {
  // Given
  MDCFloatingButton *defaultButton = [[MDCFloatingButton alloc] init];
  [defaultButton setTitle:@"An even longer title that should require more than 328 points to render"
                 forState:UIControlStateNormal];
  defaultButton.mode = MDCFloatingButtonModeExpanded;

  // When
  [defaultButton sizeToFit];

  // Then
  XCTAssertLessThanOrEqual(defaultButton.bounds.size.width, 328);
}

- (void)testSetMaximumSizeForShapeInModeNormal {
  // Given
  MDCFloatingButton *defaultButton = [[MDCFloatingButton alloc] init];  // Default shape
  [defaultButton setTitle:@"a very long title" forState:UIControlStateNormal];
  defaultButton.mode = MDCFloatingButtonModeExpanded;
  MDCFloatingButton *miniButton =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];
  [miniButton setTitle:@"a very long title" forState:UIControlStateNormal];
  miniButton.mode = MDCFloatingButtonModeExpanded;

  // When
  [defaultButton setMaximumSize:CGSizeMake(100, 50)
                       forShape:MDCFloatingButtonShapeDefault
                         inMode:MDCFloatingButtonModeNormal];
  defaultButton.mode = MDCFloatingButtonModeNormal;
  [miniButton setMaximumSize:CGSizeMake(100, 50)
                    forShape:MDCFloatingButtonShapeMini
                      inMode:MDCFloatingButtonModeNormal];
  miniButton.mode = MDCFloatingButtonModeNormal;

  // Then
  XCTAssertLessThanOrEqual(defaultButton.bounds.size.width, 100);
  XCTAssertLessThanOrEqual(defaultButton.bounds.size.height, 50);
  XCTAssertLessThanOrEqual(miniButton.bounds.size.width, 100);
  XCTAssertLessThanOrEqual(miniButton.bounds.size.height, 50);
}

- (void)testSetMaximumSizeForShapeInModeExpanded {
  // Given
  MDCFloatingButton *defaultButton = [[MDCFloatingButton alloc] init];  // Default shape
  [defaultButton setTitle:@"An even longer title that should require more than 328 points to render"
                 forState:UIControlStateNormal];
  MDCFloatingButton *miniButton =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];
  [miniButton setTitle:@"An even longer title that should require more than 328 points to render"
              forState:UIControlStateNormal];

  // When
  [defaultButton setMaximumSize:CGSizeMake(50, 100)
                       forShape:MDCFloatingButtonShapeDefault
                         inMode:MDCFloatingButtonModeExpanded];
  defaultButton.mode = MDCFloatingButtonModeExpanded;
  [miniButton setMaximumSize:CGSizeMake(50, 100)
                    forShape:MDCFloatingButtonShapeMini
                      inMode:MDCFloatingButtonModeExpanded];
  miniButton.mode = MDCFloatingButtonModeExpanded;

  // Then
  XCTAssertLessThanOrEqual(defaultButton.bounds.size.width, 50);
  XCTAssertLessThanOrEqual(defaultButton.bounds.size.height, 100);
  XCTAssertLessThanOrEqual(miniButton.bounds.size.width, 50);
  XCTAssertLessThanOrEqual(miniButton.bounds.size.height, 100);
}

- (void)testSettingMaximumSizeInvalidatesIntrinsicContentSize {
  // Given
  FakeFloatingButton *button = [[FakeFloatingButton alloc] init];  // Default shape
  [button reset];

  // When
  [button setMaximumSize:CGSizeMake(7, 7)
                forShape:MDCFloatingButtonShapeDefault
                  inMode:MDCFloatingButtonModeNormal];

  // Then
  XCTAssertFalse(button.intrinsicContentSizeCalled);
  XCTAssertTrue(button.invalidateIntrinsicContentSizeCalled);
  XCTAssertFalse(button.sizeThatFitsCalled);
  XCTAssertFalse(button.layoutSubviewsCalled);
}

#pragma mark - setMinimumSize:forShape:inMode:

- (void)testDefaultMinimumSizeForShapeInNormalModeSizeToFit {
  // Given
  MDCFloatingButton *defaultButton = [[MDCFloatingButton alloc] init];
  MDCFloatingButton *miniButton =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];

  // When
  [defaultButton sizeToFit];
  [miniButton sizeToFit];

  // Then
  XCTAssertGreaterThanOrEqual(defaultButton.bounds.size.width,
                              [MDCFloatingButton defaultDimension]);
  XCTAssertGreaterThanOrEqual(defaultButton.bounds.size.height,
                              [MDCFloatingButton defaultDimension]);
  XCTAssertGreaterThanOrEqual(miniButton.bounds.size.width, [MDCFloatingButton miniDimension]);
  XCTAssertGreaterThanOrEqual(miniButton.bounds.size.height, [MDCFloatingButton miniDimension]);
}

- (void)testDefaultMinimumSizeForShapeInExpandedModeSizeToFit {
  // Given
  MDCFloatingButton *defaultButton = [[MDCFloatingButton alloc] init];
  defaultButton.mode = MDCFloatingButtonModeExpanded;

  // When
  [defaultButton sizeToFit];

  // Then
  XCTAssertGreaterThanOrEqual(defaultButton.bounds.size.height, 48);
}

- (void)testSetMinimumSizeForShapeInModeNormal {
  // Given
  MDCFloatingButton *defaultButton = [[MDCFloatingButton alloc] init];  // Default shape
  defaultButton.mode = MDCFloatingButtonModeExpanded;
  MDCFloatingButton *miniButton =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];
  miniButton.mode = MDCFloatingButtonModeExpanded;

  // When
  [defaultButton setMinimumSize:CGSizeMake(100, 50)
                       forShape:MDCFloatingButtonShapeDefault
                         inMode:MDCFloatingButtonModeNormal];
  [defaultButton setMaximumSize:CGSizeZero
                       forShape:MDCFloatingButtonShapeDefault
                         inMode:MDCFloatingButtonModeNormal];
  defaultButton.mode = MDCFloatingButtonModeNormal;
  [defaultButton sizeToFit];

  [miniButton setMinimumSize:CGSizeMake(100, 50)
                    forShape:MDCFloatingButtonShapeMini
                      inMode:MDCFloatingButtonModeNormal];
  [miniButton setMaximumSize:CGSizeZero
                    forShape:MDCFloatingButtonShapeMini
                      inMode:MDCFloatingButtonModeNormal];
  miniButton.mode = MDCFloatingButtonModeNormal;
  [miniButton sizeToFit];

  // Then
  XCTAssertGreaterThanOrEqual(defaultButton.bounds.size.width, 100);
  XCTAssertGreaterThanOrEqual(defaultButton.bounds.size.height, 50);
  XCTAssertGreaterThanOrEqual(miniButton.bounds.size.width, 100);
  XCTAssertGreaterThanOrEqual(miniButton.bounds.size.height, 50);
}

- (void)testSetMinimumSizeForShapeInModeExpanded {
  // Given
  MDCFloatingButton *defaultButton = [[MDCFloatingButton alloc] init];  // Default shape
  MDCFloatingButton *miniButton =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];

  // When
  [defaultButton setMinimumSize:CGSizeMake(50, 100)
                       forShape:MDCFloatingButtonShapeDefault
                         inMode:MDCFloatingButtonModeExpanded];
  defaultButton.mode = MDCFloatingButtonModeExpanded;
  [defaultButton sizeToFit];

  [miniButton setMinimumSize:CGSizeMake(50, 100)
                    forShape:MDCFloatingButtonShapeMini
                      inMode:MDCFloatingButtonModeExpanded];
  miniButton.mode = MDCFloatingButtonModeExpanded;
  [miniButton sizeToFit];

  // Then
  XCTAssertGreaterThanOrEqual(defaultButton.bounds.size.width, 50);
  XCTAssertGreaterThanOrEqual(defaultButton.bounds.size.height, 100);
  XCTAssertGreaterThanOrEqual(miniButton.bounds.size.width, 50);
  XCTAssertGreaterThanOrEqual(miniButton.bounds.size.height, 100);
}

- (void)testSettingMinimumSizeInvalidatesIntrinsicContentSize {
  // Given
  FakeFloatingButton *button = [[FakeFloatingButton alloc] init];  // Default shape
  [button reset];

  // When
  [button setMinimumSize:CGSizeMake(12, 12)
                forShape:MDCFloatingButtonShapeDefault
                  inMode:MDCFloatingButtonModeNormal];

  // Then
  XCTAssertFalse(button.intrinsicContentSizeCalled);
  XCTAssertTrue(button.invalidateIntrinsicContentSizeCalled);
  XCTAssertFalse(button.layoutSubviewsCalled);
  XCTAssertFalse(button.layoutSubviewsCalled);
}

#pragma mark - layoutSubviews

- (void)testExpandedLayout {
  // Given
  MDCFloatingButton *button =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeDefault];
  button.mode = MDCFloatingButtonModeExpanded;
  [button setTitle:@"A very long title that can never fit" forState:UIControlStateNormal];
  [button setImage:fakeImage() forState:UIControlStateNormal];
  [button setMaximumSize:CGSizeMake(100, 48)
                forShape:MDCFloatingButtonShapeDefault
                  inMode:MDCFloatingButtonModeExpanded];
  button.imageTitleSpace = 12;

  // When
  [button sizeToFit];

  // Then
  CGRect buttonBounds = CGRectStandardize(button.bounds);
  CGRect imageFrame = CGRectStandardize(button.imageView.frame);
  CGRect titleFrame = CGRectStandardize(button.titleLabel.frame);
  XCTAssertEqualWithAccuracy(imageFrame.origin.x, 16, 1);
  XCTAssertEqualWithAccuracy(CGRectGetMaxX(titleFrame), buttonBounds.size.width - 24, 1);
  XCTAssertEqualWithAccuracy(titleFrame.origin.x,
                             CGRectGetMaxX(imageFrame) + button.imageTitleSpace, 1);
}

- (void)testExpandedLayoutShortTitle {
  // Given
  MDCFloatingButton *button =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeDefault];
  button.mode = MDCFloatingButtonModeExpanded;
  [button setTitle:@"A" forState:UIControlStateNormal];
  [button setImage:fakeImage() forState:UIControlStateNormal];
  [button setMaximumSize:CGSizeMake(100, 48)
                forShape:MDCFloatingButtonShapeDefault
                  inMode:MDCFloatingButtonModeExpanded];
  button.imageTitleSpace = 12;

  // When
  [button sizeToFit];

  // Then
  CGRect buttonBounds = CGRectStandardize(button.bounds);
  CGRect imageFrame = CGRectStandardize(button.imageView.frame);
  CGRect titleFrame = CGRectStandardize(button.titleLabel.frame);
  XCTAssertEqualWithAccuracy(imageFrame.origin.x, 16, 1);
  XCTAssertEqualWithAccuracy(CGRectGetMaxX(titleFrame), buttonBounds.size.width - 24, 1);
  XCTAssertEqualWithAccuracy(titleFrame.origin.x,
                             CGRectGetMaxX(imageFrame) + button.imageTitleSpace, 1);
}

- (void)testExpandedLayoutWithImageLocationTrailing {
  // Given
  MDCFloatingButton *button =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeDefault];
  button.mode = MDCFloatingButtonModeExpanded;
  button.imageLocation = MDCFloatingButtonImageLocationTrailing;
  [button setTitle:@"A very long title that can never fit" forState:UIControlStateNormal];
  [button setImage:fakeImage() forState:UIControlStateNormal];
  [button setMaximumSize:CGSizeMake(100, 48)
                forShape:MDCFloatingButtonShapeDefault
                  inMode:MDCFloatingButtonModeExpanded];
  button.imageTitleSpace = 12;

  // When
  [button sizeToFit];

  // Then
  CGRect imageFrame = button.imageView.frame;
  CGRect titleFrame = button.titleLabel.frame;
  XCTAssertEqualWithAccuracy(CGRectGetMaxX(imageFrame), CGRectGetWidth(button.bounds) - 16, 1);
  XCTAssertEqualWithAccuracy(CGRectGetMinX(titleFrame), 24, 1);
  XCTAssertEqualWithAccuracy(CGRectGetMinX(imageFrame),
                             CGRectGetMaxX(titleFrame) + button.imageTitleSpace, 1);
}

- (void)testExpandedLayoutWithNonZeroContentEdgeInsets {
  // Given
  MDCFloatingButton *button = [[MDCFloatingButton alloc] initWithFrame:CGRectZero
                                                                 shape:MDCFloatingButtonShapeMini];
  button.mode = MDCFloatingButtonModeExpanded;
  [button setTitle:@"A very long title that can never fit" forState:UIControlStateNormal];
  [button setImage:fakeImage() forState:UIControlStateNormal];
  [button setMinimumSize:CGSizeMake(100, 48)
                forShape:MDCFloatingButtonShapeMini
                  inMode:MDCFloatingButtonModeExpanded];
  [button setMaximumSize:CGSizeMake(100, 48)
                forShape:MDCFloatingButtonShapeMini
                  inMode:MDCFloatingButtonModeExpanded];
  [button setContentEdgeInsets:UIEdgeInsetsMake(4, -4, 8, -8)
                      forShape:MDCFloatingButtonShapeMini
                        inMode:MDCFloatingButtonModeExpanded];

  // When
  [button sizeToFit];

  // Then
  CGRect buttonBounds = CGRectStandardize(button.bounds);
  CGRect imageFrame = CGRectStandardize(button.imageView.frame);
  CGRect titleFrame = CGRectStandardize(button.titleLabel.frame);
  XCTAssertEqualWithAccuracy(imageFrame.origin.x, 12, 1);
  XCTAssertEqualWithAccuracy(CGRectGetMaxX(titleFrame), buttonBounds.size.width - 16, 1);
  XCTAssertEqualWithAccuracy(titleFrame.origin.x,
                             CGRectGetMaxX(imageFrame) + button.imageTitleSpace, 1);
}

- (void)testExpandedLayoutBehaviorIsIdempotent {
  // Given
  MDCFloatingButton *button = [[MDCFloatingButton alloc] init];  // Default shape
  button.mode = MDCFloatingButtonModeExpanded;
  [button setTitle:@"Title" forState:UIControlStateNormal];
  [button setImage:fakeImage() forState:UIControlStateNormal];
  [button sizeToFit];
  CGRect originalImageFrame = button.imageView.frame;
  CGRect originalTitleFrame = button.titleLabel.frame;

  // When
  [button layoutIfNeeded];
  [button sizeToFit];
  [button layoutIfNeeded];
  [button layoutIfNeeded];

  // Then
  XCTAssertTrue(CGRectEqualToRect(originalImageFrame, button.imageView.frame),
                @"Image frames are not equal.\nExpected: %@\nReceived: %@",
                NSStringFromCGRect(originalImageFrame), NSStringFromCGRect(button.imageView.frame));
  XCTAssertTrue(CGRectEqualToRect(originalTitleFrame, button.titleLabel.frame),
                @"Title frames are not equal.\nExpected: %@\nReceived: %@",
                NSStringFromCGRect(originalTitleFrame),
                NSStringFromCGRect(button.titleLabel.frame));
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

#pragma mark - Animations

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
  CGAffineTransform transform = CGAffineTransformRotate(button.transform, (CGFloat)M_PI_2);
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

// This test is flaky.
// <unknown>:0: error: -[FloatingButtonsTests testCollapseExpandAnimatedRestoresTransform] :
// Asynchronous wait failed: Exceeded timeout of 1 seconds, with unfulfilled expectations: "Expand
// animation complete".
- (void)disabled_testCollapseExpandAnimatedRestoresTransform {
  // Given
  MDCFloatingButton *button = [[MDCFloatingButton alloc] init];
  CGAffineTransform transform = CGAffineTransformMakeTranslation(10, (CGFloat)-77.1);
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

#pragma mark - Sizing methods

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
  CGFloat miniDimension = [MDCFloatingButton miniDimension];
  CGFloat defaultDimension = [MDCFloatingButton defaultDimension];
  XCTAssertTrue(CGSizeEqualToSize(CGSizeMake(miniDimension, miniDimension), miniSize));
  XCTAssertTrue(CGSizeEqualToSize(CGSizeMake(defaultDimension, defaultDimension), defaultSize));
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
  CGFloat miniDimension = [MDCFloatingButton miniDimension];
  CGFloat defaultDimension = [MDCFloatingButton defaultDimension];
  XCTAssertTrue(CGSizeEqualToSize(CGSizeMake(miniDimension, miniDimension), miniSize));
  XCTAssertTrue(CGSizeEqualToSize(CGSizeMake(defaultDimension, defaultDimension), defaultSize));
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

#pragma mark - shape methods

- (void)testSizeChangeWhenChangingShapeFromDefaultToMini {
  // Given
  MDCFloatingButton *button =
      [MDCFloatingButton floatingButtonWithShape:MDCFloatingButtonShapeDefault];
  [button sizeToFit];
  [button layoutIfNeeded];

  // When
  button.shape = MDCFloatingButtonShapeMini;
  [button sizeToFit];

  // Then
  XCTAssertEqual(button.shape, MDCFloatingButtonShapeMini);
  CGFloat miniDimension = [MDCFloatingButton miniDimension];
  XCTAssertEqualWithAccuracy(CGRectGetWidth(button.frame), miniDimension, FLT_EPSILON);
  XCTAssertEqualWithAccuracy(CGRectGetHeight(button.frame), miniDimension, FLT_EPSILON);
}

- (void)testSizeChangeWhenChangingShapeFromMiniToDefault {
  // Given
  MDCFloatingButton *button =
      [MDCFloatingButton floatingButtonWithShape:MDCFloatingButtonShapeMini];
  [button sizeToFit];
  [button layoutIfNeeded];

  // When
  button.shape = MDCFloatingButtonShapeDefault;
  [button sizeToFit];

  // Then
  XCTAssertEqual(button.shape, MDCFloatingButtonShapeDefault);
  CGFloat defaultDimension = [MDCFloatingButton defaultDimension];
  XCTAssertEqualWithAccuracy(CGRectGetWidth(button.frame), defaultDimension, FLT_EPSILON);
  XCTAssertEqualWithAccuracy(CGRectGetHeight(button.frame), defaultDimension, FLT_EPSILON);
}

#pragma mark - setCenterVisibleArea:forShape:inMode:

- (void)testDefaultCenterVisibleAreaValues {
  // Given
  MDCFloatingButton *defaultButtonNormal =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeDefault];
  MDCFloatingButton *defaultButtonExpanded =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeDefault];
  defaultButtonExpanded.mode = MDCFloatingButtonModeExpanded;
  MDCFloatingButton *miniButtonNormal =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];
  MDCFloatingButton *miniButtonExpanded =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];
  miniButtonExpanded.mode = MDCFloatingButtonModeExpanded;

  // Then
  XCTAssertFalse(defaultButtonNormal.centerVisibleArea);
  XCTAssertFalse(defaultButtonExpanded.centerVisibleArea);
  XCTAssertFalse(miniButtonNormal.centerVisibleArea);
  XCTAssertFalse(miniButtonExpanded.centerVisibleArea);
}

- (void)testSetCenterVisibleAreaForShapeInNormalMode {
  // Given
  MDCFloatingButton *defaultButton = [[MDCFloatingButton alloc] init];  // Default shape
  defaultButton.mode = MDCFloatingButtonModeExpanded;
  MDCFloatingButton *miniButton =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];
  miniButton.mode = MDCFloatingButtonModeExpanded;

  // When
  [defaultButton setCenterVisibleArea:YES
                             forShape:MDCFloatingButtonShapeDefault
                               inMode:MDCFloatingButtonModeNormal];
  defaultButton.mode = MDCFloatingButtonModeNormal;
  [miniButton setCenterVisibleArea:YES
                          forShape:MDCFloatingButtonShapeMini
                            inMode:MDCFloatingButtonModeNormal];
  miniButton.mode = MDCFloatingButtonModeNormal;

  // Then
  XCTAssertTrue(defaultButton.centerVisibleArea);
  XCTAssertTrue(miniButton.centerVisibleArea);
}

- (void)testSetCenterVisibleAreaForShapeInExpandedMode {
  // Given
  MDCFloatingButton *defaultButton = [[MDCFloatingButton alloc] init];  // Default shape
  MDCFloatingButton *miniButton =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];

  // When
  [defaultButton setCenterVisibleArea:YES
                             forShape:MDCFloatingButtonShapeDefault
                               inMode:MDCFloatingButtonModeExpanded];
  defaultButton.mode = MDCFloatingButtonModeExpanded;
  [miniButton setCenterVisibleArea:YES
                          forShape:MDCFloatingButtonShapeMini
                            inMode:MDCFloatingButtonModeExpanded];
  miniButton.mode = MDCFloatingButtonModeExpanded;

  // Then
  XCTAssertTrue(defaultButton.centerVisibleArea);
  XCTAssertTrue(miniButton.centerVisibleArea);
}

@end
