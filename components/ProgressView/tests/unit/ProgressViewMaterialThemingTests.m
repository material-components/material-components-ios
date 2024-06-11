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

#import <CoreGraphics/CoreGraphics.h>
#import <XCTest/XCTest.h>

#import "MDCProgressView.h"
#import "MDCProgressView+MaterialTheming.h"
#import "MDCSemanticColorScheme.h"
#import "MDCContainerScheme.h"

// The ratio by which to desaturate the progress tint color to obtain the default track tint color.
static const CGFloat MDCProgressViewTrackColorDesaturation = (CGFloat)0.3;

@interface ProgressViewMaterialThemingTests : XCTestCase
@property(strong, nonatomic) MDCProgressView *progressView;
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

- (MDCSemanticColorScheme *)defaultColorScheme {
  return [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
}

- (MDCSemanticColorScheme *)customColorScheme {
  MDCSemanticColorScheme *defaultColorScheme = [self defaultColorScheme];
  defaultColorScheme.primaryColor = [UIColor blueColor];
  return defaultColorScheme;
}

- (void)testProgressViewMaterialTheming {
  MDCContainerScheme *scheme = [[MDCContainerScheme alloc] init];
  scheme.colorScheme = [self defaultColorScheme];

  // When
  [self.progressView applyThemeWithScheme:scheme];

  // Then
  // Test Colors
  XCTAssertEqualObjects(
      self.progressView.trackTintColor,
      [self
          mdcThemingTestDefaultTrackTintColorForProgressTintColor:scheme.colorScheme.primaryColor]);
  XCTAssertEqualObjects(self.progressView.progressTintColor, scheme.colorScheme.primaryColor);
}

- (void)testProgressViewMaterialThemingWithACustomColorScheme {
  MDCContainerScheme *scheme = [[MDCContainerScheme alloc] init];
  scheme.colorScheme = [self customColorScheme];

  // When
  [self.progressView applyThemeWithScheme:scheme];

  // Then
  // Test Colors
  XCTAssertEqualObjects(
      self.progressView.trackTintColor,
      [self
          mdcThemingTestDefaultTrackTintColorForProgressTintColor:scheme.colorScheme.primaryColor]);
  XCTAssertEqualObjects(self.progressView.progressTintColor, scheme.colorScheme.primaryColor);
}

- (UIColor *)mdcThemingTestDefaultTrackTintColorForProgressTintColor:(UIColor *)progressTintColor {
  CGFloat hue, saturation, brightness, alpha;
  if ([progressTintColor getHue:&hue saturation:&saturation brightness:&brightness alpha:&alpha]) {
    CGFloat newSaturation = MIN(saturation * MDCProgressViewTrackColorDesaturation, 1);
    return [UIColor colorWithHue:hue saturation:newSaturation brightness:brightness alpha:alpha];
  }
  return [UIColor clearColor];
}

@end
