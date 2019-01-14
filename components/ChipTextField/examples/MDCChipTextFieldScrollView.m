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

#import "MDCChipTextFieldScrollView.h"

@interface MDCChipTextFieldScrollView ()

@property(nonatomic, readwrite, strong) UIView *contentView;

@property(nonatomic, readwrite, weak) NSLayoutConstraint *trailingConstraint;

@end

@implementation MDCChipTextFieldScrollView
@synthesize delegate = _delegate;

- (instancetype)initWithFrame:(CGRect)frame {
  if ((self = [super initWithFrame:frame])) {
    [self commonInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  if ((self = [super initWithCoder:aDecoder])) {
    [self commonInit];
  }
  return self;
}

- (void)commonInit {
  // set up content view
  UIView *contentView = [[UIView alloc] initWithFrame:self.frame];
  contentView.translatesAutoresizingMaskIntoConstraints = NO;
  [self addSubview:contentView];
  self.contentView = contentView;

  NSLayoutConstraint *contentConstraintTop =
      [NSLayoutConstraint constraintWithItem:contentView
                                   attribute:NSLayoutAttributeTop
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeTop
                                  multiplier:1
                                    constant:0];
  NSLayoutConstraint *contentConstraintBottom =
      [NSLayoutConstraint constraintWithItem:contentView
                                   attribute:NSLayoutAttributeBottom
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeBottom
                                  multiplier:1
                                    constant:0];
  NSLayoutConstraint *contentConstraintLeading =
      [NSLayoutConstraint constraintWithItem:contentView
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeLeading
                                  multiplier:1
                                    constant:0];
  NSLayoutConstraint *contentConstraintTrailing =
      [NSLayoutConstraint constraintWithItem:contentView
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeTrailing
                                  multiplier:1
                                    constant:0];
  contentConstraintTrailing.priority = UILayoutPriorityDefaultLow;
  NSLayoutConstraint *contentConstraintHeight =
      [NSLayoutConstraint constraintWithItem:contentView
                                   attribute:NSLayoutAttributeHeight
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeHeight
                                  multiplier:1
                                    constant:0];
  NSLayoutConstraint *contentConstraintWidth =
      [NSLayoutConstraint constraintWithItem:contentView
                                   attribute:NSLayoutAttributeWidth
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:self
                                   attribute:NSLayoutAttributeWidth
                                  multiplier:1
                                    constant:0];
  contentConstraintWidth.priority = UILayoutPriorityDefaultLow;
  [NSLayoutConstraint activateConstraints:@[
    contentConstraintTop, contentConstraintBottom, contentConstraintLeading,
    contentConstraintTrailing, contentConstraintHeight, contentConstraintWidth
  ]];

  NSLayoutConstraint *contentToChipTrailingConstraint =
      [NSLayoutConstraint constraintWithItem:contentView
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:contentView
                                   attribute:NSLayoutAttributeLeading
                                  multiplier:1
                                    constant:0];
  contentToChipTrailingConstraint.active = YES;
  self.trailingConstraint = contentToChipTrailingConstraint;

  // Set fixed values for this scroll view.
  [self setShowsVerticalScrollIndicator:NO];
  [self setShowsHorizontalScrollIndicator:NO];
  self.bounces = NO;
  self.scrollEnabled = NO;
}

- (void)appendChipView:(MDCChipView *)chipView {
  self.trailingConstraint.active = NO;
  [self.contentView addSubview:chipView];
  NSLayoutConstraint *chipViewConstraintTop =
      [NSLayoutConstraint constraintWithItem:self.contentView
                                   attribute:NSLayoutAttributeTop
                                   relatedBy:NSLayoutRelationLessThanOrEqual
                                      toItem:chipView
                                   attribute:NSLayoutAttributeTop
                                  multiplier:1
                                    constant:0];
  NSLayoutConstraint *chipViewConstraintBottom =
      [NSLayoutConstraint constraintWithItem:self.contentView
                                   attribute:NSLayoutAttributeBottom
                                   relatedBy:NSLayoutRelationGreaterThanOrEqual
                                      toItem:chipView
                                   attribute:NSLayoutAttributeBottom
                                  multiplier:1
                                    constant:0];
  NSLayoutConstraint *chipViewConstraintCenterY =
      [NSLayoutConstraint constraintWithItem:self.contentView
                                   attribute:NSLayoutAttributeCenterY
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:chipView
                                   attribute:NSLayoutAttributeCenterY
                                  multiplier:1
                                    constant:0];

  NSLayoutConstraint *chipViewConstraintLeading = nil;
  NSInteger numberOfChips = [self.dataSource numberOfChipsInScrollView:self];
  // The left most chip is always done before all other chips are added right now,
  // we should remove the assumption when moving to Beta
  if (numberOfChips == 0) {
    chipViewConstraintLeading = [NSLayoutConstraint constraintWithItem:self.contentView
                                                             attribute:NSLayoutAttributeLeading
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:chipView
                                                             attribute:NSLayoutAttributeLeading
                                                            multiplier:1
                                                              constant:0];
  } else {
    MDCChipView *lastChipView = [self.dataSource scrollView:self chipForIndex:numberOfChips - 1];
    chipViewConstraintLeading = [NSLayoutConstraint constraintWithItem:chipView
                                                             attribute:NSLayoutAttributeLeading
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:lastChipView
                                                             attribute:NSLayoutAttributeTrailing
                                                            multiplier:1
                                                              constant:self.chipSpacing];
  }
  NSLayoutConstraint *chipViewConstraintTrailing =
      [NSLayoutConstraint constraintWithItem:self.contentView
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:chipView
                                   attribute:NSLayoutAttributeTrailing
                                  multiplier:1
                                    constant:0];
  [NSLayoutConstraint activateConstraints:@[
    chipViewConstraintTop, chipViewConstraintBottom, chipViewConstraintCenterY,
    chipViewConstraintLeading, chipViewConstraintTrailing
  ]];
  self.trailingConstraint = chipViewConstraintTrailing;

  // Add touch handler
  [chipView addTarget:self
                action:@selector(didTapChipView:)
      forControlEvents:UIControlEventTouchUpInside];
}

- (void)removeChipView:(MDCChipView *)chipView {
  [chipView removeFromSuperview];

  NSInteger numberOfChips = [self.dataSource numberOfChipsInScrollView:self];
  if (numberOfChips > 0) {
    MDCChipView *lastChipView = [self.dataSource scrollView:self chipForIndex:numberOfChips - 1];
    NSLayoutConstraint *chipViewConstraintTrailing =
        [NSLayoutConstraint constraintWithItem:self.contentView
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:lastChipView
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1
                                      constant:0];
    chipViewConstraintTrailing.active = YES;
    self.trailingConstraint = chipViewConstraintTrailing;
  }
}

- (void)scrollToLeft {
  self.contentOffset = CGPointMake(0.0f, self.contentOffset.y);
}

- (void)scrollToRight {
  self.contentOffset =
      CGPointMake(self.contentSize.width - self.bounds.size.width, self.contentOffset.y);
}

- (void)layoutSubviews {
  [super layoutSubviews];

  self.contentSize = self.contentView.frame.size;
}

#pragma mark - Touch Handlers

- (void)didTapChipView:(id)sender {
  MDCChipView *chipView = (MDCChipView *)sender;
  if ([self.touchDelegate respondsToSelector:@selector(chipTextFieldScrollView:didTapChipView:)]) {
    [self.touchDelegate chipTextFieldScrollView:self didTapChipView:chipView];
  }
}

@end
