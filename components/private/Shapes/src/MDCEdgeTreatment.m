#import "MDCEdgeTreatment.h"

#import "MDCPathGenerator.h"

@implementation MDCEdgeTreatment

- (instancetype)init {
  return [super init];
}

- (instancetype)initWithCoder:(NSCoder *)__unused aDecoder {
  if (self = [super init]) {
    // MDCEdgeTreatment has no params so nothing to decode here.
  }
  return self;
}

- (MDCPathGenerator *)pathGeneratorForEdgeWithLength:(CGFloat)length {
  MDCPathGenerator *path = [MDCPathGenerator pathGeneratorWithStartPoint:CGPointZero];
  [path addLineToPoint:CGPointMake(length, 0)];
  return path;
}

- (void)encodeWithCoder:(NSCoder *)__unused aCoder {
  // MDCEdgeTreatment has no params, so nothing to encode here.
}

- (id)copyWithZone:(nullable NSZone *)__unused zone {
  return [[[self class] alloc] init];
}

+ (BOOL)supportsSecureCoding {
  return YES;
}

@end
