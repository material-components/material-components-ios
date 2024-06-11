// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialIcons+ic_arrow_back.h"
#import "MaterialIcons+ic_check.h"
#import "MaterialIcons+ic_check_circle.h"
#import "MaterialIcons+ic_chevron_right.h"
#import "MaterialIcons+ic_color_lens.h"
#import "MaterialIcons+ic_help_outline.h"
#import "MaterialIcons+ic_info.h"
#import "MaterialIcons+ic_more_horiz.h"
#import "MaterialIcons+ic_radio_button_unchecked.h"
#import "MaterialIcons+ic_reorder.h"
#import "MaterialIcons+ic_settings.h"
#import "MDCIcons+BundleLoader.h"
#import "MDCIcons.h"

@interface MDCIconsTests : XCTestCase
@end

@implementation MDCIconsTests

- (void)testBundleNamed {
  // Given
  NSString *badBundleName = @"someNameThatDoesNotExist";

  // When
  NSBundle *bundle = [MDCIcons bundleNamed:badBundleName];

  // Then
  XCTAssertNil(bundle);
}

- (void)testImageForArrowBackOldStyle {
  // When
  [MDCIcons ic_arrow_backUseNewStyle:NO];

  // Then
  XCTAssertNotNil([MDCIcons imageFor_ic_arrow_back],
                  @"No image was returned for ic_arrow_back (old style)");
}

- (void)testImageForArrowBackNewStyle {
  // When
  [MDCIcons ic_arrow_backUseNewStyle:YES];

  // Then
  XCTAssertNotNil([MDCIcons imageFor_ic_arrow_back],
                  @"No image was returned for ic_arrow_back (new style)");
}

- (void)testImageForCheck {
  XCTAssertNotNil([MDCIcons imageFor_ic_check], @"No image was returned for ic_check");
}

- (void)testImageForCheckCircle {
  XCTAssertNotNil([MDCIcons imageFor_ic_check_circle],
                  @"No image was returned for ic_check_circle");
}

- (void)testImageForColorLens {
  XCTAssertNotNil([MDCIcons imageFor_ic_color_lens], @"No image was returned for ic_color_lens");
}

- (void)testImageForChevronRight {
  XCTAssertNotNil([MDCIcons imageFor_ic_chevron_right],
                  @"No image was returned for ic_chevron_right");
}

- (void)testImageForHelpOutline {
  XCTAssertNotNil([MDCIcons imageFor_ic_help_outline],
                  @"No image was returned for ic_help_outline");
}

- (void)testImageForInfo {
  XCTAssertNotNil([MDCIcons imageFor_ic_info], @"No image was returned for ic_info");
}

- (void)testImageForMoreHoriz {
  XCTAssertNotNil([MDCIcons imageFor_ic_more_horiz], @"No image was returned for ic_more_horiz");
}

- (void)testImageForRadioButtonUnchecked {
  XCTAssertNotNil([MDCIcons imageFor_ic_radio_button_unchecked],
                  @"No image was returned for ic_radio_button_unchecked");
}

- (void)testImageForReorder {
  XCTAssertNotNil([MDCIcons imageFor_ic_reorder], @"No image was returned for ic_reorder");
}

- (void)testImageForSettings {
  XCTAssertNotNil([MDCIcons imageFor_ic_settings], @"No image was returned for ic_settings");
}

@end
