/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCCollectionInfoBarView.h"

#import "MaterialShadowLayer.h"
#import "MaterialTypography.h"

const CGFloat MDCCollectionInfoBarAnimationDuration = 0.3f;

static const CGFloat kInfoBarDefaultHeight = 48.0f;
static const NSTimeInterval kInfoBarDefaultDismissal = 1.0f;
static const CGFloat kInfoBarDefaultLabelHorizontalPadding = 16.0f;

// Colors derived from http://www.google.com/design/spec/style/color.html#color-color-palette .
static const uint32_t kInfoBarBlueColor = 0x448AFF;  // Blue A200
static const uint32_t kInfoBarRedColor = 0xF44336;   // Red 500

// Creates a UIColor from a 24-bit RGB color encoded as an integer.
static inline UIColor *ColorFromRGB(uint32_t rgbValue) {
  return [UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255
                         green:((CGFloat)((rgbValue & 0x00FF00) >> 8)) / 255
                          blue:((CGFloat)((rgbValue & 0x0000FF) >> 0)) / 255
                         alpha:1];
}

@interface ShadowedView : UIView
@end

@implementation ShadowedView
+ (Class)layerClass {
  return [MDCShadowLayer class];
}
@end

@implementation MDCCollectionInfoBarView {
  CGFloat _backgroundTransformY;
  CALayer *_backgroundBorderLayer;
  UITapGestureRecognizer *_tapGesture;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCCollectionInfoBarViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCCollectionInfoBarViewInit];
  }
  return self;
}

- (instancetype)initWithStyle:(MDCInfoBarStyle)style
                         kind:(MDCInfoBarKind)kind
               collectionView:(UICollectionView *)collectionView {
  _style = style;
  _kind = kind;

  // Determine frame based on if header or footer.
  CGFloat offsetY = 0;
  if (_kind == MDCInfoBarKindFooter) {
    offsetY = collectionView.bounds.size.height - kInfoBarDefaultHeight;
  }
  CGRect frame = CGRectMake(0, offsetY, collectionView.bounds.size.width, kInfoBarDefaultHeight);

  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCCollectionInfoBarViewInit];
  }
  return self;
}

- (void)commonMDCCollectionInfoBarViewInit {
  self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
  self.backgroundColor = [UIColor clearColor];
  self.userInteractionEnabled = NO;

  // Setup background view.
  _backgroundView = [[ShadowedView alloc] initWithFrame:self.bounds];
  _backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  _backgroundView.clipsToBounds = YES;
  _backgroundView.hidden = YES;
  _backgroundTransformY =
      (_kind == MDCInfoBarKindHeader) ? -kInfoBarDefaultHeight : kInfoBarDefaultHeight;
  _backgroundView.transform = CGAffineTransformMakeTranslation(0, _backgroundTransformY);
  _tapGesture =
      [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
  [_backgroundView addGestureRecognizer:_tapGesture];
  [self addSubview:_backgroundView];

  // Setup label.
  _titleLabel = [[UILabel alloc]
      initWithFrame:CGRectInset(self.bounds, kInfoBarDefaultLabelHorizontalPadding, 0)];
  _titleLabel.backgroundColor = [UIColor clearColor];
  _titleLabel.textAlignment = NSTextAlignmentCenter;
  _titleLabel.font = [MDCTypography body1Font];
  _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  [_backgroundView addSubview:_titleLabel];


  [self prepareLayout];
}

- (void)prepareLayout {
  if (_style == MDCInfoBarStyleHUD) {
    _allowsTap = NO;
    _textAlignment = NSTextAlignmentLeft;
    _tintColor = ColorFromRGB(kInfoBarBlueColor);
    _titleColor = [UIColor whiteColor];
    _autoDismissAfterDuration = kInfoBarDefaultDismissal;
    _backgroundView.alpha = 0.9f;
    self.shouldApplyBorder = NO;
    self.isAccessibilityElement = NO;
    self.accessibilityTraits = UIAccessibilityTraitNone;
    self.accessibilityLabel = nil;
  } else if (_style == MDCInfoBarStyleActionable) {
    _allowsTap = YES;
    _textAlignment = NSTextAlignmentCenter;
    _tintColor = [UIColor whiteColor];
    _titleColor = ColorFromRGB(kInfoBarRedColor);
    _autoDismissAfterDuration = 0.0f;
    _backgroundView.alpha = 1.0f;
    _borderColor = [UIColor colorWithWhite:0 alpha:0.1f];
    _borderWidth = 1.0f / [[UIScreen mainScreen] scale];
    self.shouldApplyBorder = YES;
    self.isAccessibilityElement = YES;
    self.accessibilityTraits = UIAccessibilityTraitButton;
    self.accessibilityLabel = self.message;
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];
  NSLog(@"layoutSubviews");

  // Adjust border offset.
  CGFloat offsetY = (_kind == MDCInfoBarKindFooter) ? 1 : -1;
  CGSize boundsSize = _backgroundView.bounds.size;
  _backgroundBorderLayer.frame =
      CGRectMake(-1, 0, boundsSize.width + 2, boundsSize.height + offsetY);
  _backgroundBorderLayer.borderColor = _borderColor.CGColor;
  _backgroundBorderLayer.borderWidth = _borderWidth;

  _titleLabel.text = _message;
  _titleLabel.textAlignment = _textAlignment;
  _titleLabel.textColor = _titleColor;
  _backgroundView.backgroundColor = _tintColor;
}

- (void)setShouldApplyBorder:(BOOL)shouldApplyBorder {
  _shouldApplyBorder = shouldApplyBorder;
  if (!_shouldApplyBorder) {
    [_backgroundBorderLayer removeFromSuperlayer];
  } else if (!_backgroundBorderLayer) {
    _backgroundBorderLayer = [CALayer layer];
    [_backgroundView.layer addSublayer:_backgroundBorderLayer];
  }
}

- (void)setBorderColor:(UIColor *)borderColor {
  _borderColor = borderColor;
}

- (void)setTintColor:(UIColor *)tintColor {
  _tintColor = tintColor;
}

- (BOOL)isVisible {
  return !_backgroundView.hidden;
}

- (void)showAnimated:(BOOL)animated {
  _backgroundView.hidden = NO;
  // Notify delegate.
  if ([_delegate respondsToSelector:@selector(infoBar:willShowAnimated:willAutoDismiss:)]) {
    [_delegate infoBar:self willShowAnimated:animated willAutoDismiss:[self shouldAutoDismiss]];
  }


  NSTimeInterval duration = (animated) ? MDCCollectionInfoBarAnimationDuration : 0.0f;
  [UIView animateWithDuration:duration
                        delay:0
                      options:UIViewAnimationOptionCurveEaseOut
                   animations:^{
                     _backgroundView.transform = CGAffineTransformIdentity;
                   }
                   completion:^(BOOL finished) {
                     self.userInteractionEnabled = _allowsTap;

                     // Notify delegate.
                     if ([_delegate respondsToSelector:@selector(infoBar:didShowAnimated:willAutoDismiss:)]) {
                       [_delegate infoBar:self
                          didShowAnimated:animated
                          willAutoDismiss:[self shouldAutoDismiss]];
                     }
                     
                     [self autoDismissIfNecessaryWithAnimation:animated];
                   }];
}

- (void)dismissAnimated:(BOOL)animated {
  // Notify delegate.
  if ([_delegate respondsToSelector:@selector(infoBar:willDismissAnimated:willAutoDismiss:)]) {
    [_delegate infoBar:self willDismissAnimated:animated willAutoDismiss:[self shouldAutoDismiss]];
  }

  NSTimeInterval duration = (animated) ? MDCCollectionInfoBarAnimationDuration : 0.0f;
  [UIView animateWithDuration:duration
      delay:0
      options:UIViewAnimationOptionCurveEaseIn
      animations:^{
        _backgroundView.transform = CGAffineTransformMakeTranslation(0, _backgroundTransformY);
      }
      completion:^(BOOL finished) {
        self.userInteractionEnabled = NO;
        _backgroundView.hidden = YES;

        // Notify delegate.
        if ([_delegate respondsToSelector:@selector(infoBar:didDismissAnimated:didAutoDismiss:)]) {
          [_delegate infoBar:self
              didDismissAnimated:animated
                  didAutoDismiss:[self shouldAutoDismiss]];
        }
      }];
}

#pragma mark - Private

- (void)handleTapGesture:(UITapGestureRecognizer *)recognizer {
  if ([_delegate respondsToSelector:@selector(didTapInfoBar:)]) {
    [_delegate didTapInfoBar:self];
  }
}

- (BOOL)shouldAutoDismiss {
  return (_autoDismissAfterDuration > 0);
}

- (void)autoDismissIfNecessaryWithAnimation:(BOOL)animation {
  if ([self shouldAutoDismiss]) {
    dispatch_time_t popTime =
        dispatch_time(DISPATCH_TIME_NOW, (int64_t)(_autoDismissAfterDuration * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^{
      [self dismissAnimated:animation];
    });
  }
}

@end
