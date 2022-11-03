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

#import "MDCButton.h"
#import "MDCAlertController.h"
#import "MDCAlertControllerView.h"
#import "MDCAlertTypographyThemer.h"

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprivate-header"
#import "MDCAlertActionManager.h"
#import "MDCAlertControllerView+Private.h"
#pragma clang diagnostic pop
#import "MDCTypographyScheme.h"

#import <XCTest/XCTest.h>

NS_ASSUME_NONNULL_BEGIN

@interface MDCAlertControllerTypographyThemerTests : XCTestCase

@end

@implementation MDCAlertControllerTypographyThemerTests

- (void)testApplyingTypographyScheme {
  MDCAlertController *alert = [MDCAlertController alertControllerWithTitle:@"title"
                                                                   message:@"message"];
  MDCTypographyScheme *typographyScheme = [[MDCTypographyScheme alloc] init];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
  [MDCAlertTypographyThemer applyTypographyScheme:typographyScheme toAlertController:alert];
#pragma clang diagnostic pop

  MDCAlertControllerView *view = (MDCAlertControllerView *)alert.view;
  XCTAssertEqualObjects(view.titleLabel.font, typographyScheme.headline6);
  XCTAssertEqualObjects(view.messageTextView.font, typographyScheme.body1);
  for (UIButton *button in view.actionManager.buttonsInActionOrder) {
    XCTAssertEqualObjects(button.titleLabel.font, typographyScheme.button);
  }
}

@end

NS_ASSUME_NONNULL_END
