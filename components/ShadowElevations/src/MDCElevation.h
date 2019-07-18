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

#import <CoreGraphics/CoreGraphic.h>

/**
 This protocol is used by @c UIViews that want to provide their elevation and wish to react to
 elevation changes occuring in their view hierarchy.
 */
@protocol MDCElevation <NSObject>

/**
 The elevation did change block is called when the elevation changes for the conforming @c UIView
 object or one of it's direct ancestors in the view hierarchy.

 This block is typically used by clients that want to re-theme the color of the view in dark mode
 based on the elevation that is provided.
 */
@property (nonatomic, copy, nullable) void (^mdc_elevationDidChangeBlock)(CGFloat elevation);

/**
 The current elevation of the conforming @c UIView object.

 If an elevation API already exist, then this getter can directly call that API to get the current
 elevation.
 */
@property (nonatomic, assign, readonly) CGFloat mdc_currentElevation;

@optional

/**
 Override base elevation allows clients to override the automatic calculation of the @c
 mdc_baseElevation getter in @c MaterialElevationResponding.

 This can be used in cases where there is latent elevation behind an object that is not part of the
 view hierarchy, like a @c UIPresentationController.
 */
@property (nonatomic, assign, readwrite) CGFloat mdc_overrideBaseElevation;
@end


@end
