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
#import "MaterialColorScheme.h"

/**
 Creating a new MDCStateExampleColorScheme to add a couple of semantic colors to the
 StateScheme example.

 Note: onPrimaryColorVariant and onSurfaceColorVariant are not used in state theming.
 */
@interface MDCStateExampleColorScheme : NSObject <MDCColorScheming, NSCopying>

@property(nonnull, readwrite, copy, nonatomic) MDCSemanticColorScheme *MDCColorScheme;

// Redeclare protocol properties as readwrite (overriding the protocol's readonly attribute)
@property(nonnull, readwrite, copy, nonatomic) UIColor *primaryColor;
@property(nonnull, readwrite, copy, nonatomic) UIColor *primaryColorVariant;
@property(nonnull, readwrite, copy, nonatomic) UIColor *secondaryColor;
@property(nonnull, readwrite, copy, nonatomic) UIColor *errorColor;
@property(nonnull, readwrite, copy, nonatomic) UIColor *surfaceColor;
@property(nonnull, readwrite, copy, nonatomic) UIColor *backgroundColor;
@property(nonnull, readwrite, copy, nonatomic) UIColor *onPrimaryColor;
@property(nonnull, readwrite, copy, nonatomic) UIColor *onSecondaryColor;
@property(nonnull, readwrite, copy, nonatomic) UIColor *onSurfaceColor;
@property(nonnull, readwrite, copy, nonatomic) UIColor *onBackgroundColor;

// Additional semantic names used by the state example
@property(nonnull, readwrite, copy, nonatomic) UIColor *overlayColor;
@property(nonnull, readwrite, copy, nonatomic) UIColor *outlineColor;

/**
 Initializes the color scheme with the latest material defaults.
 */
- (nonnull instancetype)init;

/**
 Initializes the color scheme with the colors associated with the given defaults.
 */
- (nonnull instancetype)initWithDefaults:(MDCColorSchemeDefaults)defaults;

@end
