/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

/**
 Generates a UIColor from RGBA (red, green, blue, alpha) values. Each value is encoded in 8-bits
 of the uint32_t and is divided by 255. Specifically, the most significant 8 bits represent the red
 channel value, the next 8 bits represent green, the third 8 bits represent blue, and the final 8
 bits represent the alpha channel.

 @param rgbaValue a 32-bit value representing the red, green, blue, and alpha channel values.

 @returns a @c UIColor with the specified color and alpha channel values.
 */
static inline UIColor *MDCColorFromRGBA(uint32_t rgbaValue) {
  return [UIColor colorWithRed:((CGFloat)((rgbaValue & 0xFF000000) >> 24)) / 255
                         green:((CGFloat)((rgbaValue & 0x00FF0000) >> 16)) / 255
                          blue:((CGFloat)((rgbaValue & 0x0000FF00) >> 8)) / 255
                         alpha:((CGFloat)((rgbaValue & 0x000000FF) >> 0)) / 255];
}

/**
 Generates a UIColor from RGB (red, green, blue) values in the least significant 24 bits.
 Specifically, the most significant 8 bits are ignored, the next 8 bits represent the red channel
 value, the third 8 bits represent the green channel, and the final 8 bits represent the blue
 channel value. The alpha channel value of the color is set to 1.0.

 @param rgbValue a 24-bit value representing the red, green, and blue channel values.

 @returns a @c UIColor with the specified color channel values and an alpha of 1.0.

 @seealso MDCColorFromRGBA
 */
static inline UIColor *MDCColorFromRGB(uint32_t rgbValue) {
  return MDCColorFromRGBA((rgbValue << 8) | 0x000000FF);
}
