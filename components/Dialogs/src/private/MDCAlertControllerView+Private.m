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

static const UIEdgeInsets MDCDialogContentInsets = {24.0f, 24.0f, 24.0f, 24.0f};
static const CGFloat MDCDialogContentVerticalPadding = 20.0f;
static const CGFloat MDCDialogTitleIconVerticalPadding = 12.0f;

static const UIEdgeInsets MDCDialogActionsInsets = {8.0f, 8.0f, 8.0f, 8.0f};
static const CGFloat MDCDialogActionsHorizontalPadding = 8.0f;
static const CGFloat MDCDialogActionsVerticalPadding = 12.0f;
static const CGFloat MDCDialogActionButtonMinimumHeight = 36.0f;
static const CGFloat MDCDialogActionButtonMinimumWidth = 48.0f;
static const CGFloat MDCDialogActionMinTouchTarget = 48.0f;

static const CGFloat MDCDialogMessageOpacity = 0.54f;

@interface MDCAlertControllerView ()

@property(nonatomic, getter=isVerticalActionsLayout) BOOL verticalActionsLayout;
@property(nonatomic, nullable, strong) UIImageView *titleIconImageView;

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

    self.titleIconInsets = UIEdgeInsetsMake(24.f, 24.f, 20.f, 24.f);
    self.titleInsets = UIEdgeInsetsMake(24.f, 24.f, 20.f, 24.f);
    self.contentInsets = UIEdgeInsetsMake(24.f, 24.f, 28.f, 24.f);
    self.actionsInsets = UIEdgeInsetsMake(8.f, 8.f, 8.f, 8.f);
    self.actionsHorizontalMargin = 8.f;
    self.actionsVerticalMargin = 12.f;

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

  if (self.titleIconView != nil) {
    [self.titleIconView removeFromSuperview];
    self.titleIconView = nil;
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
  if (self.titleIconImageView != nil) {
    NSLog(@"Warning: unintended use of the API. The following APIs are not expected to be used"
           "together: 'setTitleIconView:' and `setTitleIcon:` API. Please set either, but not "
           "both at the same time. If 'titleIcon' is set, 'titleIconView' is ignored.");
    return;
  }
  if (_titleIconView == nil || ![_titleIconView isEqual:titleIconView]) {
    if (_titleIconView != nil) {
      [_titleIconView removeFromSuperview];
    }
    _titleIconView = titleIconView;
    if (_titleIconView != nil) {
      [self.titleScrollView addSubview:_titleIconView];
    }
    [self.titleScrollView setNeedsLayout];
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

- (CGSize)actionButtonsSizeInHorizontalLayout {
  CGSize size = CGSizeZero;
  NSArray<MDCButton *> *buttons = self.actionManager.buttonsInActionOrder;
  if (0 < buttons.count) {
    CGFloat maxButtonHeight = MDCDialogActionButtonMinimumHeight;
    size.width = MDCDialogActionsInsets.left + MDCDialogActionsInsets.right;
    for (UIButton *button in buttons) {
      CGSize buttonSize = [button sizeThatFits:size];
      size.width += buttonSize.width;
      maxButtonHeight = MAX(maxButtonHeight, buttonSize.height);
      if (button != buttons.lastObject) {
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
  if (0 < buttons.count) {
    size.height = MDCDialogActionsInsets.top + MDCDialogActionsInsets.bottom;
    size.width = MDCDialogActionsInsets.left + MDCDialogActionsInsets.right;
    for (UIButton *button in buttons) {
      CGSize buttonSize = [button sizeThatFits:size];
      buttonSize.height = MAX(buttonSize.height, MDCDialogActionButtonMinimumHeight);
      size.height += buttonSize.height;
      size.width = MAX(size.width, buttonSize.width);
      if (button != buttons.lastObject) {
        size.height += MDCDialogActionsVerticalPadding;
      }
    }
  }

  return size;
}

- (BOOL)hasTitleIcon {
  return (0.0f < self.titleIconImageView.image.size.height);
}

- (BOOL)hasTitle {
  return self.title.length > 0;
}

- (BOOL)hasMessage {
  return self.message.length > 0;
}

- (CGFloat)contentInternalVerticalPadding {
  return (([self hasTitle] || [self hasTitleIcon]) && [self hasMessage])
             ? MDCDialogContentVerticalPadding
             : 0.0f;
}

- (CGFloat)contentTitleIconVerticalPadding {
  return ([self hasTitle] && [self hasTitleIcon]) ? MDCDialogTitleIconVerticalPadding : 0.0f;
}

- (CGFloat)contentAccessoryVerticalPaddingWithFittingSize:(CGSize)boundsSize {
  CGSize accessoryViewSize = [self.accessoryView systemLayoutSizeFittingSize:boundsSize];
  return (([self hasTitle] || [self hasTitleIcon] || [self hasMessage]) &&
          (0.0 < accessoryViewSize.height))
             ? MDCDialogContentVerticalPadding
             : 0.0f;
}

- (CGSize)titleIconViewSize {
  CGSize titleIconViewSize = CGSizeZero;
  if (self.titleIconImageView != nil) {
    titleIconViewSize = self.titleIconImageView.image.size;
  } else if (self.titleIconView != nil) {
    titleIconViewSize = self.titleIconView.frame.size;
  }
  return titleIconViewSize;
}

- (CGFloat)titleTop {
  return MDCDialogContentInsets.top + [self contentTitleIconVerticalPadding] +
         [self titleIconViewSize].height;
}

- (CGRect)titleFrameWithTitleSize:(CGSize)titleSize {
  return CGRectMake(MDCDialogContentInsets.left, [self titleTop], titleSize.width,
                    titleSize.height);
}

- (CGRect)messageFrameWithSize:(CGSize)messageSize {
  CGRect messageFrame =
      CGRectMake(MDCDialogContentInsets.left, 0, messageSize.width, messageSize.height);
  return messageFrame;
}

- (CGRect)titleIconFrameWithTitleSize:(CGSize)titleSize {
  CGSize titleIconViewSize = [self titleIconViewSize];
  CGRect titleFrame = [self titleFrameWithTitleSize:titleSize];
  // match the titleIcon alignment to the title alignment
  CGFloat titleIconLeftPadding = MDCDialogContentInsets.left;
  if (self.titleAlignment == NSTextAlignmentCenter) {
    titleIconLeftPadding =
        CGRectGetMinX(titleFrame) + (CGRectGetWidth(titleFrame) - titleIconViewSize.width) / 2.0f;
  } else if (self.titleAlignment == NSTextAlignmentRight ||
             (self.titleAlignment == NSTextAlignmentNatural &&
              [self mdf_effectiveUserInterfaceLayoutDirection] ==
                  UIUserInterfaceLayoutDirectionRightToLeft)) {
    titleIconLeftPadding = CGRectGetMaxX(titleFrame) - titleIconViewSize.width;
  }
  CGRect titleIconFrame = CGRectMake(titleIconLeftPadding, MDCDialogContentInsets.top,
                                     titleIconViewSize.width, titleIconViewSize.height);
  return titleIconFrame;
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
  CGSize boundsSize = CGRectInfinite.size;
  boundsSize.width = boundingWidth - MDCDialogContentInsets.left - MDCDialogContentInsets.right;

  CGSize titleSize = [self.titleLabel sizeThatFits:boundsSize];
  CGSize messageSize = [self.messageLabel sizeThatFits:boundsSize];
  CGSize accessoryViewSize = [self.accessoryView systemLayoutSizeFittingSize:boundsSize];

  CGFloat contentWidth = MAX(MAX(titleSize.width, messageSize.width), accessoryViewSize.width) +
                         MDCDialogContentInsets.left + MDCDialogContentInsets.right;

  CGFloat contentAccessoryVerticalPadding =
      [self contentAccessoryVerticalPaddingWithFittingSize:boundsSize];
  CGFloat contentHeight = messageSize.height + contentAccessoryVerticalPadding +
                          accessoryViewSize.height + MDCDialogContentInsets.bottom;

  CGSize contentSize;
  contentSize.width = (CGFloat)ceil(contentWidth);
  contentSize.height = (CGFloat)ceil(contentHeight);

  return contentSize;
}

// @param boundingWidth should not include any internal margins or padding
- (CGSize)calculateTitleViewSizeThatFitsWidth:(CGFloat)boundingWidth {
  CGSize boundsSize = CGRectInfinite.size;
  boundsSize.width = boundingWidth - MDCDialogContentInsets.left - MDCDialogContentInsets.right;

  CGSize titleSize = [self.titleLabel sizeThatFits:boundsSize];
  CGSize messageSize = [self.messageLabel sizeThatFits:boundsSize];
  CGSize accessoryViewSize = [self.accessoryView systemLayoutSizeFittingSize:boundsSize];
  CGFloat contentWidth = MAX(MAX(titleSize.width, messageSize.width), accessoryViewSize.width) +
                         MDCDialogContentInsets.left + MDCDialogContentInsets.right;

  CGFloat contentHeight = MDCDialogContentInsets.top + [self titleIconViewSize].height +
                          [self contentTitleIconVerticalPadding] + titleSize.height +
                          [self contentInternalVerticalPadding];

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
    CGFloat verticalInsets = (CGRectGetHeight(button.frame) - MDCDialogActionMinTouchTarget) / 2.0f;
    CGFloat horizontalInsets =
        (CGRectGetWidth(button.frame) - MDCDialogActionMinTouchTarget) / 2.0f;
    verticalInsets = MIN(0.0f, verticalInsets);
    horizontalInsets = MIN(0.0f, horizontalInsets);
    button.hitAreaInsets =
        UIEdgeInsetsMake(verticalInsets, horizontalInsets, verticalInsets, horizontalInsets);
  }

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
  boundsSize.width = boundsSize.width - MDCDialogContentInsets.left - MDCDialogContentInsets.right;
  CGSize titleSize = [self.titleLabel sizeThatFits:boundsSize];
  titleSize.width = boundsSize.width;

  CGSize messageSize = [self.messageLabel sizeThatFits:boundsSize];
  messageSize.width = boundsSize.width;

  CGSize accessoryViewSize =
      [self.accessoryView systemLayoutSizeFittingSize:boundsSize
                        withHorizontalFittingPriority:UILayoutPriorityRequired
                              verticalFittingPriority:UILayoutPriorityFittingSizeLevel];
  accessoryViewSize.width = boundsSize.width;

  boundsSize.width = boundsSize.width + MDCDialogContentInsets.left + MDCDialogContentInsets.right;

  CGFloat contentAccessoryVerticalPadding =
      [self contentAccessoryVerticalPaddingWithFittingSize:boundsSize];
  CGRect titleFrame = [self titleFrameWithTitleSize:titleSize];
  CGRect messageFrame = [self messageFrameWithSize:messageSize];
  CGRect accessoryViewFrame = CGRectMake(
      MDCDialogContentInsets.left, CGRectGetMaxY(messageFrame) + contentAccessoryVerticalPadding,
      accessoryViewSize.width, accessoryViewSize.height);

  CGRect titleIconImageViewRect = [self titleIconFrameWithTitleSize:titleSize];
  if (self.titleIconImageView != nil) {
    // Match the title icon alignment to the title alignment.
    self.titleIconImageView.frame = titleIconImageViewRect;
  } else if (self.titleIconView != nil) {
    self.titleIconView.frame = titleIconImageViewRect;
  }

  self.titleLabel.frame = titleFrame;
  self.messageLabel.frame = messageFrame;
  self.accessoryView.frame = accessoryViewFrame;

  // Actions
  CGSize actionSize = [self calculateActionsSizeThatFitsWidth:boundsSize.width];

  CGRect actionsFrame = CGRectZero;
  actionsFrame.size.width = CGRectGetWidth(self.bounds);
  if (0 < buttons.count) {
    actionsFrame.size.height = actionSize.height;
  }
  self.actionsScrollView.contentSize = actionsFrame.size;

  // Place buttons in actionsScrollView
  if (self.isVerticalActionsLayout) {
    CGPoint buttonCenter;
    buttonCenter.x = self.actionsScrollView.contentSize.width / 2.0f;
    buttonCenter.y = self.actionsScrollView.contentSize.height - MDCDialogActionsInsets.bottom;
    CGFloat maxButtonWidth = self.actionsScrollView.contentSize.width -
                             (MDCDialogActionsInsets.left + MDCDialogActionsInsets.right);
    for (UIButton *button in buttons) {
      CGRect buttonRect = button.bounds;

      if (CGRectGetWidth(buttonRect) > maxButtonWidth) {
        buttonRect.size.width = maxButtonWidth;
        button.bounds = buttonRect;
      }

      buttonCenter.y -= buttonRect.size.height / 2.0f;

      button.center = buttonCenter;

      if (button != buttons.lastObject) {
        buttonCenter.y -= buttonRect.size.height / 2.0f;
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

      if (button != buttons.lastObject) {
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
  contentScrollViewRect.origin.y =
      CGRectGetMaxY(titleFrame) + [self contentInternalVerticalPadding];

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
    contentScrollViewRect.size.height = CGRectGetHeight(self.bounds) -
                                        actionsScrollViewRect.size.height -
                                        contentScrollViewRect.origin.y;
  }
  self.actionsScrollView.frame = actionsScrollViewRect;
  self.contentScrollView.frame = contentScrollViewRect;
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
