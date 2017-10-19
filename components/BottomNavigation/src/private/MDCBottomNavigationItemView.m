/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCBottomNavigationItemView.h"

#import "MaterialRTL.h"
#import "MDCBottomNavigationItemBadge.h"

static const CGFloat kMDCBottomNavigationItemViewCircleLayerOffset = -6.f;
static const CGFloat kMDCBottomNavigationItemViewCircleLayerDimension = 36.f;
static const CGFloat kMDCBottomNavigationItemViewCircleOpacity = 0.150f;
static const CGFloat kMDCBottomNavigationItemViewTitleFontSize = 12.f;

// The duration of the selection transition animation.
static const NSTimeInterval kMDCBottomNavigationItemViewTransitionDuration = 0.180f;

@interface MDCBottomNavigationItemView ()

@property(nonatomic, strong) CAShapeLayer *circleLayer;
@property(nonatomic, strong) MDCBottomNavigationItemBadge *badge;
@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel *label;

@end

@implementation MDCBottomNavigationItemView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCBottomNavigationItemViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCBottomNavigationItemViewInit];
  }
  return self;
}

- (void)commonMDCBottomNavigationItemViewInit {
  self.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);

  _titleBelowIcon = YES;
  _selectedItemTintColor = [UIColor blackColor];
  _unselectedItemTintColor = [UIColor grayColor];

  _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
  [self addSubview:_iconImageView];

  _label = [[UILabel alloc] initWithFrame:CGRectZero];
  _label.text = _title;
  _label.font = [UIFont systemFontOfSize:kMDCBottomNavigationItemViewTitleFontSize];
  _label.textAlignment = NSTextAlignmentCenter;
  _label.textColor = _selectedItemTintColor;
  _label.isAccessibilityElement = NO;
  [self addSubview:_label];

  _badge = [[MDCBottomNavigationItemBadge alloc] initWithFrame:CGRectZero];
  _badge.isAccessibilityElement = NO;
  [self addSubview:_badge];

  if (!_badgeValue) {
    _badge.hidden = YES;
  }

  _circleLayer = [CAShapeLayer layer];
  CGRect circleLayerRect = CGRectMake(kMDCBottomNavigationItemViewCircleLayerOffset,
                                      kMDCBottomNavigationItemViewCircleLayerOffset,
                                      kMDCBottomNavigationItemViewCircleLayerDimension,
                                      kMDCBottomNavigationItemViewCircleLayerDimension);
  UIBezierPath *bezierPath = [UIBezierPath bezierPathWithOvalInRect:circleLayerRect];
  _circleLayer.path = bezierPath.CGPath;
  _circleLayer.fillColor = _selectedItemTintColor.CGColor;
  _circleLayer.opacity = 0;
  [_iconImageView.layer addSublayer:_circleLayer];

  _button = [[UIButton alloc] initWithFrame:self.bounds];
  _button.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  _button.accessibilityLabel = _title;
  [self addSubview:_button];
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGSize labelSize = [self sizeForText:self.title
                                     font:self.label.font
                         boundingRectSize:self.bounds.size];
  self.label.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
  [self centerLayoutAnimated:NO];
}

- (void)centerLayoutAnimated:(bool)animated {
  if (self.titleBelowIcon) {
    CGPoint iconImageViewCenter =
        CGPointMake(CGRectGetMidX(self.bounds),
                    CGRectGetMidY(self.bounds) - CGRectGetHeight(self.bounds) * 0.1f);
    BOOL titleHideStateSelectedAways = self.selected &&
    self.titleHideState == MDCBottomNavigationBarTitleHideStateAlways;
    BOOL titleHideStateUnselectedDefaultAlways = !self.selected &&
    (self.titleHideState == MDCBottomNavigationBarTitleHideStateDefault ||
     self.titleHideState == MDCBottomNavigationBarTitleHideStateAlways);
    if (titleHideStateSelectedAways) {
      iconImageViewCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    } else if (titleHideStateUnselectedDefaultAlways) {
      iconImageViewCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    }
    CGPoint badgeCenter =
        CGPointMake(CGRectGetMidX(self.bounds) + CGRectGetWidth(self.iconImageView.bounds) / 2,
                    iconImageViewCenter.y - CGRectGetMidX(self.iconImageView.bounds));
    self.label.center =
        CGPointMake(CGRectGetMidX(self.bounds),
                    CGRectGetMidY(self.bounds) + CGRectGetHeight(self.bounds) * 0.25f);
    if (animated) {
      [UIView animateWithDuration:kMDCBottomNavigationItemViewTransitionDuration animations:^(void) {
        self.iconImageView.center = iconImageViewCenter;
        self.badge.center = badgeCenter;
      }];
    } else {
      self.iconImageView.center = iconImageViewCenter;
      self.badge.center = badgeCenter;
    }
    self.label.textAlignment = NSTextAlignmentCenter;
  } else {
    UIUserInterfaceLayoutDirection layoutDirection = self.mdc_effectiveUserInterfaceLayoutDirection;
    if (layoutDirection == UIUserInterfaceLayoutDirectionLeftToRight) {
      CGPoint iconImageViewCenter =
          CGPointMake(CGRectGetMidX(self.bounds) - CGRectGetWidth(self.bounds) * 0.2f,
                      CGRectGetMidY(self.bounds));
      self.iconImageView.center = iconImageViewCenter;
      self.label.center =
          CGPointMake(iconImageViewCenter.x + CGRectGetWidth(self.iconImageView.bounds) +
                      CGRectGetWidth(self.label.bounds) / 2,
                      CGRectGetMidY(self.bounds));
      self.badge.center =
          CGPointMake(CGRectGetMidX(self.bounds) - CGRectGetWidth(self.bounds) * 0.2f +
                      CGRectGetWidth(self.iconImageView.bounds) / 2,
                      iconImageViewCenter.y - CGRectGetMidX(self.iconImageView.bounds));
      self.label.textAlignment = NSTextAlignmentLeft;
    } else {
      CGPoint iconImageViewCenter =
          CGPointMake(CGRectGetMidX(self.bounds) + CGRectGetWidth(self.bounds) * 0.2f,
                      CGRectGetMidY(self.bounds));
      self.iconImageView.center = iconImageViewCenter;
      self.label.center =
          CGPointMake(iconImageViewCenter.x - CGRectGetWidth(self.iconImageView.bounds) -
                      CGRectGetWidth(self.label.bounds) / 2,
                      CGRectGetMidY(self.bounds));
      self.badge.center =
          CGPointMake(CGRectGetMidX(self.bounds) + CGRectGetWidth(self.bounds) * 0.2f +
                      CGRectGetWidth(self.iconImageView.bounds) / 2,
                      iconImageViewCenter.y - CGRectGetMidX(self.iconImageView.bounds));
      self.label.textAlignment = NSTextAlignmentRight;
    }
  }
}

- (CGSize)sizeForText:(NSString *)text
                 font:(UIFont *)font
     boundingRectSize:(CGSize)boundingRectSize {
  CGRect rect = [text boundingRectWithSize:boundingRectSize
                                   options:NSStringDrawingUsesLineFragmentOrigin
                                attributes:@{ NSFontAttributeName:font }
                                   context:nil];
  return rect.size;
}

#pragma mark - Setters

- (void)setSelected:(BOOL)selected {
  [self setSelected:selected animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  _selected = selected;
  if (selected) {
    self.label.textColor = self.selectedItemTintColor;
    self.iconImageView.tintColor = self.selectedItemTintColor;
    self.button.accessibilityTraits |= UIAccessibilityTraitSelected;

    switch (self.titleHideState) {
      case MDCBottomNavigationBarTitleHideStateDefault:
        self.label.hidden = NO;
        break;
      case MDCBottomNavigationBarTitleHideStateNever:
        self.label.hidden = NO;
        break;
      case MDCBottomNavigationBarTitleHideStateAlways:
        self.label.hidden = YES;
        break;
    }
  } else {
    self.label.textColor = self.unselectedItemTintColor;
    self.iconImageView.tintColor = self.unselectedItemTintColor;
    self.button.accessibilityTraits &= ~UIAccessibilityTraitSelected;

    switch (self.titleHideState) {
      case MDCBottomNavigationBarTitleHideStateDefault:
        self.label.hidden = YES;
        break;
      case MDCBottomNavigationBarTitleHideStateNever:
        self.label.hidden = NO;
        break;
      case MDCBottomNavigationBarTitleHideStateAlways:
        self.label.hidden = YES;
        break;
    }
  }
  [self centerLayoutAnimated:animated];
}

- (void)setCircleHighlightHidden:(BOOL)circleHighlightHidden {
  _circleHighlightHidden = circleHighlightHidden;
  if (!circleHighlightHidden) {
    self.circleLayer.opacity = kMDCBottomNavigationItemViewCircleOpacity;
    self.iconImageView.tintColor = self.selectedItemTintColor;
  } else {
    self.circleLayer.opacity = 0;
    if (self.selected) {
      self.iconImageView.tintColor = self.selectedItemTintColor;
    } else {
      self.iconImageView.tintColor = self.unselectedItemTintColor;
    }
  }
}

- (void)setSelectedItemTintColor:(UIColor *)selectedItemTintColor {
  _selectedItemTintColor = selectedItemTintColor;
  self.label.textColor = self.selectedItemTintColor;
  self.circleLayer.fillColor = self.selectedItemTintColor.CGColor;
}

- (void)setUnselectedItemTintColor:(UIColor *)unselectedItemTintColor {
  _unselectedItemTintColor = unselectedItemTintColor;
}

- (void)setBadgeColor:(UIColor *)badgeColor {
  _badgeColor = badgeColor;
  self.badge.badgeColor = badgeColor;
}

- (void)setBadgeValue:(NSString *)badgeValue {
  _badgeValue = badgeValue;
  self.badge.badgeValue = badgeValue;
  self.button.accessibilityValue = badgeValue;
  if (_badgeValue == nil || _badgeValue.length == 0) {
    self.badge.hidden = YES;
  } else {
    self.badge.hidden = NO;
  }
}

- (void)setImage:(UIImage *)image {
  _image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.iconImageView.image = _image;
  self.iconImageView.tintColor = self.selectedItemTintColor;
  [self.iconImageView sizeToFit];
}

- (void)setTitle:(NSString *)title {
  _title = [title copy];
  self.label.text = _title;
  self.button.accessibilityLabel = _title;
}

- (void)setItemTitleFont:(UIFont *)itemTitleFont {
  _itemTitleFont = itemTitleFont;
  self.label.font = itemTitleFont;
  [self setNeedsLayout];
}

@end
