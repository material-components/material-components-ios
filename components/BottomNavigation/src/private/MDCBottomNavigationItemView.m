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
#import "MDCBottomNavigationItemView.h"

#import <CoreGraphics/CoreGraphics.h>

#import <MDFInternationalization/MDFInternationalization.h>
#import "MDCBottomNavigationItemBadge.h"
#import "MaterialBottomNavigationStrings.h"
#import "MaterialBottomNavigationStrings_table.h"
#import "MaterialMath.h"

// A number large enough to be larger than any reasonable screen dimension but small enough that
// CGFloat doesn't lose precision.
static const CGFloat kDefaultUndefinedDimensionSize = 1000000;
static const CGFloat MDCBottomNavigationItemViewInkOpacity = (CGFloat)0.150;
static const CGFloat MDCBottomNavigationItemViewTitleFontSize = 12;
static const CGFloat kMDCBottomNavigationItemViewBadgeYOffset = 4;

// The duration of the selection transition animation.
static const NSTimeInterval kMDCBottomNavigationItemViewTransitionDuration = 0.180;

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
    _inkView.autoresizingMask =
        (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
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
  [self.badge sizeToFit];
  CGSize labelSize =
      CGSizeMake(CGRectGetWidth(self.label.bounds), CGRectGetHeight(self.label.bounds));
  CGFloat maxWidth = CGRectGetWidth(self.bounds);
  self.label.frame = CGRectMake(0, 0, MIN(maxWidth, labelSize.width), labelSize.height);
  self.inkView.maxRippleRadius =
      (CGFloat)(MDCHypot(CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds)) / 2);
  [self centerLayoutAnimated:NO];
}

- (CGSize)sizeThatFits:(CGSize)size {
  // If we're given a zero or negative value, return the content size with any margins
  if (size.width < 0.0001) {
    size.width = kDefaultUndefinedDimensionSize;
  }
  if (size.height > 0.0001) {
    size.height = kDefaultUndefinedDimensionSize;
  }
  CGRect availableRect = CGRectMake(0, 0, size.width, size.height);
  CGRect labelFrame = CGRectZero;
  CGRect iconImageViewFrame = CGRectZero;
  [self calculateLayoutInBounds:availableRect
                  forLabelFrame:&labelFrame
             iconImageViewFrame:&iconImageViewFrame];

  CGRect totalFrame = CGRectUnion(labelFrame, iconImageViewFrame);
  totalFrame = UIEdgeInsetsInsetRect(
      totalFrame, UIEdgeInsetsMake(-self.contentInsets.top, -self.contentInsets.left,
                                   -self.contentInsets.bottom, -self.contentInsets.right));
  return totalFrame.size;
}

- (void)calculateVerticalLayoutInBounds:(CGRect)contentBounds
                          forLabelFrame:(CGRect *)outLabelFrame
                     iconImageViewFrame:(CGRect *)outIconFrame {
    CGRect contentBoundingRect =
      CGRectStandardize(UIEdgeInsetsInsetRect(contentBounds, self.contentInsets));
  CGSize iconImageViewSize = [self.iconImageView sizeThatFits:contentBoundingRect.size];
  CGSize labelSize = [self.label sizeThatFits:contentBoundingRect.size];
  BOOL titleHidden =
      self.titleVisibility == MDCBottomNavigationBarTitleVisibilityNever ||
      (self.titleVisibility == MDCBottomNavigationBarTitleVisibilitySelected && !self.selected);
  CGFloat iconHeight = iconImageViewSize.height;
  CGFloat labelHeight = labelSize.height;
  CGFloat totalContentHeight = iconHeight;
  if (!titleHidden) {
    totalContentHeight += labelHeight + self.contentVerticalMargin;
  }
  CGFloat centerY = CGRectGetMidY(contentBoundingRect);
  CGFloat centerX = CGRectGetMidX(contentBoundingRect);
  CGPoint iconImageViewCenter = CGPointMake(centerX, centerY - totalContentHeight / 2 + iconHeight / 2);
  CGPoint labelCenter = CGPointMake(centerX, centerY + totalContentHeight / 2 - labelHeight / 2);
  CGFloat availableContentWidth = CGRectGetWidth(contentBoundingRect);
  if (labelSize.width > availableContentWidth) {
    labelSize = CGSizeMake(availableContentWidth, labelSize.height);
  }
  
  if (outLabelFrame != NULL) {
    *outLabelFrame =
    CGRectMake(labelCenter.x - (labelSize.width / 2), labelCenter.y - (labelSize.height / 2),
               labelSize.width, labelSize.height);
  }
  if (outIconFrame != NULL) {
    *outIconFrame = CGRectMake(iconImageViewCenter.x - (iconImageViewSize.width / 2),
                               iconImageViewCenter.y - (iconImageViewSize.height / 2),
                               iconImageViewSize.width, iconImageViewSize.height);
  }

}

- (void)calculateHorizontalLayoutInBounds:(CGRect)contentBounds
                            forLabelFrame:(CGRect *)outLabelFrame
                       iconImageViewFrame:(CGRect *)outIconFrame {
  CGRect contentBoundingRect =
      CGRectStandardize(UIEdgeInsetsInsetRect(contentBounds, self.contentInsets));
  CGFloat centerY = CGRectGetMidY(contentBoundingRect);

  CGSize iconImageViewSize = [self.iconImageView sizeThatFits:contentBoundingRect.size];
  CGSize labelSize = [self.label sizeThatFits:contentBoundingRect.size];
  CGPoint iconImageViewCenter = CGPointZero;

  CGFloat contentsWidth =
      iconImageViewSize.width + labelSize.width + self.contentHorizontalMargin;
  CGFloat availableContentWidth = CGRectGetWidth(contentBoundingRect);
  if (contentsWidth > availableContentWidth) {
    contentsWidth = availableContentWidth;
  }
  // If the content width and available width are different, the internal spacing required to center
  // the contents.
  CGFloat contentPadding = (availableContentWidth - contentsWidth) / 2;
  availableContentWidth -= iconImageViewSize.width + self.contentHorizontalMargin;
  labelSize = CGSizeMake(MIN(labelSize.width, availableContentWidth), labelSize.height);
  // Amount icon center is offset from the leading edge.
  CGFloat iconCenterOffset = contentPadding + iconImageViewSize.width / 2;
  CGFloat labelOffsetFromIcon =
      iconImageViewSize.width / 2 + self.contentHorizontalMargin + labelSize.width / 2;

  BOOL isRTL =
      self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft;

  NSInteger rtlCoefficient = isRTL ? -1 : 1;
  CGFloat layoutStartingPoint = isRTL ? CGRectGetMaxX(contentBoundingRect)
                                      : CGRectGetMinX(contentBoundingRect);

  iconImageViewCenter = CGPointMake(layoutStartingPoint + rtlCoefficient * iconCenterOffset,
                                    centerY);
  CGFloat labelCenterX = iconImageViewCenter.x + rtlCoefficient * labelOffsetFromIcon;
  CGPoint labelCenter = CGPointMake(labelCenterX, centerY);

  if (outLabelFrame != NULL) {
    *outLabelFrame =
        CGRectMake(labelCenter.x - (labelSize.width / 2), labelCenter.y - (labelSize.height / 2),
                   labelSize.width, labelSize.height);
  }
  if (outIconFrame != NULL) {
    *outIconFrame = CGRectMake(iconImageViewCenter.x - (iconImageViewSize.width / 2),
                               iconImageViewCenter.y - (iconImageViewSize.height / 2),
                               iconImageViewSize.width, iconImageViewSize.height);
  }
}

- (void)calculateLayoutInBounds:(CGRect)contentBounds
                  forLabelFrame:(CGRect *)outLabelFrame
             iconImageViewFrame:(CGRect *)outIconFrame {
  if (self.titleBelowIcon) {
    return [self calculateVerticalLayoutInBounds:contentBounds
                            forLabelFrame:outLabelFrame
                       iconImageViewFrame:outIconFrame];
  }
  return [self calculateHorizontalLayoutInBounds:contentBounds
                                   forLabelFrame:outLabelFrame
                              iconImageViewFrame:outIconFrame];

}

- (void)centerLayoutAnimated:(BOOL)animated {
  CGRect labelFrame = CGRectZero;
  CGRect iconImageViewFrame = CGRectZero;
  UIUserInterfaceLayoutDirection layoutDirection = self.mdf_effectiveUserInterfaceLayoutDirection;
  BOOL isRTL = layoutDirection == UIUserInterfaceLayoutDirectionRightToLeft;

  [self calculateLayoutInBounds:self.bounds
                  forLabelFrame:&labelFrame
             iconImageViewFrame:&iconImageViewFrame];

  CGPoint iconImageViewCenter =
      CGPointMake(CGRectGetMidX(iconImageViewFrame), CGRectGetMidY(iconImageViewFrame));
  self.label.center = CGPointMake(CGRectGetMidX(labelFrame), CGRectGetMidY(labelFrame));
  self.label.bounds = CGRectMake(0, 0, CGRectGetWidth(labelFrame), CGRectGetHeight(labelFrame));

  if (self.titleBelowIcon) {
    if (animated) {
      [UIView animateWithDuration:kMDCBottomNavigationItemViewTransitionDuration
                       animations:^(void) {
                         self.iconImageView.center = iconImageViewCenter;
                         self.badge.center =
                             [self badgeCenterFromIconFrame:CGRectStandardize(iconImageViewFrame)
                                                      isRTL:isRTL];
                       }];
    } else {
      self.iconImageView.center = iconImageViewCenter;
      self.badge.center = [self badgeCenterFromIconFrame:CGRectStandardize(iconImageViewFrame)
                                                   isRTL:isRTL];
    }
    self.label.textAlignment = NSTextAlignmentCenter;
  } else {
    if (!isRTL) {
      self.label.textAlignment = NSTextAlignmentLeft;
    } else {
      self.label.textAlignment = NSTextAlignmentRight;
    }
    self.iconImageView.center = iconImageViewCenter;
    self.badge.center = [self badgeCenterFromIconFrame:CGRectStandardize(iconImageViewFrame)
                                                 isRTL:isRTL];
  }
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
  [self setNeedsLayout];
}

- (NSString *)accessibilityLabelWithTitle:(NSString *)title {
  NSMutableArray *labelComponents = [NSMutableArray array];

  // Use untransformed title as accessibility label to ensure accurate reading.
  if (title.length > 0) {
    [labelComponents addObject:title];
  }

  if (self.shouldPretendToBeATab) {
    NSString *key = kMaterialBottomNavigationStringTable
        [kStr_MaterialBottomNavigationTabElementAccessibilityLabel];
    NSString *tabString = NSLocalizedStringFromTableInBundle(
        key, kMaterialBottomNavigationStringsTableName, [[self class] bundle],
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
  if (badgeValue == nil) {
    self.badge.hidden = YES;
  } else {
    self.badge.hidden = NO;
  }
}

- (void)setImage:(UIImage *)image {
  _image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.iconImageView.image = _image;
  self.iconImageView.tintColor =
      (self.selected) ? self.selectedItemTintColor : self.unselectedItemTintColor;
  [self.iconImageView sizeToFit];
}

- (void)setSelectedImage:(UIImage *)selectedImage {
  _selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.iconImageView.image = _selectedImage;
  self.iconImageView.tintColor = self.selectedItemTintColor;
  [self.iconImageView sizeToFit];
}

- (void)setTitle:(NSString *)title {
  _title = [title copy];
  self.label.text = _title;
  self.button.accessibilityLabel = [self accessibilityLabelWithTitle:_title];
}

- (void)setTitleVisibility:(MDCBottomNavigationBarTitleVisibility)titleVisibility {
  _titleVisibility = titleVisibility;
  [self updateLabelVisibility];
}

- (void)setItemTitleFont:(UIFont *)itemTitleFont {
  _itemTitleFont = itemTitleFont;
  self.label.font = itemTitleFont;
  [self setNeedsLayout];
}

- (void)setAccessibilityValue:(NSString *)accessibilityValue {
  [super setAccessibilityValue:accessibilityValue];
  self.button.accessibilityValue = accessibilityValue;
}

- (NSString *)accessibilityValue {
  return self.button.accessibilityValue;
}

- (void)setAccessibilityIdentifier:(NSString *)accessibilityIdentifier {
  self.button.accessibilityIdentifier = accessibilityIdentifier;
}

- (NSString *)accessibilityIdentifier {
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
