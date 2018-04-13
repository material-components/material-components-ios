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
#import <CoreGraphics/CoreGraphics.h>

#import "MDCBottomNavigationItemView.h"

#import <MDFInternationalization/MDFInternationalization.h>

#import "MaterialBottomNavigationStrings.h"
#import "MaterialBottomNavigationStrings_table.h"
#import "MaterialMath.h"
#import "MDCBottomNavigationItemBadge.h"

static NSString *const MDCBottomNavigationItemViewTitleBelowIconKey =
    @"MDCBottomNavigationItemViewTitleBelowIconKey";
static NSString *const MDCBottomNavigationItemViewSelectedKey =
    @"MDCBottomNavigationItemViewSelectedKey";
static NSString *const MDCBottomNavigationItemViewTitleVisibilityKey =
    @"MDCBottomNavigationItemViewTitleVisibilityKey";
static NSString *const MDCBottomNavigationItemViewTitleKey = @"MDCBottomNavigationItemViewTitleKey";
static NSString *const MDCBottomNavigationItemViewItemTitleFontKey =
    @"MDCBottomNavigationItemViewItemTitleFontKey";
static NSString *const MDCBottomNavigationItemViewBadgeColorKey =
    @"MDCBottomNavigationItemViewBadgeColorKey";
static NSString *const MDCBottomNavigationItemViewSelectedItemTintColorKey =
    @"MDCBottomNavigationItemViewSelectedItemTintColorKey";
static NSString *const MDCBottomNavigationItemViewUnselectedItemTintColorKey =
    @"MDCBottomNavigationItemViewUnselectedItemTintColorKey";

static const CGFloat MDCBottomNavigationItemViewInkOpacity = 0.150f;
static const CGFloat kMDCBottomNavigationItemViewItemInset = 8.f;
static const CGFloat MDCBottomNavigationItemViewTitleFontSize = 12.f;

// The duration of the selection transition animation.
static const NSTimeInterval kMDCBottomNavigationItemViewTransitionDuration = 0.180f;

// The Bundle for string resources.
static NSString *const kMaterialBottomNavigationBundle = @"MaterialBottomNavigation.bundle";
static NSString *const kMDCBottomNavigationItemViewTabString = @"tab";

@interface MDCBottomNavigationItemView ()

@property(nonatomic, strong) MDCBottomNavigationItemBadge *badge;
@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel *label;

@end

@implementation MDCBottomNavigationItemView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
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

    if ([aDecoder containsValueForKey:MDCBottomNavigationItemViewTitleBelowIconKey]) {
      _titleBelowIcon = [aDecoder decodeBoolForKey:MDCBottomNavigationItemViewTitleBelowIconKey];
    }
    if ([aDecoder containsValueForKey:MDCBottomNavigationItemViewSelectedKey]) {
      _selected = [aDecoder decodeBoolForKey:MDCBottomNavigationItemViewSelectedKey];
    }
    if ([aDecoder containsValueForKey:MDCBottomNavigationItemViewTitleVisibilityKey]) {
      _titleVisibility =
          [aDecoder decodeIntegerForKey:MDCBottomNavigationItemViewTitleVisibilityKey];
    }
    if ([aDecoder containsValueForKey:MDCBottomNavigationItemViewTitleKey]) {
      _title = [aDecoder decodeObjectForKey:MDCBottomNavigationItemViewTitleKey];
    }
    if ([aDecoder containsValueForKey:MDCBottomNavigationItemViewItemTitleFontKey]) {
      _itemTitleFont = [aDecoder decodeObjectForKey:MDCBottomNavigationItemViewItemTitleFontKey];
    }
    if ([aDecoder containsValueForKey:MDCBottomNavigationItemViewBadgeColorKey]) {
      _badgeColor = [aDecoder decodeObjectForKey:MDCBottomNavigationItemViewBadgeColorKey];
    }
    if ([aDecoder containsValueForKey:MDCBottomNavigationItemViewSelectedItemTintColorKey]) {
      _selectedItemTintColor =
          [aDecoder decodeObjectForKey:MDCBottomNavigationItemViewSelectedItemTintColorKey];
    }
    if ([aDecoder containsValueForKey:MDCBottomNavigationItemViewUnselectedItemTintColorKey]) {
      _unselectedItemTintColor =
      [aDecoder decodeObjectForKey:MDCBottomNavigationItemViewUnselectedItemTintColorKey];
    }

    [self commonMDCBottomNavigationItemViewInit];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];
  [aCoder encodeBool:self.titleBelowIcon forKey:MDCBottomNavigationItemViewTitleBelowIconKey];
  [aCoder encodeBool:self.selected forKey:MDCBottomNavigationItemViewSelectedKey];
  [aCoder encodeInteger:self.titleVisibility forKey:MDCBottomNavigationItemViewTitleVisibilityKey];
  [aCoder encodeObject:self.title forKey:MDCBottomNavigationItemViewTitleKey];
  [aCoder encodeObject:self.itemTitleFont forKey:MDCBottomNavigationItemViewItemTitleFontKey];
  [aCoder encodeObject:self.badgeColor  forKey:MDCBottomNavigationItemViewBadgeColorKey];
  [aCoder encodeObject:self.selectedItemTintColor
                forKey:MDCBottomNavigationItemViewSelectedItemTintColorKey];
  [aCoder encodeObject:self.unselectedItemTintColor
                forKey:MDCBottomNavigationItemViewUnselectedItemTintColorKey];
}

- (void)commonMDCBottomNavigationItemViewInit {

  if (!_selectedItemTintColor) {
    _selectedItemTintColor = [UIColor blackColor];
  }
  if (!_unselectedItemTintColor) {
    _unselectedItemTintColor = [UIColor grayColor];
  }

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
    _label.textColor = _selectedItemTintColor;
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
    [self addSubview:_button];
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGSize labelSize = [self.title boundingRectWithSize:self.bounds.size
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:@{ NSFontAttributeName:self.label.font }
                                              context:nil].size;
  self.label.frame = CGRectMake(0, 0, labelSize.width, labelSize.height);
  self.inkView.maxRippleRadius =
      (CGFloat)(MDCHypot(CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds)) / 2);
  [self centerLayoutAnimated:NO];
}

- (void)centerLayoutAnimated:(bool)animated {
  if (self.titleBelowIcon) {
    CGPoint iconImageViewCenter =
        CGPointMake(CGRectGetMidX(self.bounds), CGRectGetHeight(self.iconImageView.bounds) / 2 +
                    kMDCBottomNavigationItemViewItemInset);
    BOOL titleVisibilityNever = self.selected &&
        self.titleVisibility == MDCBottomNavigationBarTitleVisibilityNever;
    BOOL titleVisibilitySelectedNever = !self.selected &&
        (self.titleVisibility == MDCBottomNavigationBarTitleVisibilitySelected ||
         self.titleVisibility == MDCBottomNavigationBarTitleVisibilityNever);
    if (titleVisibilityNever) {
      iconImageViewCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    } else if (titleVisibilitySelectedNever) {
      iconImageViewCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    }
    CGPoint badgeCenter =
        CGPointMake(CGRectGetMidX(self.bounds) + CGRectGetWidth(self.iconImageView.bounds) / 2,
                    iconImageViewCenter.y - CGRectGetMidX(self.iconImageView.bounds));
    self.label.center =
        CGPointMake(CGRectGetMidX(self.bounds), CGRectGetHeight(self.bounds) -
                    CGRectGetHeight(self.label.bounds) / 2 - kMDCBottomNavigationItemViewItemInset);
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
    UIUserInterfaceLayoutDirection layoutDirection = self.mdf_effectiveUserInterfaceLayoutDirection;
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

- (NSString *)accessibilityLabelWithTitle:(NSString *)title {
  NSMutableArray *labelComponents = [NSMutableArray array];

  // Use untransformed title as accessibility label to ensure accurate reading.
  if (title.length > 0) {
    [labelComponents addObject:title];
  }

  NSString *key =
      kMaterialBottomNavigationStringTable[kStr_MaterialBottomNavigationTabElementAccessibilityLabel];
  NSString *tabString =
      NSLocalizedStringFromTableInBundle(key,
                                         kMaterialBottomNavigationStringsTableName,
                                         [[self class] bundle],
                                         kMDCBottomNavigationItemViewTabString);
  [labelComponents addObject:tabString];

  // Speak components with a pause in between.
  return [labelComponents componentsJoinedByString:@", "];
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
    self.label.textColor = self.selectedItemTintColor;
    self.iconImageView.tintColor = self.selectedItemTintColor;
    self.button.accessibilityTraits |= UIAccessibilityTraitSelected;

    switch (self.titleVisibility) {
      case MDCBottomNavigationBarTitleVisibilitySelected:
        self.label.hidden = NO;
        break;
      case MDCBottomNavigationBarTitleVisibilityAlways:
        self.label.hidden = NO;
        break;
      case MDCBottomNavigationBarTitleVisibilityNever:
        self.label.hidden = YES;
        break;
    }
  } else {
    self.label.textColor = self.unselectedItemTintColor;
    self.iconImageView.tintColor = self.unselectedItemTintColor;
    self.button.accessibilityTraits &= ~UIAccessibilityTraitSelected;

    switch (self.titleVisibility) {
      case MDCBottomNavigationBarTitleVisibilitySelected:
        self.label.hidden = YES;
        break;
      case MDCBottomNavigationBarTitleVisibilityAlways:
        self.label.hidden = NO;
        break;
      case MDCBottomNavigationBarTitleVisibilityNever:
        self.label.hidden = YES;
        break;
    }
  }
  [self centerLayoutAnimated:animated];
}

- (void)setSelectedItemTintColor:(UIColor *)selectedItemTintColor {
  _selectedItemTintColor = selectedItemTintColor;
  if (self.selected) {
    self.iconImageView.tintColor = self.selectedItemTintColor;
    self.label.textColor = self.selectedItemTintColor;
    self.inkView.inkColor =
        [self.selectedItemTintColor colorWithAlphaComponent:MDCBottomNavigationItemViewInkOpacity];
  }
}

- (void)setUnselectedItemTintColor:(UIColor *)unselectedItemTintColor {
  _unselectedItemTintColor = unselectedItemTintColor;
  if (!self.selected) {
    self.iconImageView.tintColor = self.unselectedItemTintColor;
    self.label.textColor = self.unselectedItemTintColor;
    CGFloat alpha = MDCBottomNavigationItemViewInkOpacity;
    self.inkView.inkColor = [self.unselectedItemTintColor colorWithAlphaComponent:alpha];
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
  self.button.accessibilityValue = badgeValue;
  if (badgeValue == nil || badgeValue.length == 0) {
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
  self.button.accessibilityLabel = [self accessibilityLabelWithTitle:_title];
}

- (void)setItemTitleFont:(UIFont *)itemTitleFont {
  _itemTitleFont = itemTitleFont;
  self.label.font = itemTitleFont;
  [self setNeedsLayout];
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
