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

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (MaterialDynamic)

/// Returns a color object that picks its value from given color objects dynamically
/// based on currently active traits. For pre iOS 13, this method returns the default
/// color object.
///
/// @param darkColor A color object returned when @c userInterfaceStyle is @c
/// UIUserInterfaceStyleDark based on currently active traits.
/// @param defaultColor A default color object.
+ (UIColor *)colorWithUserInterfaceStyleDarkColor:(UIColor *)darkColor
                                     defaultColor:(UIColor *)defaultColor;

@end

NS_ASSUME_NONNULL_END
