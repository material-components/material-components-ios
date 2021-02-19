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

#import <UIKit/UIKit.h>

#import "MDCButtonBarButton.h"
#import "MaterialButtons.h"
#import "MaterialInk.h"

static const CGFloat kMinimumItemWidth = 36;

@implementation MDCButtonBarButton

- (void)setContentEdgeInsets:(UIEdgeInsets)contentEdgeInsets {
  // Center the button's inkView around the content
  // This is here because MDCAppBarButtonBarBuilder adjusts the content insets of the button based
  // on where in the trailing/leading order the button is, and we want to center the ripple effect
  // around this button's content.
  CGFloat horizontalDifference = contentEdgeInsets.left - contentEdgeInsets.right;
  CGFloat verticalDifference = contentEdgeInsets.top - contentEdgeInsets.bottom;
  self.inkViewOffset = CGSizeMake(horizontalDifference / 2.f, verticalDifference / 2.f);
  [super setContentEdgeInsets:contentEdgeInsets];
}

- (CGSize)sizeThatFits:(CGSize)size {
  CGSize fitSize = [super sizeThatFits:size];
  fitSize.height = MAX(kMinimumItemWidth, fitSize.height);
  fitSize.width = MAX(kMinimumItemWidth, fitSize.width);

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

#pragma mark - UILargeContentViewerItem

- (BOOL)showsLargeContentViewer {
  return YES;
}

- (NSString *)largeContentTitle {
  if (_largeContentTitle) {
    return _largeContentTitle;
  }

  NSString *title = [self titleForState:UIControlStateNormal];
  if (!title && self.largeContentImage) {
    return self.accessibilityLabel;
  }

  return title;
}

- (UIImage *)largeContentImage {
  if (_largeContentImage) {
    return _largeContentImage;
  }

  return [self imageForState:UIControlStateNormal];
}

- (BOOL)scalesLargeContentImage {
  return _largeContentImage == nil;
}

@end
