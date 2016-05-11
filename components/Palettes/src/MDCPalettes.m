/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

#import "MDCPalettes.h"

static const NSString *kTint50Name = @"50";
static const NSString *kTint100Name = @"100";
static const NSString *kTint200Name = @"200";
static const NSString *kTint300Name = @"300";
static const NSString *kTint400Name = @"400";
static const NSString *kTint500Name = @"500";
static const NSString *kTint600Name = @"600";
static const NSString *kTint700Name = @"700";
static const NSString *kTint800Name = @"800";
static const NSString *kTint900Name = @"900";
static const NSString *kAccent100Name = @"A100";
static const NSString *kAccent200Name = @"A200";
static const NSString *kAccent400Name = @"A400";
static const NSString *kAccent700Name = @"A700";

// Creates a UIColor from a 24-bit RGB color encoded as an integer.
static inline UIColor *ColorFromRGB(uint32_t rgbValue) {
  return [UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255
                         green:((CGFloat)((rgbValue & 0x00FF00) >> 8)) / 255
                          blue:((CGFloat)((rgbValue & 0x0000FF) >> 0)) / 255
                         alpha:1];
}

@interface MDCPalette () {
  NSDictionary *_tints;
  NSDictionary *_accents;
}

@end

@implementation MDCPalette

+ (MDCPalette *)redPalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{ kTint50Name : ColorFromRGB(0xFFEBEE),
                                             kTint100Name : ColorFromRGB(0xFFCDD2),
                                             kTint200Name : ColorFromRGB(0xEF9A9A),
                                             kTint300Name : ColorFromRGB(0xE57373),
                                             kTint400Name : ColorFromRGB(0xEF5350),
                                             kTint500Name : ColorFromRGB(0xF44336),
                                             kTint600Name : ColorFromRGB(0xE53935),
                                             kTint700Name : ColorFromRGB(0xD32F2F),
                                             kTint800Name : ColorFromRGB(0xC62828),
                                             kTint900Name : ColorFromRGB(0xB71C1C) }
                                  accents:@{kAccent100Name : ColorFromRGB(0xFF8A80),
                                            kAccent200Name : ColorFromRGB(0xFF5252),
                                            kAccent400Name : ColorFromRGB(0xFF1744),
                                            kAccent700Name : ColorFromRGB(0xD50000)}];
  });
  return palette;
}

+ (MDCPalette *)pinkPalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{ kTint50Name : ColorFromRGB(0xFCE4EC),
                                             kTint100Name : ColorFromRGB(0xF8BBD0),
                                             kTint200Name : ColorFromRGB(0xF48FB1),
                                             kTint300Name : ColorFromRGB(0xF06292),
                                             kTint400Name : ColorFromRGB(0xEC407A),
                                             kTint500Name : ColorFromRGB(0xE91E63),
                                             kTint600Name : ColorFromRGB(0xD81B60),
                                             kTint700Name : ColorFromRGB(0xC2185B),
                                             kTint800Name : ColorFromRGB(0xAD1457),
                                             kTint900Name : ColorFromRGB(0x880E4F) }
                                  accents:@{kAccent100Name : ColorFromRGB(0xFF80AB),
                                            kAccent200Name : ColorFromRGB(0xFF4081),
                                            kAccent400Name : ColorFromRGB(0xF50057),
                                            kAccent700Name : ColorFromRGB(0xC51162)}];
  });
  return palette;
}

+ (MDCPalette *)purplePalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{ kTint50Name : ColorFromRGB(0xF3E5F5),
                                             kTint100Name : ColorFromRGB(0xE1BEE7),
                                             kTint200Name : ColorFromRGB(0xCE93D8),
                                             kTint300Name : ColorFromRGB(0xBA68C8),
                                             kTint400Name : ColorFromRGB(0xAB47BC),
                                             kTint500Name : ColorFromRGB(0x9C27B0),
                                             kTint600Name : ColorFromRGB(0x8E24AA),
                                             kTint700Name : ColorFromRGB(0x7B1FA2),
                                             kTint800Name : ColorFromRGB(0x6A1B9A),
                                             kTint900Name : ColorFromRGB(0x4A148C) }
                                  accents:@{kAccent100Name : ColorFromRGB(0xEA80FC),
                                            kAccent200Name : ColorFromRGB(0xE040FB),
                                            kAccent400Name : ColorFromRGB(0xD500F9),
                                            kAccent700Name : ColorFromRGB(0xAA00FF)}];
  });
  return palette;
}

+ (MDCPalette *)deepPurplePalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{ kTint50Name : ColorFromRGB(0xEDE7F6),
                                             kTint100Name : ColorFromRGB(0xD1C4E9),
                                             kTint200Name : ColorFromRGB(0xB39DDB),
                                             kTint300Name : ColorFromRGB(0x9575CD),
                                             kTint400Name : ColorFromRGB(0x7E57C2),
                                             kTint500Name : ColorFromRGB(0x673AB7),
                                             kTint600Name : ColorFromRGB(0x5E35B1),
                                             kTint700Name : ColorFromRGB(0x512DA8),
                                             kTint800Name : ColorFromRGB(0x4527A0),
                                             kTint900Name : ColorFromRGB(0x311B92) }
                                  accents:@{kAccent100Name : ColorFromRGB(0xB388FF),
                                            kAccent200Name : ColorFromRGB(0x7C4DFF),
                                            kAccent400Name : ColorFromRGB(0x651FFF),
                                            kAccent700Name : ColorFromRGB(0x6200EA)}];
  });
  return palette;
}

+ (MDCPalette *)indigoPalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{ kTint50Name : ColorFromRGB(0xE8EAF6),
                                             kTint100Name : ColorFromRGB(0xC5CAE9),
                                             kTint200Name : ColorFromRGB(0x9FA8DA),
                                             kTint300Name : ColorFromRGB(0x7986CB),
                                             kTint400Name : ColorFromRGB(0x5C6BC0),
                                             kTint500Name : ColorFromRGB(0x3F51B5),
                                             kTint600Name : ColorFromRGB(0x3949AB),
                                             kTint700Name : ColorFromRGB(0x303F9F),
                                             kTint800Name : ColorFromRGB(0x283593),
                                             kTint900Name : ColorFromRGB(0x1A237E) }
                                  accents:@{kAccent100Name : ColorFromRGB(0x8C9EFF),
                                            kAccent200Name : ColorFromRGB(0x536DFE),
                                            kAccent400Name : ColorFromRGB(0x3D5AFE),
                                            kAccent700Name : ColorFromRGB(0x304FFE)}];
  });
  return palette;
}

+ (MDCPalette *)bluePalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{ kTint50Name : ColorFromRGB(0xE3F2FD),
                                             kTint100Name : ColorFromRGB(0xBBDEFB),
                                             kTint200Name : ColorFromRGB(0x90CAF9),
                                             kTint300Name : ColorFromRGB(0x64B5F6),
                                             kTint400Name : ColorFromRGB(0x42A5F5),
                                             kTint500Name : ColorFromRGB(0x2196F3),
                                             kTint600Name : ColorFromRGB(0x1E88E5),
                                             kTint700Name : ColorFromRGB(0x1976D2),
                                             kTint800Name : ColorFromRGB(0x1565C0),
                                             kTint900Name : ColorFromRGB(0x0D47A1) }
                                  accents:@{kAccent100Name : ColorFromRGB(0x82B1FF),
                                            kAccent200Name : ColorFromRGB(0x448AFF),
                                            kAccent400Name : ColorFromRGB(0x2979FF),
                                            kAccent700Name : ColorFromRGB(0x2962FF)}];
  });
  return palette;
}

+ (MDCPalette *)lightBluePalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{ kTint50Name : ColorFromRGB(0xE1F5FE),
                                             kTint100Name : ColorFromRGB(0xB3E5FC),
                                             kTint200Name : ColorFromRGB(0x81D4FA),
                                             kTint300Name : ColorFromRGB(0x4FC3F7),
                                             kTint400Name : ColorFromRGB(0x29B6F6),
                                             kTint500Name : ColorFromRGB(0x03A9F4),
                                             kTint600Name : ColorFromRGB(0x039BE5),
                                             kTint700Name : ColorFromRGB(0x0288D1),
                                             kTint800Name : ColorFromRGB(0x0277BD),
                                             kTint900Name : ColorFromRGB(0x01579B) }
                                  accents:@{kAccent100Name : ColorFromRGB(0x80D8FF),
                                            kAccent200Name : ColorFromRGB(0x40C4FF),
                                            kAccent400Name : ColorFromRGB(0x00B0FF),
                                            kAccent700Name : ColorFromRGB(0x0091EA)}];
  });
  return palette;
}

+ (MDCPalette *)cyanPalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{ kTint50Name : ColorFromRGB(0xE0F7FA),
                                             kTint100Name : ColorFromRGB(0xB2EBF2),
                                             kTint200Name : ColorFromRGB(0x80DEEA),
                                             kTint300Name : ColorFromRGB(0x4DD0E1),
                                             kTint400Name : ColorFromRGB(0x26C6DA),
                                             kTint500Name : ColorFromRGB(0x00BCD4),
                                             kTint600Name : ColorFromRGB(0x00ACC1),
                                             kTint700Name : ColorFromRGB(0x0097A7),
                                             kTint800Name : ColorFromRGB(0x00838F),
                                             kTint900Name : ColorFromRGB(0x006064) }
                                  accents:@{kAccent100Name : ColorFromRGB(0x84FFFF),
                                            kAccent200Name : ColorFromRGB(0x18FFFF),
                                            kAccent400Name : ColorFromRGB(0x00E5FF),
                                            kAccent700Name : ColorFromRGB(0x00B8D4)}];
  });
  return palette;
}

+ (MDCPalette *)tealPalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{ kTint50Name : ColorFromRGB(0xE0F2F1),
                                             kTint100Name : ColorFromRGB(0xB2DFDB),
                                             kTint200Name : ColorFromRGB(0x80CBC4),
                                             kTint300Name : ColorFromRGB(0x4DB6AC),
                                             kTint400Name : ColorFromRGB(0x26A69A),
                                             kTint500Name : ColorFromRGB(0x009688),
                                             kTint600Name : ColorFromRGB(0x00897B),
                                             kTint700Name : ColorFromRGB(0x00796B),
                                             kTint800Name : ColorFromRGB(0x00695C),
                                             kTint900Name : ColorFromRGB(0x004D40) }
                                  accents:@{kAccent100Name : ColorFromRGB(0xA7FFEB),
                                            kAccent200Name : ColorFromRGB(0x64FFDA),
                                            kAccent400Name : ColorFromRGB(0x1DE9B6),
                                            kAccent700Name : ColorFromRGB(0x00BFA5)}];
  });
  return palette;
}

+ (MDCPalette *)greenPalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{ kTint50Name : ColorFromRGB(0xE8F5E9),
                                             kTint100Name : ColorFromRGB(0xC8E6C9),
                                             kTint200Name : ColorFromRGB(0xA5D6A7),
                                             kTint300Name : ColorFromRGB(0x81C784),
                                             kTint400Name : ColorFromRGB(0x66BB6A),
                                             kTint500Name : ColorFromRGB(0x4CAF50),
                                             kTint600Name : ColorFromRGB(0x43A047),
                                             kTint700Name : ColorFromRGB(0x388E3C),
                                             kTint800Name : ColorFromRGB(0x2E7D32),
                                             kTint900Name : ColorFromRGB(0x1B5E20) }
                                  accents:@{kAccent100Name : ColorFromRGB(0xB9F6CA),
                                            kAccent200Name : ColorFromRGB(0x69F0AE),
                                            kAccent400Name : ColorFromRGB(0x00E676),
                                            kAccent700Name : ColorFromRGB(0x00C853)}];
  });
  return palette;
}

+ (MDCPalette *)lightGreenPalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{ kTint50Name : ColorFromRGB(0xF1F8E9),
                                             kTint100Name : ColorFromRGB(0xDCEDC8),
                                             kTint200Name : ColorFromRGB(0xC5E1A5),
                                             kTint300Name : ColorFromRGB(0xAED581),
                                             kTint400Name : ColorFromRGB(0x9CCC65),
                                             kTint500Name : ColorFromRGB(0x8BC34A),
                                             kTint600Name : ColorFromRGB(0x7CB342),
                                             kTint700Name : ColorFromRGB(0x689F38),
                                             kTint800Name : ColorFromRGB(0x558B2F),
                                             kTint900Name : ColorFromRGB(0x33691E) }
                                  accents:@{kAccent100Name : ColorFromRGB(0xCCFF90),
                                            kAccent200Name : ColorFromRGB(0xB2FF59),
                                            kAccent400Name : ColorFromRGB(0x76FF03),
                                            kAccent700Name : ColorFromRGB(0x64DD17)}];
  });
  return palette;
}

+ (MDCPalette *)limePalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{ kTint50Name : ColorFromRGB(0xF9FBE7),
                                             kTint100Name : ColorFromRGB(0xF0F4C3),
                                             kTint200Name : ColorFromRGB(0xE6EE9C),
                                             kTint300Name : ColorFromRGB(0xDCE775),
                                             kTint400Name : ColorFromRGB(0xD4E157),
                                             kTint500Name : ColorFromRGB(0xCDDC39),
                                             kTint600Name : ColorFromRGB(0xC0CA33),
                                             kTint700Name : ColorFromRGB(0xAFB42B),
                                             kTint800Name : ColorFromRGB(0x9E9D24),
                                             kTint900Name : ColorFromRGB(0x827717) }
                                  accents:@{kAccent100Name : ColorFromRGB(0xF4FF81),
                                            kAccent200Name : ColorFromRGB(0xEEFF41),
                                            kAccent400Name : ColorFromRGB(0xC6FF00),
                                            kAccent700Name : ColorFromRGB(0xAEEA00)}];
  });
  return palette;
}

+ (MDCPalette *)yellowPalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{ kTint50Name : ColorFromRGB(0xFFFDE7),
                                             kTint100Name : ColorFromRGB(0xFFF9C4),
                                             kTint200Name : ColorFromRGB(0xFFF59D),
                                             kTint300Name : ColorFromRGB(0xFFF176),
                                             kTint400Name : ColorFromRGB(0xFFEE58),
                                             kTint500Name : ColorFromRGB(0xFFEB3B),
                                             kTint600Name : ColorFromRGB(0xFDD835),
                                             kTint700Name : ColorFromRGB(0xFBC02D),
                                             kTint800Name : ColorFromRGB(0xF9A825),
                                             kTint900Name : ColorFromRGB(0xF57F17) }
                                  accents:@{kAccent100Name : ColorFromRGB(0xFFFF8D),
                                            kAccent200Name : ColorFromRGB(0xFFFF00),
                                            kAccent400Name : ColorFromRGB(0xFFEA00),
                                            kAccent700Name : ColorFromRGB(0xFFD600)}];
  });
  return palette;
}

+ (MDCPalette *)amberPalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{ kTint50Name : ColorFromRGB(0xFFF8E1),
                                             kTint100Name : ColorFromRGB(0xFFECB3),
                                             kTint200Name : ColorFromRGB(0xFFE082),
                                             kTint300Name : ColorFromRGB(0xFFD54F),
                                             kTint400Name : ColorFromRGB(0xFFCA28),
                                             kTint500Name : ColorFromRGB(0xFFC107),
                                             kTint600Name : ColorFromRGB(0xFFB300),
                                             kTint700Name : ColorFromRGB(0xFFA000),
                                             kTint800Name : ColorFromRGB(0xFF8F00),
                                             kTint900Name : ColorFromRGB(0xFF6F00) }
                                  accents:@{kAccent100Name : ColorFromRGB(0xFFE57F),
                                            kAccent200Name : ColorFromRGB(0xFFD740),
                                            kAccent400Name : ColorFromRGB(0xFFC400),
                                            kAccent700Name : ColorFromRGB(0xFFAB00)}];
  });
  return palette;
}

+ (MDCPalette *)orangePalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{ kTint50Name : ColorFromRGB(0xFFF3E0),
                                             kTint100Name : ColorFromRGB(0xFFE0B2),
                                             kTint200Name : ColorFromRGB(0xFFCC80),
                                             kTint300Name : ColorFromRGB(0xFFB74D),
                                             kTint400Name : ColorFromRGB(0xFFA726),
                                             kTint500Name : ColorFromRGB(0xFF9800),
                                             kTint600Name : ColorFromRGB(0xFB8C00),
                                             kTint700Name : ColorFromRGB(0xF57C00),
                                             kTint800Name : ColorFromRGB(0xEF6C00),
                                             kTint900Name : ColorFromRGB(0xE65100) }
                                  accents:@{kAccent100Name : ColorFromRGB(0xFFD180),
                                            kAccent200Name : ColorFromRGB(0xFFAB40),
                                            kAccent400Name : ColorFromRGB(0xFF9100),
                                            kAccent700Name : ColorFromRGB(0xFF6D00)}];
  });
  return palette;
}

+ (MDCPalette *)deepOrangePalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{ kTint50Name : ColorFromRGB(0xFBE9E7),
                                             kTint100Name : ColorFromRGB(0xFFCCBC),
                                             kTint200Name : ColorFromRGB(0xFFAB91),
                                             kTint300Name : ColorFromRGB(0xFF8A65),
                                             kTint400Name : ColorFromRGB(0xFF7043),
                                             kTint500Name : ColorFromRGB(0xFF5722),
                                             kTint600Name : ColorFromRGB(0xF4511E),
                                             kTint700Name : ColorFromRGB(0xE64A19),
                                             kTint800Name : ColorFromRGB(0xD84315),
                                             kTint900Name : ColorFromRGB(0xBF360C) }
                                  accents:@{kAccent100Name : ColorFromRGB(0xFF9E80),
                                            kAccent200Name : ColorFromRGB(0xFF6E40),
                                            kAccent400Name : ColorFromRGB(0xFF3D00),
                                            kAccent700Name : ColorFromRGB(0xDD2C00)}];
  });
  return palette;
}

+ (MDCPalette *)brownPalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{ kTint50Name : ColorFromRGB(0xEFEBE9),
                                             kTint100Name : ColorFromRGB(0xD7CCC8),
                                             kTint200Name : ColorFromRGB(0xBCAAA4),
                                             kTint300Name : ColorFromRGB(0xA1887F),
                                             kTint400Name : ColorFromRGB(0x8D6E63),
                                             kTint500Name : ColorFromRGB(0x795548),
                                             kTint600Name : ColorFromRGB(0x6D4C41),
                                             kTint700Name : ColorFromRGB(0x5D4037),
                                             kTint800Name : ColorFromRGB(0x4E342E),
                                             kTint900Name : ColorFromRGB(0x3E2723) }
                                  accents:nil];
  });
  return palette;
}

+ (MDCPalette *)greyPalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{ kTint50Name : ColorFromRGB(0xFAFAFA),
                                             kTint100Name : ColorFromRGB(0xF5F5F5),
                                             kTint200Name : ColorFromRGB(0xEEEEEE),
                                             kTint300Name : ColorFromRGB(0xE0E0E0),
                                             kTint400Name : ColorFromRGB(0xBDBDBD),
                                             kTint500Name : ColorFromRGB(0x9E9E9E),
                                             kTint600Name : ColorFromRGB(0x757575),
                                             kTint700Name : ColorFromRGB(0x616161),
                                             kTint800Name : ColorFromRGB(0x424242),
                                             kTint900Name : ColorFromRGB(0x212121) }
                                  accents:nil];
  });
  return palette;
}

+ (MDCPalette *)blueGreyPalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{ kTint50Name : ColorFromRGB(0xECEFF1),
                                             kTint100Name : ColorFromRGB(0xCFD8DC),
                                             kTint200Name : ColorFromRGB(0xB0BEC5),
                                             kTint300Name : ColorFromRGB(0x90A4AE),
                                             kTint400Name : ColorFromRGB(0x78909C),
                                             kTint500Name : ColorFromRGB(0x607D8B),
                                             kTint600Name : ColorFromRGB(0x546E7A),
                                             kTint700Name : ColorFromRGB(0x455A64),
                                             kTint800Name : ColorFromRGB(0x37474F),
                                             kTint900Name : ColorFromRGB(0x263238) }
                                  accents:nil];
  });
  return palette;
}

- (instancetype)initWithTints:(NSDictionary *)tints accents:(NSDictionary *)accents {
  self = [super init];
  if (self) {
    _tints = [tints copy];
    _accents = accents ? [accents copy] : @{};
  }
  return self;
}

- (UIColor *)tint50 {
  return _tints[kTint50Name];
}

- (UIColor *)tint100 {
  return _tints[kTint100Name];
}

- (UIColor *)tint200 {
  return _tints[kTint200Name];
}

- (UIColor *)tint300 {
  return _tints[kTint300Name];
}

- (UIColor *)tint400 {
  return _tints[kTint400Name];
}

- (UIColor *)tint500 {
  return _tints[kTint500Name];
}

- (UIColor *)tint600 {
  return _tints[kTint600Name];
}

- (UIColor *)tint700 {
  return _tints[kTint700Name];
}

- (UIColor *)tint800 {
  return _tints[kTint800Name];
}

- (UIColor *)tint900 {
  return _tints[kTint900Name];
}

- (UIColor *)accent100 {
  return _accents[kAccent100Name];
}

- (UIColor *)accent200 {
  return _accents[kAccent200Name];
}

- (UIColor *)accent400 {
  return _accents[kAccent400Name];
}

- (UIColor *)accent700 {
  return _accents[kAccent700Name];
}

@end
