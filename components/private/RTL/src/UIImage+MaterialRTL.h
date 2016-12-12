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

#import <UIKit/UIKit.h>

/**
 Partial backporting of iOS 9's `-[UIImage imageFlippedForRightToLeftLayoutDirection]`. In Apple's
 iOS 9 implementation, the image is not actually flipped, but prepared to be flipped when displayed
 in a Right-to-Left environment, i.e. it's just an additional flag on the UIImage (like
 `imageOrientation`, `scale` or `resizingMode` for example). On iOS 8, the partial backporting
 actually flips the image, so this method should only be called when in an RTL environment already.
 TODO: consider solutions to complete the backporting to get the same behavior.
 https://github.com/material-components/material-components-ios/issues/599
 */

@interface UIImage (MaterialRTL)

/**
 On iOS 9 and above, returns a copy of the current image, prepared to flip horizontally if it's in a
 right-to-left layout. Prior to iOS 9, it returns the image already flipped in place. For that
 reason, it should be called only in RTL environments.
 */
- (UIImage *)mdc_imageFlippedForRightToLeftLayoutDirection;

@end
