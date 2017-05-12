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
 Subclasses UIWindow to allow overlays to cover all content.

 Overlays will be the full size of the screen, or when multitasking use all available screen space,
 and will be rotated as appropriate based on device orientation. For performance, owners of overlay
 views should set the @c hidden property to YES when the overlay is not in use.
 */
@interface MDCOverlayWindow : UIWindow

/**
 Notifies the window that the given overlay view should be shown.

 Overlay owners must call this method to ensure that the overlay is actually displayed over the
 window's primary content.

 @param overlay The overlay being displayed.
 @param level The UIWindowLevel to display the overlay on.
 */
- (void)activateOverlay:(UIView *)overlay withLevel:(UIWindowLevel)level;

/**
 Notifies the window that the given overlay is no longer active.

 Overlay owners should still hide their overlay before calling this method.

 @param overlay The overlay being displayed.
 */
- (void)deactivateOverlay:(UIView *)overlay;

@end
