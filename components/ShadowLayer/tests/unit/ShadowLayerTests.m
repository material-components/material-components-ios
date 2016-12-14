/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import <XCTest/XCTest.h>
#import "MaterialShadowLayer.h"

@interface ShadowLayerTests : XCTestCase
@end

@implementation ShadowLayerTests

- (void)testBasicEncode {
	MDCShadowLayer *shadowLayer = [[MDCShadowLayer alloc] init];

  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:shadowLayer];

  MDCShadowLayer *unarchivedLayer = [NSKeyedUnarchiver unarchiveObjectWithData:data];

  XCTAssertEqual(shadowLayer.elevation, unarchivedLayer.elevation);
  XCTAssertEqual(shadowLayer.shadowMaskEnabled, unarchivedLayer.shadowMaskEnabled);
}

- (void)testElevationEncode {
  MDCShadowLayer *shadowLayer = [[MDCShadowLayer alloc] init];
  shadowLayer.elevation = 11.0;

  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:shadowLayer];

  MDCShadowLayer *unarchivedLayer = [NSKeyedUnarchiver unarchiveObjectWithData:data];

  XCTAssertEqual(shadowLayer.elevation, unarchivedLayer.elevation);
  XCTAssertEqual(shadowLayer.shadowMaskEnabled, unarchivedLayer.shadowMaskEnabled);
}

- (void)testShadowMaskEncode {
  MDCShadowLayer *shadowLayer = [[MDCShadowLayer alloc] init];
  shadowLayer.shadowMaskEnabled = NO;

  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:shadowLayer];

  MDCShadowLayer *unarchivedLayer = [NSKeyedUnarchiver unarchiveObjectWithData:data];

  XCTAssertEqual(shadowLayer.elevation, unarchivedLayer.elevation);
  XCTAssertEqual(shadowLayer.shadowMaskEnabled, unarchivedLayer.shadowMaskEnabled);
}

@end
