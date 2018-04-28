/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCAlertControllerView.h"
#import "MDCAlertControllerView+Private.h"

#import <MDFInternationalization/MDFInternationalization.h>

#import "MaterialButtons.h"
#import "MaterialTypography.h"

// https://material.io/go/design-dialogs#dialogs-specs
static const MDCFontTextStyle kTitleTextStyle = MDCFontTextStyleTitle;
static const MDCFontTextStyle kMessageTextStyle = MDCFontTextStyleBody1;
static const MDCFontTextStyle kButtonTextStyle = MDCFontTextStyleButton;

static const UIEdgeInsets MDCDialogContentInsets = {24.0, 24.0, 24.0, 24.0};
static const CGFloat MDCDialogContentVerticalPadding = 20.0;

static const UIEdgeInsets MDCDialogActionsInsets = {8.0, 8.0, 8.0, 8.0};
static const CGFloat MDCDialogActionsHorizontalPadding = 8.0;
static const CGFloat MDCDialogActionsVerticalPadding = 8.0;
static const CGFloat MDCDialogActionButtonHeight = 36.0;
static const CGFloat MDCDialogActionButtonMinimumWidth = 48.0;

static const CGFloat MDCDialogMessageOpacity = 0.54f;

@interface MDCAlertControllerView ()

@property(nonatomic, nonnull, strong) UIScrollView *contentScrollView;
@property(nonatomic, nonnull, strong) UIScrollView *actionsScrollView;

@property(nonatomic, getter=isVerticalActionsLayout) BOOL verticalActionsLayout;

@end

@implementation MDCAlertControllerView {
    NSMutableArray<MDCFlatButton *> *_actionButtons;
    BOOL _mdc_adjustsFontForContentSizeCategory;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.backgroundColor = [UIColor whiteColor];
    self.autoresizesSubviews = NO;
    self.clipsToBounds = YES;

    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.contentScrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.contentScrollView];

    self.actionsScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.actionsScrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.actionsScrollView];

    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textAlignment = NSTextAlignmentNatural;
    if (self.mdc_adjustsFontForContentSizeCategory) {
      self.titleLabel.font = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleTitle];
    } else {
      self.titleLabel.font = [MDCTypography titleFont];
    }
    [self.contentScrollView addSubview:self.titleLabel];

    self.messageLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.textAlignment = NSTextAlignmentNatural;
    if (self.mdc_adjustsFontForContentSizeCategory) {
      self.messageLabel.font = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleBody1];
    } else {
      self.messageLabel.font = [MDCTypography body1Font];
    }
    self.messageLabel.textColor = [UIColor colorWithWhite:0.0f alpha:MDCDialogMessageOpacity];
    [self.contentScrollView addSubview:self.messageLabel];

    _actionButtons = [[NSMutableArray alloc] init];

    [self setNeedsLayout];
  }

  return self;
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSArray<UIButton *>*)actionButtons{
  return (NSArray<UIButton *>*)_actionButtons;
}

- (NSString *)title {
  return self.titleLabel.text;
}

- (void)setTitle:(NSString *)title {
  self.titleLabel.text = title;

  [self setNeedsLayout];
}

- (void)addActionButtonTitle:(NSString *)actionTitle target:(id)target selector:(SEL)selector {
  MDCFlatButton *actionButton = [[MDCFlatButton alloc] initWithFrame:CGRectZero];
  actionButton.mdc_adjustsFontForContentSizeCategory = self.mdc_adjustsFontForContentSizeCategory;
  [actionButton setTitle:actionTitle forState:UIControlStateNormal];
  if (_buttonColor) {
    // We only set if _buttonColor since settingTitleColor to nil doesn't reset the title to the
    // default
    [actionButton setTitleColor:_buttonColor forState:UIControlStateNormal];
  }
  [actionButton setTitleFont:_buttonFont forState:UIControlStateNormal];
  // TODO(#1726): Determine default text color values for Normal and Disabled
  CGRect buttonRect = actionButton.bounds;
  buttonRect.size.height = MAX(buttonRect.size.height, MDCDialogActionButtonHeight);
  buttonRect.size.width = MAX(buttonRect.size.width, MDCDialogActionButtonMinimumWidth);
  actionButton.frame = buttonRect;
  [actionButton addTarget:target
                   action:selector
         forControlEvents:UIControlEventTouchUpInside];
  [self.actionsScrollView addSubview:actionButton];

  [_actionButtons addObject:actionButton];
}

- (void)setTitleFont:(UIFont *)font {
  _titleFont = font;

  [self updateTitleFont];
}

- (void)updateTitleFont {
  UIFont *titleFont = _titleFont ?: [[self class] titleFontDefault];
  if (_mdc_adjustsFontForContentSizeCategory) {
    _titleLabel.font =
    [titleFont mdc_fontSizedForMaterialTextStyle:kTitleTextStyle
                            scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
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
  if (_mdc_adjustsFontForContentSizeCategory) {
    _messageLabel.font =
        [messageFont mdc_fontSizedForMaterialTextStyle:kMessageTextStyle
                                scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
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
  UIFont *finalButtonFont = _buttonFont ?: [[self class] buttonFontDefault];
  if (_mdc_adjustsFontForContentSizeCategory) {
    finalButtonFont =
        [finalButtonFont mdc_fontSizedForMaterialTextStyle:kTitleTextStyle
                                scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
  }
  for (MDCFlatButton *button in self.actionButtons) {
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

  for (MDCFlatButton *button in self.actionButtons) {
    [button setTitleColor:_buttonColor forState:UIControlStateNormal];
  }
}

#pragma mark - Internal


- (CGSize)actionButtonsSizeInHorizontalLayout {
  CGSize size = CGSizeZero;
  if (0 < [self.actionButtons count]) {
    size.height =
    MDCDialogActionsInsets.top + MDCDialogActionButtonHeight + MDCDialogActionsInsets.bottom;
    size.width = MDCDialogActionsInsets.left + MDCDialogActionsInsets.right;
    for (UIButton *button in self.actionButtons) {
      size.width += CGRectGetWidth(button.bounds);
      if (button != [self.actionButtons lastObject]) {
        size.width += MDCDialogActionsHorizontalPadding;
      }
    }
  }

  return size;
}

- (CGSize)actionButtonsSizeInVericalLayout {
  CGSize size = CGSizeZero;
  if (0 < [self.actionButtons count]) {
    size.height = MDCDialogActionsInsets.top + MDCDialogActionsInsets.bottom;
    size.width = MDCDialogActionsInsets.left + MDCDialogActionsInsets.right;
    for (UIButton *button in self.actionButtons) {
      size.height += CGRectGetHeight(button.bounds);
      size.width = MAX(size.width, CGRectGetWidth(button.bounds));
      if (button != [self.actionButtons lastObject]) {
        size.height += MDCDialogActionsVerticalPadding;
      }
    }
  }

  return size;
}


// @param boundsSize should not include any internal margins or padding
- (CGSize)calculatePreferredContentSizeForBounds:(CGSize)boundsSize {
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

  CGSize titleSize = [self.titleLabel sizeThatFits:boundsSize];
  CGSize messageSize = [self.messageLabel sizeThatFits:boundsSize];

  CGFloat contentWidth = MAX(titleSize.width, messageSize.width);
  contentWidth += MDCDialogContentInsets.left + MDCDialogContentInsets.right;

  CGFloat contentInternalVerticalPadding = 0.0;
  if (0.0 < titleSize.height && 0.0 < messageSize.height) {
    contentInternalVerticalPadding = MDCDialogContentVerticalPadding;
  }
  CGFloat contentHeight = titleSize.height + contentInternalVerticalPadding + messageSize.height;
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
  CGSize verticalSize = [self actionButtonsSizeInVericalLayout];

  CGSize actionsSize;
  if (boundsSize.width < horizontalSize.width) {
    // Use VerticalLayout
    actionsSize.width = MIN(verticalSize.width, boundsSize.width);
    actionsSize.height = MIN(verticalSize.height, boundsSize.height);
  } else {
    // Use HorizontalLayout
    actionsSize.width = MIN(horizontalSize.width, boundsSize.width);
    actionsSize.height = MIN(horizontalSize.height, boundsSize.height);
  }

  actionsSize.width = (CGFloat)ceil(actionsSize.width);
  actionsSize.height = (CGFloat)ceil(actionsSize.height);

  return actionsSize;
}


- (void)layoutSubviews {
  [super layoutSubviews];

  for (UIButton *button in self.actionButtons) {
    [button sizeToFit];
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
  CGSize messageSize = [self.messageLabel sizeThatFits:boundsSize];
  messageSize.width = boundsSize.width;
  boundsSize.width = boundsSize.width + MDCDialogContentInsets.left + MDCDialogContentInsets.right;

  CGFloat contentInternalVerticalPadding = 0.0;
  if (0.0 < titleSize.height && 0.0 < messageSize.height) {
    contentInternalVerticalPadding = MDCDialogContentVerticalPadding;
  }

  CGRect titleFrame = CGRectMake(MDCDialogContentInsets.left, MDCDialogContentInsets.top,
                                 titleSize.width, titleSize.height);
  CGRect messageFrame = CGRectMake(MDCDialogContentInsets.left,
                                   CGRectGetMaxY(titleFrame) + contentInternalVerticalPadding,
                                   messageSize.width, messageSize.height);

  self.titleLabel.frame = titleFrame;
  self.messageLabel.frame = messageFrame;

  // Actions
  CGSize actionSize = [self calculateActionsSizeThatFitsWidth:boundsSize.width];
  const CGFloat horizontalActionHeight =
  MDCDialogActionsInsets.top + MDCDialogActionButtonHeight + MDCDialogActionsInsets.bottom;
  if (horizontalActionHeight < actionSize.height) {
    self.verticalActionsLayout = YES;
  } else {
    self.verticalActionsLayout = NO;
  }

  CGRect actionsFrame = CGRectZero;
  actionsFrame.size.width = CGRectGetWidth(self.bounds);
  if (0 < [self.actionButtons count]) {
    actionsFrame.size.height = actionSize.height;
  }
  self.actionsScrollView.contentSize = actionsFrame.size;

  // Place buttons in actionsScrollView
  if (self.isVerticalActionsLayout) {
    CGPoint buttonCenter;
    buttonCenter.x = self.actionsScrollView.contentSize.width * 0.5f;
    buttonCenter.y = self.actionsScrollView.contentSize.height - MDCDialogActionsInsets.bottom;
    for (UIButton *button in self.actionButtons) {
      CGRect buttonRect = button.frame;

      buttonCenter.y -= buttonRect.size.height * 0.5;

      button.center = buttonCenter;

      if (button != [self.actionButtons lastObject]) {
        buttonCenter.y -= buttonRect.size.height * 0.5;
        buttonCenter.y -= MDCDialogActionsVerticalPadding;
      }
    }
  } else {
    CGPoint buttonOrigin = CGPointZero;
    buttonOrigin.x = self.actionsScrollView.contentSize.width - MDCDialogActionsInsets.right;
    buttonOrigin.y = MDCDialogActionsInsets.top;
    for (UIButton *button in self.actionButtons) {
      CGRect buttonRect = button.frame;

      buttonOrigin.x -= buttonRect.size.width;
      buttonRect.origin = buttonOrigin;

      button.frame = buttonRect;

      if (button != [self.actionButtons lastObject]) {
        buttonOrigin.x -= MDCDialogActionsHorizontalPadding;
      }
    }
    // Handle RTL
    if (self.mdf_effectiveUserInterfaceLayoutDirection ==
        UIUserInterfaceLayoutDirectionRightToLeft) {
      for (UIButton *button in self.actionButtons) {
        CGRect flippedRect =
          MDFRectFlippedHorizontally(button.frame, CGRectGetWidth(self.bounds));
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
    if (CGRectGetHeight(contentScrollViewRect) < CGRectGetHeight(self.bounds) * 0.5f) {
      actionsScrollViewRect.size.height =
      CGRectGetHeight(self.bounds) - contentScrollViewRect.size.height;
    } else {
      CGFloat maxActionsHeight = CGRectGetHeight(self.bounds) * 0.5f;
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

  for (MDCFlatButton *button in _actionButtons) {
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
