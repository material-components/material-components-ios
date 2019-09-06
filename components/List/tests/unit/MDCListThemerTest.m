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

#import "MaterialList+ColorThemer.h"
#import "MaterialList+ListThemer.h"
#import "MaterialList+TypographyThemer.h"
#import "MaterialList.h"

#import <XCTest/XCTest.h>

#ifndef CGFLOAT_EPSILON
#if CGFLOAT_IS_DOUBLE
#define CGFLOAT_EPSILON DBL_EPSILON
#else
#define CGFLOAT_EPSILON FLT_EPSILON
#endif
#endif

static const CGFloat kHighAlpha = 0.87f;
static const CGFloat kInkAlpha = 0.16f;

@interface MDCListThemerTests : XCTestCase

@end

@implementation MDCListThemerTests

- (BOOL)color1:(UIColor *)color1 equalsColor2:(UIColor *)color2 {
  CGFloat red1 = 0;
  CGFloat green1 = 0;
  CGFloat blue1 = 0;
  CGFloat alpha1 = 0;
  [color1 getRed:&red1 green:&green1 blue:&blue1 alpha:&alpha1];
  CGFloat red2 = 0;
  CGFloat green2 = 0;
  CGFloat blue2 = 0;
  CGFloat alpha2 = 0;
  [color2 getRed:&red2 green:&green2 blue:&blue2 alpha:&alpha2];
  return (fabs(red1 - red2) < CGFLOAT_EPSILON && fabs(green1 - green2) < CGFLOAT_EPSILON &&
          fabs(blue1 - blue2) < CGFLOAT_EPSILON && fabs(alpha1 - alpha2) < CGFLOAT_EPSILON);
}

- (void)testApplyingListSchemeToSelfSizingStereoCell {
  MDCSelfSizingStereoCell *cell = [[MDCSelfSizingStereoCell alloc] initWithFrame:CGRectZero];
  MDCListScheme *scheme = [[MDCListScheme alloc] init];
  [MDCListThemer applyScheme:scheme toSelfSizingStereoCell:cell];

  XCTAssertEqualObjects(cell.titleLabel.font, scheme.typographyScheme.subtitle1);
  XCTAssertEqualObjects(cell.detailLabel.font, scheme.typographyScheme.body2);

  XCTAssertTrue([self
            color1:cell.titleLabel.textColor
      equalsColor2:[scheme.colorScheme.onSurfaceColor colorWithAlphaComponent:kHighAlpha]]);
  XCTAssertTrue([self
            color1:cell.detailLabel.textColor
      equalsColor2:[scheme.colorScheme.onSurfaceColor colorWithAlphaComponent:kHighAlpha]]);
  XCTAssertTrue([self
            color1:cell.leadingImageView.tintColor
      equalsColor2:[scheme.colorScheme.onSurfaceColor colorWithAlphaComponent:kHighAlpha]]);
  XCTAssertTrue([self
            color1:cell.trailingImageView.tintColor
      equalsColor2:[scheme.colorScheme.onSurfaceColor colorWithAlphaComponent:kHighAlpha]]);
  XCTAssertTrue([self
            color1:cell.inkColor
      equalsColor2:[scheme.colorScheme.onSurfaceColor colorWithAlphaComponent:kInkAlpha]]);
}

- (void)testApplyingListSchemeToBaseCell {
  MDCBaseCell *cell = [[MDCBaseCell alloc] initWithFrame:CGRectZero];
  MDCListScheme *scheme = [[MDCListScheme alloc] init];
  [MDCListThemer applyScheme:scheme toBaseCell:cell];

  XCTAssertTrue([self
            color1:cell.inkColor
      equalsColor2:[scheme.colorScheme.onSurfaceColor colorWithAlphaComponent:kInkAlpha]]);
}

@end
