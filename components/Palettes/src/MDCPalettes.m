/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCColorUtility.h"
#import "private/MDCPaletteExpansions.h"
#import "private/MDCPaletteNames.h"

const MDCPaletteTint MDCPaletteTint50Name = MDC_PALETTE_TINT_50_INTERNAL_NAME;
const MDCPaletteTint MDCPaletteTint100Name = MDC_PALETTE_TINT_100_INTERNAL_NAME;
const MDCPaletteTint MDCPaletteTint200Name = MDC_PALETTE_TINT_200_INTERNAL_NAME;
const MDCPaletteTint MDCPaletteTint300Name = MDC_PALETTE_TINT_300_INTERNAL_NAME;
const MDCPaletteTint MDCPaletteTint400Name = MDC_PALETTE_TINT_400_INTERNAL_NAME;
const MDCPaletteTint MDCPaletteTint500Name = MDC_PALETTE_TINT_500_INTERNAL_NAME;
const MDCPaletteTint MDCPaletteTint600Name = MDC_PALETTE_TINT_600_INTERNAL_NAME;
const MDCPaletteTint MDCPaletteTint700Name = MDC_PALETTE_TINT_700_INTERNAL_NAME;
const MDCPaletteTint MDCPaletteTint800Name = MDC_PALETTE_TINT_800_INTERNAL_NAME;
const MDCPaletteTint MDCPaletteTint900Name = MDC_PALETTE_TINT_900_INTERNAL_NAME;

const MDCPaletteAccent MDCPaletteAccent100Name = MDC_PALETTE_ACCENT_100_INTERNAL_NAME;
const MDCPaletteAccent MDCPaletteAccent200Name = MDC_PALETTE_ACCENT_200_INTERNAL_NAME;
const MDCPaletteAccent MDCPaletteAccent400Name = MDC_PALETTE_ACCENT_400_INTERNAL_NAME;
const MDCPaletteAccent MDCPaletteAccent700Name = MDC_PALETTE_ACCENT_700_INTERNAL_NAME;

@interface MDCPalette () {
  NSDictionary<MDCPaletteTint, UIColor *> *_tints;
  NSDictionary<MDCPaletteAccent, UIColor *> *_accents;
}

@end

@implementation MDCPalette

+ (MDCPalette *)redPalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{
      MDCPaletteTint50Name : MDCColorFromRGB(0xFFEBEE),
      MDCPaletteTint100Name : MDCColorFromRGB(0xFFCDD2),
      MDCPaletteTint200Name : MDCColorFromRGB(0xEF9A9A),
      MDCPaletteTint300Name : MDCColorFromRGB(0xE57373),
      MDCPaletteTint400Name : MDCColorFromRGB(0xEF5350),
      MDCPaletteTint500Name : MDCColorFromRGB(0xF44336),
      MDCPaletteTint600Name : MDCColorFromRGB(0xE53935),
      MDCPaletteTint700Name : MDCColorFromRGB(0xD32F2F),
      MDCPaletteTint800Name : MDCColorFromRGB(0xC62828),
      MDCPaletteTint900Name : MDCColorFromRGB(0xB71C1C)
    }
                                  accents:@{
                                    MDCPaletteAccent100Name : MDCColorFromRGB(0xFF8A80),
                                    MDCPaletteAccent200Name : MDCColorFromRGB(0xFF5252),
                                    MDCPaletteAccent400Name : MDCColorFromRGB(0xFF1744),
                                    MDCPaletteAccent700Name : MDCColorFromRGB(0xD50000)
                                  }];
  });
  return palette;
}

+ (MDCPalette *)pinkPalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{
      MDCPaletteTint50Name : MDCColorFromRGB(0xFCE4EC),
      MDCPaletteTint100Name : MDCColorFromRGB(0xF8BBD0),
      MDCPaletteTint200Name : MDCColorFromRGB(0xF48FB1),
      MDCPaletteTint300Name : MDCColorFromRGB(0xF06292),
      MDCPaletteTint400Name : MDCColorFromRGB(0xEC407A),
      MDCPaletteTint500Name : MDCColorFromRGB(0xE91E63),
      MDCPaletteTint600Name : MDCColorFromRGB(0xD81B60),
      MDCPaletteTint700Name : MDCColorFromRGB(0xC2185B),
      MDCPaletteTint800Name : MDCColorFromRGB(0xAD1457),
      MDCPaletteTint900Name : MDCColorFromRGB(0x880E4F)
    }
                                  accents:@{
                                    MDCPaletteAccent100Name : MDCColorFromRGB(0xFF80AB),
                                    MDCPaletteAccent200Name : MDCColorFromRGB(0xFF4081),
                                    MDCPaletteAccent400Name : MDCColorFromRGB(0xF50057),
                                    MDCPaletteAccent700Name : MDCColorFromRGB(0xC51162)
                                  }];
  });
  return palette;
}

+ (MDCPalette *)purplePalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{
      MDCPaletteTint50Name : MDCColorFromRGB(0xF3E5F5),
      MDCPaletteTint100Name : MDCColorFromRGB(0xE1BEE7),
      MDCPaletteTint200Name : MDCColorFromRGB(0xCE93D8),
      MDCPaletteTint300Name : MDCColorFromRGB(0xBA68C8),
      MDCPaletteTint400Name : MDCColorFromRGB(0xAB47BC),
      MDCPaletteTint500Name : MDCColorFromRGB(0x9C27B0),
      MDCPaletteTint600Name : MDCColorFromRGB(0x8E24AA),
      MDCPaletteTint700Name : MDCColorFromRGB(0x7B1FA2),
      MDCPaletteTint800Name : MDCColorFromRGB(0x6A1B9A),
      MDCPaletteTint900Name : MDCColorFromRGB(0x4A148C)
    }
                                  accents:@{
                                    MDCPaletteAccent100Name : MDCColorFromRGB(0xEA80FC),
                                    MDCPaletteAccent200Name : MDCColorFromRGB(0xE040FB),
                                    MDCPaletteAccent400Name : MDCColorFromRGB(0xD500F9),
                                    MDCPaletteAccent700Name : MDCColorFromRGB(0xAA00FF)
                                  }];
  });
  return palette;
}

+ (MDCPalette *)deepPurplePalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{
      MDCPaletteTint50Name : MDCColorFromRGB(0xEDE7F6),
      MDCPaletteTint100Name : MDCColorFromRGB(0xD1C4E9),
      MDCPaletteTint200Name : MDCColorFromRGB(0xB39DDB),
      MDCPaletteTint300Name : MDCColorFromRGB(0x9575CD),
      MDCPaletteTint400Name : MDCColorFromRGB(0x7E57C2),
      MDCPaletteTint500Name : MDCColorFromRGB(0x673AB7),
      MDCPaletteTint600Name : MDCColorFromRGB(0x5E35B1),
      MDCPaletteTint700Name : MDCColorFromRGB(0x512DA8),
      MDCPaletteTint800Name : MDCColorFromRGB(0x4527A0),
      MDCPaletteTint900Name : MDCColorFromRGB(0x311B92)
    }
                                  accents:@{
                                    MDCPaletteAccent100Name : MDCColorFromRGB(0xB388FF),
                                    MDCPaletteAccent200Name : MDCColorFromRGB(0x7C4DFF),
                                    MDCPaletteAccent400Name : MDCColorFromRGB(0x651FFF),
                                    MDCPaletteAccent700Name : MDCColorFromRGB(0x6200EA)
                                  }];
  });
  return palette;
}

+ (MDCPalette *)indigoPalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{
      MDCPaletteTint50Name : MDCColorFromRGB(0xE8EAF6),
      MDCPaletteTint100Name : MDCColorFromRGB(0xC5CAE9),
      MDCPaletteTint200Name : MDCColorFromRGB(0x9FA8DA),
      MDCPaletteTint300Name : MDCColorFromRGB(0x7986CB),
      MDCPaletteTint400Name : MDCColorFromRGB(0x5C6BC0),
      MDCPaletteTint500Name : MDCColorFromRGB(0x3F51B5),
      MDCPaletteTint600Name : MDCColorFromRGB(0x3949AB),
      MDCPaletteTint700Name : MDCColorFromRGB(0x303F9F),
      MDCPaletteTint800Name : MDCColorFromRGB(0x283593),
      MDCPaletteTint900Name : MDCColorFromRGB(0x1A237E)
    }
                                  accents:@{
                                    MDCPaletteAccent100Name : MDCColorFromRGB(0x8C9EFF),
                                    MDCPaletteAccent200Name : MDCColorFromRGB(0x536DFE),
                                    MDCPaletteAccent400Name : MDCColorFromRGB(0x3D5AFE),
                                    MDCPaletteAccent700Name : MDCColorFromRGB(0x304FFE)
                                  }];
  });
  return palette;
}

+ (MDCPalette *)bluePalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{
      MDCPaletteTint50Name : MDCColorFromRGB(0xE3F2FD),
      MDCPaletteTint100Name : MDCColorFromRGB(0xBBDEFB),
      MDCPaletteTint200Name : MDCColorFromRGB(0x90CAF9),
      MDCPaletteTint300Name : MDCColorFromRGB(0x64B5F6),
      MDCPaletteTint400Name : MDCColorFromRGB(0x42A5F5),
      MDCPaletteTint500Name : MDCColorFromRGB(0x2196F3),
      MDCPaletteTint600Name : MDCColorFromRGB(0x1E88E5),
      MDCPaletteTint700Name : MDCColorFromRGB(0x1976D2),
      MDCPaletteTint800Name : MDCColorFromRGB(0x1565C0),
      MDCPaletteTint900Name : MDCColorFromRGB(0x0D47A1)
    }
                                  accents:@{
                                    MDCPaletteAccent100Name : MDCColorFromRGB(0x82B1FF),
                                    MDCPaletteAccent200Name : MDCColorFromRGB(0x448AFF),
                                    MDCPaletteAccent400Name : MDCColorFromRGB(0x2979FF),
                                    MDCPaletteAccent700Name : MDCColorFromRGB(0x2962FF)
                                  }];
  });
  return palette;
}

+ (MDCPalette *)lightBluePalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{
      MDCPaletteTint50Name : MDCColorFromRGB(0xE1F5FE),
      MDCPaletteTint100Name : MDCColorFromRGB(0xB3E5FC),
      MDCPaletteTint200Name : MDCColorFromRGB(0x81D4FA),
      MDCPaletteTint300Name : MDCColorFromRGB(0x4FC3F7),
      MDCPaletteTint400Name : MDCColorFromRGB(0x29B6F6),
      MDCPaletteTint500Name : MDCColorFromRGB(0x03A9F4),
      MDCPaletteTint600Name : MDCColorFromRGB(0x039BE5),
      MDCPaletteTint700Name : MDCColorFromRGB(0x0288D1),
      MDCPaletteTint800Name : MDCColorFromRGB(0x0277BD),
      MDCPaletteTint900Name : MDCColorFromRGB(0x01579B)
    }
                                  accents:@{
                                    MDCPaletteAccent100Name : MDCColorFromRGB(0x80D8FF),
                                    MDCPaletteAccent200Name : MDCColorFromRGB(0x40C4FF),
                                    MDCPaletteAccent400Name : MDCColorFromRGB(0x00B0FF),
                                    MDCPaletteAccent700Name : MDCColorFromRGB(0x0091EA)
                                  }];
  });
  return palette;
}

+ (MDCPalette *)cyanPalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{
      MDCPaletteTint50Name : MDCColorFromRGB(0xE0F7FA),
      MDCPaletteTint100Name : MDCColorFromRGB(0xB2EBF2),
      MDCPaletteTint200Name : MDCColorFromRGB(0x80DEEA),
      MDCPaletteTint300Name : MDCColorFromRGB(0x4DD0E1),
      MDCPaletteTint400Name : MDCColorFromRGB(0x26C6DA),
      MDCPaletteTint500Name : MDCColorFromRGB(0x00BCD4),
      MDCPaletteTint600Name : MDCColorFromRGB(0x00ACC1),
      MDCPaletteTint700Name : MDCColorFromRGB(0x0097A7),
      MDCPaletteTint800Name : MDCColorFromRGB(0x00838F),
      MDCPaletteTint900Name : MDCColorFromRGB(0x006064)
    }
                                  accents:@{
                                    MDCPaletteAccent100Name : MDCColorFromRGB(0x84FFFF),
                                    MDCPaletteAccent200Name : MDCColorFromRGB(0x18FFFF),
                                    MDCPaletteAccent400Name : MDCColorFromRGB(0x00E5FF),
                                    MDCPaletteAccent700Name : MDCColorFromRGB(0x00B8D4)
                                  }];
  });
  return palette;
}

+ (MDCPalette *)tealPalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{
      MDCPaletteTint50Name : MDCColorFromRGB(0xE0F2F1),
      MDCPaletteTint100Name : MDCColorFromRGB(0xB2DFDB),
      MDCPaletteTint200Name : MDCColorFromRGB(0x80CBC4),
      MDCPaletteTint300Name : MDCColorFromRGB(0x4DB6AC),
      MDCPaletteTint400Name : MDCColorFromRGB(0x26A69A),
      MDCPaletteTint500Name : MDCColorFromRGB(0x009688),
      MDCPaletteTint600Name : MDCColorFromRGB(0x00897B),
      MDCPaletteTint700Name : MDCColorFromRGB(0x00796B),
      MDCPaletteTint800Name : MDCColorFromRGB(0x00695C),
      MDCPaletteTint900Name : MDCColorFromRGB(0x004D40)
    }
                                  accents:@{
                                    MDCPaletteAccent100Name : MDCColorFromRGB(0xA7FFEB),
                                    MDCPaletteAccent200Name : MDCColorFromRGB(0x64FFDA),
                                    MDCPaletteAccent400Name : MDCColorFromRGB(0x1DE9B6),
                                    MDCPaletteAccent700Name : MDCColorFromRGB(0x00BFA5)
                                  }];
  });
  return palette;
}

+ (MDCPalette *)greenPalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{
      MDCPaletteTint50Name : MDCColorFromRGB(0xE8F5E9),
      MDCPaletteTint100Name : MDCColorFromRGB(0xC8E6C9),
      MDCPaletteTint200Name : MDCColorFromRGB(0xA5D6A7),
      MDCPaletteTint300Name : MDCColorFromRGB(0x81C784),
      MDCPaletteTint400Name : MDCColorFromRGB(0x66BB6A),
      MDCPaletteTint500Name : MDCColorFromRGB(0x4CAF50),
      MDCPaletteTint600Name : MDCColorFromRGB(0x43A047),
      MDCPaletteTint700Name : MDCColorFromRGB(0x388E3C),
      MDCPaletteTint800Name : MDCColorFromRGB(0x2E7D32),
      MDCPaletteTint900Name : MDCColorFromRGB(0x1B5E20)
    }
                                  accents:@{
                                    MDCPaletteAccent100Name : MDCColorFromRGB(0xB9F6CA),
                                    MDCPaletteAccent200Name : MDCColorFromRGB(0x69F0AE),
                                    MDCPaletteAccent400Name : MDCColorFromRGB(0x00E676),
                                    MDCPaletteAccent700Name : MDCColorFromRGB(0x00C853)
                                  }];
  });
  return palette;
}

+ (MDCPalette *)lightGreenPalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{
      MDCPaletteTint50Name : MDCColorFromRGB(0xF1F8E9),
      MDCPaletteTint100Name : MDCColorFromRGB(0xDCEDC8),
      MDCPaletteTint200Name : MDCColorFromRGB(0xC5E1A5),
      MDCPaletteTint300Name : MDCColorFromRGB(0xAED581),
      MDCPaletteTint400Name : MDCColorFromRGB(0x9CCC65),
      MDCPaletteTint500Name : MDCColorFromRGB(0x8BC34A),
      MDCPaletteTint600Name : MDCColorFromRGB(0x7CB342),
      MDCPaletteTint700Name : MDCColorFromRGB(0x689F38),
      MDCPaletteTint800Name : MDCColorFromRGB(0x558B2F),
      MDCPaletteTint900Name : MDCColorFromRGB(0x33691E)
    }
                                  accents:@{
                                    MDCPaletteAccent100Name : MDCColorFromRGB(0xCCFF90),
                                    MDCPaletteAccent200Name : MDCColorFromRGB(0xB2FF59),
                                    MDCPaletteAccent400Name : MDCColorFromRGB(0x76FF03),
                                    MDCPaletteAccent700Name : MDCColorFromRGB(0x64DD17)
                                  }];
  });
  return palette;
}

+ (MDCPalette *)limePalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{
      MDCPaletteTint50Name : MDCColorFromRGB(0xF9FBE7),
      MDCPaletteTint100Name : MDCColorFromRGB(0xF0F4C3),
      MDCPaletteTint200Name : MDCColorFromRGB(0xE6EE9C),
      MDCPaletteTint300Name : MDCColorFromRGB(0xDCE775),
      MDCPaletteTint400Name : MDCColorFromRGB(0xD4E157),
      MDCPaletteTint500Name : MDCColorFromRGB(0xCDDC39),
      MDCPaletteTint600Name : MDCColorFromRGB(0xC0CA33),
      MDCPaletteTint700Name : MDCColorFromRGB(0xAFB42B),
      MDCPaletteTint800Name : MDCColorFromRGB(0x9E9D24),
      MDCPaletteTint900Name : MDCColorFromRGB(0x827717)
    }
                                  accents:@{
                                    MDCPaletteAccent100Name : MDCColorFromRGB(0xF4FF81),
                                    MDCPaletteAccent200Name : MDCColorFromRGB(0xEEFF41),
                                    MDCPaletteAccent400Name : MDCColorFromRGB(0xC6FF00),
                                    MDCPaletteAccent700Name : MDCColorFromRGB(0xAEEA00)
                                  }];
  });
  return palette;
}

+ (MDCPalette *)yellowPalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{
      MDCPaletteTint50Name : MDCColorFromRGB(0xFFFDE7),
      MDCPaletteTint100Name : MDCColorFromRGB(0xFFF9C4),
      MDCPaletteTint200Name : MDCColorFromRGB(0xFFF59D),
      MDCPaletteTint300Name : MDCColorFromRGB(0xFFF176),
      MDCPaletteTint400Name : MDCColorFromRGB(0xFFEE58),
      MDCPaletteTint500Name : MDCColorFromRGB(0xFFEB3B),
      MDCPaletteTint600Name : MDCColorFromRGB(0xFDD835),
      MDCPaletteTint700Name : MDCColorFromRGB(0xFBC02D),
      MDCPaletteTint800Name : MDCColorFromRGB(0xF9A825),
      MDCPaletteTint900Name : MDCColorFromRGB(0xF57F17)
    }
                                  accents:@{
                                    MDCPaletteAccent100Name : MDCColorFromRGB(0xFFFF8D),
                                    MDCPaletteAccent200Name : MDCColorFromRGB(0xFFFF00),
                                    MDCPaletteAccent400Name : MDCColorFromRGB(0xFFEA00),
                                    MDCPaletteAccent700Name : MDCColorFromRGB(0xFFD600)
                                  }];
  });
  return palette;
}

+ (MDCPalette *)amberPalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{
      MDCPaletteTint50Name : MDCColorFromRGB(0xFFF8E1),
      MDCPaletteTint100Name : MDCColorFromRGB(0xFFECB3),
      MDCPaletteTint200Name : MDCColorFromRGB(0xFFE082),
      MDCPaletteTint300Name : MDCColorFromRGB(0xFFD54F),
      MDCPaletteTint400Name : MDCColorFromRGB(0xFFCA28),
      MDCPaletteTint500Name : MDCColorFromRGB(0xFFC107),
      MDCPaletteTint600Name : MDCColorFromRGB(0xFFB300),
      MDCPaletteTint700Name : MDCColorFromRGB(0xFFA000),
      MDCPaletteTint800Name : MDCColorFromRGB(0xFF8F00),
      MDCPaletteTint900Name : MDCColorFromRGB(0xFF6F00)
    }
                                  accents:@{
                                    MDCPaletteAccent100Name : MDCColorFromRGB(0xFFE57F),
                                    MDCPaletteAccent200Name : MDCColorFromRGB(0xFFD740),
                                    MDCPaletteAccent400Name : MDCColorFromRGB(0xFFC400),
                                    MDCPaletteAccent700Name : MDCColorFromRGB(0xFFAB00)
                                  }];
  });
  return palette;
}

+ (MDCPalette *)orangePalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{
      MDCPaletteTint50Name : MDCColorFromRGB(0xFFF3E0),
      MDCPaletteTint100Name : MDCColorFromRGB(0xFFE0B2),
      MDCPaletteTint200Name : MDCColorFromRGB(0xFFCC80),
      MDCPaletteTint300Name : MDCColorFromRGB(0xFFB74D),
      MDCPaletteTint400Name : MDCColorFromRGB(0xFFA726),
      MDCPaletteTint500Name : MDCColorFromRGB(0xFF9800),
      MDCPaletteTint600Name : MDCColorFromRGB(0xFB8C00),
      MDCPaletteTint700Name : MDCColorFromRGB(0xF57C00),
      MDCPaletteTint800Name : MDCColorFromRGB(0xEF6C00),
      MDCPaletteTint900Name : MDCColorFromRGB(0xE65100)
    }
                                  accents:@{
                                    MDCPaletteAccent100Name : MDCColorFromRGB(0xFFD180),
                                    MDCPaletteAccent200Name : MDCColorFromRGB(0xFFAB40),
                                    MDCPaletteAccent400Name : MDCColorFromRGB(0xFF9100),
                                    MDCPaletteAccent700Name : MDCColorFromRGB(0xFF6D00)
                                  }];
  });
  return palette;
}

+ (MDCPalette *)deepOrangePalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{
      MDCPaletteTint50Name : MDCColorFromRGB(0xFBE9E7),
      MDCPaletteTint100Name : MDCColorFromRGB(0xFFCCBC),
      MDCPaletteTint200Name : MDCColorFromRGB(0xFFAB91),
      MDCPaletteTint300Name : MDCColorFromRGB(0xFF8A65),
      MDCPaletteTint400Name : MDCColorFromRGB(0xFF7043),
      MDCPaletteTint500Name : MDCColorFromRGB(0xFF5722),
      MDCPaletteTint600Name : MDCColorFromRGB(0xF4511E),
      MDCPaletteTint700Name : MDCColorFromRGB(0xE64A19),
      MDCPaletteTint800Name : MDCColorFromRGB(0xD84315),
      MDCPaletteTint900Name : MDCColorFromRGB(0xBF360C)
    }
                                  accents:@{
                                    MDCPaletteAccent100Name : MDCColorFromRGB(0xFF9E80),
                                    MDCPaletteAccent200Name : MDCColorFromRGB(0xFF6E40),
                                    MDCPaletteAccent400Name : MDCColorFromRGB(0xFF3D00),
                                    MDCPaletteAccent700Name : MDCColorFromRGB(0xDD2C00)
                                  }];
  });
  return palette;
}

+ (MDCPalette *)brownPalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{
      MDCPaletteTint50Name : MDCColorFromRGB(0xEFEBE9),
      MDCPaletteTint100Name : MDCColorFromRGB(0xD7CCC8),
      MDCPaletteTint200Name : MDCColorFromRGB(0xBCAAA4),
      MDCPaletteTint300Name : MDCColorFromRGB(0xA1887F),
      MDCPaletteTint400Name : MDCColorFromRGB(0x8D6E63),
      MDCPaletteTint500Name : MDCColorFromRGB(0x795548),
      MDCPaletteTint600Name : MDCColorFromRGB(0x6D4C41),
      MDCPaletteTint700Name : MDCColorFromRGB(0x5D4037),
      MDCPaletteTint800Name : MDCColorFromRGB(0x4E342E),
      MDCPaletteTint900Name : MDCColorFromRGB(0x3E2723)
    }
                                  accents:nil];
  });
  return palette;
}

+ (MDCPalette *)greyPalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{
      MDCPaletteTint50Name : MDCColorFromRGB(0xFAFAFA),
      MDCPaletteTint100Name : MDCColorFromRGB(0xF5F5F5),
      MDCPaletteTint200Name : MDCColorFromRGB(0xEEEEEE),
      MDCPaletteTint300Name : MDCColorFromRGB(0xE0E0E0),
      MDCPaletteTint400Name : MDCColorFromRGB(0xBDBDBD),
      MDCPaletteTint500Name : MDCColorFromRGB(0x9E9E9E),
      MDCPaletteTint600Name : MDCColorFromRGB(0x757575),
      MDCPaletteTint700Name : MDCColorFromRGB(0x616161),
      MDCPaletteTint800Name : MDCColorFromRGB(0x424242),
      MDCPaletteTint900Name : MDCColorFromRGB(0x212121)
    }
                                  accents:nil];
  });
  return palette;
}

+ (MDCPalette *)blueGreyPalette {
  static MDCPalette *palette;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    palette = [[self alloc] initWithTints:@{
      MDCPaletteTint50Name : MDCColorFromRGB(0xECEFF1),
      MDCPaletteTint100Name : MDCColorFromRGB(0xCFD8DC),
      MDCPaletteTint200Name : MDCColorFromRGB(0xB0BEC5),
      MDCPaletteTint300Name : MDCColorFromRGB(0x90A4AE),
      MDCPaletteTint400Name : MDCColorFromRGB(0x78909C),
      MDCPaletteTint500Name : MDCColorFromRGB(0x607D8B),
      MDCPaletteTint600Name : MDCColorFromRGB(0x546E7A),
      MDCPaletteTint700Name : MDCColorFromRGB(0x455A64),
      MDCPaletteTint800Name : MDCColorFromRGB(0x37474F),
      MDCPaletteTint900Name : MDCColorFromRGB(0x263238)
    }
                                  accents:nil];
  });
  return palette;
}

+ (instancetype)paletteGeneratedFromColor:(nonnull UIColor *)target500Color {
  NSArray *tintNames = @[
    MDCPaletteTint50Name, MDCPaletteTint100Name, MDCPaletteTint200Name, MDCPaletteTint300Name,
    MDCPaletteTint400Name, MDCPaletteTint500Name, MDCPaletteTint600Name, MDCPaletteTint700Name,
    MDCPaletteTint800Name, MDCPaletteTint900Name, MDCPaletteAccent100Name, MDCPaletteAccent200Name,
    MDCPaletteAccent400Name, MDCPaletteAccent700Name
  ];

  NSMutableDictionary *tints = [[NSMutableDictionary alloc] init];
  for (MDCPaletteTint name in tintNames) {
    [tints setObject:MDCPaletteTintFromTargetColor(target500Color, name) forKey:name];
  }

  NSArray *accentNames = @[
    MDCPaletteAccent100Name, MDCPaletteAccent200Name, MDCPaletteAccent400Name,
    MDCPaletteAccent700Name
  ];
  NSMutableDictionary *accents = [[NSMutableDictionary alloc] init];
  for (MDCPaletteAccent name in accentNames) {
    [accents setObject:MDCPaletteAccentFromTargetColor(target500Color, name) forKey:name];
  }

  return [self paletteWithTints:tints accents:accents];
}

+ (instancetype)paletteWithTints:(NSDictionary<MDCPaletteTint, UIColor *> *)tints
                         accents:(NSDictionary<MDCPaletteAccent, UIColor *> *)accents {
  return [[self alloc] initWithTints:tints accents:accents];
}

- (instancetype)initWithTints:(NSDictionary<MDCPaletteTint, UIColor *> *)tints
                      accents:(NSDictionary<MDCPaletteAccent, UIColor *> *)accents {
  self = [super init];
  if (self) {
    _accents = accents ? [accents copy] : @{};

    // Check if all the accent colors are present.
    NSDictionary<MDCPaletteTint, UIColor *> *allTints = tints;
    NSMutableSet<MDCPaletteAccent> *requiredTintKeys =
        [NSMutableSet setWithSet:[[self class] requiredTintKeys]];
    [requiredTintKeys minusSet:[NSSet setWithArray:[tints allKeys]]];
    if ([requiredTintKeys count] != 0) {
      NSAssert(NO, @"Missing accent colors for the following keys: %@.", requiredTintKeys);
      NSMutableDictionary<MDCPaletteTint, UIColor *> *replacementTints =
          [NSMutableDictionary dictionaryWithDictionary:_accents];
      for (MDCPaletteTint tintKey in requiredTintKeys) {
        [replacementTints setObject:[UIColor clearColor] forKey:tintKey];
      }
      allTints = replacementTints;
    }

    _tints = [allTints copy];
  }
  return self;
}

- (UIColor *)tint50 {
  return _tints[MDCPaletteTint50Name];
}

- (UIColor *)tint100 {
  return _tints[MDCPaletteTint100Name];
}

- (UIColor *)tint200 {
  return _tints[MDCPaletteTint200Name];
}

- (UIColor *)tint300 {
  return _tints[MDCPaletteTint300Name];
}

- (UIColor *)tint400 {
  return _tints[MDCPaletteTint400Name];
}

- (UIColor *)tint500 {
  return _tints[MDCPaletteTint500Name];
}

- (UIColor *)tint600 {
  return _tints[MDCPaletteTint600Name];
}

- (UIColor *)tint700 {
  return _tints[MDCPaletteTint700Name];
}

- (UIColor *)tint800 {
  return _tints[MDCPaletteTint800Name];
}

- (UIColor *)tint900 {
  return _tints[MDCPaletteTint900Name];
}

- (UIColor *)accent100 {
  return _accents[MDCPaletteAccent100Name];
}

- (UIColor *)accent200 {
  return _accents[MDCPaletteAccent200Name];
}

- (UIColor *)accent400 {
  return _accents[MDCPaletteAccent400Name];
}

- (UIColor *)accent700 {
  return _accents[MDCPaletteAccent700Name];
}

#pragma mark - Private methods

+ (nonnull NSSet<MDCPaletteTint> *)requiredTintKeys {
  return [NSSet setWithArray:@[
    MDCPaletteTint50Name, MDCPaletteTint100Name, MDCPaletteTint200Name, MDCPaletteTint300Name,
    MDCPaletteTint400Name, MDCPaletteTint500Name, MDCPaletteTint600Name, MDCPaletteTint700Name,
    MDCPaletteTint800Name, MDCPaletteTint900Name
  ]];
}

@end
