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

#import "MaterialButtons.h"

@class MDCInkView;

@interface MDCButton (Subclassing)

/** Access to the ink view layer. Mainly used for subclasses to override ink properties. */
@property(nonatomic, readonly, strong, nonnull) MDCInkView *inkView;

/** Whether the background color should be opaque. */
- (BOOL)shouldHaveOpaqueBackground;

/** Updates the background color based on the button's current configuration. */
- (void)updateBackgroundColor;

/**
 Should the button raise when touched?

 Default is YES.
 */
@property(nonatomic) BOOL shouldRaiseOnTouch;

/** The bounding path of the button. The shadow will follow that path. */
- (nonnull UIBezierPath *)boundingPath;

/** The corner radius of the button. The shadow will follow that path. */
- (CGFloat)cornerRadius;

/** The default content edge insets of the button. They are set at initialization time. */
- (UIEdgeInsets)defaultContentEdgeInsets;

/** The default elevation for a particular button state (if not set by the calling code). */
- (CGFloat)defaultElevationForState:(UIControlState)state;

@end
