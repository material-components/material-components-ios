#import "M3CIconAttributes.h"

NS_ASSUME_NONNULL_BEGIN

@implementation M3CIconAttributes

- (instancetype)initWithTextStyle:(UIFontTextStyle)textStyle pointSize:(CGFloat)pointSize {
  self = [super init];
  if (self) {
    _textStyle = [textStyle copy];
    _pointSize = pointSize;
  }
  return self;
}

@end

NS_ASSUME_NONNULL_END
