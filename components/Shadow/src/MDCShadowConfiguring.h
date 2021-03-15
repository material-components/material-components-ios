// Copyright 2021-present the Material Components for iOS authors. All Rights Reserved.
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

#import <UIKit/UIKit.h>

@class MDCShadow;

/**
 Given a view and a shadow color (e.g. `MDCShadowColor()`) along with an elevation, updates
 the shadow properties of `view.layer`:

 * shadowColor
 * shadowOpacity
 * shadowRadius
 * shadowOffset
 * shadowPath

 `shadowPath` will be set to the current bounds of the given view (including rounded
 corners if set on view.layer).

 TODO(b/182581383): maskedCorners, cornerCurve, and cornerCurveExpansionFactor are not
 yet supported.

 If `elevation` is < 1, disables the view's shadow. Otherwise, enables the shadow.

 Call this function from your `UIView` subclass's `-layoutSubviews` to update `shadowPath`
 whenever the view's bounds change.
 */
FOUNDATION_EXTERN void MDCConfigureShadowForViewWithElevation(UIView *_Nonnull view,
                                                              UIColor *_Nonnull shadowColor,
                                                              CGFloat elevation)
    NS_SWIFT_NAME(MDCConfigureShadow(for:color:elevation:));

/**
 Given a view and a shadow color (e.g. `MDCShadowColor()`) along with an `MDCShadow` value, updates
 the shadow properties of `view.layer`:

 * shadowColor
 * shadowOpacity
 * shadowRadius
 * shadowOffset
 * shadowPath

 `shadowPath` will be set to the current bounds of the given view (including rounded
 corners if set on view.layer).

 TODO(b/182581383): maskedCorners, cornerCurve, and cornerCurveExpansionFactor are not
 yet supported.

 Call this function from your `UIView` subclass's `-layoutSubviews` to update `shadowPath`
 whenever the view's bounds change.
 */
FOUNDATION_EXTERN void MDCConfigureShadowForViewWithShadow(UIView *_Nonnull view,
                                                           UIColor *_Nonnull shadowColor,
                                                           MDCShadow *_Nonnull shadow)
    NS_SWIFT_NAME(MDCConfigureShadow(for:color:shadow:));

/**
 Given a view, a shadow color (e.g. `MDCShadowColor()`), an `MDCShadow` value, and a `path` in the
 view's coordinate space representing the shape of the view, updates the shadow properties of
 `view.layer`:

 * shadowColor
 * shadowOpacity
 * shadowRadius
 * shadowOffset
 * shadowPath

 Call this function from your `UIView` subclass's `-layoutSubviews` to update `shadowPath`
 whenever the view's bounds or shape changes.
 */
FOUNDATION_EXTERN void MDCConfigureShadowForViewWithShadowAndPath(UIView *_Nonnull view,
                                                                  UIColor *_Nonnull shadowColor,
                                                                  MDCShadow *_Nonnull shadow,
                                                                  CGPathRef _Nonnull path)
    NS_SWIFT_NAME(MDCConfigureShadow(for:color:shadow:path:));
