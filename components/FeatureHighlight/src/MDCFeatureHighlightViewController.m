/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCFeatureHighlightViewController.h"

#import "private/MDCFeatureHighlightView.h"

@implementation MDCFeatureHighlightViewController

- (nonnull instancetype)initWithHighlightedView:(nonnull UIView *)highlightedView
                                    andShowView:(nonnull UIView *)displayedView
                                     completion:(nullable MDCFeatureHighlightCompletion)completion {
  if (self = [super initWithNibName:nil bundle:nil]) {

  }
  return self;
}

- (nonnull instancetype)initWithHighlightedView:(nonnull UIView *)highlightedView
                                     completion:(nullable MDCFeatureHighlightCompletion)completion {
  return [self initWithHighlightedView:highlightedView
                           andShowView:[highlightedView snapshotViewAfterScreenUpdates:YES]
                            completion:completion];
}

- (void)loadView {
  MDCFeatureHighlightView *view = [[MDCFeatureHighlightView alloc] initWithFrame:CGRectZero];
  self.view = view;
}

- (UIColor *)outerHighlightColor {
  if (!_outerHighlightColor) {
    return self.view.tintColor;
  }
  return _outerHighlightColor;
}

- (void)setInnerHighlightColor:(UIColor *)innerHighlightColor {
  if (!innerHighlightColor) {
    innerHighlightColor = [UIColor whiteColor];
  }
  _innerHighlightColor = innerHighlightColor;
}

- (void)acceptFeature {

}

- (void)rejectFeature {

}

@end

