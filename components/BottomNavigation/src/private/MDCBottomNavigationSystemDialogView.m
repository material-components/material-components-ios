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

#import <CoreGraphics/CoreGraphics.h>

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

/**
 * The background blur view. This property is nil if on instantiation reduced transparency was
 * enabled.
 */
@property(nonatomic, nullable) UIVisualEffectView *blurView;

@end

@implementation MDCBottomNavigationSystemDialogView

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonMDCBottomNavigationSystemDialogViewInit];
  }

  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCBottomNavigationSystemDialogViewInit];
  }

  return self;
}

- (void)commonMDCBottomNavigationSystemDialogViewInit {
  self.layer.cornerRadius = kCornerRadius;
  self.layer.masksToBounds = YES;

  // Determine the layout margins and set them on the content view.  The content view may change
  // depending upon if reduced transparency is enabled.
  CGFloat margin = kCornerRadius + kMargins;
  UIEdgeInsets layoutMargins = UIEdgeInsetsMake(margin, margin, margin, margin);
  if (UIAccessibilityIsReduceTransparencyEnabled()) {
    self.backgroundColor = [UIColor colorWithWhite:(CGFloat)0.8 alpha:(CGFloat)1];
    self.layoutMargins = layoutMargins;
  } else {
    _blurView = MDCInitializeCompatibleBlurView();
    _blurView.contentView.layoutMargins = layoutMargins;
    [self addSubview:_blurView];
  }
}

- (UIView *)contentView {
  if (self.blurView) {
    return self.blurView.contentView;
  }

  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  if (self.blurView) {
    CGFloat height = CGRectGetHeight(self.bounds);
    CGFloat width = CGRectGetWidth(self.bounds);
    CGFloat centerX = (CGFloat)floor(width / 2.0);
    CGFloat centerY = (CGFloat)floor(height / 2.0);

    self.blurView.bounds = CGRectMake(0, 0, width, height);
    self.blurView.center = CGPointMake(centerX, centerY);
  }
}

@end
