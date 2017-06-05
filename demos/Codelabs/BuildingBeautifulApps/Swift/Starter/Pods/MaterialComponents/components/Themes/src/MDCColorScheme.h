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

#import <UIKit/UIKit.h>

/**
 A color scheme comprised of set of primary and secondary colors. Material design guidelines
 recommend using primary and secondary colors with light and dark color variants.
 */
@interface MDCColorScheme : NSObject

/** The main, primary color used for a theme. */
@property (nonatomic, strong) UIColor *primaryColor;

/** 
 A slightly lighter version of the primary color. Given tonal variations of a color, this color is
 typically two color swatches lighter than the primary color.
 */
@property (nonatomic, strong) UIColor *primaryLightColor;

/**
 A slightly darker version of the primary color. Given tonal variations of a color, this color is
 typically two color swatches darker than the primary color.
 */
@property (nonatomic, strong) UIColor *primaryDarkColor;

/** The secondary, accent color used for a theme. */
@property (nonatomic, strong) UIColor *secondaryColor;

/**
 A slightly lighter version of the secondary color. Given tonal variations of a color, this color is
 typically two color swatches lighter than the secondary color.
 */
@property (nonatomic, strong) UIColor *secondaryLightColor;

/**
 A slightly darker version of the secondary color. Given tonal variations of a color, this color is
 typically two color swatches darker than the secondary color.
 */
@property (nonatomic, strong) UIColor *secondaryDarkColor;

@end
