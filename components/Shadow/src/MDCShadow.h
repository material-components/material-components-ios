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

/**
 Immutable value type holding shadow metrics to apply to a view's layer. Use
 `MDCShadowForElevation()` or `MDCShadowBuilder` to create this object.
 */
__attribute__((objc_subclassing_restricted)) @interface MDCShadow : NSObject

/** CALayer.shadowOpacity */
@property(nonatomic, readonly) CGFloat opacity;

/** CALayer.shadowRadius */
@property(nonatomic, readonly) CGFloat radius;

/** CALayer.shadowOffset */
@property(nonatomic, readonly) CGSize offset;

- (nonnull instancetype)init NS_UNAVAILABLE;

@end

/**
 Mutable builder to construct immutable `MDCShadow` objects.
 */
__attribute__((objc_subclassing_restricted)) @interface MDCShadowBuilder : NSObject

/** CALayer.shadowOpacity */
@property(nonatomic) CGFloat opacity;

/** CALayer.shadowRadius */
@property(nonatomic) CGFloat radius;

/** CALayer.shadowOffset */
@property(nonatomic) CGSize offset;

/** Returns an immutable value type containing a snapshot of the values in this object. */
- (nonnull MDCShadow *)build;

@end

/**
 Default color for a Material shadow. On iOS >= 13, this is a dynamic color.
 */
FOUNDATION_EXTERN UIColor *_Nonnull MDCShadowColor(void);

/**
 Returns an `MDCShadow` representing the Material shadow metrics for the given elevation (in
 points).
 */
FOUNDATION_EXTERN MDCShadow *_Nonnull MDCShadowForElevation(CGFloat elevation);
