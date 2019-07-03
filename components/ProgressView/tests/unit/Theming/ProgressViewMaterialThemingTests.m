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

#import <XCTest/XCTest.h>

#import "MaterialProgressView.h"
#import "MaterialProgressView+Theming.h"
#import "MaterialContainerScheme.h"

@interface MDCProgressView (DefaultTrackTintColor)
+ (UIColor *)defaultTrackTintColorForProgressTintColor:(UIColor *)progressTintColor;
@end

@interface ProgressViewMaterialThemingTests : XCTestCase
@property (strong, nonatomic) MDCProgressView *progressView;
@end

@implementation ProgressViewMaterialThemingTests

- (void)setUp {
  [super setUp];
  self.progressView = [[MDCProgressView alloc] initWithFrame:CGRectZero];
}

- (void)tearDown {
  self.progressView = nil;
  [super tearDown];
}

#pragma mark - Tests

- (void)testProgressViewMaterialTheming {
  MDCContainerScheme *scheme = [[MDCContainerScheme alloc] init];
  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  scheme.colorScheme = colorScheme;

  // When
  [self.progressView applyThemeWithScheme:scheme];

  // Then
  // Test Colors
  XCTAssertEqualObjects(self.progressView.trackTintColor, [MDCProgressView defaultTrackTintColorForProgressTintColor:colorScheme.primaryColor]);
  XCTAssertEqualObjects(self.progressView.progressTintColor, colorScheme.primaryColor);
}

@end
