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
#import "MDCControlState.h"

@interface MDCColorResource ()

/**
 [TBD]
 */
@property(nonatomic, strong, readwrite, nullable) NSString *hex;
@property(nonatomic, assign, readwrite) MDCColorResourceSemantic semantic;
@property(nonatomic, assign, readwrite) MDCColorResourcePalette palette;
@property(nonatomic, assign, readwrite) MDCColorResourcePaletteTint tint;
@property(nonatomic, assign, readwrite) CGFloat opacity;
@property(nonatomic, assign, readwrite) CGFloat dim;

@end

@implementation MDCColorResource

- (nonnull instancetype)initWithSemanticResource:(MDCColorResourceSemantic)semanticResource {
  return [self initWithSemanticResource:semanticResource
                                opacity:MDCColorResourceDefaultOpacity
                                    dim:MDCColorResourceDefaultDim];
}

- (nonnull instancetype)initWithSemanticResource:(MDCColorResourceSemantic)semanticResource
                                         opacity:(CGFloat)opacity
                                             dim:(CGFloat)dim {
  self = [super init];
  if (self) {
    self.semantic = semanticResource;
    self.opacity = opacity;
    self.dim = dim;

    self.palette = MDCColorResourcePaletteNone;
    self.tint = MDCColorResourcePaletteTintNone;
    self.hex = nil;
  }
  return self;
}

- (nonnull instancetype)initWithPaletteResource:(MDCColorResourcePalette)palette
                                           tint:(MDCColorResourcePaletteTint)tint {
  return [self initWithPaletteResource:palette
                                  tint:tint
                               opacity:MDCColorResourceDefaultOpacity
                                   dim:MDCColorResourceDefaultDim];
}

- (nonnull instancetype)initWithPaletteResource:(MDCColorResourcePalette)palette
                                           tint:(MDCColorResourcePaletteTint)tint
                                        opacity:(CGFloat)opacity
                                            dim:(CGFloat)dim {
  self = [super init];
  if (self) {
    self.palette = palette;
    self.tint = tint;
    self.opacity = opacity;
    self.dim = dim;

    self.semantic = MDCColorResourceSemanticNone;
    self.hex = nil;
  }
  return self;
}

- (nonnull instancetype)initWithHexString:(NSString *)hex {
  return [self initWithHexString:hex
                         opacity:MDCColorResourceDefaultOpacity
                             dim:MDCColorResourceDefaultDim];
}

// Expecting hex string with format: #999999
- (nonnull instancetype)initWithHexString:(NSString *)hex
                                  opacity:(CGFloat)opacity
                                      dim:(CGFloat)dim {
  if (hex.length != 7) {
    return nil;  // Invalid hex string
  }
  // Extract the last 6 charachters
  unsigned int hexval;
  NSString *hexString = [hex substringFromIndex:1];
  NSScanner *scanner = [NSScanner scannerWithString:hexString];
  [scanner scanHexInt:&hexval];
  if (hexval == 0) {
    return nil;  // Invalid hex string
  }
  self = [super init];
  if (self) {
    self.hex = [NSString stringWithFormat:@"#%@", hexString];
    self.opacity = opacity;
    self.dim = dim;

    self.palette = MDCColorResourcePaletteNone;
    self.tint = MDCColorResourcePaletteTintNone;
    self.semantic = MDCColorResourceSemanticNone;
  }
  return self;
}

- (NSString *)description {
  return [NSString
      stringWithFormat:@"semantic: %@ | palette: %@, tint: %@, hex: %@, opacity: %.2f, dim: %.2f",
                       [self semanticNameFromResource:self.semantic],
                       [self paletteNameFromResource:self.palette],
                       [self paletteTintNameFromResource:self.tint], self.hex, self.opacity,
                       self.dim];
}

- (nullable NSString *)semanticNameFromResource:(MDCColorResourceSemantic)semantic {
  switch (semantic) {
    case MDCColorResourceSemanticPrimary:
      return @"primary";
      break;
    case MDCColorResourceSemanticOnPrimary:
      return @"on-primary";
      break;
    case MDCColorResourceSemanticSurface:
      return @"surface";
      break;
    case MDCColorResourceSemanticOnSurface:
      return @"on-surface";
      break;
    case MDCColorResourceSemanticOverlay:
      return @"overlay";
      break;
    case MDCColorResourceSemanticBackground:
      return @"background";
      break;
    case MDCColorResourceSemanticOnBackground:
      return @"on-background";
      break;
    case MDCColorResourceSemanticOutline:
      return @"outline";
      break;
    case MDCColorResourceSemanticError:
      return @"error";
      break;
    case MDCColorResourceSemanticNone:
      return nil;
      break;
  }
}

- (nullable NSString *)paletteNameFromResource:(MDCColorResourcePalette)palette {
  switch (palette) {
    case MDCColorResourcePaletteGrey:
      return @"grey";
      break;
    case MDCColorResourcePaletteBlueGrey:
      return @"bluegrey";
      break;
    case MDCColorResourcePaletteBlue:
      return @"blue";
      break;
    case MDCColorResourcePaletteIndigo:
      return @"indigo";
      break;
    case MDCColorResourcePalettePurple:
      return @"purple";
      break;
    case MDCColorResourcePaletteRed:
      return @"red";
      break;
    case MDCColorResourcePaletteOrange:
      return @"orange";
      break;
    case MDCColorResourcePaletteYellow:
      return @"yellow";
      break;
    case MDCColorResourcePaletteNone:
      return nil;
      break;
  }
}

- (nullable NSString *)paletteTintNameFromResource:(MDCColorResourcePaletteTint)tint {
  switch (tint) {
    case MDCColorResourcePaletteTint50:
      return @"50";
      break;
    case MDCColorResourcePaletteTint100:
      return @"100";
      break;
    case MDCColorResourcePaletteTint200:
      return @"200";
      break;
    case MDCColorResourcePaletteTint300:
      return @"300";
      break;
    case MDCColorResourcePaletteTint400:
      return @"400";
      break;
    case MDCColorResourcePaletteTint500:
      return @"500";
      break;
    case MDCColorResourcePaletteTint600:
      return @"600";
      break;
    case MDCColorResourcePaletteTint700:
      return @"700";
      break;
    case MDCColorResourcePaletteTint800:
      return @"800";
      break;
    case MDCColorResourcePaletteTint900:
      return @"900";
      break;
    case MDCColorResourcePaletteTintNone:
      return nil;
      break;
  }
}

- (MDCColorResourceSemantic)semanticResourceFromName:(NSString *)semanticName {
  if ([semanticName isEqualToString:@"primary"]) {
    return MDCColorResourceSemanticPrimary;
  }
  if ([semanticName isEqualToString:@"on-primary"]) {
    return MDCColorResourceSemanticOnPrimary;
  }
  if ([semanticName isEqualToString:@"surface"]) {
    return MDCColorResourceSemanticSurface;
  }
  if ([semanticName isEqualToString:@"on-surface"]) {
    return MDCColorResourceSemanticOnSurface;
  }
  if ([semanticName isEqualToString:@"overlay"]) {
    return MDCColorResourceSemanticOverlay;
  }
  if ([semanticName isEqualToString:@"background"]) {
    return MDCColorResourceSemanticBackground;
  }
  if ([semanticName isEqualToString:@"on-background"]) {
    return MDCColorResourceSemanticOnBackground;
  }
  if ([semanticName isEqualToString:@"outline"]) {
    return MDCColorResourceSemanticOutline;
  }
  if ([semanticName isEqualToString:@"error"]) {
    return MDCColorResourceSemanticError;
  }
  return MDCColorResourceSemanticNone;
}

- (MDCColorResourcePalette)paletteResourceFromName:(NSString *)paletteName {
  if ([paletteName isEqualToString:@"grey"]) {
    return MDCColorResourcePaletteGrey;
  }
  if ([paletteName isEqualToString:@"blue"]) {
    return MDCColorResourcePaletteBlue;
  }
  if ([paletteName isEqualToString:@"bluegrey"]) {
    return MDCColorResourcePaletteBlueGrey;
  }
  if ([paletteName isEqualToString:@"indigo"]) {
    return MDCColorResourcePaletteIndigo;
  }
  if ([paletteName isEqualToString:@"purple"]) {
    return MDCColorResourcePalettePurple;
  }
  if ([paletteName isEqualToString:@"red"]) {
    return MDCColorResourcePaletteRed;
  }
  if ([paletteName isEqualToString:@"orange"]) {
    return MDCColorResourcePaletteOrange;
  }
  if ([paletteName isEqualToString:@"yellow"]) {
    return MDCColorResourcePaletteYellow;
  }
  return MDCColorResourcePaletteNone;
}

- (MDCColorResourcePaletteTint)paletteTintResourceFromName:(NSString *)tintName {
  if ([tintName isEqualToString:@"50"]) {
    return MDCColorResourcePaletteTint50;
  }
  if ([tintName isEqualToString:@"100"]) {
    return MDCColorResourcePaletteTint100;
  }
  if ([tintName isEqualToString:@"200"]) {
    return MDCColorResourcePaletteTint200;
  }
  if ([tintName isEqualToString:@"300"]) {
    return MDCColorResourcePaletteTint300;
  }
  if ([tintName isEqualToString:@"400"]) {
    return MDCColorResourcePaletteTint400;
  }
  if ([tintName isEqualToString:@"500"]) {
    return MDCColorResourcePaletteTint500;
  }
  if ([tintName isEqualToString:@"600"]) {
    return MDCColorResourcePaletteTint600;
  }
  if ([tintName isEqualToString:@"700"]) {
    return MDCColorResourcePaletteTint700;
  }
  if ([tintName isEqualToString:@"800"]) {
    return MDCColorResourcePaletteTint800;
  }
  if ([tintName isEqualToString:@"900"]) {
    return MDCColorResourcePaletteTint900;
  }

  return MDCColorResourcePaletteTintNone;
}

@end
