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

#import "MDCAlertControllerView+Private.h"
#import "MDCAlertControllerView.h"

#import <MDFInternationalization/MDFInternationalization.h>

#import "MaterialButtons.h"
#import "MaterialMath.h"
#import "MaterialTypography.h"

// https://material.io/go/design-dialogs#dialogs-specs
static const MDCFontTextStyle kTitleTextStyle = MDCFontTextStyleTitle;
static const MDCFontTextStyle kMessageTextStyle = MDCFontTextStyleBody1;
static const MDCFontTextStyle kButtonTextStyle = MDCFontTextStyleButton;

static const CGFloat MDCDialogMaximumWidth = 560.0f;

static const CGFloat MDCDialogActionButtonMinimumHeight = 36.0f;
static const CGFloat MDCDialogActionButtonMinimumWidth = 48.0f;
static const CGFloat MDCDialogActionMinTouchTarget = 48.0f;

static const CGFloat MDCDialogMessageOpacity = 0.54f;

@interface MDCAlertControllerView ()

@property(nonatomic, getter=isVerticalActionsLayout) BOOL verticalActionsLayout;

@end

@implementation MDCAlertControllerView {
  BOOL _mdc_adjustsFontForContentSizeCategory;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.autoresizesSubviews = NO;
    self.clipsToBounds = YES;

    self.orderVerticalActionsByEmphasis = NO;
    self.actionsHorizontalAlignment = MDCContentHorizontalAlignmentTrailing;
    self.actionsHorizontalAlignmentInVerticalLayout = MDCContentHorizontalAlignmentCenter;

    self.titleIconInsets = UIEdgeInsetsMake(24.0f, 24.0f, 12.0f, 24.0f);
    self.titleInsets = UIEdgeInsetsMake(24.0f, 24.0f, 20.0f, 24.0f);
    self.contentInsets = UIEdgeInsetsMake(24.0f, 24.0f, 24.0f, 24.0f);
    self.actionsInsets = UIEdgeInsetsMake(8.0f, 8.0f, 8.0f, 8.0f);
    self.actionsHorizontalMargin = 8.0f;
    self.actionsVerticalMargin = 12.0f;
    self.accessoryViewVerticalInset = 20.0f;

    self.titleScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.titleScrollView];

    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.contentScrollView];

    self.actionsScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.actionsScrollView];

    // Set the background color after all surface subviews are added.
    self.backgroundColor = [UIColor whiteColor];

    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textAlignment = NSTextAlignmentNatural;
    if (self.mdc_adjustsFontForContentSizeCategory) {
      self.titleLabel.font = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleTitle];
    } else {
      self.titleLabel.font = [MDCTypography titleFont];
    }
    self.titleLabel.accessibilityTraits |= UIAccessibilityTraitHeader;
    [self.titleScrollView addSubview:self.titleLabel];

    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.textAlignment = NSTextAlignmentNatural;
    if (self.mdc_adjustsFontForContentSizeCategory) {
      self.messageLabel.font = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleBody1];
    } else {
      self.messageLabel.font = [MDCTypography body1Font];
    }
    self.messageLabel.textColor = [UIColor colorWithWhite:0 alpha:MDCDialogMessageOpacity];
    [self.contentScrollView addSubview:self.messageLabel];

    [self setNeedsLayout];
  }

  return self;
}

- (NSString *)title {
  return self.titleLabel.text;
}

- (void)setTitle:(NSString *)title {
  self.titleLabel.text = title;

  [self setNeedsLayout];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
  super.backgroundColor = backgroundColor;
  self.titleScrollView.backgroundColor = backgroundColor;
  self.contentScrollView.backgroundColor = backgroundColor;
  self.actionsScrollView.backgroundColor = backgroundColor;
}

- (UIColor *)backgroundColor {
  return super.backgroundColor;
}

- (void)addActionButton:(nonnull MDCButton *)button {
  if (button.superview == nil) {
    [self.actionsScrollView addSubview:button];
    if (_buttonColor) {
      // We only set if _buttonColor since settingTitleColor to nil doesn't
      // reset the title to the default
      [button setTitleColor:_buttonColor forState:UIControlStateNormal];
    }
    [button setTitleFont:_buttonFont forState:UIControlStateNormal];
    button.enableRippleBehavior = self.enableRippleBehavior;
    button.inkColor = self.buttonInkColor;
    // These two lines must be after @c setTitleFont:forState: in order to @c MDCButton to handle
    // dynamic type correctly.
    button.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable =
        self.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable;
    button.mdc_adjustsFontForContentSizeCategory = self.mdc_adjustsFontForContentSizeCategory;
    // TODO(#1726): Determine default text color values for Normal and Disabled
    CGRect buttonRect = button.bounds;
    buttonRect.size.height = MAX(buttonRect.size.height, MDCDialogActionButtonMinimumHeight);
    buttonRect.size.width = MAX(buttonRect.size.width, MDCDialogActionButtonMinimumWidth);
    button.frame = buttonRect;
  }
}

+ (void)styleAsTextButton:(nonnull MDCButton *)button {
  // This preserves default buttons style (as MDCFlatButton/text) for backward compatibility reasons
  UIColor *themeColor = [UIColor blackColor];
  [button setBackgroundColor:UIColor.clearColor forState:UIControlStateNormal];
  [button setTitleColor:themeColor forState:UIControlStateNormal];
  [button setImageTintColor:themeColor forState:UIControlStateNormal];
  [button setInkColor:[UIColor colorWithWhite:0.0f alpha:0.06f]];
  button.disabledAlpha = 1.0f;
  [button setElevation:MDCShadowElevationNone forState:UIControlStateNormal];
}

- (void)setTitleFont:(UIFont *)font {
  _titleFont = font;

  [self updateTitleFont];
}

- (void)updateTitleFont {
  UIFont *titleFont = self.titleFont ?: [[self class] titleFontDefault];
  if (self.mdc_adjustsFontForContentSizeCategory) {
    if (self.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable) {
      titleFont =
          [titleFont mdc_fontSizedForMaterialTextStyle:kTitleTextStyle
                                  scaledForDynamicType:self.mdc_adjustsFontForContentSizeCategory];
    }
  }

  self.titleLabel.font = titleFont;
  [self setNeedsLayout];
}

+ (UIFont *)titleFontDefault {
  if ([MDCTypography.fontLoader isKindOfClass:[MDCSystemFontLoader class]]) {
    return [UIFont mdc_standardFontForMaterialTextStyle:kTitleTextStyle];
  }
  return [MDCTypography titleFont];
}

- (void)setTitleColor:(UIColor *)titleColor {
  _titleColor = titleColor;

  _titleLabel.textColor = titleColor;
}

- (NSTextAlignment)titleAlignment {
  return self.titleLabel.textAlignment;
}

- (void)setTitleAlignment:(NSTextAlignment)titleAlignment {
  self.titleLabel.textAlignment = titleAlignment;
}

- (UIImage *)titleIcon {
  return self.titleIconImageView.image;
}

- (void)setTitleIcon:(UIImage *)titleIcon {
  if (titleIcon == nil) {
    [self.titleIconImageView removeFromSuperview];
    self.titleIconImageView = nil;
    [self setNeedsLayout];
    return;
  }

  if (self.titleIconImageView == nil) {
    self.titleIconImageView = [[UIImageView alloc] initWithImage:titleIcon];
    self.titleIconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.titleScrollView addSubview:self.titleIconImageView];
  } else {
    self.titleIconImageView.image = titleIcon;
  }

  self.titleIconImageView.tintColor = self.titleIconTintColor;
  [self setNeedsLayout];
}

- (void)setTitleIconTintColor:(UIColor *)titleIconTintColor {
  _titleIconTintColor = titleIconTintColor;
  self.titleIconImageView.tintColor = titleIconTintColor;
}

- (void)setTitleIconView:(UIView *)titleIconView {
  if (titleIconView != nil && self.titleIconImageView != nil) {
    NSLog(@"Warning: unintended use of the API. The following APIs are not expected to be used"
           "together: 'setTitleIconView:' and `setTitleIcon:` API. Please set either, but not "
           "both at the same time. If 'titleIconView' is set, 'titleIcon' is ignored.");
    [self.titleIconImageView removeFromSuperview];
    self.titleIconImageView = nil;
    [self setNeedsLayout];
  }
  if (_titleIconView == nil || ![_titleIconView isEqual:titleIconView]) {
    if (_titleIconView != nil) {
      [_titleIconView removeFromSuperview];
    }
    _titleIconView = titleIconView;
    if (_titleIconView != nil) {
      [self.titleScrollView addSubview:_titleIconView];
    }
    [self setNeedsLayout];
  }
}

- (NSString *)message {
  return self.messageLabel.text;
}

- (void)setMessage:(NSString *)message {
  self.messageLabel.text = message;

  [self setNeedsLayout];
}

- (void)setMessageFont:(UIFont *)messageFont {
  _messageFont = messageFont;

  [self updateMessageFont];
}

- (void)updateMessageFont {
  UIFont *messageFont = self.messageFont ?: [[self class] messageFontDefault];
  if (self.mdc_adjustsFontForContentSizeCategory) {
    if (self.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable) {
      messageFont = [messageFont
          mdc_fontSizedForMaterialTextStyle:kMessageTextStyle
                       scaledForDynamicType:self.mdc_adjustsFontForContentSizeCategory];
    }
  }

  self.messageLabel.font = messageFont;
  [self setNeedsLayout];
}

+ (UIFont *)messageFontDefault {
  if ([MDCTypography.fontLoader isKindOfClass:[MDCSystemFontLoader class]]) {
    return [UIFont mdc_standardFontForMaterialTextStyle:kMessageTextStyle];
  }
  return [MDCTypography body1Font];
}

- (void)setMessageColor:(UIColor *)messageColor {
  _messageColor = messageColor;

  _messageLabel.textColor = messageColor;
}

- (NSTextAlignment)messageAlignment {
  return self.messageLabel.textAlignment;
}

- (void)setMessageAlignment:(NSTextAlignment)messageAlignment {
  self.messageLabel.textAlignment = messageAlignment;
}

- (void)setAccessoryView:(UIView *)accessoryView {
  if (_accessoryView == accessoryView) {
    return;
  }

  if (_accessoryView.superview == self.contentScrollView) {
    [_accessoryView removeFromSuperview];
  }

  _accessoryView = accessoryView;

  if (_accessoryView) {
    [self.contentScrollView addSubview:_accessoryView];
  }

  [self setNeedsLayout];
}

- (void)setButtonFont:(UIFont *)font {
  _buttonFont = font;

  [self updateButtonFont];
}

- (void)updateButtonFont {
  UIFont *finalButtonFont = self.buttonFont ?: [[self class] buttonFontDefault];
  if (self.mdc_adjustsFontForContentSizeCategory) {
    if (self.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable) {
      finalButtonFont = [finalButtonFont
          mdc_fontSizedForMaterialTextStyle:kTitleTextStyle
                       scaledForDynamicType:self.mdc_adjustsFontForContentSizeCategory];
    }
  }
  for (MDCButton *button in self.actionManager.buttonsInActionOrder) {
    [button setTitleFont:finalButtonFont forState:UIControlStateNormal];
  }

  [self setNeedsLayout];
}

+ (UIFont *)buttonFontDefault {
  if ([MDCTypography.fontLoader isKindOfClass:[MDCSystemFontLoader class]]) {
    return [UIFont mdc_standardFontForMaterialTextStyle:kButtonTextStyle];
  }
  return [MDCTypography titleFont];
}

- (void)setButtonColor:(UIColor *)color {
  _buttonColor = color;

  for (MDCButton *button in self.actionManager.buttonsInActionOrder) {
    [button setTitleColor:_buttonColor forState:UIControlStateNormal];
  }
}

- (void)setButtonInkColor:(UIColor *)color {
  _buttonInkColor = color;

  for (MDCButton *button in self.actionManager.buttonsInActionOrder) {
    button.inkColor = color;
  }
}

- (CGFloat)cornerRadius {
  return self.layer.cornerRadius;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
  if (MDCCGFloatEqual(cornerRadius, self.layer.cornerRadius)) {
    return;
  }
  self.layer.cornerRadius = cornerRadius;
  [self setNeedsLayout];
}

- (void)setEnableRippleBehavior:(BOOL)enableRippleBehavior {
  if (_enableRippleBehavior == enableRippleBehavior) {
    return;
  }
  _enableRippleBehavior = enableRippleBehavior;

  for (MDCButton *button in self.actionManager.buttonsInActionOrder) {
    button.enableRippleBehavior = enableRippleBehavior;
  }
}

#pragma mark - Internal

- (CGSize)actionFittingSizeInHorizontalLayout {
  CGSize size = CGSizeZero;
  NSArray<MDCButton *> *buttons = self.actionManager.buttonsInActionOrder;
  if (0 < buttons.count) {
    CGFloat maxButtonHeight = MDCDialogActionButtonMinimumHeight;
    size.width = self.actionsInsets.left + self.actionsInsets.right;
    for (UIButton *button in buttons) {
      CGSize buttonSize = [button sizeThatFits:size];
      size.width += buttonSize.width;
      maxButtonHeight = MAX(maxButtonHeight, buttonSize.height);
      if (button != buttons.lastObject) {
        size.width += self.actionsHorizontalMargin;
      }
    }
    size.height = self.actionsInsets.top + maxButtonHeight + self.actionsInsets.bottom;
  }

  return size;
}

- (CGSize)actionButtonsSizeInVerticalLayout {
  CGSize size = CGSizeZero;
  NSArray<MDCButton *> *buttons = self.actionManager.buttonsInActionOrder;
  if (0 < buttons.count) {
    size.height = self.actionsInsets.top + self.actionsInsets.bottom;
    CGFloat widthInset = self.actionsInsets.left + self.actionsInsets.right;
    for (UIButton *button in buttons) {
      CGSize buttonSize = [button sizeThatFits:size];
      buttonSize.height = MAX(buttonSize.height, MDCDialogActionButtonMinimumHeight);
      size.height += buttonSize.height;
      size.width = MAX(size.width, buttonSize.width + widthInset);
      if (button != buttons.lastObject) {
        size.height += self.actionsVerticalMargin;
      }
    }
  }

  return size;
}

- (BOOL)hasTitleIconOrImage {
  return self.titleIconImageView.image.size.height > 0.0f || self.titleIconView != nil;
}

- (BOOL)hasTitle {
  return self.title.length > 0;
}

- (BOOL)hasMessage {
  return self.message.length > 0;
}

- (BOOL)hasAccessoryView {
  CGSize accessoryViewSize = [self.accessoryView systemLayoutSizeFittingSize:CGRectInfinite.size];
  return accessoryViewSize.height > 0.0f;
}

- (CGFloat)titleIconInsetBottom {
  return [self hasTitleIconOrImage] && [self hasTitle] ? self.titleIconInsets.bottom : 0.0f;
}

- (CGFloat)titleInsetTop {
  return [self hasTitleIconOrImage] ? self.titleIconInsets.top : self.titleInsets.top;
}

- (CGFloat)titleInsetBottom {
  if (![self hasMessage] && ![self hasAccessoryView]) {
    return 0.0f;
  } else if ([self hasTitle] || [self hasTitleIconOrImage]) {
    return self.titleInsets.bottom;
  } else {
    return 0.0f;
  }
}

- (CGFloat)accessoryVerticalInset {
  return ([self hasMessage] && [self hasAccessoryView]) ? self.accessoryViewVerticalInset : 0.0f;
}

- (CGSize)titleIconViewSize {
  if (self.titleIconView != nil) {
    return self.titleIconView.frame.size;
  } else if (self.titleIconImageView != nil) {
    return self.titleIconImageView.frame.size;
  }
  return CGSizeZero;
}

- (CGRect)titleFrameWithTitleSize:(CGSize)titleSize {
  CGFloat leftInset = self.titleInsets.left;
  CGFloat titleTop =
      [self titleIconViewSize].height + [self titleInsetTop] + [self titleIconInsetBottom];
  return CGRectMake(leftInset, titleTop, titleSize.width, titleSize.height);
}

- (CGRect)messageFrameWithSize:(CGSize)messageSize {
  return CGRectMake(self.contentInsets.left, 0.0f, messageSize.width, messageSize.height);
}

- (CGRect)titleIconFrameWithTitleSize:(CGSize)titleSize {
  CGSize titleIconViewSize = [self titleIconViewSize];
  CGRect titleFrame = [self titleFrameWithTitleSize:titleSize];

  // match the titleIcon alignment to the title alignment
  CGFloat leftInset = self.titleIconInsets.left;
  CGFloat topInset = self.titleIconInsets.top;
  if (self.titleAlignment == NSTextAlignmentCenter) {
    leftInset =
        CGRectGetMinX(titleFrame) + (CGRectGetWidth(titleFrame) - titleIconViewSize.width) / 2.0f;
  } else if (self.titleAlignment == NSTextAlignmentRight ||
             (self.titleAlignment == NSTextAlignmentNatural &&
              [self mdf_effectiveUserInterfaceLayoutDirection] ==
                  UIUserInterfaceLayoutDirectionRightToLeft)) {
    leftInset = CGRectGetMaxX(titleFrame) - titleIconViewSize.width;
  }
  return CGRectMake(leftInset, topInset, titleIconViewSize.width, titleIconViewSize.height);
}

// @param boundsSize should not include any internal margins or padding
- (CGSize)calculatePreferredContentSizeForBounds:(CGSize)boundsSize {
  // Even if we have more room, limit our maximum width
  boundsSize.width = MIN(boundsSize.width, MDCDialogMaximumWidth);

  // Title, Content & Actions
  CGSize titleViewSize = [self calculateTitleViewSizeThatFitsWidth:boundsSize.width];
  CGSize contentSize = [self calculateContentSizeThatFitsWidth:boundsSize.width];
  CGSize actionSize = [self calculateActionsSizeThatFitsWidth:boundsSize.width];

  // Final Sizing
  CGSize totalSize;
  totalSize.width = MAX(titleViewSize.width, MAX(contentSize.width, actionSize.width));
  totalSize.height = titleViewSize.height + contentSize.height + actionSize.height;

  return totalSize;
}

// @param boundingWidth should not include any internal margins or padding
- (CGSize)calculateContentSizeThatFitsWidth:(CGFloat)boundingWidth {
  CGFloat leftInset =
      MAX(MAX(self.titleInsets.left, self.titleIconInsets.left), self.contentInsets.left);
  CGFloat rightInset =
      MAX(MAX(self.titleInsets.right, self.titleIconInsets.right), self.contentInsets.right);

  CGSize boundsSize = CGRectInfinite.size;
  boundsSize.width = boundingWidth - leftInset - rightInset;

  CGSize titleSize = [self.titleLabel sizeThatFits:boundsSize];
  CGSize messageSize = [self.messageLabel sizeThatFits:boundsSize];
  CGSize accessoryViewSize = [self.accessoryView systemLayoutSizeFittingSize:boundsSize];

  CGFloat contentWidth = MAX(MAX(titleSize.width, messageSize.width), accessoryViewSize.width) +
                         leftInset + rightInset;
  CGFloat totalElementsHeight = messageSize.height + accessoryViewSize.height;

  CGFloat contentHeight =
      totalElementsHeight + [self accessoryVerticalInset] + self.contentInsets.bottom;
  return CGSizeMake((CGFloat)ceil(contentWidth), (CGFloat)ceil(contentHeight));
}

/**
 Calculate the size of the title frame, which includes an optional title, optional title icon and
 optional icon view.

 @param boundingWidth should not include any internal margins or padding
*/
- (CGSize)calculateTitleViewSizeThatFitsWidth:(CGFloat)boundingWidth {
  CGFloat leftInset =
      MAX(MAX(self.titleInsets.left, self.titleIconInsets.left), self.contentInsets.left);
  CGFloat rightInset =
      MAX(MAX(self.titleInsets.right, self.titleIconInsets.right), self.contentInsets.right);

  CGSize boundsSize = CGRectInfinite.size;
  boundsSize.width = boundingWidth - leftInset - rightInset;

  CGSize titleSize = [self.titleLabel sizeThatFits:boundsSize];
  CGSize messageSize = [self.messageLabel sizeThatFits:boundsSize];
  CGSize accessoryViewSize = [self.accessoryView systemLayoutSizeFittingSize:boundsSize];
  CGFloat titleWidth = MAX(MAX(titleSize.width, messageSize.width), accessoryViewSize.width) +
                       leftInset + rightInset;
  CGFloat totalElementsHeight = [self titleIconViewSize].height + titleSize.height;

  CGFloat titleHeight = totalElementsHeight + [self titleInsetTop] + [self titleIconInsetBottom] +
                        [self titleInsetBottom];
  return CGSizeMake((CGFloat)ceil(titleWidth), (CGFloat)ceil(titleHeight));
}

// @param boundingWidth should not include any internal margins or padding
- (CGSize)calculateActionsSizeThatFitsWidth:(CGFloat)boundingWidth {
  CGSize boundsSize = CGRectInfinite.size;
  boundsSize.width = boundingWidth;

  CGSize horizontalSize = [self actionFittingSizeInHorizontalLayout];
  CGSize verticalSize = [self actionButtonsSizeInVerticalLayout];

  CGSize actionsSize;
  if (boundsSize.width < horizontalSize.width) {
    // Use VerticalLayout
    if (self.actionsHorizontalAlignmentInVerticalLayout == MDCContentHorizontalAlignmentJustified) {
      verticalSize.width = boundingWidth - (self.actionsInsets.left + self.actionsInsets.right);
    }
    actionsSize.width = MIN(verticalSize.width, boundsSize.width);
    actionsSize.height = MIN(verticalSize.height, boundsSize.height);
    self.verticalActionsLayout = YES;
  } else {
    // Use HorizontalLayout
    if (self.actionsHorizontalAlignmentInVerticalLayout == MDCContentHorizontalAlignmentJustified) {
      horizontalSize.width = boundingWidth - (self.actionsInsets.left + self.actionsInsets.right);
    }
    actionsSize.width = MIN(horizontalSize.width, boundsSize.width);
    actionsSize.height = MIN(horizontalSize.height, boundsSize.height);
    self.verticalActionsLayout = NO;
  }

  actionsSize.width = (CGFloat)ceil(actionsSize.width);
  actionsSize.height = (CGFloat)ceil(actionsSize.height);

  return actionsSize;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  // Used to calculate the height of the scrolling content, so we limit the width.
  CGSize boundsSize = CGRectInfinite.size;
  boundsSize.width = CGRectGetWidth(self.bounds);

  // Title view
  CGSize titleViewSize = [self calculateTitleViewSizeThatFitsWidth:boundsSize.width];

  CGRect titleViewRect = CGRectZero;
  titleViewRect.size.width = CGRectGetWidth(self.bounds);
  titleViewRect.size.height = titleViewSize.height;

  self.titleScrollView.contentSize = titleViewRect.size;
  self.titleScrollView.frame = titleViewRect;

  // Content
  CGSize contentSize = [self calculateContentSizeThatFitsWidth:boundsSize.width];

  CGRect contentRect = CGRectZero;
  contentRect.size.width = CGRectGetWidth(self.bounds);
  contentRect.size.height = contentSize.height;

  self.contentScrollView.contentSize = contentRect.size;

  // Place Content in contentScrollView
  CGFloat horizontalContentInsets = self.contentInsets.left + self.contentInsets.right;
  boundsSize.width = boundsSize.width - horizontalContentInsets;
  CGSize titleSize = [self.titleLabel sizeThatFits:boundsSize];
  titleSize.width = boundsSize.width;

  CGSize messageSize = [self.messageLabel sizeThatFits:boundsSize];
  messageSize.width = boundsSize.width;

  CGSize accessoryViewSize =
      [self.accessoryView systemLayoutSizeFittingSize:boundsSize
                        withHorizontalFittingPriority:UILayoutPriorityRequired
                              verticalFittingPriority:UILayoutPriorityFittingSizeLevel];
  accessoryViewSize.width = boundsSize.width;

  boundsSize.width = boundsSize.width + horizontalContentInsets;

  CGRect titleFrame = [self titleFrameWithTitleSize:titleSize];
  CGRect messageFrame = [self messageFrameWithSize:messageSize];
  CGRect accessoryViewFrame = CGRectMake(
      self.contentInsets.left, CGRectGetMaxY(messageFrame) + [self accessoryVerticalInset],
      accessoryViewSize.width, accessoryViewSize.height);

  CGRect titleIconImageViewRect = [self titleIconFrameWithTitleSize:titleSize];
  if (self.titleIconView != nil) {
    self.titleIconView.frame = titleIconImageViewRect;
  } else if (self.titleIconImageView != nil) {
    // Match the title icon alignment to the title alignment.
    self.titleIconImageView.frame = titleIconImageViewRect;
  }

  self.titleLabel.frame = titleFrame;
  self.messageLabel.frame = messageFrame;
  self.accessoryView.frame = accessoryViewFrame;

  // Actions
  NSArray<MDCButton *> *buttons = self.actionManager.buttonsInActionOrder;
  CGSize actionSize = [self calculateActionsSizeThatFitsWidth:boundsSize.width];

  CGRect actionsFrame = CGRectZero;
  actionsFrame.size.width = CGRectGetWidth(self.bounds);
  if (buttons.count > 0) {
    actionsFrame.size.height = actionSize.height;
  }
  self.actionsScrollView.contentSize = actionsFrame.size;

  [self setHitAreaForButtons:buttons];

  if (self.isVerticalActionsLayout) {
    [self layoutVerticalButtons:buttons];
  } else {
    [self layoutHorizontalButtons:buttons actionSize:actionSize];
  }

  // Place scrollviews
  CGRect contentScrollViewRect = CGRectZero;
  contentScrollViewRect.size = self.contentScrollView.contentSize;
  contentScrollViewRect.origin.y = CGRectGetMaxY(titleFrame) + [self titleInsetBottom];

  CGRect actionsScrollViewRect = CGRectZero;
  actionsScrollViewRect.size = self.actionsScrollView.contentSize;
  actionsScrollViewRect.origin.y = CGRectGetHeight(self.bounds) - actionsScrollViewRect.size.height;

  const CGFloat requestedHeight = contentScrollViewRect.origin.y +
                                  self.contentScrollView.contentSize.height +
                                  self.actionsScrollView.contentSize.height;
  // Check the layout: do both content and actions fit on the screen at once?
  if (requestedHeight > CGRectGetHeight(self.bounds)) {
    // Complex layout case : Split the space between the two scrollviews.
    if (CGRectGetHeight(contentScrollViewRect) < CGRectGetHeight(self.bounds) / 2.0f) {
      actionsScrollViewRect.size.height =
          CGRectGetHeight(self.bounds) - contentScrollViewRect.size.height;
    } else {
      CGFloat maxActionsHeight = CGRectGetHeight(self.bounds) / 2.0f;
      actionsScrollViewRect.size.height = MIN(maxActionsHeight, actionsScrollViewRect.size.height);
    }
    contentScrollViewRect.size.height =
        actionsScrollViewRect.origin.y - contentScrollViewRect.origin.y;

    self.messageLabel.accessibilityFrame = UIAccessibilityConvertFrameToScreenCoordinates(
        CGRectMake(messageFrame.origin.x, contentScrollViewRect.origin.y, messageFrame.size.width,
                   MIN(contentScrollViewRect.size.height, messageFrame.size.height)),
        self);
  }
  self.actionsScrollView.frame = actionsScrollViewRect;
  self.contentScrollView.frame = contentScrollViewRect;
}

- (void)setHitAreaForButtons:(NSArray<MDCButton *> *)buttons {
  for (MDCButton *button in buttons) {
    [button sizeToFit];
    CGRect buttonFrame = button.frame;
    buttonFrame.size.width = MAX(CGRectGetWidth(buttonFrame), MDCDialogActionButtonMinimumWidth);
    buttonFrame.size.height = MAX(CGRectGetHeight(buttonFrame), MDCDialogActionButtonMinimumHeight);
    button.frame = buttonFrame;
    CGFloat verticalInsets = (CGRectGetHeight(button.frame) - MDCDialogActionMinTouchTarget) / 2.0f;
    CGFloat horizontalInsets =
        (CGRectGetWidth(button.frame) - MDCDialogActionMinTouchTarget) / 2.0f;
    verticalInsets = MIN(0.0f, verticalInsets);
    horizontalInsets = MIN(0.0f, horizontalInsets);
    button.hitAreaInsets =
        UIEdgeInsetsMake(verticalInsets, horizontalInsets, verticalInsets, horizontalInsets);
  }
}

- (void)layoutHorizontalButtons:(NSArray<MDCButton *> *)buttons actionSize:(CGSize)actionSize {
  CGFloat maxButtonWidth = self.actionsScrollView.contentSize.width -
                           (self.actionsInsets.left + self.actionsInsets.right);
  CGPoint buttonOrigin = CGPointZero;
  CGFloat buttonWidth = 0.f;
  CGFloat multiplier =
      self.actionsHorizontalAlignment == MDCContentHorizontalAlignmentLeading ? 1.f : -1.f;
  if (self.actionsHorizontalAlignment == MDCContentHorizontalAlignmentLeading) {
    buttonOrigin.x = self.actionsInsets.left;
  } else if (self.actionsHorizontalAlignment == MDCContentHorizontalAlignmentCenter) {
    CGFloat actionWidthNoInsets =
        actionSize.width - self.actionsInsets.left - self.actionsInsets.right;
    buttonOrigin.x = ((self.actionsScrollView.contentSize.width - actionWidthNoInsets) / 2.f) +
                     actionWidthNoInsets;
  } else {  // trailing or justified
    buttonOrigin.x = self.actionsScrollView.contentSize.width - self.actionsInsets.right;
  }
  buttonOrigin.y = self.actionsInsets.top;
  for (UIButton *button in buttons) {
    CGRect buttonRect = button.frame;

    buttonWidth = buttonRect.size.width;
    if (self.actionsHorizontalAlignment == MDCContentHorizontalAlignmentJustified) {
      if (buttons.count > 1) {
        CGFloat totalMargin = self.actionsHorizontalMargin * (buttons.count - 1);
        buttonWidth = (maxButtonWidth - totalMargin) / buttons.count;
      } else {
        buttonWidth = maxButtonWidth;
      }
    }

    if (self.actionsHorizontalAlignment != MDCContentHorizontalAlignmentLeading) {
      buttonOrigin.x += multiplier * buttonWidth;
    }

    buttonRect.origin = buttonOrigin;
    buttonRect.size.width = buttonWidth;

    button.frame = buttonRect;

    if (button != buttons.lastObject) {
      if (self.actionsHorizontalAlignment == MDCContentHorizontalAlignmentLeading) {
        buttonOrigin.x += multiplier * (buttonWidth + self.actionsHorizontalMargin);
      } else {
        buttonOrigin.x += multiplier * self.actionsHorizontalMargin;
      }
    }
  }
  // Handle RTL
  if (self.mdf_effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    for (UIButton *button in buttons) {
      CGRect flippedRect = MDFRectFlippedHorizontally(button.frame, CGRectGetWidth(self.bounds));
      button.frame = flippedRect;
    }
  }
}

- (void)layoutVerticalButtons:(NSArray<MDCButton *> *)buttons {
  CGFloat maxButtonWidth = self.actionsScrollView.contentSize.width -
                           (self.actionsInsets.left + self.actionsInsets.right);
  CGFloat multiplier = self.orderVerticalActionsByEmphasis ? 1.f : -1.f;
  CGPoint buttonCenter;
  CGPoint buttonOrigin;
  buttonOrigin.y = self.orderVerticalActionsByEmphasis
                       ? self.actionsInsets.bottom
                       : self.actionsScrollView.contentSize.height - self.actionsInsets.bottom;
  if (self.actionsHorizontalAlignmentInVerticalLayout == MDCContentHorizontalAlignmentCenter ||
      self.actionsHorizontalAlignmentInVerticalLayout == MDCContentHorizontalAlignmentJustified) {
    buttonCenter.x = self.actionsScrollView.contentSize.width / 2.0f;
    buttonCenter.y = buttonOrigin.y;
    for (UIButton *button in buttons) {
      CGRect buttonRect = button.bounds;

      if (CGRectGetWidth(buttonRect) > maxButtonWidth ||
          self.actionsHorizontalAlignmentInVerticalLayout ==
              MDCContentHorizontalAlignmentJustified) {
        buttonRect.size.width = maxButtonWidth;
        button.bounds = buttonRect;
      }

      buttonCenter.y += multiplier * (buttonRect.size.height / 2.0f);

      button.center = buttonCenter;

      if (button != buttons.lastObject) {
        buttonCenter.y += multiplier * (buttonRect.size.height / 2.0f);
        buttonCenter.y += multiplier * self.actionsVerticalMargin;
      }
    }

  } else {  // Leading/Trailing alignment.
    for (UIButton *button in buttons) {
      CGRect buttonRect = button.bounds;
      buttonOrigin.x = self.actionsInsets.left;
      if (self.actionsHorizontalAlignmentInVerticalLayout ==
          MDCContentHorizontalAlignmentTrailing) {
        buttonOrigin.x = self.actionsScrollView.contentSize.width - buttonRect.size.width -
                         self.actionsInsets.right;
      }
      buttonOrigin.y += multiplier * buttonRect.size.height;

      buttonRect.origin = buttonOrigin;
      button.frame = buttonRect;
      if (button != buttons.lastObject) {
        buttonOrigin.y += multiplier * self.actionsVerticalMargin;
      }
    }
    // Handle RTL
    if (self.mdf_effectiveUserInterfaceLayoutDirection ==
        UIUserInterfaceLayoutDirectionRightToLeft) {
      for (UIButton *button in buttons) {
        CGRect flippedRect = MDFRectFlippedHorizontally(button.frame, CGRectGetWidth(self.bounds));
        button.frame = flippedRect;
      }
    }
  }
}

#pragma mark - Dynamic Type

- (BOOL)mdc_adjustsFontForContentSizeCategory {
  return _mdc_adjustsFontForContentSizeCategory;
}

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  _mdc_adjustsFontForContentSizeCategory = adjusts;

  for (MDCButton *button in self.actionManager.buttonsInActionOrder) {
    button.mdc_adjustsFontForContentSizeCategory = adjusts;
  }

  [self updateFonts];
}

// Update the fonts used based on whether Dynamic Type is enabled.
- (void)updateFonts {
  [self updateTitleFont];
  [self updateMessageFont];
  [self updateButtonFont];

  [self setNeedsLayout];
}

@end
