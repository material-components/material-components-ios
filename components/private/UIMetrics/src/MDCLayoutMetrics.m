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

#import "MDCLayoutMetrics.h"

#import "UIApplication+MDCAppExtensions.h"

#if defined(TARGET_OS_VISION) && TARGET_OS_VISION
// For code review, use the review queue listed in go/material-visionos-review.
#define IS_VISIONOS 1
#else
#define IS_VISIONOS 0
#endif

const CGFloat MDCFixedStatusBarHeightOnPreiPhoneXDevices = 20;

#if !IS_VISIONOS
static BOOL HasHardwareSafeAreas(void) {
  static BOOL hasHardwareSafeAreas = NO;
  static BOOL hasCheckedForHardwareSafeAreas = NO;
  static dispatch_once_t onceToken;
  if (!hasCheckedForHardwareSafeAreas && [UIApplication mdc_safeSharedApplication].keyWindow) {
    dispatch_once(&onceToken, ^{
      UIEdgeInsets insets = [UIApplication mdc_safeSharedApplication].keyWindow.safeAreaInsets;
      hasHardwareSafeAreas = (insets.top > MDCFixedStatusBarHeightOnPreiPhoneXDevices ||
                              insets.left > 0 || insets.bottom > 0 || insets.right > 0);

      hasCheckedForHardwareSafeAreas = YES;
    });
  }
  return hasHardwareSafeAreas;
}
#endif

CGFloat MDCDeviceTopSafeAreaInset(void) {
#if IS_VISIONOS
  CGFloat topInset = 0.0;
#else
  CGFloat topInset = MDCFixedStatusBarHeightOnPreiPhoneXDevices;
  // Devices with hardware safe area insets have fixed insets that depend on the device
  // orientation. On such devices, we aren't interested in the status bar's height because the
  // hardware safe area insets are what ultimately define the margins for the app. If we are
  // running on such a device, we read from the safe area insets instead of the fixed status bar
  // height so that we react to changes in safe area insets (usually due to orientation changes)
  // and update the fixed margin accordingly.
  if (HasHardwareSafeAreas()) {
    UIEdgeInsets insets = [UIApplication mdc_safeSharedApplication].keyWindow.safeAreaInsets;
    topInset = insets.top;
  }
#endif
  return topInset;
}
