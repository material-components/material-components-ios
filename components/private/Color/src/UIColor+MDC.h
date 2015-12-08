/*
 Copyright 2015-present Google Inc. All Rights Reserved.

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

@interface UIColor (MDC)

/**
 Creates and returns a color object by linearly interpolating between two existing colors.

 @param fromColor The color to interpolate from.
 @param toColor The color to interpolate to.
 @param percent specified as a value from 0.0 to 1.0.

 @return The new color
 */
+ (nonnull UIColor *)mdc_colorInterpolatedFromColor:(nonnull UIColor *)fromColor
                                            toColor:(nonnull UIColor *)toColor
                                            percent:(CGFloat)percent;

@end
