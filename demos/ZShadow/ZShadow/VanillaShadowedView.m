#import "VanillaShadowedView.h"

@implementation VanillaShadowedView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    self.layer.shadowOffset = CGSizeMake(0, 8);
    self.layer.shadowRadius = 8;
    self.layer.shadowOpacity = 0.6;
  }
  return self;
}

@end
