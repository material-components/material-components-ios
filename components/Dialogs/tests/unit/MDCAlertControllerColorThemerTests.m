/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MaterialDialogs.h"
#import "MDCAlertColorThemer.h"

#import "MDCAlertControllerView+Private.h"

#import <XCTest/XCTest.h>

@interface MDCAlertControllerColorThemerTests : XCTestCase

@end

@implementation MDCAlertControllerColorThemerTests

- (void)testApplyingTypographyScheme {
  MDCAlertController *alert = [MDCAlertController alertControllerWithTitle:@"title"
                                                                   message:@"message"];
  MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
  [MDCAlertColorThemer applySemanticColorScheme:colorScheme toAlertController:alert];

  MDCAlertControllerView *view = (MDCAlertControllerView *)alert.view;
  XCTAssertEqual(view.titleLabel.textColor,
                 [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.87]);
  XCTAssertEqual(view.messageLabel.textColor,
                 [colorScheme.onSurfaceColor colorWithAlphaComponent:(CGFloat)0.60]);
  for (UIButton *button in view.actionButtons) {
    XCTAssertEqual(button.titleLabel.textColor, colorScheme.primaryColor);
  }
}

@end
