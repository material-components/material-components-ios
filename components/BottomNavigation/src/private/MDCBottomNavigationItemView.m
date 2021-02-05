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

#import "MaterialInk.h"
#import "MaterialRipple.h"
#import <MDFInternationalization/MDFInternationalization.h>

#import "MDCBottomNavigationBar.h"
#import "MDCBottomNavigationItemBadge.h"

// A number large enough to be larger than any reasonable screen dimension but small enough that
// CGFloat doesn't lose precision.
static const CGFloat kMaxSizeDimension = 1000000;
static const CGFloat MDCBottomNavigationItemViewInkOpacity = (CGFloat)0.150;
static const CGFloat MDCBottomNavigationItemViewTitleFontSize = 12;

/** The default value for @c numberOfLines for the title label. */
static const NSInteger kDefaultTitleNumberOfLines = 1;

// The fonts available on iOS differ from that used on Material.io.  When trying to approximate
// the position on iOS, it seems like a horizontal inset of 10 points looks pretty close.
static const CGFloat kBadgeXOffsetFromIconEdgeWithTextLTR = -8;

// However, when the badge has no visible text, its horizontal center should be 1 point inset from
// the edge of the image.
static const CGFloat kBadgeXOffsetFromIconEdgeEmptyLTR = -1;

// The duration of the (de)selection transition animation.
static const NSTimeInterval kMDCBottomNavigationItemViewSelectionAnimationDuration = 0.100f;

// The duration of the title label's fade-out animation on deselection. The fade-in animation of the
// label on selection will be delayed by this value, and the duration of that animation is
// @c kMDCBottomNavigationItemViewSelectionAnimationDuration minus this value.
static const NSTimeInterval kMDCBottomNavigationItemViewLabelFadeOutAnimationDuration = 0.0333f;

// The amount to inset pointerEffectHoverRect.
// These values were chosen to achieve visual parity with UITabBar's highlight effect.
const CGSize MDCButtonNavigationItemViewPointerEffectHighlightRectInset = {-24, -12};

@interface MDCBottomNavigationItemView ()

@property(nonatomic, strong) MDCBottomNavigationItemBadge *badge;
@property(nonatomic, strong) UIImageView *iconImageView;
@property(nonatomic, strong) UILabel *label;
- (CGPoint)badgeCenterFromIconFrame:(CGRect)iconFrame isRTL:(BOOL)isRTL;

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
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
      if ([view isKindOfClass:[MDCInkView class]]) {
        _inkView = (MDCInkView *)view;
#pragma clang diagnostic pop
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
  _truncatesTitle = YES;
  _titleNumberOfLines = kDefaultTitleNumberOfLines;
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
  _label.numberOfLines = kDefaultTitleNumberOfLines;

  if (!_badge) {
    _badge = [[MDCBottomNavigationItemBadge alloc] initWithFrame:CGRectZero];
    _badge.isAccessibilityElement = NO;
    [self addSubview:_badge];
  }

  if (!_badge.badgeValue) {
    _badge.hidden = YES;
  }

  if (!_inkView) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    _inkView = [[MDCInkView alloc] initWithFrame:self.bounds];
#pragma clang diagnostic pop
    _inkView.autoresizingMask =
        (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    _inkView.usesLegacyInkRipple = NO;
    _inkView.clipsToBounds = NO;
    [self addSubview:_inkView];
  }

  if (!_rippleTouchController) {
    _rippleTouchController = [[MDCRippleTouchController alloc] initWithView:self];
    _rippleTouchController.rippleView.rippleStyle = MDCRippleStyleUnbounded;
  }

  if (!_button) {
    _button = [[UIButton alloc] initWithFrame:self.bounds];
    _button.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    _button.accessibilityLabel = [self accessibilityLabelWithTitle:_title];
    _button.accessibilityValue = self.accessibilityValue;
    // This needs to be set specifically for VoiceOver to work on iOS 14, see b/175421576
    if (@available(iOS 14, *)) {
      _button.accessibilityTraits |= UIAccessibilityTraitButton;
    }
    [self addSubview:_button];
  }
}

- (CGSize)sizeThatFits:(__unused CGSize)size {
  if (self.titleBelowIcon) {
    return [self sizeThatFitsForVerticalLayout];
  } else {
    return [self sizeThatFitsForHorizontalLayout];
  }
}

- (BOOL)isTitleHidden {
  return self.titleVisibility == MDCBottomNavigationBarTitleVisibilityNever ||
         (self.titleVisibility == MDCBottomNavigationBarTitleVisibilitySelected && !self.selected);
}

- (CGSize)sizeThatFitsForVerticalLayout {
  CGSize maxSize = CGSizeMake(kMaxSizeDimension, kMaxSizeDimension);
  CGSize iconSize = [self.iconImageView sizeThatFits:maxSize];
  CGRect iconFrame = CGRectMake(0, 0, iconSize.width, iconSize.height);
  CGSize badgeSize = [self.badge sizeThatFits:maxSize];
  CGPoint badgeCenter = [self badgeCenterFromIconFrame:iconFrame isRTL:NO];
  CGRect badgeFrame =
      CGRectMake(floor(badgeCenter.x - badgeSize.width / 2),
                 floor(badgeCenter.y - badgeSize.height / 2), badgeSize.width, badgeSize.height);
  CGRect labelFrame = CGRectZero;
  if (![self isTitleHidden]) {
    CGSize labelSize = [self.label sizeThatFits:maxSize];
    labelFrame = CGRectMake(floor(CGRectGetMidX(iconFrame) - labelSize.width / 2),
                            CGRectGetMaxY(iconFrame) + self.contentVerticalMargin, labelSize.width,
                            labelSize.height);
  }
  return CGRectStandardize(CGRectUnion(labelFrame, CGRectUnion(iconFrame, badgeFrame))).size;
}

- (CGSize)sizeThatFitsForHorizontalLayout {
  CGSize maxSize = CGSizeMake(kMaxSizeDimension, kMaxSizeDimension);
  CGSize iconSize = [self.iconImageView sizeThatFits:maxSize];
  CGRect iconFrame = CGRectMake(0, 0, iconSize.width, iconSize.height);
  CGSize badgeSize = [self.badge sizeThatFits:maxSize];
  CGPoint badgeCenter = [self badgeCenterFromIconFrame:iconFrame isRTL:NO];
  CGRect badgeFrame =
      CGRectMake(floor(badgeCenter.x - badgeSize.width / 2),
                 floor(badgeCenter.y - badgeSize.height / 2), badgeSize.width, badgeSize.height);
  CGSize labelSize = [self.label sizeThatFits:maxSize];
  CGRect labelFrame = CGRectMake(CGRectGetMaxX(iconFrame) + self.contentHorizontalMargin,
                                 floor(CGRectGetMidY(iconFrame) - labelSize.height / 2),
                                 labelSize.width, labelSize.height);
  return CGRectStandardize(CGRectUnion(labelFrame, CGRectUnion(iconFrame, badgeFrame))).size;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  [self.label sizeToFit];
  [self.badge sizeToFit];
  self.inkView.maxRippleRadius =
      (CGFloat)(hypot(CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds)) / 2);
  [self centerLayoutAnimated:NO];
  [self invalidatePointerInteractions];
}

- (void)calculateVerticalLayoutInBounds:(CGRect)contentBounds
                          forLabelFrame:(CGRect *)outLabelFrame
                     iconImageViewFrame:(CGRect *)outIconFrame {
  // Determine the intrinsic size of the label, icon, and combined content
  CGRect contentBoundingRect = CGRectStandardize(contentBounds);
  CGSize iconImageViewSize = [self.iconImageView sizeThatFits:contentBoundingRect.size];
  CGSize labelSize = [self.label sizeThatFits:contentBoundingRect.size];
  CGFloat iconHeight = iconImageViewSize.height;
  CGFloat labelHeight = labelSize.height;
  CGFloat totalContentHeight = iconHeight;
  if (![self isTitleHidden]) {
    totalContentHeight += labelHeight + self.contentVerticalMargin;
  }

  // Determine the position of the label and icon
  CGFloat centerX = CGRectGetMidX(contentBoundingRect);
  CGFloat iconImageViewCenterY =
      MAX(floor(CGRectGetMidY(contentBoundingRect) - totalContentHeight / 2 +
                   iconHeight / 2),  // Content centered
          floor(CGRectGetMinY(contentBoundingRect) +
                   iconHeight / 2)  // Pinned to top of bounding rect.
      );
  CGPoint iconImageViewCenter = CGPointMake(centerX, iconImageViewCenterY);
  // Ignore the horizontal titlePositionAdjustment in a vertical layout to match UITabBar behavior.
  CGFloat centerY;
  if ([self isTitleHidden]) {
    centerY = iconImageViewCenter.y + iconHeight / 2 + self.titlePositionAdjustment.vertical +
              self.contentVerticalMargin / 2;
  } else {
    centerY = iconImageViewCenter.y + iconHeight / 2 + self.contentVerticalMargin +
              labelHeight / 2 + self.titlePositionAdjustment.vertical;
  }

  CGPoint labelCenter = CGPointMake(centerX, centerY);
  CGFloat availableContentWidth = CGRectGetWidth(contentBoundingRect);
  if (self.truncatesTitle && (labelSize.width > availableContentWidth)) {
    labelSize = CGSizeMake(availableContentWidth, labelSize.height);
  }

  // Assign the frames to the inout arguments
  if (outLabelFrame != NULL) {
    *outLabelFrame = CGRectMake(floor(labelCenter.x - (labelSize.width / 2)),
                                floor(labelCenter.y - (labelSize.height / 2)), labelSize.width,
                                labelSize.height);
  }
  if (outIconFrame != NULL) {
    *outIconFrame = CGRectMake(floor(iconImageViewCenter.x - (iconImageViewSize.width / 2)),
                               floor(iconImageViewCenter.y - (iconImageViewSize.height / 2)),
                               iconImageViewSize.width, iconImageViewSize.height);
  }
}

- (void)calculateHorizontalLayoutInBounds:(CGRect)contentBounds
                            forLabelFrame:(CGRect *)outLabelFrame
                       iconImageViewFrame:(CGRect *)outIconFrame {
  // Determine the intrinsic size of the label and icon
  CGRect contentBoundingRect = CGRectStandardize(contentBounds);
  CGSize iconImageViewSize = [self.iconImageView sizeThatFits:contentBoundingRect.size];
  CGSize maxLabelSize = CGSizeMake(
      contentBoundingRect.size.width - self.contentHorizontalMargin - iconImageViewSize.width,
      contentBoundingRect.size.height);
  CGSize labelSize = [self.label sizeThatFits:maxLabelSize];

  CGFloat contentsWidth = iconImageViewSize.width + self.contentHorizontalMargin + labelSize.width;
  CGFloat remainingContentWidth = CGRectGetWidth(contentBoundingRect);
  if (contentsWidth > remainingContentWidth) {
    contentsWidth = remainingContentWidth;
  }
  // If the content width and available width are different, the internal spacing required to center
  // the contents.
  CGFloat contentPadding = (remainingContentWidth - contentsWidth) / 2;
  remainingContentWidth -= iconImageViewSize.width + self.contentHorizontalMargin;
  if (self.truncatesTitle) {
    labelSize = CGSizeMake(MIN(labelSize.width, remainingContentWidth), labelSize.height);
  }

  // Account for RTL
  BOOL isRTL =
      self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft;
  NSInteger rtlCoefficient = isRTL ? -1 : 1;
  CGFloat layoutStartingPoint =
      isRTL ? CGRectGetMaxX(contentBoundingRect) : CGRectGetMinX(contentBoundingRect);

  CGFloat centerY = CGRectGetMidY(contentBoundingRect);
  // Amount icon center is offset from the leading edge.
  CGFloat iconCenterOffset = contentPadding + iconImageViewSize.width / 2;

  // Determine the position of the label and icon
  CGPoint iconImageViewCenter =
      CGPointMake(layoutStartingPoint + rtlCoefficient * iconCenterOffset, centerY);
  CGFloat labelOffsetFromIcon =
      iconImageViewSize.width / 2 + self.contentHorizontalMargin + labelSize.width / 2;
  CGPoint labelCenter = CGPointMake(iconImageViewCenter.x + rtlCoefficient * labelOffsetFromIcon +
                                        self.titlePositionAdjustment.horizontal,
                                    centerY + self.titlePositionAdjustment.vertical);

  // Assign the frames to the inout arguments
  if (outLabelFrame != NULL) {
    *outLabelFrame = CGRectMake(floor(labelCenter.x - (labelSize.width / 2)),
                                floor(labelCenter.y - (labelSize.height / 2)), labelSize.width,
                                labelSize.height);
  }
  if (outIconFrame != NULL) {
    *outIconFrame = CGRectMake(floor(iconImageViewCenter.x - (iconImageViewSize.width / 2)),
                               floor(iconImageViewCenter.y - (iconImageViewSize.height / 2)),
                               iconImageViewSize.width, iconImageViewSize.height);
  }
}

- (void)centerLayoutAnimated:(BOOL)animated {
  CGRect labelFrame = CGRectZero;
  CGRect iconImageViewFrame = CGRectZero;

  if (self.titleBelowIcon) {
    [self calculateVerticalLayoutInBounds:self.bounds
                            forLabelFrame:&labelFrame
                       iconImageViewFrame:&iconImageViewFrame];
  } else {
    [self calculateHorizontalLayoutInBounds:self.bounds
                              forLabelFrame:&labelFrame
                         iconImageViewFrame:&iconImageViewFrame];
  }

  CGPoint iconImageViewCenter =
      CGPointMake(CGRectGetMidX(iconImageViewFrame), CGRectGetMidY(iconImageViewFrame));
  self.label.center = CGPointMake(CGRectGetMidX(labelFrame), CGRectGetMidY(labelFrame));
  self.label.bounds = CGRectMake(0, 0, CGRectGetWidth(labelFrame), CGRectGetHeight(labelFrame));

  UIUserInterfaceLayoutDirection layoutDirection = self.mdf_effectiveUserInterfaceLayoutDirection;
  BOOL isRTL = layoutDirection == UIUserInterfaceLayoutDirectionRightToLeft;

  if (self.titleBelowIcon) {
    if (animated) {
      [UIView animateWithDuration:kMDCBottomNavigationItemViewSelectionAnimationDuration
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

- (void)updateLabelVisibility:(BOOL)animated {
  BOOL shouldHide;
  if (self.selected) {
    switch (self.titleVisibility) {
      case MDCBottomNavigationBarTitleVisibilitySelected:
      case MDCBottomNavigationBarTitleVisibilityAlways:
        shouldHide = NO;
        break;
      case MDCBottomNavigationBarTitleVisibilityNever:
        shouldHide = YES;
        break;
    }
  } else {
    switch (self.titleVisibility) {
      case MDCBottomNavigationBarTitleVisibilitySelected:
      case MDCBottomNavigationBarTitleVisibilityNever:
        shouldHide = YES;
        break;
      case MDCBottomNavigationBarTitleVisibilityAlways:
        shouldHide = NO;
        break;
    }
  }

  if (!animated) {
    [self setNeedsLayout];
    self.label.alpha = shouldHide ? 0.0f : 1.0f;
  } else {
    [UIView animateWithDuration:kMDCBottomNavigationItemViewSelectionAnimationDuration
                     animations:^{
                       [self setNeedsLayout];
                       self.label.alpha = shouldHide ? 0.0f : 1.0f;
                     }];
    if (shouldHide) {
      [UIView animateWithDuration:kMDCBottomNavigationItemViewLabelFadeOutAnimationDuration
                       animations:^{
                         self.label.alpha = 0.0f;
                       }];
    } else {
      [UIView animateWithDuration:(kMDCBottomNavigationItemViewSelectionAnimationDuration -
                                   kMDCBottomNavigationItemViewLabelFadeOutAnimationDuration)
                            delay:kMDCBottomNavigationItemViewLabelFadeOutAnimationDuration
                          options:UIViewAnimationOptionCurveLinear
                       animations:^{
                         self.label.alpha = 1.0f;
                       }
                       completion:nil];
    }
  }
}

- (NSString *)accessibilityLabelWithTitle:(NSString *)title {
  NSMutableArray *labelComponents = [NSMutableArray array];

  // Use untransformed title as accessibility label to ensure accurate reading.
  if (title.length > 0) {
    [labelComponents addObject:title];
  }

  // Speak components with a pause in between.
  return [labelComponents componentsJoinedByString:@", "];
}

- (CGPoint)badgeCenterFromIconFrame:(CGRect)iconFrame isRTL:(BOOL)isRTL {
  CGSize badgeSize = [self.badge sizeThatFits:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)];

  // There are no specifications for badge layout, so this is based on the Material Guidelines
  // article for Bottom Navigation which includes an image showing badge positions.
  // https://storage.googleapis.com/spec-host-backup/mio-design%2Fassets%2F0B6xUSjjSulxcaVpEMk5tZ2RGZ3c%2Fbottomnav-badging-1.png
  // Attempting to match the "88" badge on the "chrome reader mode" icon results in the badge's top
  // edge equalling that of the image bounds.
  // https://material.io/tools/icons/?icon=chrome_reader_mode&style=baseline
  CGFloat badgeCenterY = CGRectGetMinY(iconFrame) + (badgeSize.height / 2);

  CGFloat badgeCenterXOffset = kBadgeXOffsetFromIconEdgeWithTextLTR + badgeSize.width / 2;
  if (self.badgeValue.length == 0) {
    badgeCenterXOffset = kBadgeXOffsetFromIconEdgeEmptyLTR;
  }
  CGFloat badgeCenterX = isRTL ? CGRectGetMinX(iconFrame) - badgeCenterXOffset
                               : CGRectGetMaxX(iconFrame) + badgeCenterXOffset;

  return CGPointMake(badgeCenterX, badgeCenterY);
}

- (NSString *)badgeValue {
  return self.badge.badgeValue;
}

- (CGRect)pointerEffectHighlightRect {
  NSMutableArray<UIView *> *visibleViews = [[NSMutableArray alloc] init];
  if (!self.iconImageView.hidden) {
    [visibleViews addObject:self.iconImageView];
  }
  if (!self.label.hidden) {
    [visibleViews addObject:self.label];
  }
  if (!self.badge.hidden) {
    [visibleViews addObject:self.badge];
  }

  // If we don't have any visible views, there is no content to frame
  if (visibleViews.count == 0) {
    return self.frame;
  }

  CGRect contentRect = visibleViews.firstObject.frame;
  for (UIView *visibleView in visibleViews) {
    contentRect = CGRectUnion(contentRect, visibleView.frame);
  }

  CGRect insetContentRect =
      CGRectInset(contentRect, MDCButtonNavigationItemViewPointerEffectHighlightRectInset.width,
                  MDCButtonNavigationItemViewPointerEffectHighlightRectInset.height);

  // Ensure insetContentRect is the same size or smaller than self.bounds
  CGSize boundsSize = CGRectStandardize(self.bounds).size;
  if (insetContentRect.size.width > boundsSize.width) {
    insetContentRect.origin.x = 0;
    insetContentRect.size.width = boundsSize.width;
  }

  if (insetContentRect.size.height > boundsSize.height) {
    insetContentRect.origin.y = 0;
    insetContentRect.size.height = boundsSize.height;
  }

  return insetContentRect;
}

- (void)invalidatePointerInteractions {
#ifdef __IPHONE_13_4
  if (@available(iOS 13.4, *)) {
    for (UIPointerInteraction *interaction in self.interactions) {
      [interaction invalidate];
    }
  }
#endif
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
    [self updateLabelVisibility:animated];
  } else {
    self.label.textColor = self.unselectedItemTintColor;
    self.iconImageView.tintColor = self.unselectedItemTintColor;
    self.button.accessibilityTraits &= ~UIAccessibilityTraitSelected;
    self.iconImageView.image = self.image;
    [self updateLabelVisibility:animated];
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
  UIColor *rippleColor =
      [self.selectedItemTintColor colorWithAlphaComponent:MDCBottomNavigationItemViewInkOpacity];
  self.inkView.inkColor = rippleColor;
  self.rippleTouchController.rippleView.rippleColor = rippleColor;
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

- (void)setBadgeTextColor:(UIColor *)badgeTextColor {
  _badgeTextColor = badgeTextColor;
  self.badge.badgeValueLabel.textColor = badgeTextColor;
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
  [self setNeedsLayout];
}

- (void)setImage:(UIImage *)image {
  _image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

  // _image updates unselected state
  // _image updates selected state IF there is no selectedImage
  if (!self.selected || (self.selected && !self.selectedImage)) {
    self.iconImageView.image = _image;
    self.iconImageView.tintColor =
        (self.selected) ? self.selectedItemTintColor : self.unselectedItemTintColor;
    [self.iconImageView sizeToFit];
    [self setNeedsLayout];
  }
}

- (void)setSelectedImage:(UIImage *)selectedImage {
  _selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  if (self.selected) {
    self.iconImageView.image = _selectedImage;
    self.iconImageView.tintColor = self.selectedItemTintColor;
    [self.iconImageView sizeToFit];
    [self setNeedsLayout];
  }
}

- (void)setTitle:(NSString *)title {
  _title = [title copy];
  self.label.text = _title;
  self.button.accessibilityLabel = [self accessibilityLabelWithTitle:_title];
  [self setNeedsLayout];
}

- (void)setTitleVisibility:(MDCBottomNavigationBarTitleVisibility)titleVisibility {
  _titleVisibility = titleVisibility;
  [self updateLabelVisibility:NO];
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

- (void)setAccessibilityHint:(NSString *)accessibilityHint {
  [super setAccessibilityHint:accessibilityHint];
  self.button.accessibilityHint = accessibilityHint;
}

- (NSString *)accessibilityHint {
  return self.button.accessibilityHint;
}

- (void)setAccessibilityElementIdentifier:(NSString *)accessibilityElementIdentifier {
  self.button.accessibilityIdentifier = accessibilityElementIdentifier;
}

- (NSString *)accessibilityElementIdentifier {
  return self.button.accessibilityIdentifier;
}

- (void)setTitlePositionAdjustment:(UIOffset)titlePositionAdjustment {
  if (!UIOffsetEqualToOffset(_titlePositionAdjustment, titlePositionAdjustment)) {
    _titlePositionAdjustment = titlePositionAdjustment;
    [self setNeedsLayout];
  }
}

- (NSInteger)renderedTitleNumberOfLines {
  return self.titleBelowIcon ? _titleNumberOfLines : kDefaultTitleNumberOfLines;
}

- (void)setTitleNumberOfLines:(NSInteger)titleNumberOfLines {
  _titleNumberOfLines = titleNumberOfLines;
  self.label.numberOfLines = [self renderedTitleNumberOfLines];
}

- (void)setTitleBelowIcon:(BOOL)titleBelowIcon {
  _titleBelowIcon = titleBelowIcon;
  self.label.numberOfLines = [self renderedTitleNumberOfLines];
}

#pragma mark - UILargeContentViewerItem

- (BOOL)showsLargeContentViewer {
  return YES;
}

- (NSString *)largeContentTitle {
  if (_largeContentTitle) {
    return _largeContentTitle;
  }

  return self.title;
}

- (UIImage *)largeContentImage {
  if (_largeContentImage) {
    return _largeContentImage;
  }

  return self.image;
}

- (BOOL)scalesLargeContentImage {
  return _largeContentImage == nil;
}

@end
