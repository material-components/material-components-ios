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

#import "MDCAvailability.h"
#import "MDCOverlayWindow.h"

@interface MockOverlayWindow : MDCOverlayWindow

@property(nonatomic) BOOL commonInitCalled;

- (void)commonInit;

@end

@implementation MockOverlayWindow

- (void)commonInit {
  self.commonInitCalled = YES;
}

@end

@interface OverlayWindowInitTest : XCTestCase
@end

@implementation OverlayWindowInitTest

- (void)testInitCallsCommonInit {
  // When
  MockOverlayWindow *window = [[MockOverlayWindow alloc] init];

  // Then
  XCTAssertTrue(window.commonInitCalled);
}

- (void)testInitWithFrameCallsCommonInit {
  // When
  MockOverlayWindow *window = [[MockOverlayWindow alloc] initWithFrame:CGRectZero];

  // Then
  XCTAssertTrue(window.commonInitCalled);
}

- (void)testInitWithCoderCallsCommonInit {
  // Given
  NSMutableData *archiverData = [[NSMutableData alloc] init];
  NSKeyedUnarchiver *archiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:archiverData];

  // When
  MockOverlayWindow *window = [[MockOverlayWindow alloc] initWithCoder:archiver];

  // Then
  XCTAssertTrue(window.commonInitCalled);
}

- (void)testInitWithWindowSceneCallsCommonInit {
#if MDC_AVAILABLE_SDK_IOS(13_0)
  if (@available(iOS 13.0, *)) {
    // Given
    UIWindowScene *scene = nil;

    // When
    MockOverlayWindow *window = [[MockOverlayWindow alloc] initWithWindowScene:scene];

    // Then
    XCTAssertTrue(window.commonInitCalled);
  }
#endif  // MDC_AVAILABLE_SDK_IOS(13_0)
}

@end
