#import "MDCDotBadgeAppearance.h"

@implementation MDCDotBadgeAppearance

- (nonnull instancetype)init {
  return [super init];
}

#pragma mark - NSCopying

- (nonnull id)copyWithZone:(nullable __unused NSZone *)zone {
  MDCDotBadgeAppearance *config = [[MDCDotBadgeAppearance alloc] init];
  config.backgroundColor = self.backgroundColor;
  config.innerRadius = self.innerRadius;
  config.borderColor = self.borderColor;
  config.borderWidth = self.borderWidth;
  return config;
}

@end
