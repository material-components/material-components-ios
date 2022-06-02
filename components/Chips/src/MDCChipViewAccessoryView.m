#import "MDCChipViewAccessoryView.h"

@implementation MDCChipViewAccessoryView

- (CGSize)sizeThatFits:(CGSize)size {
  if (!CGSizeEqualToSize(self.preferredsize, CGSizeZero)) {
    return self.preferredsize;
  }
  return [super sizeThatFits:size];
}

- (CGSize)intrinsicContentSize {
  if (!CGSizeEqualToSize(self.preferredsize, CGSizeZero)) {
    return self.preferredsize;
  }

  return [super intrinsicContentSize];
}

@end
