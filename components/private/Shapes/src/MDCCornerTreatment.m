#import "MDCCornerTreatment.h"

#import "MDCPathGenerator.h"

@implementation MDCCornerTreatment

- (instancetype)init {
  return [super init];
}

- (instancetype)initWithCoder:(NSCoder *)__unused aDecoder {
  if (self = [super init]) {
    // MDCCornerTreatment has no params so nothing to decode here.
  }
  return self;
}

- (MDCPathGenerator *)pathGeneratorForCornerWithAngle:(CGFloat)__unused angle {
  return [MDCPathGenerator pathGeneratorWithStartPoint:CGPointZero];
}

- (void)encodeWithCoder:(NSCoder *)__unused aCoder {
  // MDCCornerTreatment has no params, so nothing to encode here.
}

- (id)copyWithZone:(nullable NSZone *)__unused zone {
  return [[[self class] alloc] init];
}

+ (BOOL)supportsSecureCoding {
  return YES;
}

@end
