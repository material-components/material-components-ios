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

#import "MDCSnapshotTestCase.h"

#import <sys/utsname.h>

/*
 Due to differences between the iPhone 6 and iPhone 7 snapshots (when working with textfields), we
 will limit the snapshot tests to only run on the iPhone 7 until we have a better solution for
 generating the matrix of devices and OS's that we want to support.
 https://github.com/material-components/material-components-ios/issues/5888
 */
static NSString *const kiPhone7ModelA = @"iPhone9,1";
static NSString *const kiPhone7ModelB = @"iPhone9,3";

@implementation MDCSnapshotTestCase

- (void)setUp {
  [super setUp];
  self.agnosticOptions = FBSnapshotTestCaseAgnosticOptionOS;
}

- (UIView *)addBackgroundViewToView:(UIView *)view {
  UIView *backgroundView =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.bounds) + 20,
                                               CGRectGetHeight(view.bounds) + 20)];
  backgroundView.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
  [backgroundView addSubview:view];
  view.center = backgroundView.center;
  return backgroundView;
}

- (void)snapshotVerifyView:(UIView *)view {
  [self snapshotVerifyView:view tolerance:0];
}

- (void)snapshotVerifyView:(UIView *)view tolerance:(CGFloat)tolerancePercent {
  if (![self isSupportedDevice]) {
    return;
  }

  UIImage *result = nil;

  if (@available(iOS 10, *)) {
    UIGraphicsImageRenderer *renderer =
        [[UIGraphicsImageRenderer alloc] initWithSize:view.frame.size];
    result = [renderer imageWithActions:^(UIGraphicsImageRendererContext *_Nonnull context) {
      BOOL success = [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:YES];
      NSAssert(success, @"View %@ must draw correctly", view);
    }];

    NSAssert(result != nil, @"View %@ must render image", view);
  } else {
    NSLog(@"Skipping this test. Snapshot tests require iOS 10.0 or later.");
    return;
  }

  UIImageView *imageView = [[UIImageView alloc] initWithFrame:view.frame];
  imageView.image = result;

  FBSnapshotVerifyViewWithOptions(imageView, nil, FBSnapshotTestCaseDefaultSuffixes(),
                                  tolerancePercent);
}

// TODO(https://github.com/material-components/material-components-ios/issues/5888)
// Support multiple OS versions and devices for snapshots
- (BOOL)isSupportedDevice {
  if (NSProcessInfo.processInfo.operatingSystemVersion.majorVersion != 11 ||
      NSProcessInfo.processInfo.operatingSystemVersion.minorVersion != 2 ||
      NSProcessInfo.processInfo.operatingSystemVersion.patchVersion != 0) {
    NSLog(@"Unsupported device. Snapshot tests currently only run on iOS 11.2.0");
    return NO;
  }

  NSString *deviceName = [self getDeviceName];
  if (!([deviceName isEqualToString:kiPhone7ModelA] ||
        [deviceName isEqualToString:kiPhone7ModelB])) {
    NSLog(@"Unsupported device. Snapshot tests currently only run on iPhone 7");
    return NO;
  }

  return YES;
}

- (NSString *)getDeviceName {
  NSString *deviceName;
#if TARGET_OS_SIMULATOR
  // This solution was found here: https://stackoverflow.com/a/26680063
  deviceName = [NSProcessInfo processInfo].environment[@"SIMULATOR_MODEL_IDENTIFIER"];
#else
  struct utsname systemInfo;
  uname(&systemInfo);
  deviceName = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
#endif
  return deviceName;
}

@end
