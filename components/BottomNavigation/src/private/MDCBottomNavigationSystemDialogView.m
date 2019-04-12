// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCBottomNavigationSystemDialogView.h"

static const CGFloat kCornerRadius = 10;
static const CGFloat kMargins = 10;

static UIVisualEffectView *MDCInitializeCompatibleBlurView() {
  if (@available(iOS 10, *)) {
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleProminent];
    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    return blurView;
  }

  UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
  return [[UIVisualEffectView alloc] initWithEffect:blurEffect];
}

@interface MDCBottomNavigationSystemDialogView ()

@property(nonatomic, nullable) UIVisualEffectView *blurView;

@end

@implementation MDCBottomNavigationSystemDialogView

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonInitMDCBottomNavigationSystemDialogView];
  }

  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonInitMDCBottomNavigationSystemDialogView];
  }

  return self;
}

- (void)commonInitMDCBottomNavigationSystemDialogView {
  self.layer.cornerRadius = kCornerRadius;
  self.layer.masksToBounds = YES;

  CGFloat margin = kCornerRadius + kMargins;
  UIEdgeInsets layoutMargins = UIEdgeInsetsMake(margin, margin, margin, margin);
  if (UIAccessibilityIsReduceTransparencyEnabled()) {
    self.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.8 alpha:(CGFloat)1];
    self.layoutMargins = layoutMargins;
  } else {
    _blurView = MDCInitializeCompatibleBlurView();
    _blurView.translatesAutoresizingMaskIntoConstraints = NO;
    _blurView.contentView.layoutMargins = layoutMargins;
    [self addSubview:_blurView];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_blurView
                                                     attribute:NSLayoutAttributeLeading
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeading
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_blurView
                                                     attribute:NSLayoutAttributeTrailing
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTrailing
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_blurView
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1
                                                      constant:0]];
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_blurView
                                                     attribute:NSLayoutAttributeBottom
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeBottom
                                                    multiplier:1
                                                      constant:0]];
  }
}

- (UIView *)contentView {
  if (UIAccessibilityIsReduceTransparencyEnabled()) {
    return self;
  }

  return self.blurView.contentView;
}

- (void)setContent:(UIView *)content {
  if ([self.contentView.subviews containsObject:content]) {
    return;
  }

  if (self.contentView.subviews.count > 0) {
    [self removeContentViewSubviews];
  }

  [self.contentView addSubview:content];
  content.translatesAutoresizingMaskIntoConstraints = NO;
  NSMutableArray<NSLayoutConstraint *> *constraints = [NSMutableArray array];
  [constraints addObject:[NSLayoutConstraint constraintWithItem:content
                                                      attribute:NSLayoutAttributeLeading
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self
                                                      attribute:NSLayoutAttributeLeadingMargin
                                                     multiplier:1
                                                       constant:0]];
  [constraints addObject:[NSLayoutConstraint constraintWithItem:content
                                                      attribute:NSLayoutAttributeTrailing
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self
                                                      attribute:NSLayoutAttributeTrailingMargin
                                                     multiplier:1
                                                       constant:0]];
  [constraints addObject:[NSLayoutConstraint constraintWithItem:content
                                                      attribute:NSLayoutAttributeTop
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self
                                                      attribute:NSLayoutAttributeTopMargin
                                                     multiplier:1
                                                       constant:0]];
  [constraints addObject:[NSLayoutConstraint constraintWithItem:content
                                                      attribute:NSLayoutAttributeBottom
                                                      relatedBy:NSLayoutRelationEqual
                                                         toItem:self
                                                      attribute:NSLayoutAttributeBottomMargin
                                                     multiplier:1
                                                       constant:0]];
  [self addConstraints:constraints];
}

#pragma mark - Private Methods

- (void)removeContentViewSubviews {
  for (UIView *subview in self.contentView.subviews) {
    [subview removeFromSuperview];
  }
}

@end
