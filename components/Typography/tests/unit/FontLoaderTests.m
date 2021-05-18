// Copyright 2021-present the Material Components for iOS authors. All Rights Reserved.
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
#import "MDCTypographyFontLoader.h"
#import "MaterialTypography.h"

@interface FontLoaderTests : XCTestCase

@end

/** This font loader is for Bodoni Ornaments and is for testing setting a custom font loader */
@interface BodoniOrnamentsCustomFontLoader : NSObject <MDCTypographyFontLoading>
@end

@implementation BodoniOrnamentsCustomFontLoader

- (UIFont *)lightFontOfSize:(CGFloat)fontSize {
  return [UIFont fontWithName:@"Bodoni Ornaments" size:fontSize];
}

- (UIFont *)regularFontOfSize:(CGFloat)fontSize {
  return [UIFont fontWithName:@"Bodoni Ornaments" size:fontSize];
}

- (UIFont *)mediumFontOfSize:(CGFloat)fontSize {
  return [UIFont fontWithName:@"Bodoni Ornaments" size:fontSize];
}

@end

@implementation FontLoaderTests

- (void)testFontLoader {
  // Given
  BodoniOrnamentsCustomFontLoader *fontLoader = [[BodoniOrnamentsCustomFontLoader alloc] init];
  [MDCTypography setFontLoader:fontLoader];

  // When
  UIFont *font = [MDCTypography buttonFont];

  // Then
  XCTAssertTrue([font.fontName isEqualToString:@"BodoniOrnamentsITCTT"]);

  // Cleanup
  [MDCTypography setFontLoader:[[MDCSystemFontLoader alloc] init]];
}

@end
