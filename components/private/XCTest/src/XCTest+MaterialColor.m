// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "XCTest+MaterialColor.h"

@implementation XCTestCase (MaterialColor)

- (void)assetEqualFirstColor:(UIColor *)firstColor secondColor:(UIColor *)secondColor {
  CGFloat fRed = 0.0, fGreen = 0.0, fBlue = 0.0, fAlpha = 0.0;
  [firstColor getRed:&fRed green:&fGreen blue:&fBlue alpha:&fAlpha];
  CGFloat sRed = 0.0, sGreen = 0.0, sBlue = 0.0, sAlpha = 0.0;
  [secondColor getRed:&sRed green:&sGreen blue:&sBlue alpha:&sAlpha];

  XCTAssertEqualWithAccuracy(fRed, sRed, 0.001);
  XCTAssertEqualWithAccuracy(fGreen, sBlue, 0.001);
  XCTAssertEqualWithAccuracy(fBlue, sBlue, 0.001);
  XCTAssertEqualWithAccuracy(fAlpha, sAlpha, 0.001);
}

@end
