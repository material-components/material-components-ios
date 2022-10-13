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

/** An object for customizing the appearance of a badge. */
__attribute__((objc_subclassing_restricted))
@interface MDCBadgeAppearance : NSObject<NSCopying>

/** Returns a configuration initialized with empty defaults. */
- (nonnull instancetype)init;

#pragma mark - Configuring the badge's visual appearance

/**
 The background color of the badge.

 A value of nil uses the view's tint color; use `clearColor` for no color (transparent).
 */
@property(nonatomic, strong, nullable) UIColor *backgroundColor;

/** The color of the text representing the value. */
@property(nonatomic, strong, nullable) UIColor *textColor;

/** The font that will be used to display the value. */
@property(nonatomic, strong, nullable) UIFont *font;

/**
 The color of the border surrounding the badge.

 Use this property instead of self.layer.borderColor. This property allows the badge to support
 a border color that responds to trait collection changes.
 */
@property(nonatomic, strong, nullable) UIColor *borderColor;

/**
 The width of the border surrounding the badge.

 Use this property instead of self.layer.borderWidth. Setting this property will cause the badge's
 intrinsic size and layout to be invalidated.
 */
@property(nonatomic) CGFloat borderWidth;

@end
