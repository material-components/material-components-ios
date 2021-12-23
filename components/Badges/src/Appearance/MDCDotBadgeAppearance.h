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

#import "MDCMinimumOS.h"  // IWYU pragma: keep

/** A configuration that specifies the appearance and behavior of a dot badge and its contents. */
__attribute__((objc_subclassing_restricted)) API_AVAILABLE(ios(13.0))
    @interface MDCDotBadgeAppearance : NSObject

/** Returns a configuration initialized with empty defaults. */
- (nonnull instancetype)init;

#pragma mark - Configuring the badge's visual appearance

/**
 The background color of the badge.

 A value of nil uses the view's tint color; use `clearColor` for no color (transparent).
 */
@property(nonatomic, strong, nullable, direct) UIColor *backgroundColor;

/**
 The radius of the filled portion of the dot badge.

 The width and height of the dot badge's frame will be equal to (innerRadius + borderWidth) * 2.
 */
@property(nonatomic, direct) CGFloat innerRadius;

/**
 The color of the border surrounding the badge.

 Use this property instead of self.layer.borderColor. This property allows the badge to support
 a border color that responds to trait collection changes.
 */
@property(nonatomic, strong, nullable, direct) UIColor *borderColor;

/**
 The width of the border surrounding the badge.

 Use this property instead of self.layer.borderWidth. Setting this property will cause the badge's
 intrinsic size and layout to be invalidated.
 */
@property(nonatomic, direct) CGFloat borderWidth;

@end
