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

#import "MaterialHeaderStackView.h"
#import "MaterialThemes.h"

#import <Foundation/Foundation.h>

/**
 The Material Design color system's themer for instances of MDCHeaderStackView.
 */
@interface MDCHeaderStackViewColorThemer : NSObject

/**
 Applies a color scheme's properties to an MDCHeaderStackView.

 @param colorScheme The color scheme to apply to the component instance.
 @param headerStackView A component instance to which the color scheme should be applied.
 */
+ (void)applyColorScheme:(nonnull id<MDCColorScheme>)colorScheme
       toHeaderStackView:(nonnull MDCHeaderStackView *)headerStackView;

@end
