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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 A tonal palette consists of a main color and variants of the main color that are lighter and darker
 shades of the main color. Material design guidelines recommend one main color with nine color
 variations. One of the color variations is designated as a light color in relation to the main
 color and another of the color variations is designated as a dark color in relation to the main
 color.
 */
@interface MDCTonalPalette : NSObject <NSCopying>

/**
 The colors that comprise a tonal palette.
 */
@property(nonatomic, copy, nonnull, readonly) NSArray<UIColor *> *colors;

/**
 The index of the main color of a tonal palette.
 */
@property(nonatomic, readonly) NSUInteger mainColorIndex;

/**
 The index of the light color of a tonal palette.
 */
@property(nonatomic, readonly) NSUInteger lightColorIndex;

/**
 The index of the dark color of a tonal palette.
 */
@property(nonatomic, readonly) NSUInteger darkColorIndex;

/**
 The main color of a tonal palette.
 */
@property(nonatomic, strong, nonnull, readonly) UIColor *mainColor;

/**
 The light color of a tonal palette in relation to the main color.
 */
@property(nonatomic, strong, nonnull, readonly) UIColor *lightColor;

/**
 The dark color of a tonal palette in relation to the main color.
 */
@property(nonatomic, strong, nonnull, readonly) UIColor *darkColor;

- (nonnull instancetype)init NS_UNAVAILABLE;

/**
 Initializes and returns a color scheme given an array of colors and specified indices of the main,
 light and dark colors within the color array. Indices that are out of bounds of the color array are
 not acceptable. However, there can be duplicate indices (i.e. the main color index can potentially
 be the same as the light or dark color index).
 */
- (nonnull instancetype)initWithColors:(nonnull NSArray<UIColor *> *)colors
                        mainColorIndex:(NSUInteger)mainColorIndex
                       lightColorIndex:(NSUInteger)lightColorIndex
                        darkColorIndex:(NSUInteger)darkColorIndex NS_DESIGNATED_INITIALIZER;

@end
