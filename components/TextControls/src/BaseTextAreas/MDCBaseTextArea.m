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

#import "MDCBaseTextArea.h"

#import <CoreGraphics/CoreGraphics.h>
#import <MDFInternationalization/MDFInternationalization.h>
#import <QuartzCore/QuartzCore.h>

#import "MaterialMath.h"
#import "MaterialTextControlsPrivate+BaseStyle.h"
#import "MaterialTextControlsPrivate+Shared.h"
#import "MaterialTypography.h"
#import "private/MDCBaseTextAreaLayout.h"
#import "private/MDCBaseTextAreaTextView.h"

@interface MDCBaseTextArea () <MDCTextControl,
                               MDCBaseTextAreaTextViewDelegate,
                               UIGestureRecognizerDelegate>

#pragma mark MDCTextControl properties
@property(strong, nonatomic) MDCBaseTextAreaTextView *textAreaTextView;
@property(strong, nonatomic) UITouch *lastTouch;
@property(nonatomic, assign) CGPoint lastTouchInitialContentOffset;
@property(nonatomic, assign) CGPoint lastTouchInitialLocation;

@property(nonatomic, strong) MDCTextControlGradientManager *gradientManager;

@property(strong, nonatomic) UITapGestureRecognizer *tapGesture;

@end

@implementation MDCBaseTextArea

#pragma mark Object Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCBaseTextAreaInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCBaseTextAreaInit];
  }
  return self;
}

- (void)commonMDCBaseTextAreaInit {
  [self observeTextViewNotifications];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark Setup

- (void)setUpTextAreaSpecificSubviews {
  self.maskedScrollViewContainerView = [[UIView alloc] init];
  [self addSubview:self.maskedScrollViewContainerView];

  self.scrollView = [[UIScrollView alloc] init];
  self.scrollView.bounces = NO;
  [self.maskedScrollViewContainerView addSubview:self.scrollView];

  self.scrollViewContentViewTouchForwardingView = [[UIView alloc] init];
  [self.scrollView addSubview:self.scrollViewContentViewTouchForwardingView];

  self.textAreaTextView = [[MDCBaseTextAreaTextView alloc] init];
  self.textAreaTextView.textAreaTextViewDelegate = self;
  self.textAreaTextView.showsVerticalScrollIndicator = NO;
  self.textAreaTextView.showsHorizontalScrollIndicator = NO;
  [self.scrollView addSubview:self.textAreaTextView];
}

#pragma mark UIView Overrides

- (void)layoutSubviews {
  [self preLayoutSubviews];
  [super layoutSubviews];
  [self postLayoutSubviews];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  UIView *result = [super hitTest:point withEvent:event];
  if (result == self.scrollViewContentViewTouchForwardingView) {
    return self;
  }
  return result;
}

#pragma mark UIControl Overrides

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
  BOOL result = [super beginTrackingWithTouch:touch withEvent:event];
  self.lastTouchInitialContentOffset = self.scrollView.contentOffset;
  self.lastTouchInitialLocation = [touch locationInView:self];
  return result;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
  BOOL result = [super continueTrackingWithTouch:touch withEvent:event];

  CGPoint location = [touch locationInView:self];
  CGPoint offsetFromStart = [self offsetOfPoint:location fromPoint:self.lastTouchInitialLocation];

  CGPoint offset = self.lastTouchInitialContentOffset;
  CGFloat height = CGRectGetHeight(self.frame);
  offset.y -= offsetFromStart.y;
  if (offset.y < 0) {
    offset.y = 0;
  }
  if (offset.y + height > self.scrollView.contentSize.height) {
    offset.y = self.scrollView.contentSize.height - height;
  }
  self.scrollView.contentOffset = offset;

  return result;
}

- (void)handleResponderChange {
  [self setNeedsLayout];
}

#pragma mark Dynamic Type

- (void)setAdjustsFontForContentSizeCategory:(BOOL)adjustsFontForContentSizeCategory {
  if (@available(iOS 10.0, *)) {
    _adjustsFontForContentSizeCategory = adjustsFontForContentSizeCategory;
    self.textView.adjustsFontForContentSizeCategory = adjustsFontForContentSizeCategory;
  }
}

#pragma mark Custom Accessors

- (UITextView *)textView {
  return self.textAreaTextView;
}

#pragma mark InputChipViewTextViewDelegate

- (void)textAreaTextViewWillResignFirstResponder:(BOOL)didBecome {
  [self handleResponderChange];
}

- (void)textAreaTextViewWillBecomeFirstResponder:(BOOL)didBecome {
  [self handleResponderChange];
}

#pragma mark Notifications

- (void)textViewChanged:(NSNotification *)notification {
  [self setNeedsLayout];
}

- (void)observeTextViewNotifications {
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(textViewChanged:)
                                               name:UITextViewTextDidChangeNotification
                                             object:nil];
}

@end
