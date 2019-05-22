// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCCollectionInfoBarView.h"

#import "MaterialPalettes.h"
#import "MaterialShadowLayer.h"
#import "MaterialTypography.h"

const CGFloat MDCCollectionInfoBarAnimationDuration = (CGFloat)0.3;
const CGFloat MDCCollectionInfoBarHeaderHeight = 48;
const CGFloat MDCCollectionInfoBarFooterHeight = 48;

static const CGFloat MDCCollectionInfoBarLabelHorizontalPadding = 16;

static inline UIColor *CollectionInfoBarBlueColor(void) {
  return MDCPalette.bluePalette.accent200;
}

static inline UIColor *CollectionInfoBarRedColor(void) {
  return MDCPalette.redPalette.tint500;
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

- (void)commonMDCCollectionInfoBarViewInit {
  self.backgroundColor = [UIColor clearColor];
  self.userInteractionEnabled = NO;
  _backgroundView = [[ShadowedView alloc] initWithFrame:self.bounds];
  _backgroundView.autoresizingMask =
      (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  _backgroundView.hidden = YES;

  _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  _titleLabel.backgroundColor = [UIColor clearColor];
  _titleLabel.textAlignment = NSTextAlignmentCenter;
  _titleLabel.font = [MDCTypography body1Font];
  _titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  [_backgroundView addSubview:_titleLabel];

  [self addSubview:_backgroundView];

  _tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                        action:@selector(handleTapGesture:)];
  [_backgroundView addGestureRecognizer:_tapGesture];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  UIEdgeInsets collectionViewSafeAreaInsets = UIEdgeInsetsZero;
  if (@available(iOS 11.0, *)) {
    if (self.superview) {
      collectionViewSafeAreaInsets = self.superview.safeAreaInsets;
    }
  }
  CGFloat leftInset =
      MAX(MDCCollectionInfoBarLabelHorizontalPadding, collectionViewSafeAreaInsets.left);
  CGFloat rightInset =
      MAX(MDCCollectionInfoBarLabelHorizontalPadding, collectionViewSafeAreaInsets.right);
  CGFloat height = [_kind isEqualToString:MDCCollectionInfoBarKindHeader]
                       ? MDCCollectionInfoBarHeaderHeight
                       : MDCCollectionInfoBarFooterHeight;
  _titleLabel.frame =
      CGRectMake(leftInset, 0, CGRectGetWidth(self.bounds) - (leftInset + rightInset), height);

  if (_shouldApplyBackgroundViewShadow) {
    [self setShouldApplyBackgroundViewShadow:_shouldApplyBackgroundViewShadow];
  }
}

- (void)layoutSublayersOfLayer:(CALayer *)layer {
  [super layoutSublayersOfLayer:layer];
  // Set border layer frame.
  _backgroundBorderLayer.frame = CGRectMake(-1, 0, CGRectGetWidth(self.backgroundView.bounds) + 2,
                                            CGRectGetHeight(self.backgroundView.bounds) + 1);
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
  [super applyLayoutAttributes:layoutAttributes];
  self.layer.zPosition = layoutAttributes.zIndex;
}

- (void)setTintColor:(UIColor *)tintColor {
  _tintColor = tintColor;
  _backgroundView.backgroundColor = _tintColor;
}

- (void)setMessage:(NSString *)message {
  _message = message;
  _titleLabel.text = message;
}

- (void)setKind:(NSString *)kind {
  _kind = kind;
  _backgroundTransformY = CGRectGetHeight(self.bounds);
  if ([kind isEqualToString:MDCCollectionInfoBarKindHeader]) {
    _backgroundTransformY *= -1;
  }
  _backgroundView.transform = CGAffineTransformMakeTranslation(0, _backgroundTransformY);
}

- (void)setShouldApplyBackgroundViewShadow:(BOOL)shouldApplyBackgroundViewShadow {
  _shouldApplyBackgroundViewShadow = shouldApplyBackgroundViewShadow;
  MDCShadowLayer *shadowLayer = (MDCShadowLayer *)_backgroundView.layer;
  shadowLayer.elevation = shouldApplyBackgroundViewShadow ? 1 : 0;
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
  _textAlignment = textAlignment;
  _titleLabel.textAlignment = textAlignment;
}

- (void)setStyle:(MDCCollectionInfoBarViewStyle)style {
  _style = style;
  if (style == MDCCollectionInfoBarViewStyleHUD) {
    self.allowsTap = NO;
    self.shouldApplyBackgroundViewShadow = NO;
    self.textAlignment = NSTextAlignmentLeft;
    self.tintColor = CollectionInfoBarBlueColor();
    self.titleLabel.textColor = [UIColor whiteColor];
    self.autoDismissAfterDuration = 1;
    self.backgroundView.alpha = (CGFloat)0.9;
  } else if (style == MDCCollectionInfoBarViewStyleActionable) {
    self.allowsTap = YES;
    self.shouldApplyBackgroundViewShadow = YES;
    self.textAlignment = NSTextAlignmentCenter;
    self.tintColor = [UIColor whiteColor];
    self.titleLabel.textColor = CollectionInfoBarRedColor();
    self.autoDismissAfterDuration = 0;
    self.backgroundView.alpha = 1;
    self.isAccessibilityElement = YES;
    self.accessibilityTraits = UIAccessibilityTraitButton;
    self.accessibilityLabel = self.message;

    // Adds border to be positioned during sublayer layout.
    self.backgroundView.clipsToBounds = YES;
    if (!_backgroundBorderLayer) {
      _backgroundBorderLayer = [CALayer layer];
      _backgroundBorderLayer.borderColor = [UIColor colorWithWhite:0 alpha:(CGFloat)0.1].CGColor;
      _backgroundBorderLayer.borderWidth = 1 / [[UIScreen mainScreen] scale];
      [self.backgroundView.layer addSublayer:_backgroundBorderLayer];
    }
  }
}

- (BOOL)isVisible {
  return !_backgroundView.hidden;
}

- (void)showAnimated:(BOOL)animated {
  [self layoutIfNeeded];
  _backgroundView.hidden = NO;

  // Notify delegate.
  if ([_delegate respondsToSelector:@selector(infoBar:willShowAnimated:willAutoDismiss:)]) {
    [_delegate infoBar:self willShowAnimated:animated willAutoDismiss:[self shouldAutoDismiss]];
  }

  NSTimeInterval duration = (animated) ? MDCCollectionInfoBarAnimationDuration : 0;
  [UIView animateWithDuration:duration
      delay:0
      options:UIViewAnimationOptionCurveEaseOut
      animations:^{
        self.backgroundView.transform = CGAffineTransformIdentity;
      }
      completion:^(__unused BOOL finished) {
        self.userInteractionEnabled = self.allowsTap;

        // Notify delegate.
        if ([self.delegate respondsToSelector:@selector(infoBar:
                                                  didShowAnimated:willAutoDismiss:)]) {
          [self.delegate infoBar:self
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

  NSTimeInterval duration = (animated) ? MDCCollectionInfoBarAnimationDuration : 0;
  [UIView animateWithDuration:duration
      delay:0
      options:UIViewAnimationOptionCurveEaseIn
      animations:^{
        self.backgroundView.transform =
            CGAffineTransformMakeTranslation(0, self->_backgroundTransformY);
      }
      completion:^(__unused BOOL finished) {
        self.userInteractionEnabled = NO;
        self.backgroundView.hidden = YES;

        // Notify delegate.
        if ([self.delegate respondsToSelector:@selector(infoBar:
                                                  didDismissAnimated:didAutoDismiss:)]) {
          [self.delegate infoBar:self
              didDismissAnimated:animated
                  didAutoDismiss:[self shouldAutoDismiss]];
        }
      }];
}

#pragma mark - Private

- (void)handleTapGesture:(__unused UITapGestureRecognizer *)recognizer {
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
