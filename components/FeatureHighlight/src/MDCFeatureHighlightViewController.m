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

@implementation MDCFeatureHighlightViewController {
  MDCFeatureHighlightCompletion _completion;
  MDCFeatureHighlightView *_featureHighlightView;
  NSTimer *_pulseTimer;
  UIView *_displayedView;
  UIView *_highlightedView;
}

- (nonnull instancetype)initWithHighlightedView:(nonnull UIView *)highlightedView
                                    andShowView:(nonnull UIView *)displayedView
                                     completion:(nullable MDCFeatureHighlightCompletion)completion {
  if (self = [super initWithNibName:nil bundle:nil]) {
    _highlightedView = highlightedView;
    _displayedView = displayedView;
    _completion = completion;

    [_highlightedView addObserver:self
                       forKeyPath:@"frame"
                          options:NSKeyValueObservingOptionNew
                          context:nil];

    self.modalPresentationStyle = UIModalPresentationOverFullScreen;
  }
  return self;
}

- (nonnull instancetype)initWithHighlightedView:(nonnull UIView *)highlightedView
                                     completion:(nullable MDCFeatureHighlightCompletion)completion {
  return [self initWithHighlightedView:highlightedView
                           andShowView:[highlightedView snapshotViewAfterScreenUpdates:YES]
                            completion:completion];
}

- (void)dealloc {
  [_pulseTimer invalidate];
  [_highlightedView removeObserver:self forKeyPath:@"frame"];
}

- (void)loadView {
  _featureHighlightView = [[MDCFeatureHighlightView alloc] initWithFrame:CGRectZero];
  _featureHighlightView.displayedView = _displayedView;
  _featureHighlightView.titleLabel.text = @"Title";
  _featureHighlightView.bodyLabel.text = @"Description text goes here.";

  __weak typeof(self) weakSelf = self;
  _featureHighlightView.interactionBlock = ^(BOOL accepted) {
    typeof(self) strongSelf = weakSelf;
    [strongSelf dismiss:accepted];
  };

  self.view = _featureHighlightView;
}

- (void)viewWillAppear:(BOOL)animated {
  CGPoint point = [_highlightedView.superview convertPoint:_highlightedView.center
                                                    toView:_featureHighlightView];
  _featureHighlightView.highlightPoint = point;
}

// TODO: this should trigger at the same time as viewWillAppear so that the discover animation
// occurs during the native presentation animation time.
- (void)viewDidAppear:(BOOL)animated {
  [_featureHighlightView animateDiscover];
  _pulseTimer = [NSTimer scheduledTimerWithTimeInterval:1.5
                                                 target:_featureHighlightView
                                               selector:@selector(animatePulse)
                                               userInfo:NULL
                                                repeats:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
  [_pulseTimer invalidate];
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
  [self dismiss:YES];
}

- (void)rejectFeature {
  [self dismiss:NO];
}

- (void)dismiss:(BOOL)accepted {
  if (accepted) {
    [_featureHighlightView animateAccepted];
  } else {
    [_featureHighlightView animateRejected];
  }
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    [self dismissViewControllerAnimated:YES completion:^() {
      if (_completion) {
        _completion(YES);
      }
    }];
  });
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
  if (object == _highlightedView && [keyPath isEqualToString:@"frame"]) {
    CGPoint point = [_highlightedView.superview convertPoint:_highlightedView.center
                                                      toView:_featureHighlightView];
    _featureHighlightView.highlightPoint = point;
    [_featureHighlightView layoutIfNeeded];
  }
}

@end

