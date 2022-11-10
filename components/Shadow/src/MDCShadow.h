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

NS_ASSUME_NONNULL_BEGIN

/**
 An immutable shadow object that consists of shadow properties (color, opacity, radius, offset,
 spread).

 To generate a shadow instance, please use the MDCShadowBuilder APIs.
 */
__attribute__((objc_subclassing_restricted)) @interface MDCShadow : NSObject

- (nonnull instancetype)init NS_UNAVAILABLE;

/** The color value of shadow */
@property(nonatomic, readonly) UIColor *color;

/** CALayer.shadowOpacity */
@property(nonatomic, readonly) CGFloat opacity;

/** CALayer.shadowRadius */
@property(nonatomic, readonly) CGFloat radius;

/** CALayer.shadowOffset */
@property(nonatomic, readonly) CGSize offset;

/** The spread value of shadow */
@property(nonatomic, readonly) CGFloat spread;

@end

/**
 Mutable builder to construct immutable `MDCShadow` objects.
 */
__attribute__((objc_subclassing_restricted)) @interface MDCShadowBuilder : NSObject

/** The color value of shadow */
@property(nonatomic) UIColor *color;

/** CALayer.shadowOpacity */
@property(nonatomic) CGFloat opacity;

/** CALayer.shadowRadius */
@property(nonatomic) CGFloat radius;

/** CALayer.shadowOffset */
@property(nonatomic) CGSize offset;

/** The spread value of shadow */
@property(nonatomic) CGFloat spread;

/** Returns an immutable value type containing a snapshot of the values in this object. */
- (nonnull MDCShadow *)build;

/** Returns a builder with the provided color, opacity, radius, and offset properties. */
+ (nonnull MDCShadowBuilder *)builderWithColor:(UIColor *)color
                                       opacity:(CGFloat)opacity
                                        radius:(CGFloat)radius
                                        offset:(CGSize)offset;

/** Returns a builder with the provided color, opacity, radius, offset, and spread properties. */
+ (nonnull MDCShadowBuilder *)builderWithColor:(UIColor *)color
                                       opacity:(CGFloat)opacity
                                        radius:(CGFloat)radius
                                        offset:(CGSize)offset
                                        spread:(CGFloat)spread;

@end

NS_ASSUME_NONNULL_END
