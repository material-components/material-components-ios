// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialProgressView.h"
#import "MaterialThemes.h"

#import <Foundation/Foundation.h>

/**
 Used to apply a color scheme to theme MDCProgressView. This API does not yet implement the Material
 Design color system.
 */
@interface MDCProgressViewColorThemer : NSObject
@end

@interface MDCProgressViewColorThemer (ToBeDeprecated)

/**
 Applies a color scheme to theme a MDCProgressView.

 @warning This method will soon be deprecated. There is no replacement yet. Learn more at
 components/schemes/Color/docs/migration-guide-semantic-color-scheme.md

 @param colorScheme The color scheme to apply to the component instance.
 @param progressView A component instance to which the color scheme should be applied.
 */
+ (void)applyColorScheme:(nonnull id<MDCColorScheme>)colorScheme
          toProgressView:(nonnull MDCProgressView *)progressView;

@end
