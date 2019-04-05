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

#import "MaterialSnapshot.h"

#import "MaterialShadowLayer.h"

/** UIView using MDCShadowLayer as its layer. */
@interface MDCShadowLayerTestView : UIView

/** The MDCShadowLayer backing this view. */
@property(nonatomic, strong, readonly) MDCShadowLayer *shadowLayer;

@end

@implementation MDCShadowLayerTestView

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

- (MDCShadowLayer *)shadowLayer {
  return (MDCShadowLayer *)self.layer;
}

@end

/** Snapshot tests for MDCShadowLayer. */
@interface MDCShadowLayerSnapshotTests : MDCSnapshotTestCase

/** The view being tested. */
@property(nonatomic, strong) MDCShadowLayerTestView *testView;

@end

@implementation MDCShadowLayerSnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.testView = [[MDCShadowLayerTestView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  self.testView.backgroundColor = UIColor.whiteColor;
  self.testView.shadowLayer.shadowColor = UIColor.redColor.CGColor;
}

- (void)tearDown {
  self.testView = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyView {
  UIView *snapshotView =
      [self.testView mdc_addToBackgroundViewWithInsets:UIEdgeInsetsMake(40, 40, 80, 40)];
  [self snapshotVerifyView:snapshotView];
}

#pragma mark - Tests

- (void)testShadowMaskEnabledElevation00 {
  // When
  self.testView.shadowLayer.elevation = 0;
  self.testView.shadowLayer.shadowMaskEnabled = YES;

  // Then
  [self generateSnapshotAndVerifyView];
}

- (void)testShadowMaskDisabledElevation00 {
  // When
  self.testView.shadowLayer.elevation = 0;
  self.testView.shadowLayer.shadowMaskEnabled = NO;

  // Then
  [self generateSnapshotAndVerifyView];
}

- (void)testShadowMaskEnabledElevation06 {
  // When
  self.testView.shadowLayer.elevation = 6;
  self.testView.shadowLayer.shadowMaskEnabled = YES;

  // Then
  [self generateSnapshotAndVerifyView];
}

- (void)testShadowMaskDisabledElevation06 {
  // When
  self.testView.shadowLayer.elevation = 6;
  self.testView.shadowLayer.shadowMaskEnabled = NO;

  // Then
  [self generateSnapshotAndVerifyView];
}

- (void)testShadowMaskEnabledElevation12 {
  // When
  self.testView.shadowLayer.elevation = 12;
  self.testView.shadowLayer.shadowMaskEnabled = YES;

  // Then
  [self generateSnapshotAndVerifyView];
}

- (void)testShadowMaskDisabledElevation12 {
  // When
  self.testView.shadowLayer.elevation = 12;
  self.testView.shadowLayer.shadowMaskEnabled = NO;

  // Then
  [self generateSnapshotAndVerifyView];
}

- (void)testShadowMaskEnabledElevation18 {
  // When
  self.testView.shadowLayer.elevation = 18;
  self.testView.shadowLayer.shadowMaskEnabled = YES;

  // Then
  [self generateSnapshotAndVerifyView];
}

- (void)testShadowMaskDisabledElevation18 {
  // When
  self.testView.shadowLayer.elevation = 18;
  self.testView.shadowLayer.shadowMaskEnabled = NO;

  // Then
  [self generateSnapshotAndVerifyView];
}

- (void)testShadowMaskEnabledElevation24 {
  // When
  self.testView.shadowLayer.elevation = 24;
  self.testView.shadowLayer.shadowMaskEnabled = YES;

  // Then
  [self generateSnapshotAndVerifyView];
}

- (void)testShadowMaskDisabledElevation24 {
  // When
  self.testView.shadowLayer.elevation = 24;
  self.testView.shadowLayer.shadowMaskEnabled = NO;

  // Then
  [self generateSnapshotAndVerifyView];
}

@end
