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

#import "MDCColorResource.h"
#import "MDCStateExampleColorScheme.h"
#import "MaterialColorScheme.h"

@interface MDCColorResource (ColorScheming)

/**
 Converts a color resource to a UIColor instance, using the given color scheme if
 the resouce represents a semantic color.

 Note: While in alpha, MDCColorResource uses MDCStateExampleColorScheme in order to
       support additional colors used in alpha. Once these colors migrate to Beta, this
       API will reference the MDCColorScheming protocol instead:

 - (UIColor *)colorWithColorScheme:(id<MDCColorScheming>)colorScheme;

 */
- (UIColor *)colorWithColorScheme:(MDCStateExampleColorScheme *)colorScheme;

@end
