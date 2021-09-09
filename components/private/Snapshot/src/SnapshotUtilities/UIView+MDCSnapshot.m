// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "UIView+MDCSnapshot.h"

@implementation UIView (MDCSnapshot)

- (UIView *)mdc_addToBackgroundView {
  return [self mdc_addToBackgroundViewWithInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
}

- (UIView *)mdc_addToBackgroundViewWithInsets:(UIEdgeInsets)insets {
  UIView *backgroundView = [[UIView alloc]
      initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.bounds) + insets.left + insets.right,
                               CGRectGetHeight(self.bounds) + insets.top + insets.bottom)];
  backgroundView.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.8 alpha:1];
  [backgroundView addSubview:self];

  CGRect frame = self.frame;
  frame.origin = CGPointMake(insets.left, insets.top);
  self.frame = frame;

  return backgroundView;
}

- (void)mdc_layoutAndApplyBestFitFrameWithWidth:(CGFloat)width {
  [self layoutIfNeeded];
  CGSize size = CGSizeMake(width, 0);
  size = [self systemLayoutSizeFittingSize:size
             withHorizontalFittingPriority:UILayoutPriorityRequired
                   verticalFittingPriority:UILayoutPriorityFittingSizeLevel];
  if (size.width <= 0 || size.height <= 0) {
    size = [self sizeThatFits:CGSizeMake(width, CGFLOAT_MAX)];
  }
  CGRect result = CGRectZero;
  result.size = size;
  self.frame = result;
}

@end
