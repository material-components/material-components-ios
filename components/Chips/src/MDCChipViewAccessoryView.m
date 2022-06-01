#import "MDCChipViewAccessoryView.h"

@implementation MDCChipViewAccessoryView

- (CGSize)sizeThatFits:(CGSize)size {
  if (!CGSizeEqualToSize(self.preferedSize, CGSizeZero)) {
    return self.preferedSize;
  }
  return [super sizeThatFits:size];
}

- (CGSize)intrinsicContentSize {
  if (!CGSizeEqualToSize(self.preferedSize, CGSizeZero)) {
    return self.preferedSize;
  }

  return [super intrinsicContentSize];
}

@end
