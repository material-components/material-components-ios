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

static const UIEdgeInsets MDCDialogContentInsets = {24.0, 24.0, 24.0, 24.0};
static const CGFloat MDCDialogContentVerticalPadding = 20.0;
static const CGFloat MDCDialogTitleIconVerticalPadding = 12.0;

static const UIEdgeInsets MDCDialogActionsInsets = {8.0, 8.0, 8.0, 8.0};
static const CGFloat MDCDialogActionsHorizontalPadding = 8.0;
static const CGFloat MDCDialogActionsVerticalPadding = 12.0;
static const CGFloat MDCDialogActionButtonMinimumHeight = 36.0;
static const CGFloat MDCDialogActionButtonMinimumWidth = 48.0;
static const CGFloat MDCDialogActionMinTouchTarget = 48;

static const CGFloat MDCDialogMessageOpacity = (CGFloat)0.54;

@interface MDCAlertControllerView ()

@property(nonatomic, getter=isVerticalActionsLayout) BOOL verticalActionsLayout;

@end

@implementation MDCAlertControllerView {
  BOOL _mdc_adjustsFontForContentSizeCategory;
}

@dynamic titleAlignment;
@dynamic titleIcon;

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.autoresizesSubviews = NO;
    self.clipsToBounds = YES;

    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.contentScrollView];

    self.actionsScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.actionsScrollView];

    // set the background color after all surface subviews are added
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
    [self.contentScrollView addSubview:self.titleLabel];

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

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
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
  self.contentScrollView.backgroundColor = backgroundColor;
  self.actionsScrollView.backgroundColor = backgroundColor;
}

- (UIColor *)backgroundColor {
  return super.backgroundColor;
}

- (void)addActionButton:(nonnull MDCButton *)button {
  if (button.superview == nil) {
    button.mdc_adjustsFontForContentSizeCategory = self.mdc_adjustsFontForContentSizeCategory;
    [self.actionsScrollView addSubview:button];
    if (_buttonColor) {
      // We only set if _buttonColor since settingTitleColor to nil doesn't
      // reset the title to the default
      [button setTitleColor:_buttonColor forState:UIControlStateNormal];
    }
    [button setTitleFont:_buttonFont forState:UIControlStateNormal];
    button.inkColor = self.buttonInkColor;
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
  [button setInkColor:[UIColor colorWithWhite:0 alpha:(CGFloat)0.06]];
  button.disabledAlpha = 1;
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
      self.titleLabel.font =
          [titleFont mdc_fontSizedForMaterialTextStyle:kTitleTextStyle
                                  scaledForDynamicType:self.mdc_adjustsFontForContentSizeCategory];
    }
  } else {
    _titleLabel.font = titleFont;
  }
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
  } else if (self.titleIconImageView == nil) {
    self.titleIconImageView = [[UIImageView alloc] initWithImage:titleIcon];
    self.titleIconImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentScrollView addSubview:self.titleIconImageView];
  } else {
    self.titleIconImageView.image = titleIcon;
  }

  self.titleIconImageView.tintColor = self.titleIconTintColor;
  [self.titleIconImageView sizeToFit];
}

- (void)setTitleIconTintColor:(UIColor *)titleIconTintColor {
  _titleIconTintColor = titleIconTintColor;
  self.titleIconImageView.tintColor = titleIconTintColor;
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
  UIFont *messageFont = _messageFont ?: [[self class] messageFontDefault];
  if (self.mdc_adjustsFontForContentSizeCategory) {
    if (self.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable) {
      self.messageLabel.font = [messageFont
          mdc_fontSizedForMaterialTextStyle:kMessageTextStyle
                       scaledForDynamicType:self.mdc_adjustsFontForContentSizeCategory];
    }
  } else {
    _messageLabel.font = messageFont;
  }
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

#pragma mark - Internal

- (CGSize)actionButtonsSizeInHorizontalLayout {
  CGSize size = CGSizeZero;
  NSArray<MDCButton *> *buttons = self.actionManager.buttonsInActionOrder;
  if (0 < [buttons count]) {
    CGFloat maxButtonHeight = MDCDialogActionButtonMinimumHeight;
    size.width = MDCDialogActionsInsets.left + MDCDialogActionsInsets.right;
    for (UIButton *button in buttons) {
      CGSize buttonSize = [button sizeThatFits:size];
      size.width += buttonSize.width;
      maxButtonHeight = MAX(maxButtonHeight, buttonSize.height);
      if (button != [buttons lastObject]) {
        size.width += MDCDialogActionsHorizontalPadding;
      }
    }
    size.height = MDCDialogActionsInsets.top + maxButtonHeight + MDCDialogActionsInsets.bottom;
  }

  return size;
}

- (CGSize)actionButtonsSizeInVerticalLayout {
  CGSize size = CGSizeZero;
  NSArray<MDCButton *> *buttons = self.actionManager.buttonsInActionOrder;
  if (0 < [buttons count]) {
    size.height = MDCDialogActionsInsets.top + MDCDialogActionsInsets.bottom;
    size.width = MDCDialogActionsInsets.left + MDCDialogActionsInsets.right;
    for (UIButton *button in buttons) {
      CGSize buttonSize = [button sizeThatFits:size];
      buttonSize.height = MAX(buttonSize.height, MDCDialogActionButtonMinimumHeight);
      size.height += buttonSize.height;
      size.width = MAX(size.width, buttonSize.width);
      if (button != [buttons lastObject]) {
        size.height += MDCDialogActionsVerticalPadding;
      }
    }
  }

  return size;
}

// @param boundsSize should not include any internal margins or padding
- (CGSize)calculatePreferredContentSizeForBounds:(CGSize)boundsSize {
  // Even if we have more room, limit our maximum width
  boundsSize.width = MIN(boundsSize.width, MDCDialogMaximumWidth);

  // Content & Actions
  CGSize contentSize = [self calculateContentSizeThatFitsWidth:boundsSize.width];
  CGSize actionSize = [self calculateActionsSizeThatFitsWidth:boundsSize.width];

  // Final Sizing
  CGSize totalSize;
  totalSize.width = MAX(contentSize.width, actionSize.width);
  totalSize.height = contentSize.height + actionSize.height;

  return totalSize;
}

// @param boundingWidth should not include any internal margins or padding
- (CGSize)calculateContentSizeThatFitsWidth:(CGFloat)boundingWidth {
  CGSize boundsSize = CGRectInfinite.size;
  boundsSize.width = boundingWidth - MDCDialogContentInsets.left - MDCDialogContentInsets.right;

  CGSize titleIconSize = CGSizeZero;
  if (self.titleIconImageView != nil) {
    // TODO(galiak): Have title-icon size respond to dynamic type or device screen size, once this:
    // https://github.com/material-components/material-components-ios/issues/5198 is resolved.
    titleIconSize = self.titleIconImageView.image.size;
  }

  CGSize titleSize = [self.titleLabel sizeThatFits:boundsSize];
  CGSize messageSize = [self.messageLabel sizeThatFits:boundsSize];

  CGFloat contentWidth = MAX(titleSize.width, messageSize.width);
  contentWidth += MDCDialogContentInsets.left + MDCDialogContentInsets.right;

  CGFloat contentInternalVerticalPadding = 0.0;
  if ((0.0 < titleSize.height || 0.0 < titleIconSize.height) && 0.0 < messageSize.height) {
    contentInternalVerticalPadding = MDCDialogContentVerticalPadding;
  }
  CGFloat contentTitleIconVerticalPadding = 0;
  if (0.0 < titleSize.height && 0.0 < titleIconSize.height) {
    contentTitleIconVerticalPadding = MDCDialogTitleIconVerticalPadding;
  }
  CGFloat contentHeight = titleIconSize.height + contentTitleIconVerticalPadding +
                          titleSize.height + contentInternalVerticalPadding + messageSize.height;
  contentHeight += MDCDialogContentInsets.top + MDCDialogContentInsets.bottom;

  CGSize contentSize;
  contentSize.width = (CGFloat)ceil(contentWidth);
  contentSize.height = (CGFloat)ceil(contentHeight);

  return contentSize;
}

// @param boundingWidth should not include any internal margins or padding
- (CGSize)calculateActionsSizeThatFitsWidth:(CGFloat)boundingWidth {
  CGSize boundsSize = CGRectInfinite.size;
  boundsSize.width = boundingWidth;

  CGSize horizontalSize = [self actionButtonsSizeInHorizontalLayout];
  CGSize verticalSize = [self actionButtonsSizeInVerticalLayout];

  CGSize actionsSize;
  if (boundsSize.width < horizontalSize.width) {
    // Use VerticalLayout
    actionsSize.width = MIN(verticalSize.width, boundsSize.width);
    actionsSize.height = MIN(verticalSize.height, boundsSize.height);
    self.verticalActionsLayout = YES;
  } else {
    // Use HorizontalLayout
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

  NSArray<MDCButton *> *buttons = self.actionManager.buttonsInActionOrder;

  for (MDCButton *button in buttons) {
    [button sizeToFit];
    CGRect buttonFrame = button.frame;
    buttonFrame.size.width = MAX(CGRectGetWidth(buttonFrame), MDCDialogActionButtonMinimumWidth);
    buttonFrame.size.height = MAX(CGRectGetHeight(buttonFrame), MDCDialogActionButtonMinimumHeight);
    button.frame = buttonFrame;
    CGFloat verticalInsets = (CGRectGetHeight(button.frame) - MDCDialogActionMinTouchTarget) / 2;
    CGFloat horizontalInsets = (CGRectGetWidth(button.frame) - MDCDialogActionMinTouchTarget) / 2;
    verticalInsets = MIN(0, verticalInsets);
    horizontalInsets = MIN(0, horizontalInsets);
    button.hitAreaInsets =
        UIEdgeInsetsMake(verticalInsets, horizontalInsets, verticalInsets, horizontalInsets);
  }

  // Used to calculate the height of the scrolling content, so we limit the width.
  CGSize boundsSize = CGRectInfinite.size;
  boundsSize.width = CGRectGetWidth(self.bounds);

  // Content
  CGSize contentSize = [self calculateContentSizeThatFitsWidth:boundsSize.width];

  CGRect contentRect = CGRectZero;
  contentRect.size.width = CGRectGetWidth(self.bounds);
  contentRect.size.height = contentSize.height;

  self.contentScrollView.contentSize = contentRect.size;

  // Place Content in contentScrollView
  boundsSize.width = boundsSize.width - MDCDialogContentInsets.left - MDCDialogContentInsets.right;
  CGSize titleSize = [self.titleLabel sizeThatFits:boundsSize];
  titleSize.width = boundsSize.width;

  CGSize titleIconSize = CGSizeZero;
  if (self.titleIconImageView != nil) {
    // TODO(galiak): Have title-icon size respond to dynamic type or device screen size, once this:
    // https://github.com/material-components/material-components-ios/issues/5198 is resolved.
    titleIconSize = self.titleIconImageView.image.size;
  }

  CGSize messageSize = [self.messageLabel sizeThatFits:boundsSize];
  messageSize.width = boundsSize.width;
  boundsSize.width = boundsSize.width + MDCDialogContentInsets.left + MDCDialogContentInsets.right;

  CGFloat contentInternalVerticalPadding = 0.0;
  if ((0.0 < titleSize.height || 0.0 < titleIconSize.height) && 0.0 < messageSize.height) {
    contentInternalVerticalPadding = MDCDialogContentVerticalPadding;
  }
  CGFloat contentTitleIconVerticalPadding = 0;
  if (0.0 < titleSize.height && 0.0 < titleIconSize.height) {
    contentTitleIconVerticalPadding = MDCDialogTitleIconVerticalPadding;
  }

  CGFloat titleTop =
      MDCDialogContentInsets.top + contentTitleIconVerticalPadding + titleIconSize.height;
  CGRect titleFrame =
      CGRectMake(MDCDialogContentInsets.left, titleTop, titleSize.width, titleSize.height);
  CGRect messageFrame = CGRectMake(MDCDialogContentInsets.left,
                                   CGRectGetMaxY(titleFrame) + contentInternalVerticalPadding,
                                   messageSize.width, messageSize.height);

  self.titleLabel.frame = titleFrame;
  self.messageLabel.frame = messageFrame;

  if (self.titleIconImageView != nil) {
    // match the titleIcon alignment to the title alignment
    CGFloat titleIconPosition = titleFrame.origin.x;
    if (self.titleAlignment == NSTextAlignmentCenter) {
      titleIconPosition = (contentSize.width - titleIconSize.width) / 2;
    } else if (self.titleAlignment == NSTextAlignmentRight ||
               (self.titleAlignment == NSTextAlignmentNatural &&
                [self mdf_effectiveUserInterfaceLayoutDirection] ==
                    UIUserInterfaceLayoutDirectionRightToLeft)) {
      titleIconPosition = CGRectGetMaxX(titleFrame) - titleIconSize.width;
    }
    CGRect titleIconFrame = CGRectMake(titleIconPosition, MDCDialogContentInsets.top,
                                       titleIconSize.width, titleIconSize.height);
    self.titleIconImageView.frame = titleIconFrame;
  }

  // Actions
  CGSize actionSize = [self calculateActionsSizeThatFitsWidth:boundsSize.width];

  CGRect actionsFrame = CGRectZero;
  actionsFrame.size.width = CGRectGetWidth(self.bounds);
  if (0 < [buttons count]) {
    actionsFrame.size.height = actionSize.height;
  }
  self.actionsScrollView.contentSize = actionsFrame.size;

  // Place buttons in actionsScrollView
  if (self.isVerticalActionsLayout) {
    CGPoint buttonCenter;
    buttonCenter.x = self.actionsScrollView.contentSize.width * (CGFloat)0.5;
    buttonCenter.y = self.actionsScrollView.contentSize.height - MDCDialogActionsInsets.bottom;
    for (UIButton *button in buttons) {
      CGRect buttonRect = button.frame;

      buttonCenter.y -= buttonRect.size.height * (CGFloat)0.5;

      button.center = buttonCenter;

      if (button != [buttons lastObject]) {
        buttonCenter.y -= buttonRect.size.height * (CGFloat)0.5;
        buttonCenter.y -= MDCDialogActionsVerticalPadding;
      }
    }
  } else {
    CGPoint buttonOrigin = CGPointZero;
    buttonOrigin.x = self.actionsScrollView.contentSize.width - MDCDialogActionsInsets.right;
    buttonOrigin.y = MDCDialogActionsInsets.top;
    for (UIButton *button in buttons) {
      CGRect buttonRect = button.frame;

      buttonOrigin.x -= buttonRect.size.width;
      buttonRect.origin = buttonOrigin;

      button.frame = buttonRect;

      if (button != [buttons lastObject]) {
        buttonOrigin.x -= MDCDialogActionsHorizontalPadding;
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

  // Place scrollviews
  CGRect contentScrollViewRect = CGRectZero;
  contentScrollViewRect.size = self.contentScrollView.contentSize;

  CGRect actionsScrollViewRect = CGRectZero;
  actionsScrollViewRect.size = self.actionsScrollView.contentSize;

  const CGFloat requestedHeight =
      self.contentScrollView.contentSize.height + self.actionsScrollView.contentSize.height;
  if (requestedHeight <= CGRectGetHeight(self.bounds)) {
    // Simple layout case : both content and actions fit on the screen at once
    self.contentScrollView.frame = contentScrollViewRect;

    actionsScrollViewRect.origin.y =
        CGRectGetHeight(self.bounds) - actionsScrollViewRect.size.height;
    self.actionsScrollView.frame = actionsScrollViewRect;
  } else {
    // Complex layout case : Split the space between the two scrollviews
    if (CGRectGetHeight(contentScrollViewRect) < CGRectGetHeight(self.bounds) * (CGFloat)0.5) {
      actionsScrollViewRect.size.height =
          CGRectGetHeight(self.bounds) - contentScrollViewRect.size.height;
    } else {
      CGFloat maxActionsHeight = CGRectGetHeight(self.bounds) * (CGFloat)0.5;
      actionsScrollViewRect.size.height = MIN(maxActionsHeight, actionsScrollViewRect.size.height);
    }
    actionsScrollViewRect.origin.y =
        CGRectGetHeight(self.bounds) - actionsScrollViewRect.size.height;
    self.actionsScrollView.frame = actionsScrollViewRect;

    contentScrollViewRect.size.height =
        CGRectGetHeight(self.bounds) - actionsScrollViewRect.size.height;
    self.contentScrollView.frame = contentScrollViewRect;
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

// Update the fonts used based on whether Dynamic Type is enabled
- (void)updateFonts {
  [self updateTitleFont];
  [self updateMessageFont];
  [self updateButtonFont];

  [self setNeedsLayout];
}

@end
