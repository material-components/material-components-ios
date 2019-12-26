// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import <CoreGraphics/CoreGraphics.h>

/**
 The standard shadow values applied to a UIView's @c layer when creating Material components.
 */
@interface MDCShadowStandards : NSObject

/**
 The opacity of the layer’s shadow.
 */
@property(nonatomic, assign, readonly) float shadowOpacity;

/**
 The blur radius (in points) used to render the layer’s shadow.
 */
@property(nonatomic, assign, readonly) CGFloat shadowRadius;

/**
The offset (in points) of the layer’s shadow. 
 */
@property(nonatomic, assign, readonly) CGSize shadowOffset;

/**
 Returns a @c MDCShadowStandard with the properties set for a given elevation.

 @param elevation The elevation a @c UIView should represent.
 */
- (nonnull instancetype)initWithElevation:(CGFloat)elevation NS_DESIGNATED_INITIALIZER;

/**
 Please use @c initWithElevation.
 */
- (nonnull instancetype)init NS_UNAVAILABLE;

@end
