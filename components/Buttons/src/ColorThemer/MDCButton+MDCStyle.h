/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import <Foundation/Foundation.h>
#import "MaterialButtons.h"

@protocol MDCColorScheme;

@interface MDCButton (MDCStyle)

/**
 Creates a new MDCButton styled as a "default size" floating action button. If @c colorScheme is
 provided, it will be applied to the button.

 @param colorScheme The color scheme to apply to the created button. May be nil.
 @return A newly created MDCButton styled as a floating action button and with the color scheme
         applied.
 */
+ (nonnull MDCButton *)floatingButtonWithScheme:(nullable NSObject<MDCColorScheme> *)colorScheme;

/**
 Creates a new MDCButton styled as a "mini size" floating action button. If @c colorScheme is
 provided, it will be applied to the button.

 @param colorScheme The color scheme to apply to the created button. May be nil.
 @return A newly created MDCButton styled as a floating action button and with the color scheme
         applied.
 */
+ (nonnull MDCButton *)miniFloatingButtonWithScheme:
    (nullable NSObject<MDCColorScheme> *)colorScheme;

/**
 Creates a new MDCButton styled as a "default size" floating action button with a large (36 point)
 icon. If @c colorScheme is provided, it will be applied to the button.

 @param colorScheme The color scheme to apply to the created button. May be nil.
 @return A newly created MDCButton styled as a floating action button and with the color scheme
         applied.
 */
+ (nonnull MDCButton *)largeIconFloatingButtonWithScheme:
    (nullable NSObject<MDCColorScheme> *)colorScheme;

@end
