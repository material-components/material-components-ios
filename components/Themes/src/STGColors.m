#import "STGColors.h"

@interface STGColors ()

/**
 * Mapping of palette names to color palettes.  Each color palette is another mapping of NSString to
 * UIColor.
 */
@property(nonatomic) NSDictionary *palettes;

/**
 * Converts a dictionary of integers to a UIColor object.  Returns nil if it could not convert
 * the array to a UIColor object.
 */
+ (UIColor *)colorForDict:(NSDictionary *)colorDict;

@end

@implementation STGColors

+ (instancetype)sharedInstance {
  static dispatch_once_t onceToken;
  static STGColors *instance;
  dispatch_once(&onceToken, ^{
    instance = [[STGColors alloc] initWithPlist:@"colors"];
  });
  return instance;
}

- (instancetype)initWithPlist:(NSString *)plistName {
  self = [super init];
  if (!self) {
    return nil;
  }
  _defaultPalette = nil;
  NSString *path = [[NSBundle mainBundle] pathForResource:plistName ofType:@"plist"];
  NSDictionary *palettesRaw = [NSDictionary dictionaryWithContentsOfFile:path];
  NSMutableDictionary *palettesOut = [[NSMutableDictionary alloc] init];
  for (NSString *paletteName in palettesRaw) {
    if (_defaultPalette == nil) {
      _defaultPalette = paletteName;
    }
    NSDictionary *palette = [palettesRaw objectForKey:paletteName];
    NSMutableDictionary *paletteOut = [[NSMutableDictionary alloc] init];
    for (NSString *colorName in palette) {
      NSDictionary *rgbaMap = [palette objectForKey:colorName];
      UIColor *colorOut = [STGColors colorForDict:rgbaMap];
      // TODO(awdavies): Notify the user if something went wrong.
      [paletteOut setObject:colorOut forKey:colorName];
    }
    [palettesOut setObject:paletteOut forKey:paletteName];
  }
  _palettes = palettesOut;
  return self;
}

- (NSDictionary *)paletteWithName:(NSString *)paletteName {
  return [_palettes objectForKey:paletteName];
}

+ (UIColor *)colorForDict:(NSDictionary *)colorDict {
  if ([colorDict count] < 3) {
    return nil;
  }
  NSNumber *red = [colorDict objectForKey:@"red"];
  NSNumber *green = [colorDict objectForKey:@"green"];
  NSNumber *blue = [colorDict objectForKey:@"blue"];
  NSNumber *alpha = [colorDict objectForKey:@"alpha"];
  if (alpha == nil) {
    alpha = [NSNumber numberWithInt:255];
  }
  if (red == nil || green == nil || blue == nil) {
    return nil;
  }
  return [UIColor colorWithRed:red.floatValue
                         green:green.floatValue
                          blue:blue.floatValue
                         alpha:alpha.floatValue];
//  return [UIColor colorWithRed:red.integerValue / 255.0
//                         green:green.integerValue / 255.0
//                          blue:blue.integerValue / 255.0
//                         alpha:alpha.integerValue / 255.0];
}

- (UIColor *)colorWithName:(NSString *)colorName {
  return [self colorWithName:colorName fromPalette:nil];
}

- (UIColor *)colorWithName:(NSString *)colorName fromPalette:(NSString *)paletteName {
  if (paletteName == nil) {
    paletteName = _defaultPalette;
  }
  NSDictionary *palette = [_palettes objectForKey:paletteName];
  return [palette objectForKey:colorName];
}

- (void)setDefaultPalette:(NSString *)paletteName {
  NSDictionary *palette = [_palettes objectForKey:paletteName];
  if (palette == nil) {
    NSLog(@"[ERROR] Could not set default palette to \"%@\"", paletteName);
    return;
  }
  _defaultPalette = paletteName;
}

@end
