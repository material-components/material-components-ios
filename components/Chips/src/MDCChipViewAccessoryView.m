#import "MDCChipViewAccessoryView.h"

@implementation MDCChipViewAccessoryView

- (CGSize)sizeThatFits:(CGSize)size {
  if (!CGSizeEqualToSize(self.preferredSize, CGSizeZero)) {
    return self.preferredSize;
  }
  return [super sizeThatFits:size];
}

- (CGSize)intrinsicContentSize {
  if (!CGSizeEqualToSize(self.preferredSize, CGSizeZero)) {
    return self.preferredSize;
  }

  return [super intrinsicContentSize];
}

@end
