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
static NSString *const kiPhone8ModelA = @"iPhone10,1";
static NSString *const kiPhone8ModelB = @"iPhone10,4";

@implementation MDCSnapshotTestCase

- (void)setUp {
  [super setUp];
  self.agnosticOptions = FBSnapshotTestCaseAgnosticOptionOS;
}

- (void)snapshotVerifyView:(UIView *)view {
  [self snapshotVerifyView:view tolerance:0 supportIOS13:NO];
}

- (void)snapshotVerifyViewForIOS13:(UIView *)view {
  [self snapshotVerifyView:view tolerance:0 supportIOS13:YES];
}

- (void)snapshotVerifyView:(UIView *)view
                 tolerance:(CGFloat)tolerancePercent
              supportIOS13:(BOOL)supportIOS13 {
  if (!supportIOS13 && ![self isSupportedDevice]) {
    return;
  } else if (supportIOS13 && ![self isSupportedIOS13Device]) {
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

- (void)changeViewToRTL:(UIView *)view {
  [self changeViewLayoutToRTL:view];
  [self changeTextInputToRTL:view];
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

- (BOOL)isSupportedIOS13Device {
  if (NSProcessInfo.processInfo.operatingSystemVersion.majorVersion != 13 ||
      NSProcessInfo.processInfo.operatingSystemVersion.minorVersion != 0 ||
      NSProcessInfo.processInfo.operatingSystemVersion.patchVersion != 0) {
    NSLog(@"Unsupported device. Snapshot tests currently only run on iOS 13.0.0");
    return NO;
  }

  NSString *deviceName = [self getDeviceName];
  if (!([deviceName isEqualToString:kiPhone8ModelA] ||
        [deviceName isEqualToString:kiPhone8ModelB])) {
    NSLog(@"Unsupported device. Snapshot tests currently only run on iPhone 8");
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

- (void)changeViewLayoutToRTL:(UIView *)view {
  view.semanticContentAttribute = UISemanticContentAttributeForceRightToLeft;
  if ([view isKindOfClass:[UILabel class]]) {
    UILabel *label = (UILabel *)view;
    if (label.textAlignment == NSTextAlignmentNatural) {
      label.textAlignment = NSTextAlignmentRight;
    }
  }
  for (UIView *subview in view.subviews) {
    [self changeViewLayoutToRTL:subview];
  }
}

- (void)changeTextInputToRTL:(UIView *)view {
  if ([view conformsToProtocol:@protocol(UITextInput)]) {
    id<UITextInput> textInput = (id<UITextInput>)view;
    UITextRange *textRange = [textInput textRangeFromPosition:textInput.beginningOfDocument
                                                   toPosition:textInput.endOfDocument];
    if (textRange) {
      [textInput setBaseWritingDirection:UITextWritingDirectionRightToLeft forRange:textRange];
    }
  }
  for (UIView *subview in view.subviews) {
    [self changeTextInputToRTL:subview];
  }
}

@end
