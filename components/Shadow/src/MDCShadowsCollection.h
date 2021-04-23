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

#import "MDCShadow.h"

/**
 An immutable shadows collection object that encapsulates a storage of shadows correlating to
 elevation values.

 To apply a shadow on a view, please see and use the C methods @c MDCConfigureShadowForView and
 @c MDCConfigureShadowForViewWithPath.
 */
__attribute__((objc_subclassing_restricted)) @interface MDCShadowsCollection : NSObject

- (nonnull instancetype)init NS_UNAVAILABLE;

/**
 Returns an MDCShadow instance representing the shadow properties for the given elevation (in
 points) by fetching from the @c shadowsCollection container holding elevation to MDCShadow instance
 bindings.

 Note: If the provided elevation is not stored, the shadow properties that are set are of the
 nearest elevation above the provided elevation. i.e. if elevations 1 and 3 are set, and an
 elevation of 2 is provided as input, the shadow properties set will be of elevation 3. If the
 provided elevation is above the highest elevation value that is set, then the shadow properties set
 will be of the highest elevation.
 */
- (nonnull MDCShadow *)shadowForElevation:(CGFloat)elevation;

@end

/**
 A shadows collection object builder that generates an MDCShadowsCollection instance using the @c
 build method. The object allows to add shadows for a given elevation.

 To ensure no nullability situations, please instantiate the builder using @c
 builderWithShadow:forElevation and provide an initial MDCShadow instance.
 */
__attribute__((objc_subclassing_restricted)) @interface MDCShadowsCollectionBuilder : NSObject

- (nonnull instancetype)init NS_UNAVAILABLE;

/**
 Adds a shadow for the given elevation.

 @param shadow An MDCShadow object consisting of shadow properties such as radius, opacity, and
 offset.
 @param elevation The elevation provided in points (dp).
 */
- (void)addShadow:(MDCShadow *_Nonnull)shadow forElevation:(CGFloat)elevation;

/**
 Adds a dictionary of shadows with their correlating elevations to the shadows collection.

 @param shadowsForElevations A dictionary holding NSNumber elevation value keys, and their values
 are MDCShadow objects correlating to their elevation key.
 */
- (void)addShadowsForElevations:
    (NSDictionary<NSNumber *, MDCShadow *> *_Nonnull)shadowsForElevations;

/**
 Creates an initial MDCShadowsCollectionBuilder by providing it an initial MDCShadow object and its
 correlating elevation.

 @param shadow An MDCShadow object consisting of shadow properties such as radius, opacity, and
 offset.
 @param elevation The elevation provided in points (dp).
 */
+ (nonnull MDCShadowsCollectionBuilder *)builderWithShadow:(MDCShadow *_Nonnull)shadow
                                              forElevation:(CGFloat)elevation;

/**
 Builds and returns an MDCShadowsCollection instance given the provided shadows using the
 @c addShadow:forElevation and  @c addShadowsForElevations: APIs.
 */
- (nonnull MDCShadowsCollection *)build;

@end

/**
 Given a view, MDCShadow instance, and a shadow color (e.g. `MDCShadowColor()`), updates the shadow
 properties of `view.layer`:

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
FOUNDATION_EXTERN void MDCConfigureShadowForView(UIView *_Nonnull view, MDCShadow *_Nonnull shadow,
                                                 UIColor *_Nonnull shadowColor)
    NS_SWIFT_NAME(MDCConfigureShadow(for:shadow:color:));

/**
 Given a view, MDCShadow instance, a shadow color (e.g. `MDCShadowColor()`),  and a `path` in the
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
FOUNDATION_EXTERN void MDCConfigureShadowForViewWithPath(UIView *_Nonnull view,
                                                         MDCShadow *_Nonnull shadow,
                                                         UIColor *_Nonnull shadowColor,
                                                         CGPathRef _Nonnull path)
    NS_SWIFT_NAME(MDCConfigureShadow(for:shadow:color:path:));

/**
 Default color for a Material shadow. On iOS >= 13, this is a dynamic color.
 */
FOUNDATION_EXTERN UIColor *_Nonnull MDCShadowColor(void);

/**
 Returns an MDCShadowsCollection instance with predefined defaults of shadow properties (opacity,
 radius, offset) for elevations.
 */
FOUNDATION_EXTERN MDCShadowsCollection *_Nonnull MDCShadowsCollectionDefault(void);
