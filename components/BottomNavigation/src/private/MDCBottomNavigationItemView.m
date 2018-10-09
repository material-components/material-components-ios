// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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
#import <CoreGraphics/CoreGraphics.h>

#import "MDCBottomNavigationItemView.h"

#import <MDFInternationalization/MDFInternationalization.h>

#import "MaterialBottomNavigationStrings.h"
#import "MaterialBottomNavigationStrings_table.h"
#import "MaterialMath.h"
#import "MDCBottomNavigationItemBadge.h"

static const CGFloat MDCBottomNavigationItemViewInkOpacity = 0.150f;
static const CGFloat MDCBottomNavigationItemViewTitleFontSize = 12.f;
static const CGFloat kMDCBottomNavigationItemViewBadgeYOffset = 4.f;

// The duration of the selection transition animation.
static const NSTimeInterval kMDCBottomNavigationItemViewTransitionDuration = 0.180f;

// The Bundle for string resources.
static NSString *const kMaterialBottomNavigationBundle = @"MaterialBottomNavigation.bundle";
static NSString *const kMDCBottomNavigationItemViewTabString = @"tab";

@interface MDCBottomNavigationItemView ()

@property(nonatomic, strong) MDCBottomNavigationItemBadge *badge;
@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel *label;
@property(nonatomic) BOOL shouldPretendToBeATab;
- (CGPoint)badgeCenterFromIconFrame:(CGRect)iconFrame isRTL:(BOOL)isRTL;

@end

@implementation MDCBottomNavigationItemView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
#if defined(__IPHONE_10_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wunguarded-availability"
#pragma clang diagnostic ignored "-Wtautological-pointer-compare"
    if (&UIAccessibilityTraitTabBar == NULL) {
      _shouldPretendToBeATab = YES;
    }
#pragma clang diagnostic pop
#else
    _shouldPretendToBeATab = YES;
#endif
    _titleBelowIcon = YES;
    [self commonMDCBottomNavigationItemViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    _titleBelowIcon = YES;

    NSUInteger totalViewsProcessed = 0;
    for (UIView *view in self.subviews) {
      if ([view isKindOfClass:[MDCInkView class]]) {
        _inkView = (MDCInkView *)view;
        ++totalViewsProcessed;
      } else if ([view isKindOfClass:[UIImageView class]]) {
        _iconImageView = (UIImageView *)view;
        _image = _iconImageView.image;
        ++totalViewsProcessed;
      } else if ([view isKindOfClass:[UILabel class]]) {
        _label = (UILabel *)view;
        ++totalViewsProcessed;
      } else if ([view isKindOfClass:[MDCBottomNavigationItemBadge class]]) {
        _badge = (MDCBottomNavigationItemBadge *)view;
        ++totalViewsProcessed;
      } else if ([view isKindOfClass:[UIButton class]]) {
        _button = (UIButton *)view;
        ++totalViewsProcessed;
      }
    }
    NSAssert(totalViewsProcessed == self.subviews.count,
             @"Unexpected number of subviews. Expected %lu but restored %lu. Unarchiving may fail.",
             (unsigned long)self.subviews.count, (unsigned long)totalViewsProcessed);

    [self commonMDCBottomNavigationItemViewInit];
  }
  return self;
}

- (void)commonMDCBottomNavigationItemViewInit {

  if (!_selectedItemTintColor) {
    _selectedItemTintColor = [UIColor blackColor];
  }
  if (!_unselectedItemTintColor) {
    _unselectedItemTintColor = [UIColor grayColor];
  }
  _selectedItemTitleColor = _selectedItemTintColor;

  if (!_iconImageView) {
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _iconImageView.isAccessibilityElement = NO;
    [self addSubview:_iconImageView];
  }

  if (!_label) {
    _label = [[UILabel alloc] initWithFrame:CGRectZero];
    _label.text = _title;
    _label.font = [UIFont systemFontOfSize:MDCBottomNavigationItemViewTitleFontSize];
    _label.textAlignment = NSTextAlignmentCenter;
    _label.textColor = _selectedItemTitleColor;
    _label.isAccessibilityElement = NO;
    [self addSubview:_label];

  }

  if (!_badge) {
    _badge = [[MDCBottomNavigationItemBadge alloc] initWithFrame:CGRectZero];
    _badge.isAccessibilityElement = NO;
    [self addSubview:_badge];
  }

  if (!_badge.badgeValue) {
    _badge.hidden = YES;
  }

  if (!_inkView) {
    _inkView = [[MDCInkView alloc] initWithFrame:self.bounds];
    _inkView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    _inkView.usesLegacyInkRipple = NO;
    _inkView.clipsToBounds = NO;
    [self addSubview:_inkView];
  }

  if (!_button) {
    _button = [[UIButton alloc] initWithFrame:self.bounds];
    _button.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    _button.accessibilityLabel = [self accessibilityLabelWithTitle:_title];
    _button.accessibilityTraits &= ~UIAccessibilityTraitButton;
    _button.accessibilityValue = self.accessibilityValue;
    [self addSubview:_button];
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];

  [self.label sizeToFit];
  CGSize labelSize = CGSizeMake(CGRectGetWidth(self.label.bounds),
                                CGRectGetHeight(self.label.bounds));
  CGFloat maxWidth = CGRectGetWidth(self.bounds);
  self.label.frame = CGRectMake(0, 0, MIN(maxWidth, labelSize.width), labelSize.height);
  self.inkView.maxRippleRadius =
      (CGFloat)(MDCHypot(CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds)) / 2);
  [self centerLayoutAnimated:NO];
}

- (void)centerLayoutAnimated:(BOOL)animated {
  CGRect contentBoundingRect = UIEdgeInsetsInsetRect(self.bounds, self.contentInsets);
  CGFloat centerY = CGRectGetMidY(contentBoundingRect);
  CGFloat centerX = CGRectGetMidX(contentBoundingRect);
  UIUserInterfaceLayoutDirection layoutDirection = self.mdf_effectiveUserInterfaceLayoutDirection;
  BOOL isRTL = layoutDirection == UIUserInterfaceLayoutDirectionRightToLeft;
  if (isRTL) {
    centerX = CGRectGetWidth(self.bounds) - centerX;
  }

  if (self.titleBelowIcon) {
    BOOL titleHidden =
        self.titleVisibility == MDCBottomNavigationBarTitleVisibilityNever ||
        (self.titleVisibility == MDCBottomNavigationBarTitleVisibilitySelected && !self.selected);
    CGFloat iconHeight = CGRectGetHeight(self.iconImageView.bounds);
    CGFloat labelHeight = CGRectGetHeight(self.label.bounds);
    CGFloat totalContentHeight = iconHeight;
    if (!titleHidden) {
      totalContentHeight += labelHeight + self.contentVerticalMargin;
    }
    CGPoint iconImageViewCenter =
        CGPointMake(centerX, centerY - totalContentHeight / 2 + iconHeight / 2);
    self.label.center = CGPointMake(centerX, centerY + totalContentHeight / 2 - labelHeight / 2);
    if (animated) {
      [UIView animateWithDuration:kMDCBottomNavigationItemViewTransitionDuration animations:^(void) {
        self.iconImageView.center = iconImageViewCenter;
      }];
    } else {
      self.iconImageView.center = iconImageViewCenter;
    }
    self.label.textAlignment = NSTextAlignmentCenter;
  } else {
    CGFloat contentsWidth =
        CGRectGetWidth(self.iconImageView.bounds) + CGRectGetWidth(self.label.bounds);
    if (!isRTL) {
      CGPoint iconImageViewCenter =
          CGPointMake(centerX - CGRectGetWidth(contentBoundingRect) * 0.2f, centerY);
      self.iconImageView.center = iconImageViewCenter;
      CGFloat labelCenterX =
          iconImageViewCenter.x + contentsWidth / 2 + self.contentHorizontalMargin;
      self.label.center = CGPointMake(labelCenterX, centerY);
      self.label.textAlignment = NSTextAlignmentLeft;
    } else {
      CGPoint iconImageViewCenter =
          CGPointMake(centerX + CGRectGetWidth(contentBoundingRect) * 0.2f, centerY);
      self.iconImageView.center = iconImageViewCenter;
      CGFloat labelCenterX =
          iconImageViewCenter.x - contentsWidth / 2 - self.contentHorizontalMargin;
      self.label.center = CGPointMake(labelCenterX, centerY);
      self.label.textAlignment = NSTextAlignmentRight;
    }
  }
  self.badge.center = [self badgeCenterFromIconFrame:CGRectStandardize(self.iconImageView.frame)
                                               isRTL:isRTL];
}

- (void)updateLabelVisibility {
  if (self.selected) {
    switch (self.titleVisibility) {
      case MDCBottomNavigationBarTitleVisibilitySelected:
      case MDCBottomNavigationBarTitleVisibilityAlways:
        self.label.hidden = NO;
        break;
      case MDCBottomNavigationBarTitleVisibilityNever:
        self.label.hidden = YES;
        break;
    }
  } else {
    switch (self.titleVisibility) {
      case MDCBottomNavigationBarTitleVisibilitySelected:
      case MDCBottomNavigationBarTitleVisibilityNever:
        self.label.hidden = YES;
        break;
      case MDCBottomNavigationBarTitleVisibilityAlways:
        self.label.hidden = NO;
        break;
    }
  }
}

- (NSString *)accessibilityLabelWithTitle:(NSString *)title {
  NSMutableArray *labelComponents = [NSMutableArray array];

  // Use untransformed title as accessibility label to ensure accurate reading.
  if (title.length > 0) {
    [labelComponents addObject:title];
  }

  if (self.shouldPretendToBeATab) {
    NSString *key =
        kMaterialBottomNavigationStringTable[kStr_MaterialBottomNavigationTabElementAccessibilityLabel];
    NSString *tabString =
        NSLocalizedStringFromTableInBundle(key,
                                           kMaterialBottomNavigationStringsTableName,
                                           [[self class] bundle],
                                           kMDCBottomNavigationItemViewTabString);
    [labelComponents addObject:tabString];
  }

  // Speak components with a pause in between.
  return [labelComponents componentsJoinedByString:@", "];
}

- (CGPoint)badgeCenterFromIconFrame:(CGRect)iconFrame isRTL:(BOOL)isRTL {
  if (isRTL) {
    return CGPointMake(CGRectGetMinX(iconFrame),
                       CGRectGetMinY(iconFrame) + kMDCBottomNavigationItemViewBadgeYOffset);
  }
  return CGPointMake(CGRectGetMaxX(iconFrame),
                     CGRectGetMinY(iconFrame) + kMDCBottomNavigationItemViewBadgeYOffset);
}

- (NSString *)badgeValue {
  return self.badge.badgeValue;
}

#pragma mark - Setters

- (void)setSelected:(BOOL)selected {
  [self setSelected:selected animated:NO];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
  _selected = selected;
  if (selected) {
    self.label.textColor = self.selectedItemTitleColor;
    self.iconImageView.tintColor = self.selectedItemTintColor;
    self.button.accessibilityTraits |= UIAccessibilityTraitSelected;
    self.iconImageView.image = (self.selectedImage) ? self.selectedImage : self.image;
    [self updateLabelVisibility];
  } else {
    self.label.textColor = self.unselectedItemTintColor;
    self.iconImageView.tintColor = self.unselectedItemTintColor;
    self.button.accessibilityTraits &= ~UIAccessibilityTraitSelected;
    self.iconImageView.image = self.image;
    [self updateLabelVisibility];
  }
  [self centerLayoutAnimated:animated];
}

- (void)setSelectedItemTintColor:(UIColor *)selectedItemTintColor {
  _selectedItemTintColor = selectedItemTintColor;
  _selectedItemTitleColor = selectedItemTintColor;
  if (self.selected) {
    self.iconImageView.tintColor = self.selectedItemTintColor;
    self.label.textColor = self.selectedItemTitleColor;
  }
  self.inkView.inkColor =
      [self.selectedItemTintColor colorWithAlphaComponent:MDCBottomNavigationItemViewInkOpacity];

}

- (void)setUnselectedItemTintColor:(UIColor *)unselectedItemTintColor {
  _unselectedItemTintColor = unselectedItemTintColor;
  if (!self.selected) {
    self.iconImageView.tintColor = self.unselectedItemTintColor;
    self.label.textColor = self.unselectedItemTintColor;
  }
}

- (void)setSelectedItemTitleColor:(UIColor *)selectedItemTitleColor {
  _selectedItemTitleColor = selectedItemTitleColor;
  if (self.selected) {
    self.label.textColor = self.selectedItemTitleColor;
  }
}

- (void)setBadgeColor:(UIColor *)badgeColor {
  _badgeColor = badgeColor;
  self.badge.badgeColor = badgeColor;
}

- (void)setBadgeValue:(NSString *)badgeValue {
  // Due to KVO, badgeValue may be of type NSNull.
  if ([badgeValue isKindOfClass:[NSNull class]]) {
    badgeValue = nil;
  }
  self.badge.badgeValue = badgeValue;
  if ([super accessibilityValue] == nil || [self accessibilityValue].length == 0) {
    self.button.accessibilityValue = badgeValue;
  }
  if (badgeValue == nil || badgeValue.length == 0) {
    self.badge.hidden = YES;
  } else {
    self.badge.hidden = NO;
  }
}

- (void)setImage:(UIImage *)image {
  _image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.iconImageView.image = _image;
  self.iconImageView.tintColor = (self.selected) ? self.selectedItemTintColor
      : self.unselectedItemTintColor;
  [self.iconImageView sizeToFit];
}

-(void)setSelectedImage:(UIImage *)selectedImage {
  _selectedImage = [selectedImage imageWithRenderingMode: UIImageRenderingModeAlwaysTemplate];
  self.iconImageView.image = _selectedImage;
  self.iconImageView.tintColor = self.selectedItemTintColor;
  [self.iconImageView sizeToFit];
}

- (void)setTitle:(NSString *)title {
  _title = [title copy];
  self.label.text = _title;
  self.button.accessibilityLabel = [self accessibilityLabelWithTitle:_title];
}

-(void)setTitleVisibility:(MDCBottomNavigationBarTitleVisibility)titleVisibility {
  _titleVisibility = titleVisibility;
  [self updateLabelVisibility];
}

- (void)setItemTitleFont:(UIFont *)itemTitleFont {
  _itemTitleFont = itemTitleFont;
  self.label.font = itemTitleFont;
  [self setNeedsLayout];
}

-(void)setAccessibilityValue:(NSString *)accessibilityValue {
  [super setAccessibilityValue:accessibilityValue];
  self.button.accessibilityValue = accessibilityValue;
}

- (NSString *)accessibilityValue {
  return self.button.accessibilityValue;
}

-(void)setAccessibilityIdentifier:(NSString *)accessibilityIdentifier {
  self.button.accessibilityIdentifier = accessibilityIdentifier;
}

-(NSString *)accessibilityIdentifier {
  return self.button.accessibilityIdentifier;
}

#pragma mark - Resource bundle

+ (NSBundle *)bundle {
  static NSBundle *bundle = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    bundle = [NSBundle bundleWithPath:[self bundlePathWithName:kMaterialBottomNavigationBundle]];
  });
  return bundle;
}

+ (NSString *)bundlePathWithName:(NSString *)bundleName {
  // In iOS 8+, we could be included by way of a dynamic framework, and our resource bundles may
  // not be in the main .app bundle, but rather in a nested framework, so figure out where we live
  // and use that as the search location.
  NSBundle *bundle = [NSBundle bundleForClass:[MDCBottomNavigationBar class]];
  NSString *resourcePath = [(nil == bundle ? [NSBundle mainBundle] : bundle) resourcePath];
  return [resourcePath stringByAppendingPathComponent:bundleName];
}

@end
