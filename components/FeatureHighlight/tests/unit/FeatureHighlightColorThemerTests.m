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


#import "MaterialFeatureHighlight.h"
#import "MaterialFeatureHighlight+ColorThemer.h"

#import <XCTest/XCTest.h>

@interface FeatureHighlightColorThemerTests : XCTestCase
@property (nonatomic, strong) UIView *highlightedView;
@property (nonatomic, strong) UIView *showView;
@end

@implementation FeatureHighlightColorThemerTests

- (void)setUp {
  [super setUp];
  self.showView = [[UIView alloc] init];
  self.highlightedView = [[UIView alloc] init];
  [self.showView addSubview:self.highlightedView];
}

- (void)tearDown {
  [super tearDown];
  self.showView = nil;
  self.highlightedView = nil;
}

- (void)testFeaturehighlightSemanticColorThemer {
  MDCFeatureHighlightViewController *featureHighlightViewController =
      [[MDCFeatureHighlightViewController alloc] initWithHighlightedView:self.highlightedView
                                                             andShowView:self.showView
                                                              completion:nil];
  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
  [MDCFeatureHighlightColorThemer applySemanticColorScheme:colorScheme
                          toFeatureHighlightViewController:featureHighlightViewController];
  XCTAssertEqualObjects(featureHighlightViewController.titleColor, colorScheme.onPrimaryColor);
  XCTAssertEqualObjects(featureHighlightViewController.bodyColor, colorScheme.onPrimaryColor);
  XCTAssertEqualObjects(featureHighlightViewController.innerHighlightColor,
                        colorScheme.surfaceColor);
  XCTAssertEqualObjects(featureHighlightViewController.outerHighlightColor,
                        colorScheme.primaryColor);
}

@end
