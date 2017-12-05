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

@interface FloatingButtonsTests : XCTestCase
@end

@implementation FloatingButtonsTests

#pragma mark - setHitAreaInsets:forShape:inMode:

- (void)testDefaultHitAreaInsetsValues {
  // Given
  MDCFloatingButton *defaultButtonNormal =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeDefault];
  MDCFloatingButton *defaultButtonExpanded =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeDefault];
  defaultButtonExpanded.mdc_expandedMode = MDCFloatingButtonExpandedModeExpanded;
  MDCFloatingButton *miniButtonNormal =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];
  MDCFloatingButton *miniButtonExpanded =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];
  miniButtonExpanded.mdc_expandedMode = MDCFloatingButtonExpandedModeExpanded;

  // Then
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, defaultButtonNormal.hitAreaInsets));
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero,
                                              defaultButtonExpanded.hitAreaInsets));
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsMake(-4, -4, -4, -4),
                                              miniButtonNormal.hitAreaInsets));
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero, miniButtonExpanded.hitAreaInsets));
}

- (void)testSetHitAreaInsetsForShapeInNormalMode {
  // Given
  MDCFloatingButton *defaultButton = [[MDCFloatingButton alloc] init]; // Default shape
  defaultButton.mdc_expandedMode = MDCFloatingButtonExpandedModeExpanded;
  MDCFloatingButton *miniButton =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];
  miniButton.mdc_expandedMode = MDCFloatingButtonExpandedModeExpanded;

  // When
  [defaultButton setHitAreaInsets:UIEdgeInsetsMake(1, 2, 3, 4)
                         forShape:MDCFloatingButtonShapeDefault
                           inMode:MDCFloatingButtonExpandedModeNormal];
  defaultButton.mdc_expandedMode = MDCFloatingButtonExpandedModeNormal;
  [miniButton setHitAreaInsets:UIEdgeInsetsMake(9, 8, 7, 6)
                          forShape:MDCFloatingButtonShapeMini
                            inMode:MDCFloatingButtonExpandedModeNormal];
  miniButton.mdc_expandedMode = MDCFloatingButtonExpandedModeNormal;

  // Then
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsMake(1, 2, 3, 4),
                                              defaultButton.hitAreaInsets));
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsMake(9, 8, 7, 6),
                                              miniButton.hitAreaInsets));
}

- (void)testSetHitAreaInsetsForShapeInExpandedMode {
  // Given
  MDCFloatingButton *defaultButton = [[MDCFloatingButton alloc] init]; // Default shape
  MDCFloatingButton *miniButton =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];

  // When
  [defaultButton setHitAreaInsets:UIEdgeInsetsMake(1, 2, 3, 4)
                         forShape:MDCFloatingButtonShapeDefault
                           inMode:MDCFloatingButtonExpandedModeExpanded];
  defaultButton.mdc_expandedMode = MDCFloatingButtonExpandedModeExpanded;
  [miniButton setHitAreaInsets:UIEdgeInsetsMake(9, 8, 7, 6)
                      forShape:MDCFloatingButtonShapeMini
                        inMode:MDCFloatingButtonExpandedModeExpanded];
  miniButton.mdc_expandedMode = MDCFloatingButtonExpandedModeExpanded;

  // Then
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsMake(1, 2, 3, 4),
                                              defaultButton.hitAreaInsets));
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsMake(9, 8, 7, 6),
                                              miniButton.hitAreaInsets));
}

- (void)testChangingHitAreaInsetsWontTriggerResizing {
  // Given
  FakeFloatingButton *button = [[FakeFloatingButton alloc] init]; // Default shape
  [button reset];

  // When
  [button setHitAreaInsets:UIEdgeInsetsMake(17, 21, 25, 29)
                  forShape:MDCFloatingButtonShapeDefault
                    inMode:MDCFloatingButtonExpandedModeNormal];

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
  defaultButtonExpanded.mdc_expandedMode = MDCFloatingButtonExpandedModeExpanded;
  MDCFloatingButton *miniButtonNormal =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];
  MDCFloatingButton *miniButtonExpanded =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];
  miniButtonExpanded.mdc_expandedMode = MDCFloatingButtonExpandedModeExpanded;

  // Then
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero,
                                              defaultButtonNormal.contentEdgeInsets));
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero,
                                              defaultButtonExpanded.contentEdgeInsets));
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsMake(8, 8, 8, 8),
                                              miniButtonNormal.contentEdgeInsets));
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsZero,
                                              miniButtonExpanded.contentEdgeInsets));
}

- (void)testSetContentEdgeInsetsForShapeInNormalMode {
  // Given
  MDCFloatingButton *defaultButton = [[MDCFloatingButton alloc] init]; // Default shape
  defaultButton.mdc_expandedMode = MDCFloatingButtonExpandedModeExpanded;
  MDCFloatingButton *miniButton =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];
  miniButton.mdc_expandedMode = MDCFloatingButtonExpandedModeExpanded;

  // When
  [defaultButton setContentEdgeInsets:UIEdgeInsetsMake(1, 2, 3, 4)
                             forShape:MDCFloatingButtonShapeDefault
                               inMode:MDCFloatingButtonExpandedModeNormal];
  defaultButton.mdc_expandedMode = MDCFloatingButtonExpandedModeNormal;
  [miniButton setContentEdgeInsets:UIEdgeInsetsMake(9, 8, 7, 6)
                          forShape:MDCFloatingButtonShapeMini
                            inMode:MDCFloatingButtonExpandedModeNormal];
  miniButton.mdc_expandedMode = MDCFloatingButtonExpandedModeNormal;

  // Then
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsMake(1, 2, 3, 4),
                                              defaultButton.contentEdgeInsets));
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsMake(9, 8, 7, 6),
                                              miniButton.contentEdgeInsets));
}

- (void)testSetContentEdgeInsetsForShapeInExpandedMode {
  // Given
  MDCFloatingButton *defaultButton = [[MDCFloatingButton alloc] init]; // Default shape
  MDCFloatingButton *miniButton =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];

  // When
  [defaultButton setContentEdgeInsets:UIEdgeInsetsMake(1, 2, 3, 4)
                             forShape:MDCFloatingButtonShapeDefault
                               inMode:MDCFloatingButtonExpandedModeExpanded];
  defaultButton.mdc_expandedMode = MDCFloatingButtonExpandedModeExpanded;
  [miniButton setContentEdgeInsets:UIEdgeInsetsMake(9, 8, 7, 6)
                          forShape:MDCFloatingButtonShapeMini
                            inMode:MDCFloatingButtonExpandedModeExpanded];
  miniButton.mdc_expandedMode = MDCFloatingButtonExpandedModeExpanded;

  // Then
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsMake(1, 2, 3, 4),
                                              defaultButton.contentEdgeInsets));
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(UIEdgeInsetsMake(9, 8, 7, 6),
                                              miniButton.contentEdgeInsets));
}

- (void)testSettingContentEdgeInsetsInvalidatesIntrinsicContentSize {
  // Given
  FakeFloatingButton *button = [[FakeFloatingButton alloc] init]; // Default shape
  [button reset];

  // When
  [button setContentEdgeInsets:UIEdgeInsetsMake(9, 8, 7, 7)
                      forShape:MDCFloatingButtonShapeDefault
                        inMode:MDCFloatingButtonExpandedModeNormal];

  // Then
  XCTAssertFalse(button.intrinsicContentSizeCalled);
  XCTAssertTrue(button.invalidateIntrinsicContentSizeCalled);
  XCTAssertFalse(button.sizeThatFitsCalled);
  XCTAssertFalse(button.layoutSubviewsCalled);
}

#pragma mark - setMaximumSize:forShape:inMode:

- (void)testDefaultMaximumSizeForShapeInNormalModeSizeToFit {
  // Given
  MDCFloatingButton *defaultButton = [[MDCFloatingButton alloc] init]; // Default shape
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
  defaultButton.mdc_expandedMode = MDCFloatingButtonExpandedModeExpanded;

  // When
  [defaultButton sizeToFit];

  // Then
  XCTAssertLessThanOrEqual(defaultButton.bounds.size.width, 328);
}

- (void)testSetMaximumSizeForShapeInModeNormal {
  // Given
  MDCFloatingButton *defaultButton = [[MDCFloatingButton alloc] init]; // Default shape
  [defaultButton setTitle:@"a very long title" forState:UIControlStateNormal];
  defaultButton.mdc_expandedMode = MDCFloatingButtonExpandedModeExpanded;
  MDCFloatingButton *miniButton =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];
  [miniButton setTitle:@"a very long title" forState:UIControlStateNormal];
  miniButton.mdc_expandedMode = MDCFloatingButtonExpandedModeExpanded;

  // When
  [defaultButton setMaximumSize:CGSizeMake(100, 50)
                       forShape:MDCFloatingButtonShapeDefault
                         inMode:MDCFloatingButtonExpandedModeNormal];
  defaultButton.mdc_expandedMode = MDCFloatingButtonExpandedModeNormal;
  [miniButton setMaximumSize:CGSizeMake(100, 50)
                    forShape:MDCFloatingButtonShapeMini
                      inMode:MDCFloatingButtonExpandedModeNormal];
  miniButton.mdc_expandedMode = MDCFloatingButtonExpandedModeNormal;

  // Then
  XCTAssertLessThanOrEqual(defaultButton.bounds.size.width, 100);
  XCTAssertLessThanOrEqual(defaultButton.bounds.size.height, 50);
  XCTAssertLessThanOrEqual(miniButton.bounds.size.width, 100);
  XCTAssertLessThanOrEqual(miniButton.bounds.size.height, 50);
}

- (void)testSetMaximumSizeForShapeInModeExpanded {
  // Given
  MDCFloatingButton *defaultButton = [[MDCFloatingButton alloc] init]; // Default shape
  [defaultButton setTitle:@"An even longer title that should require more than 328 points to render"
                 forState:UIControlStateNormal];
  MDCFloatingButton *miniButton =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];
  [miniButton setTitle:@"An even longer title that should require more than 328 points to render"
              forState:UIControlStateNormal];

  // When
  [defaultButton setMaximumSize:CGSizeMake(50, 100)
                       forShape:MDCFloatingButtonShapeDefault
                         inMode:MDCFloatingButtonExpandedModeExpanded];
  defaultButton.mdc_expandedMode = MDCFloatingButtonExpandedModeExpanded;
  [miniButton setMaximumSize:CGSizeMake(50, 100)
                    forShape:MDCFloatingButtonShapeMini
                      inMode:MDCFloatingButtonExpandedModeExpanded];
  miniButton.mdc_expandedMode = MDCFloatingButtonExpandedModeExpanded;

  // Then
  XCTAssertLessThanOrEqual(defaultButton.bounds.size.width, 50);
  XCTAssertLessThanOrEqual(defaultButton.bounds.size.height, 100);
  XCTAssertLessThanOrEqual(miniButton.bounds.size.width, 50);
  XCTAssertLessThanOrEqual(miniButton.bounds.size.height, 100);
}

- (void)testSettingMaximumSizeInvalidatesIntrinsicContentSize {
  // Given
  FakeFloatingButton *button = [[FakeFloatingButton alloc] init]; // Default shape
  [button reset];

  // When
  [button setMaximumSize:CGSizeMake(7, 7)
                forShape:MDCFloatingButtonShapeDefault
                  inMode:MDCFloatingButtonExpandedModeNormal];

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
  defaultButton.mdc_expandedMode = MDCFloatingButtonExpandedModeExpanded;

  // When
  [defaultButton sizeToFit];

  // Then
  XCTAssertGreaterThanOrEqual(defaultButton.bounds.size.width, 132);
  XCTAssertGreaterThanOrEqual(defaultButton.bounds.size.height, 48);
}

- (void)testSetMinimumSizeForShapeInModeNormal {
  // Given
  MDCFloatingButton *defaultButton = [[MDCFloatingButton alloc] init]; // Default shape
  defaultButton.mdc_expandedMode = MDCFloatingButtonExpandedModeExpanded;
  MDCFloatingButton *miniButton =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];
  miniButton.mdc_expandedMode = MDCFloatingButtonExpandedModeExpanded;

  // When
  [defaultButton setMinimumSize:CGSizeMake(100, 50)
                       forShape:MDCFloatingButtonShapeDefault
                         inMode:MDCFloatingButtonExpandedModeNormal];
  [defaultButton setMaximumSize:CGSizeZero
                       forShape:MDCFloatingButtonShapeDefault
                         inMode:MDCFloatingButtonExpandedModeNormal];
  defaultButton.mdc_expandedMode = MDCFloatingButtonExpandedModeNormal;
  [defaultButton sizeToFit];

  [miniButton setMinimumSize:CGSizeMake(100, 50)
                    forShape:MDCFloatingButtonShapeMini
                      inMode:MDCFloatingButtonExpandedModeNormal];
  [miniButton setMaximumSize:CGSizeZero
                    forShape:MDCFloatingButtonShapeMini
                      inMode:MDCFloatingButtonExpandedModeNormal];
  miniButton.mdc_expandedMode = MDCFloatingButtonExpandedModeNormal;
  [miniButton sizeToFit];

  // Then
  XCTAssertGreaterThanOrEqual(defaultButton.bounds.size.width, 100);
  XCTAssertGreaterThanOrEqual(defaultButton.bounds.size.height, 50);
  XCTAssertGreaterThanOrEqual(miniButton.bounds.size.width, 100);
  XCTAssertGreaterThanOrEqual(miniButton.bounds.size.height, 50);
}

- (void)testSetMinimumSizeForShapeInModeExpanded {
  // Given
  MDCFloatingButton *defaultButton = [[MDCFloatingButton alloc] init]; // Default shape
  MDCFloatingButton *miniButton =
      [[MDCFloatingButton alloc] initWithFrame:CGRectZero shape:MDCFloatingButtonShapeMini];

  // When
  [defaultButton setMinimumSize:CGSizeMake(50, 100)
                       forShape:MDCFloatingButtonShapeDefault
                         inMode:MDCFloatingButtonExpandedModeExpanded];
  defaultButton.mdc_expandedMode = MDCFloatingButtonExpandedModeExpanded;
  [defaultButton sizeToFit];

  [miniButton setMinimumSize:CGSizeMake(50, 100)
                    forShape:MDCFloatingButtonShapeMini
                      inMode:MDCFloatingButtonExpandedModeExpanded];
  miniButton.mdc_expandedMode = MDCFloatingButtonExpandedModeExpanded;
  [miniButton sizeToFit];

  // Then
  XCTAssertGreaterThanOrEqual(defaultButton.bounds.size.width, 50);
  XCTAssertGreaterThanOrEqual(defaultButton.bounds.size.height, 100);
  XCTAssertGreaterThanOrEqual(miniButton.bounds.size.width, 50);
  XCTAssertGreaterThanOrEqual(miniButton.bounds.size.height, 100);
}

- (void)testSettingMinimumSizeInvalidatesIntrinsicContentSize {
  // Given
  FakeFloatingButton *button = [[FakeFloatingButton alloc] init]; // Default shape
  [button reset];

  // When
  [button setMinimumSize:CGSizeMake(12, 12)
                forShape:MDCFloatingButtonShapeDefault
                  inMode:MDCFloatingButtonExpandedModeNormal];

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
  button.mdc_expandedMode = MDCFloatingButtonExpandedModeExpanded;
  [button setTitle:@"A very long title that can never fit" forState:UIControlStateNormal];
  [button setImage:[UIImage imageNamed:@"Plus"] forState:UIControlStateNormal];
  [button setMaximumSize:CGSizeMake(100, 48)
                forShape:MDCFloatingButtonShapeDefault
                  inMode:MDCFloatingButtonExpandedModeExpanded];
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

- (void)testExpandedLayoutWithNonZeroContentEdgeInsets {
  // Given
  MDCFloatingButton *button = [[MDCFloatingButton alloc] initWithFrame:CGRectZero
                                                                 shape:MDCFloatingButtonShapeMini];
  button.mdc_expandedMode = MDCFloatingButtonExpandedModeExpanded;
  [button setTitle:@"A very long title that can never fit" forState:UIControlStateNormal];
  [button setImage:[UIImage imageNamed:@"Plus"] forState:UIControlStateNormal];
  [button setMinimumSize:CGSizeMake(100, 48)
                forShape:MDCFloatingButtonShapeMini
                  inMode:MDCFloatingButtonExpandedModeExpanded];
  [button setMaximumSize:CGSizeMake(100, 48)
                forShape:MDCFloatingButtonShapeMini
                  inMode:MDCFloatingButtonExpandedModeExpanded];
  [button setContentEdgeInsets:UIEdgeInsetsMake(4, -4, 8, -8)
                      forShape:MDCFloatingButtonShapeMini
                        inMode:MDCFloatingButtonExpandedModeExpanded];

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

#pragma mark - Encoding/decoding

- (void)testEncoding {
  // Given
  MDCFloatingButton *button = [[MDCFloatingButton alloc] initWithFrame:CGRectMake(1, 2, 3, 4)
                                                                 shape:MDCFloatingButtonShapeMini];
  button.mdc_expandedMode = MDCFloatingButtonExpandedModeExpanded;
  button.imageLocation = MDCFloatingButtonImageLocationTrailing;
  [button setImage:[UIImage imageNamed:@"Plus"] forState:UIControlStateNormal];
  [button setTitle:@"Title" forState:UIControlStateNormal];
  [button setMinimumSize:CGSizeMake(75, 37)
                forShape:MDCFloatingButtonShapeMini
                  inMode:MDCFloatingButtonExpandedModeExpanded];
  [button setMaximumSize:CGSizeMake(99, 65)
                forShape:MDCFloatingButtonShapeMini
                  inMode:MDCFloatingButtonExpandedModeExpanded];
  [button setContentEdgeInsets:UIEdgeInsetsMake(5, 3, 1, 7)
                      forShape:MDCFloatingButtonShapeMini
                        inMode:MDCFloatingButtonExpandedModeExpanded];
  [button setHitAreaInsets:UIEdgeInsetsMake(8, 6, 4, 2)
                  forShape:MDCFloatingButtonShapeMini
                    inMode:MDCFloatingButtonExpandedModeExpanded];

  // When
  NSData *archivedData = [NSKeyedArchiver archivedDataWithRootObject:button];
  MDCFloatingButton *unarchivedButton = [NSKeyedUnarchiver unarchiveObjectWithData:archivedData];
  [button sizeToFit];
  [button layoutIfNeeded];
  [unarchivedButton sizeToFit];
  [unarchivedButton layoutIfNeeded];

  // Then
  XCTAssertTrue(CGRectEqualToRect(button.bounds, unarchivedButton.bounds),
                @"Unarchived bounds did not match original button's bounds.\nExpected: %@\n"
                 "Received: %@",NSStringFromCGRect(button.bounds),
                NSStringFromCGRect(unarchivedButton.bounds));
  XCTAssertEqual(button.mdc_expandedMode, unarchivedButton.mdc_expandedMode);
  XCTAssertEqual(button.imageLocation, unarchivedButton.imageLocation);
  XCTAssertEqualObjects(button.currentTitle, unarchivedButton.currentTitle);
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(button.contentEdgeInsets,
                                              unarchivedButton.contentEdgeInsets));
  XCTAssertTrue(UIEdgeInsetsEqualToEdgeInsets(button.hitAreaInsets,
                                              unarchivedButton.hitAreaInsets));
  XCTAssertTrue(CGSizeEqualToSize(button.minimumSize, unarchivedButton.minimumSize));
  XCTAssertTrue(CGSizeEqualToSize(button.maximumSize, unarchivedButton.maximumSize));
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
  CGFloat dimension = [MDCFloatingButton defaultDimension];
  XCTAssertTrue(CGRectEqualToRect(unarchivedButton.bounds, CGRectMake(0, 0, dimension, dimension)));
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

@end
