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

#import "MaterialInk.h"

#pragma mark - Fake classes

@interface FakeMDCInkViewAnimationDelegate : NSObject <MDCInkViewDelegate, NSCoding>
@property(nonatomic, strong) MDCInkView *inkView;
@end

@implementation FakeMDCInkViewAnimationDelegate

- (void)encodeWithCoder:(nonnull NSCoder *)aCoder {
  [aCoder encodeObject:self.inkView forKey:@"inkView"];
}

- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    _inkView = [aDecoder decodeObjectForKey:@"inkView"];
  }
  return self;
}

@end

#pragma mark - Tests

@interface MDCInkViewTests : XCTestCase

@end

@implementation MDCInkViewTests

- (void)testInit {
  // Given
  MDCInkView *inkView = [[MDCInkView alloc] init];

  // Then
  XCTAssertTrue(inkView.usesLegacyInkRipple);
  XCTAssertFalse(inkView.usesCustomInkCenter);
  XCTAssertTrue(CGPointEqualToPoint(inkView.customInkCenter, CGPointZero),
                @"%@ is not equal to %@",
                NSStringFromCGPoint(inkView.customInkCenter),
                NSStringFromCGPoint(CGPointZero));
  XCTAssertNil(inkView.animationDelegate);
  XCTAssertEqualObjects(inkView.inkColor, inkView.defaultInkColor);
  XCTAssertEqual(inkView.inkStyle, MDCInkStyleBounded);
  XCTAssertEqualWithAccuracy(inkView.maxRippleRadius, 0.0, 0.0001);
}

- (void)testEncodingWithoutLegacyInk {
  // Given
  FakeMDCInkViewAnimationDelegate *delegate = [[FakeMDCInkViewAnimationDelegate alloc] init];
  MDCInkView *inkView = [[MDCInkView alloc] init];
  delegate.inkView = inkView;
  inkView.usesLegacyInkRipple = NO;
  inkView.usesCustomInkCenter = YES;
  inkView.customInkCenter = CGPointMake(5,8);
  inkView.animationDelegate = delegate;
  inkView.inkColor = UIColor.purpleColor;
  inkView.inkStyle = MDCInkStyleUnbounded;
  inkView.maxRippleRadius = (CGFloat)9.1;

  // When
  NSData *archive = [NSKeyedArchiver archivedDataWithRootObject:delegate];
  FakeMDCInkViewAnimationDelegate *unarchivedDelegate =
      [NSKeyedUnarchiver unarchiveObjectWithData:archive];
  MDCInkView *unarchivedInkView = unarchivedDelegate.inkView;

  // Then
  XCTAssertEqual(unarchivedInkView.usesLegacyInkRipple, inkView.usesLegacyInkRipple);
  XCTAssertEqual(unarchivedInkView.usesCustomInkCenter, inkView.usesCustomInkCenter);
  XCTAssertTrue(CGPointEqualToPoint(unarchivedInkView.customInkCenter, inkView.customInkCenter),
                @"%@ is not equal to %@",
                NSStringFromCGPoint(unarchivedInkView.customInkCenter),
                NSStringFromCGPoint(inkView.customInkCenter));
  XCTAssertEqual(unarchivedInkView.animationDelegate, unarchivedDelegate);
  XCTAssertEqualObjects(unarchivedInkView.inkColor, inkView.inkColor);
  XCTAssertEqual(unarchivedInkView.inkStyle, inkView.inkStyle);
  XCTAssertEqualWithAccuracy(unarchivedInkView.maxRippleRadius, inkView.maxRippleRadius, 0.0001);
}

- (void)testEncodingWithLegacyInk {
  // Given
  FakeMDCInkViewAnimationDelegate *delegate = [[FakeMDCInkViewAnimationDelegate alloc] init];
  MDCInkView *inkView = [[MDCInkView alloc] init];
  delegate.inkView = inkView;
  inkView.usesLegacyInkRipple = YES;
  inkView.usesCustomInkCenter = YES;
  inkView.customInkCenter = CGPointMake(5,8);
  inkView.animationDelegate = delegate;
  inkView.inkColor = UIColor.purpleColor;
  inkView.inkStyle = MDCInkStyleUnbounded;
  inkView.maxRippleRadius = (CGFloat)9.1;

  // When
  NSData *archive = [NSKeyedArchiver archivedDataWithRootObject:delegate];
  FakeMDCInkViewAnimationDelegate *unarchivedDelegate =
      [NSKeyedUnarchiver unarchiveObjectWithData:archive];
  MDCInkView *unarchivedInkView = unarchivedDelegate.inkView;

  // Then
  XCTAssertEqual(unarchivedInkView.usesLegacyInkRipple, inkView.usesLegacyInkRipple);
  XCTAssertEqual(unarchivedInkView.usesCustomInkCenter, inkView.usesCustomInkCenter);
  XCTAssertTrue(CGPointEqualToPoint(unarchivedInkView.customInkCenter, inkView.customInkCenter),
                @"%@ is not equal to %@",
                NSStringFromCGPoint(unarchivedInkView.customInkCenter),
                NSStringFromCGPoint(inkView.customInkCenter));
  XCTAssertEqual(unarchivedInkView.animationDelegate, unarchivedDelegate);
  XCTAssertEqualObjects(unarchivedInkView.inkColor, inkView.inkColor);
  XCTAssertEqual(unarchivedInkView.inkStyle, inkView.inkStyle);
  XCTAssertEqualWithAccuracy(unarchivedInkView.maxRippleRadius, inkView.maxRippleRadius, 0.0001);
}

@end
