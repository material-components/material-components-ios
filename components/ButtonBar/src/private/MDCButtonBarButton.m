/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <UIKit/UIKit.h>

#import "MDCButtonBarButton.h"
#import "MDCButtonBarButton+Private.h"

static const CGFloat kMinimumItemWidth = 36.f;

@implementation MDCButtonBarButton

- (CGSize)sizeThatFits:(CGSize)size {
  CGSize fitSize = [super sizeThatFits:size];
  fitSize.height =
      self.contentPadding.top + MAX(kMinimumItemWidth, fitSize.height) + self.contentPadding.bottom;
  fitSize.width =
      self.contentPadding.left + MAX(kMinimumItemWidth, fitSize.width) + self.contentPadding.right;

  return fitSize;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  // TODO(featherless): Remove this conditional and always set the max ripple radius once
  // https://github.com/material-components/material-components-ios/issues/329 lands.
  if (self.inkStyle == MDCInkStyleUnbounded) {
    self.inkMaxRippleRadius = MIN(self.bounds.size.width, self.bounds.size.height) / 2;
  } else {
    self.inkMaxRippleRadius = 0;
  }
}

// Because we are explicitly re-declaring this method in our header, we need to explictly
// re-define in our implementation. Therefore, this method just calls [super].
- (void)setTitleFont:(nullable UIFont *)font forState:(UIControlState)state {
  [super setTitleFont:font forState:state];
}

@end

