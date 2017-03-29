#import "MaterialShadowedView.h"

#import "MaterialShadowLayer.h"

@implementation MaterialShadowedView

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

- (MDCShadowLayer *)shadowLayer {
  return (MDCShadowLayer *)self.layer;
}

- (void)setElevation:(CGFloat)points {
  [(MDCShadowLayer *)self.layer setElevation:points];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self setElevation:12];
  }
  return self;
}

@end
