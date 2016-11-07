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

#import "MDCOverlayUtilities.h"

CGRect MDCOverlayConvertRectToView(CGRect screenRect, UIView *target) {
  if (target != nil && !CGRectIsNull(screenRect)) {
    // Overlay rectangles are in screen fixed coordinates in iOS 8. If available, we'll use that
    // API to do the conversion.
    UIScreen *screen = [UIScreen mainScreen];
    if ([screen respondsToSelector:@selector(fixedCoordinateSpace)]) {
      return [target convertRect:screenRect fromCoordinateSpace:screen.fixedCoordinateSpace];
    }

    // If we can't use coordinate spaces (iOS 8 only), then convert the rectangle from screen
    // coordinates to our own view. On iOS 7 and below, the window is the same size as the screen's
    // bounds, so we can safely convert from window coordinates here and get the same outcome.
    return [target convertRect:screenRect fromView:nil];
  }
  return CGRectNull;
}
