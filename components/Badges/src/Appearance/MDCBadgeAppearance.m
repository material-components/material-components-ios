#import "MDCBadgeAppearance.h"

@implementation MDCBadgeAppearance

- (nonnull instancetype)init {
  return [super init];
}

#pragma mark - NSCopying

- (nonnull id)copyWithZone:(nullable __unused NSZone *)zone {
  MDCBadgeAppearance *config = [[MDCBadgeAppearance alloc] init];
  config.backgroundColor = self.backgroundColor;
  config.textColor = self.textColor;
  config.font = self.font;
  config.boldFont = self.boldFont;
  config.borderColor = self.borderColor;
  config.borderWidth = self.borderWidth;
  return config;
}

@end
