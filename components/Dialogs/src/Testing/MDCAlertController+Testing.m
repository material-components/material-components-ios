// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCAlertController+Customize.h"
#import "MDCAlertController.h"
#import "MDCAlertControllerView.h"
#import "MDCAlertController+Testing.h"
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprivate-header"
#import "MDCAlertControllerView+Private.h"
#pragma clang diagnostic pop

NS_ASSUME_NONNULL_BEGIN

@implementation MDCAlertController (Testing)

- (void)sizeToFitContentInBounds:(CGSize)bounds {
  [self setViewBounds:bounds];
  [self sizeToBounds:bounds];
  [self.view layoutIfNeeded];
}

- (void)sizeToFitAutoLayoutContentInBounds:(CGSize)bounds {
  [self setViewBounds:bounds];
  // Making sure that tests that use accessory views with auto-layout are laid out with their final
  // frames before `sizeToBounds:` invoke their `systemLayoutSizeFittingSize:'.
  [self.view layoutIfNeeded];
  [self sizeToBounds:bounds];
}

- (void)sizeToBounds:(CGSize)bounds {
  MDCAlertControllerView *alertView = (MDCAlertControllerView *)self.view;
  CGSize preferredSize = [alertView calculatePreferredContentSizeForBounds:bounds];
  alertView.bounds = CGRectMake(0.f, 0.f, preferredSize.width, preferredSize.height);
}

- (void)setViewBounds:(CGSize)bounds {
  CGRect viewBounds = self.view.bounds;
  viewBounds.size = bounds;
  self.view.bounds = viewBounds;
}

- (void)highlightAlertPanels {
  MDCAlertControllerView *alertView = (MDCAlertControllerView *)self.view;
  alertView.titleView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:.2f];
  alertView.titleLabel.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:.2f];
  alertView.contentScrollView.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:.1f];
  alertView.messageTextView.backgroundColor = [[UIColor orangeColor] colorWithAlphaComponent:.2f];
  alertView.actionsScrollView.backgroundColor = [[UIColor blueColor] colorWithAlphaComponent:.2f];

  self.titleIconImageView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:.2f];
  self.titleIconView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:.3f];
}

@end

NS_ASSUME_NONNULL_END
