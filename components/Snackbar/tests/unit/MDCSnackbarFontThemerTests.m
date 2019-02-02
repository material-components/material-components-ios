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

#import <XCTest/XCTest.h>

#import "MaterialSnackbar+FontThemer.h"
#import "MaterialSnackbar.h"
#import "MaterialThemes.h"

@interface MDCSnackbarFontThemerTests : XCTestCase
@end

@implementation MDCSnackbarFontThemerTests

- (void)tearDown {
  [MDCSnackbarManager dismissAndCallCompletionBlocksWithCategory:nil];

  [super tearDown];
}

- (void)testSnackbarFontThemerUsingUIAppearance {
  MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
  message.text = @"How much wood would a woodchuck chuck if a woodchuck could chuck wood?";
  [MDCSnackbarManager showMessage:message];
  MDCBasicFontScheme *fontScheme = [[MDCBasicFontScheme alloc] init];
  fontScheme.button = [UIFont boldSystemFontOfSize:12];
  fontScheme.body2 = [UIFont systemFontOfSize:13];
  [MDCSnackbarFontThemer applyFontScheme:fontScheme
                   toSnackbarMessageView:[MDCSnackbarMessageView appearance]];
  XCTAssertEqualObjects([MDCSnackbarMessageView appearance].messageFont, fontScheme.body2);
  XCTAssertEqualObjects([MDCSnackbarMessageView appearance].buttonFont, fontScheme.button);
}

- (void)testSnackbarFontThemer {
  MDCSnackbarMessage *message = [[MDCSnackbarMessage alloc] init];
  message.text = @"How much wood would a woodchuck chuck if a woodchuck could chuck wood?";
  [MDCSnackbarManager showMessage:message];
  MDCBasicFontScheme *fontScheme = [[MDCBasicFontScheme alloc] init];
  fontScheme.button = [UIFont boldSystemFontOfSize:12];
  fontScheme.body2 = [UIFont systemFontOfSize:13];
  [MDCSnackbarFontThemer applyFontScheme:fontScheme];
  XCTAssertEqualObjects(MDCSnackbarManager.messageFont, fontScheme.body2);
  XCTAssertEqualObjects(MDCSnackbarManager.buttonFont, fontScheme.button);
}

@end
