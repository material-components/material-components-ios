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

#import "MDCButton.h"
#import "MDCAlertController.h"
#import "MDCAlertControllerView.h"
#import "MDCAlertActionManager.h"
#import "MDCAlertControllerView+Private.h"
#import "M3CButton.h"

#import "MDCShadowElevations.h"
#import "MDCFontTextStyle.h"
#import "MDCTypography.h"
#import "UIFont+MaterialTypography.h"
#import "MDCMath.h"
#import <MDFInternationalization/MDFInternationalization.h>

// https://material.io/go/design-dialogs#dialogs-specs
static const MDCFontTextStyle kTitleTextStyle = MDCFontTextStyleTitle;
static const MDCFontTextStyle kMessageTextStyle = MDCFontTextStyleBody1;

static const CGFloat MDCDialogMaximumWidth = 560.0f;
static const CGFloat MDCDialogMinimumWidth = 280.0f;

static const CGFloat MDCDialogActionButtonMinimumHeight = 36.0f;
static const CGFloat MDCDialogActionButtonMinimumWidth = 48.0f;
static const CGFloat MDCDialogActionMinTouchTarget = 48.0f;

static const CGFloat MDCDialogMessageOpacity = 0.54f;

/** KVO context for this file. */
static char *const kKVOContextMDCAlertControllerViewPrivate =
    "kKVOContextMDCAlertControllerViewPrivate";

/** Calculates the minimum text height for a single line text using device metrics. */
static CGFloat SingleLineTextViewHeight(NSString *_Nullable title, UIFont *_Nullable font) {
  if (title.length == 0) {
    return font.lineHeight;
  }

  NSDictionary<NSAttributedStringKey, id> *attributes =
      font == nil ? nil : @{NSFontAttributeName : font};
  CGRect boundingRect = [title boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                                            options:NSStringDrawingUsesDeviceMetrics
                                         attributes:attributes
                                            context:nil];
  // Some text height may exceed the UIFont.lineHeight.
  // https://developer.apple.com/documentation/uikit/uifont?language=objc
  // --------------------
  //  |               |
  //  | <= ascender   |
  //  |               | <= lineHeight
  // -----------------|
  //  | <= descender  |
  // --------------------
  // UIFont.lineHeight consist of UIFont.ascender and UIFont.descender. UIFont.descender is the
  // bottom offset from the baseline. The boundingRect.origin.y is the amount of space the text will
  // occupy in UIFont.descender. So the minimum text view line height is text height + the leftover
  // space in the UIFont.descender not occupied by the rendered text.
  CGFloat bottomPadding = boundingRect.origin.y - font.descender;
  return boundingRect.size.height + bottomPadding;
}

@interface MDCNonselectableTextView : UITextView
@end

@interface MDCAlertControllerView ()

@property(nonatomic, getter=isVerticalActionsLayout) BOOL verticalActionsLayout;

@property(nonatomic, strong, nullable) UIColor *buttonColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, strong, nullable) UIColor *buttonInkColor UI_APPEARANCE_SELECTOR;
@property(nonatomic, assign) BOOL enableRippleBehavior;

/** The most recent VoiceOver-assigned contentOffset for the contentScrollView whose x and
 * y values were positive. */
@property(nonatomic, assign) CGPoint contentScrollViewLastValidVoiceOverContentOffset;

@end

@implementation MDCAlertControllerView {
}

@synthesize adjustsFontForContentSizeCategory = _adjustsFontForContentSizeCategory;

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.autoresizesSubviews = NO;
    self.clipsToBounds = YES;
    self.shouldGroupAccessibilityChildren = YES;
    self.titlePinsToTop = YES;

    self.orderVerticalActionsByEmphasis = NO;
    self.actionsHorizontalAlignment = MDCContentHorizontalAlignmentTrailing;
    self.actionsHorizontalAlignmentInVerticalLayout = MDCContentHorizontalAlignmentCenter;

    self.titleIconInsets = UIEdgeInsetsMake(24.0f, 24.0f, 12.0f, 24.0f);
    self.titleInsets = UIEdgeInsetsMake(24.0f, 24.0f, 20.0f, 24.0f);
    self.contentInsets = UIEdgeInsetsMake(24.0f, 24.0f, 24.0f, 24.0f);
    self.actionsInsets = UIEdgeInsetsMake(8.0f, 8.0f, 8.0f, 8.0f);
    self.M3CButtonActionsInsets = UIEdgeInsetsMake(24.0f, 24.0f, 24.0f, 24.0f);
    self.actionsHorizontalMargin = 8.0f;
    self.M3CButtonActionsVerticalMargin = 8.0f;
    self.actionsVerticalMargin = 12.0f;
    self.accessoryViewVerticalInset = 20.0f;
    self.accessoryViewHorizontalInset = 0.0f;

    self.contentScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    self.titleView = [[UIView alloc] initWithFrame:CGRectZero];
    // If the title pins to the bounds, it is a fixed view placed outside of any scroll views.
    // Otherwise, it gets added to the content scroll view.
    if (self.titlePinsToTop) {
      [self addSubview:self.titleView];
    } else {
      [self.contentScrollView addSubview:self.titleView];
    }
    [self addSubview:self.contentScrollView];
    self.contentScrollViewLastValidVoiceOverContentOffset = CGPointZero;
    [self.contentScrollView addObserver:self
                             forKeyPath:NSStringFromSelector(@selector(contentOffset))
                                options:NSKeyValueObservingOptionNew
                                context:kKVOContextMDCAlertControllerViewPrivate];

    self.actionsScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    [self addSubview:self.actionsScrollView];

    // Set the background color after all surface subviews are added.
    self.backgroundColor = [UIColor whiteColor];

    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textAlignment = NSTextAlignmentNatural;
    self.titleLabel.font = [MDCTypography titleFont];
    self.titleLabel.adjustsFontForContentSizeCategory = self.adjustsFontForContentSizeCategory;
    self.titleLabel.accessibilityTraits |= UIAccessibilityTraitHeader;
    [self.titleView addSubview:self.titleLabel];

    self.messageTextView = [[MDCNonselectableTextView alloc] initWithFrame:CGRectZero];
    self.messageTextView.textAlignment = NSTextAlignmentNatural;
    self.messageTextView.textContainerInset = UIEdgeInsetsZero;
    self.messageTextView.textContainer.lineFragmentPadding = 0.0f;
    self.messageTextView.editable = NO;
    self.messageTextView.scrollEnabled = NO;
    self.messageTextView.selectable = YES;  // Enables link tap.
    self.messageTextView.font = [MDCTypography body1Font];
    self.messageTextView.adjustsFontForContentSizeCategory = self.adjustsFontForContentSizeCategory;
    self.messageTextView.textColor = [UIColor colorWithWhite:0 alpha:MDCDialogMessageOpacity];
    // The messageTextView is a private API, and therefore it needs to inherit its background
    // color from the alert's background so it can be themed (necessary for dark mode support,
    // for instance).
    self.messageTextView.backgroundColor = UIColor.clearColor;
    [self.contentScrollView addSubview:self.messageTextView];
    _M3CButtonEnabled = NO;

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
  self.titleView.backgroundColor = backgroundColor;
  self.contentScrollView.backgroundColor = backgroundColor;
  self.actionsScrollView.backgroundColor = backgroundColor;
}

- (UIColor *)backgroundColor {
  return super.backgroundColor;
}

- (void)addActionButton:(nonnull UIButton *)button {
  if (button.superview == nil) {
    [self.actionsScrollView addSubview:button];
    if (_buttonColor) {
      // We only set if _buttonColor since settingTitleColor to nil doesn't
      // reset the title to the default
      [button setTitleColor:_buttonColor forState:UIControlStateNormal];
    }
    if (!self.isM3CButtonEnabled) {
      MDCButton *castedButton = (MDCButton *)button;
      castedButton.enableRippleBehavior = self.enableRippleBehavior;
      castedButton.inkColor = self.buttonInkColor;
      // These two lines must be after @c setTitleFont:forState: in order to @c MDCButton to handle
      // dynamic type correctly.
      castedButton.titleLabel.adjustsFontForContentSizeCategory =
          self.adjustsFontForContentSizeCategory;
      // TODO(#1726): Determine default text color values for Normal and Disabled
      castedButton.minimumSize =
          CGSizeMake(MDCDialogActionButtonMinimumWidth, MDCDialogActionButtonMinimumHeight);
      // Set centerVisibleArea to YES by default.
      castedButton.centerVisibleArea = YES;
    }
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
    [self.titleView addSubview:self.titleIconImageView];
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

- (void)setTitleIconAlignment:(NSTextAlignment)titleIconAlignment {
  _titleIconAlignment = titleIconAlignment;
  [self setNeedsLayout];
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
      [self.titleView addSubview:_titleIconView];
    }
    [self setNeedsLayout];
  }
}

- (NSString *)message {
  return self.messageTextView.text;
}

- (void)setMessage:(NSString *)message {
  self.messageTextView.text = message;

  [self setNeedsLayout];
}

- (void)setMessageFont:(UIFont *)messageFont {
  _messageFont = messageFont;

  [self updateMessageFont];
}

- (void)updateMessageFont {
  UIFont *messageFont = self.messageFont ?: [[self class] messageFontDefault];

  self.messageTextView.font = messageFont;
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

  _messageTextView.textColor = messageColor;
}

- (NSTextAlignment)messageAlignment {
  return self.messageTextView.textAlignment;
}

- (void)setMessageAlignment:(NSTextAlignment)messageAlignment {
  self.messageTextView.textAlignment = messageAlignment;
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

- (void)updateButtonFont {
  if (!self.isM3CButtonEnabled) {
    for (MDCButton *button in self.actionManager.buttonsInActionOrder) {
      UIFont *buttonFont;
      if (button.enableTitleFontForState) {
        buttonFont = [button titleFontForState:UIControlStateNormal];
      } else {
        buttonFont = button.titleLabel.font;
      }
      if (button.enableTitleFontForState) {
        [button setTitleFont:buttonFont forState:UIControlStateNormal];
      } else {
        button.titleLabel.font = buttonFont;
      }
    }

    [self setNeedsLayout];
  }
}

- (void)setButtonColor:(UIColor *)color {
  _buttonColor = color;
  if (!self.isM3CButtonEnabled) {
    for (MDCButton *button in self.actionManager.buttonsInActionOrder) {
      [button setTitleColor:_buttonColor forState:UIControlStateNormal];
    }
  }
}

- (void)setButtonInkColor:(UIColor *)color {
  _buttonInkColor = color;

  if (!self.isM3CButtonEnabled) {
    for (MDCButton *button in self.actionManager.buttonsInActionOrder) {
      button.inkColor = color;
    }
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

  if (!self.isM3CButtonEnabled) {
    for (MDCButton *button in self.actionManager.buttonsInActionOrder) {
      button.enableRippleBehavior = enableRippleBehavior;
    }
  }
}

- (void)setTitlePinsToTop:(BOOL)titlePinsToTop {
  if (titlePinsToTop == _titlePinsToTop) {
    return;
  }
  _titlePinsToTop = titlePinsToTop;
  [self.titleView removeFromSuperview];
  if (_titlePinsToTop) {
    [self addSubview:self.titleView];
  } else {
    [self.contentScrollView addSubview:self.titleView];
  }
  [self setNeedsLayout];
}

#pragma mark - Internal

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey, id> *)change
                       context:(void *)context {
  if (context == kKVOContextMDCAlertControllerViewPrivate) {
    if (UIAccessibilityIsVoiceOverRunning() && (object == self.contentScrollView)) {
      // For some reason, VoiceOver sets a contentOffset with negative x and y values on
      // self.contentScrollView when the user navigates through the text in
      // self.messageTextView word by word in landscape. This results in the text VoiceOver is
      // focusing on to not be visible. This code remembers the contentOffsets with positive x and y
      // values that VoiceOver sets, and re-applies them when it finds that VoiceOver has set ones
      // with negative x and y values. (b/181607796)
      CGPoint contentOffset = self.contentScrollView.contentOffset;
      BOOL isValidContentOffset = (contentOffset.x >= 0 && contentOffset.y >= 0);
      if (isValidContentOffset) {
        self.contentScrollViewLastValidVoiceOverContentOffset = contentOffset;
      } else {
        self.contentScrollView.contentOffset =
            self.contentScrollViewLastValidVoiceOverContentOffset;
      }
    }
  }
}

- (CGSize)actionFittingSizeInHorizontalLayout {
  CGSize size = CGSizeMake([self horizontalSpacing], 0.0f);
  NSArray<UIButton *> *buttons = self.actionManager.buttonsInActionOrder;
  UIEdgeInsets actionsInsets = [self actionsInsetsForButtons:buttons isHorizontalLayout:YES];
  if (0 < buttons.count) {
    CGFloat maxButtonHeight =
        MAX(MDCDialogActionButtonMinimumHeight, MDCDialogActionMinTouchTarget);
    for (UIButton *button in buttons) {
      CGSize buttonSize = [button sizeThatFits:size];
      size.width += buttonSize.width;
      maxButtonHeight = MAX(maxButtonHeight, buttonSize.height);
    }
    size.height = actionsInsets.top + maxButtonHeight + actionsInsets.bottom;
  }

  NSUInteger count = self.actionManager.buttonsInActionOrder.count;
  if (self.actionsHorizontalAlignment == MDCContentHorizontalAlignmentJustified) {
    size.width = [self widestAction] * count + [self horizontalSpacing];
  }

  return size;
}

- (CGSize)actionButtonsSizeInVerticalLayout {
  CGSize size = CGSizeZero;
  NSArray<UIButton *> *buttons = self.actionManager.buttonsInActionOrder;
  UIEdgeInsets actionsInsets = [self actionsInsetsForButtons:buttons isHorizontalLayout:NO];
  if (0 < buttons.count) {
    size.height = actionsInsets.top + actionsInsets.bottom;
    CGFloat widthInset = actionsInsets.left + actionsInsets.right;
    for (NSUInteger index = 0; index < buttons.count; ++index) {
      UIButton *button = buttons[index];
      CGSize buttonSize = [button sizeThatFits:size];
      CGFloat minButtonHeight =
          MAX(MDCDialogActionButtonMinimumHeight, MDCDialogActionMinTouchTarget);
      buttonSize.height = MAX(buttonSize.height, minButtonHeight);
      size.height += buttonSize.height;
      size.width = MAX(size.width, buttonSize.width + widthInset);
      if (button != buttons.lastObject) {
        UIButton *nextButton = buttons[index + 1];
        CGFloat verticalMargin = [self actionsVerticalMarginBetweenTopButton:button
                                                                bottomButton:nextButton];
        size.height += verticalMargin;
      }
    }
  }

  return size;
}

- (UIEdgeInsets)actionsInsetsForButtons:(NSArray<UIButton *> *)buttons
                     isHorizontalLayout:(BOOL)isHorizontalLayout {
  UIEdgeInsets actionInsets = self.actionsInsets;

  if (self.isM3CButtonEnabled) {
    return self.M3CButtonActionsInsets;
  }

  if (buttons.count == 0) {
    return actionInsets;
  }

  if (isHorizontalLayout) {
    CGFloat maxButtonHeight = MDCDialogActionButtonMinimumHeight;
    for (UIButton *button in buttons) {
      CGSize buttonSize = [button sizeThatFits:CGSizeZero];
      maxButtonHeight = MAX(maxButtonHeight, buttonSize.height);
    }
    if (maxButtonHeight < MDCDialogActionMinTouchTarget) {
      // Adjust actionInsets when buttons don't meet the minimum touch area requirement.
      CGFloat verticalInsetsAdjustment = MDCDialogActionMinTouchTarget - maxButtonHeight;
      actionInsets.top -= verticalInsetsAdjustment / 2;
      actionInsets.bottom -= verticalInsetsAdjustment / 2;
    }
  } else {
    UIButton *topButton = buttons.firstObject;
    CGSize topButtonSize = [topButton sizeThatFits:CGSizeZero];
    if (topButtonSize.height < MDCDialogActionMinTouchTarget) {
      CGFloat verticalInsetsAdjustment = MDCDialogActionMinTouchTarget - topButtonSize.height;
      actionInsets.top -= verticalInsetsAdjustment / 2;
    }
    UIButton *bottomButton = buttons.lastObject;
    CGSize bottomButtonSize = [bottomButton sizeThatFits:CGSizeZero];
    if (bottomButtonSize.height < MDCDialogActionMinTouchTarget) {
      CGFloat verticalInsetsAdjustment = MDCDialogActionMinTouchTarget - bottomButtonSize.height;
      actionInsets.bottom -= verticalInsetsAdjustment / 2;
    }
  }

  return actionInsets;
}

- (CGFloat)actionsVerticalMarginBetweenTopButton:(UIButton *)topButton
                                    bottomButton:(UIButton *)bottomButton {
  CGFloat actionsVerticalMargin = self.M3CButtonActionsVerticalMargin;

  CGSize topButtonSize = [topButton sizeThatFits:CGSizeZero];
  CGSize bottomButtonSize = [bottomButton sizeThatFits:CGSizeZero];
  if (!self.isM3CButtonEnabled) {
    actionsVerticalMargin = self.actionsVerticalMargin;
    if (topButtonSize.height < MDCDialogActionMinTouchTarget) {
      CGFloat verticalInsetsAdjustment = MDCDialogActionMinTouchTarget - topButtonSize.height;
      actionsVerticalMargin -= verticalInsetsAdjustment / 2;
    }
    if (bottomButtonSize.height < MDCDialogActionMinTouchTarget) {
      CGFloat verticalInsetsAdjustment = MDCDialogActionMinTouchTarget - bottomButtonSize.height;
      actionsVerticalMargin -= verticalInsetsAdjustment / 2;
    }
  }
  return actionsVerticalMargin;
}

- (CGFloat)horizontalSpacing {
  NSUInteger count = self.actionManager.buttonsInActionOrder.count;
  CGFloat spacing = self.actionsInsets.left + self.actionsInsets.right +
                    (count - 1) * self.actionsHorizontalMargin;
  return spacing;
}

- (CGFloat)widestAction {
  CGFloat widest = 0.0f;

  if (self.isM3CButtonEnabled) {
    for (M3CButton *button in self.actionManager.buttonsInActionOrder) {
      CGSize buttonSize = [button sizeThatFits:CGSizeZero];
      if (buttonSize.width > widest) {
        widest = buttonSize.width;
      }
    }
  } else {
    for (MDCButton *button in self.actionManager.buttonsInActionOrder) {
      // For justified alignment, minimumSize is used to control button's visible area.
      // If user sets a custom value, it is ignored because button's final size is decided
      // during layout.
      // We need to reset minimumSize during sizeThatFits: to make sure it doesn't affect the
      // calculation here.
      CGSize currentMinimumSize = CGSizeZero;
      if (self.actionsHorizontalAlignment == MDCContentHorizontalAlignmentJustified) {
        currentMinimumSize = button.minimumSize;
        button.minimumSize =
            CGSizeMake(MDCDialogActionButtonMinimumWidth, MDCDialogActionButtonMinimumHeight);
      }
      CGSize buttonSize = [button sizeThatFits:CGSizeZero];
      if (buttonSize.width > widest) {
        widest = buttonSize.width;
      }
      if (self.actionsHorizontalAlignment == MDCContentHorizontalAlignmentJustified) {
        button.minimumSize = currentMinimumSize;
      }
    }
  }
  return widest;
}

- (BOOL)hasTitleIconOrImage {
  return [self hasTitleIcon] || self.titleIconView != nil;
}

- (BOOL)hasTitleIcon {
  return self.titleIconImageView.image.size.height > 0.0f;
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

- (CGSize)messageTextViewSizeThatFits:(CGSize)size {
  // Returns a size of zero when there's no message, to ensure no space is reserved for it.
  return [self.messageTextView hasText] ? [self.messageTextView sizeThatFits:size] : CGSizeZero;
}

/** Return the space between the title and the title icon, or 0 if any of them is missing. */
- (CGFloat)titleIconInsetBottom {
  return [self hasTitleIconOrImage] && [self hasTitle] ? self.titleIconInsets.bottom : 0.0f;
}

- (CGFloat)titleInsetTop {
  return [self hasTitleIconOrImage] ? self.titleIconInsets.top
                                    : ([self hasTitle] ? self.titleInsets.top : 0.f);
}

- (CGFloat)titleInsetBottom {
  return ([self hasTitle] || [self hasTitleIconOrImage]) ? self.titleInsets.bottom : 0.0f;
}

- (CGFloat)contentInsetTop {
  return ([self hasTitle] || [self hasTitleIconOrImage]) ? 0.0f : self.contentInsets.top;
}

- (CGFloat)accessoryVerticalInset {
  return ([self hasMessage] && [self hasAccessoryView]) ? self.accessoryViewVerticalInset : 0.0f;
}

// Returns the size of the title view or the current size of the title icon imageView.
- (CGSize)titleIconViewSize {
  if (self.titleIconView != nil) {
    return self.titleIconView.frame.size;
  } else if (self.titleIconImageView != nil) {
    return self.titleIconImageView.frame.size;
  }
  return CGSizeZero;
}

// Returns the size of the title view or the original size of the title icon image.
- (CGSize)titleIconImageSize {
  if (self.titleIconView != nil) {
    return self.titleIconView.frame.size;
  } else if (self.titleIcon != nil) {
    return self.titleIcon.size;
  }
  return CGSizeZero;
}

- (CGRect)titleFrameWithTitleSize:(CGSize)titleSize {
  CGFloat leftInset = self.titleInsets.left;
  CGFloat titleTop =
      [self titleIconViewSize].height + [self titleInsetTop] + [self titleIconInsetBottom];
  return CGRectMake(leftInset, titleTop, titleSize.width, titleSize.height);
}

- (CGFloat)messageTopInsetWithTitleFrame:(CGRect)titleFrame {
  return CGRectGetMaxY(titleFrame) + [self titleInsetBottom];
}

- (CGRect)messageFrameWithMessageSize:(CGSize)messageSize titleFrame:(CGRect)titleFrame {
  CGFloat top = self.titlePinsToTop
                    ? [self contentInsetTop]
                    : [self messageTopInsetWithTitleFrame:titleFrame] + [self contentInsetTop];
  return CGRectMake(self.contentInsets.left, top, messageSize.width, messageSize.height);
}

/**
 Calculate the frame of the titleIcon, given the title size and bounds size.

 @param titleSize is the pre-calculated size of the title.
 @param boundsSize is the total bounds without any internal margins or padding.
*/
- (CGRect)titleIconFrameWithTitleSize:(CGSize)titleSize boundsSize:(CGSize)boundsSize {
  CGSize titleIconViewSize = [self titleIconImageSize];
  CGFloat leftInset = self.titleIconInsets.left;
  CGFloat topInset = self.titleIconInsets.top;
  CGFloat titleIconHeight = titleIconViewSize.height;
  CGFloat titleIconWidth = titleIconViewSize.width;
  BOOL isRightOrRTLNatural =
      (self.titleIconAlignment == NSTextAlignmentRight ||
       (self.titleIconAlignment == NSTextAlignmentNatural &&
        [self effectiveUserInterfaceLayoutDirection] == UIUserInterfaceLayoutDirectionRightToLeft));

  if (self.titleIconAlignment == NSTextAlignmentJustified) {
    // Justified images are sized to fit the alert's width (minus the insets).
    titleIconWidth = boundsSize.width - leftInset - self.titleIconInsets.right;
    if (titleIconViewSize.width > titleIconWidth && [self hasTitleIcon]) {
      // If the width decreased, then decrease the height proportionally.
      titleIconHeight *= titleIconWidth / titleIconViewSize.width;
    }
  } else {
    CGRect titleFrame = [self titleFrameWithTitleSize:titleSize];
    if (self.titleIconAlignment == NSTextAlignmentCenter) {
      leftInset =
          CGRectGetMinX(titleFrame) + (CGRectGetWidth(titleFrame) - titleIconViewSize.width) / 2.0f;
    } else if (isRightOrRTLNatural) {
      leftInset = CGRectGetMaxX(titleFrame) - titleIconViewSize.width;
    }
  }

  return CGRectMake(leftInset, topInset, titleIconWidth, titleIconHeight);
}

// @param boundsSize should not include any internal margins or padding
- (CGSize)calculatePreferredContentSizeForBounds:(CGSize)boundsSize {
  // Even if we have more room, limit our maximum width
  boundsSize.width = MIN(MAX(boundsSize.width, MDCDialogMinimumWidth), MDCDialogMaximumWidth);

  // Title, Content & Actions
  CGSize titleViewSize = [self calculateTitleViewSizeThatFitsWidth:boundsSize.width];
  CGSize contentSize = [self calculateContentSizeThatFitsWidth:boundsSize.width];
  CGSize actionSize = [self calculateActionsSizeThatFitsWidth:boundsSize.width];

  // Final Sizing
  CGSize totalSize;
  totalSize.width = MAX(MAX(titleViewSize.width, MAX(contentSize.width, actionSize.width)),
                        MDCDialogMinimumWidth);
  totalSize.height = titleViewSize.height + contentSize.height + actionSize.height;

  return totalSize;
}

// @param boundingWidth should not include any internal margins or padding
- (CGSize)calculateContentSizeThatFitsWidth:(CGFloat)boundingWidth {
  CGFloat contentInsets = self.contentInsets.left + self.contentInsets.right;
  if (self.accessoryViewHorizontalInset > 0) {
    contentInsets += self.accessoryViewHorizontalInset * 2.0;
  }
  CGFloat titleInsets = self.titleInsets.left + self.titleInsets.right;
  CGSize boundsSize = CGRectInfinite.size;

  boundsSize.width = boundingWidth - titleInsets;
  CGFloat titleWidth = [self.titleLabel sizeThatFits:boundsSize].width;

  boundsSize.width = boundingWidth - contentInsets;

  CGSize messageSize = [self messageTextViewSizeThatFits:boundsSize];
  CGSize accessoryViewSize = [self.accessoryView systemLayoutSizeFittingSize:boundsSize];

  CGFloat maxWidth = MAX(messageSize.width, accessoryViewSize.width);
  CGFloat contentWidth = MAX(titleWidth + titleInsets, maxWidth + contentInsets);

  // Recalculate the accessory view size using the `boundingWidth` to ensure the height calculated
  // here matches what layoutSubviews will use for the frame.
  accessoryViewSize =
      [self.accessoryView systemLayoutSizeFittingSize:boundsSize
                        withHorizontalFittingPriority:UILayoutPriorityRequired
                              verticalFittingPriority:UILayoutPriorityFittingSizeLevel];

  CGFloat totalElementsHeight = messageSize.height + accessoryViewSize.height;
  CGFloat contentHeight = (fabs(contentWidth) <= FLT_EPSILON) || totalElementsHeight <= FLT_EPSILON
                              ? 0.0f
                              : totalElementsHeight + [self accessoryVerticalInset] +
                                    self.contentInsets.bottom + [self contentInsetTop];

  return CGSizeMake((CGFloat)ceil(contentWidth), (CGFloat)ceil(contentHeight));
}

/**
 Calculate the size of the title frame, which includes an optional title, optional title icon and
 optional icon view.

 @param boundingWidth should not include any internal margins or padding
*/
- (CGSize)calculateTitleViewSizeThatFitsWidth:(CGFloat)boundingWidth {
  CGFloat contentInsets = self.contentInsets.left + self.contentInsets.right;
  CGFloat titleInsets = self.titleInsets.left + self.titleInsets.left;

  CGSize contentSize = CGRectInfinite.size;
  contentSize.width = boundingWidth - contentInsets;
  CGFloat messageWidth = [self messageTextViewSizeThatFits:contentSize].width;
  CGFloat contentWidth =
      MAX(messageWidth, [self.accessoryView systemLayoutSizeFittingSize:contentSize].width);

  CGSize titleViewSize = CGRectInfinite.size;
  titleViewSize.width = boundingWidth - titleInsets;
  CGSize titleLabelSize = [self.titleLabel sizeThatFits:titleViewSize];
  CGSize titleIconSize = [self titleIconViewSize];
  CGFloat titleViewWidth = MAX(titleLabelSize.width + titleInsets, contentWidth + contentInsets);

  CGFloat totalElementsHeight = titleIconSize.height + titleLabelSize.height;
  CGFloat titleHeight = totalElementsHeight + [self titleInsetTop] + [self titleIconInsetBottom] +
                        [self titleInsetBottom];

  return CGSizeMake((CGFloat)ceil(titleViewWidth), (CGFloat)ceil(titleHeight));
}

// @param boundingWidth should not include any internal margins or padding
- (CGSize)calculateActionsSizeThatFitsWidth:(CGFloat)boundingWidth {
  CGSize boundsSize = CGRectInfinite.size;
  boundsSize.width = boundingWidth;

  CGSize horizontalSize = [self actionFittingSizeInHorizontalLayout];
  CGSize verticalSize = [self actionButtonsSizeInVerticalLayout];

  BOOL isVertical = boundsSize.width < horizontalSize.width;
  CGSize actionsSize;
  if (isVertical) {
    // Use VerticalLayout
    actionsSize.width = MIN(verticalSize.width, boundsSize.width);
    actionsSize.height = MIN(verticalSize.height, boundsSize.height);
  } else {
    // Use HorizontalLayout
    actionsSize.width = MIN(horizontalSize.width, boundsSize.width);
    actionsSize.height = MIN(horizontalSize.height, boundsSize.height);
  }

  self.verticalActionsLayout = isVertical;
  actionsSize.width = (CGFloat)ceil(actionsSize.width);
  actionsSize.height = (CGFloat)ceil(actionsSize.height);

  return actionsSize;
}

- (BOOL)canBecomeFirstResponder {
  return YES;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  // Used to calculate the height of the scrolling content, so we limit the width.
  CGSize boundsSize = CGRectInfinite.size;
  boundsSize.width = CGRectGetWidth(self.bounds);

  // Calculate content and title sizes
  CGSize titleViewSize = [self calculateTitleViewSizeThatFitsWidth:boundsSize.width];

  CGRect titleViewRect = CGRectZero;
  titleViewRect.size.width = CGRectGetWidth(self.bounds);
  titleViewRect.size.height = titleViewSize.height;

  self.titleView.frame = titleViewRect;

  // Content
  CGSize contentSize = [self calculateContentSizeThatFitsWidth:boundsSize.width];

  CGRect contentRect = CGRectZero;
  contentRect.size.width = CGRectGetWidth(self.bounds);
  contentRect.size.height = contentSize.height;
  if (!self.titlePinsToTop) {
    contentRect.size.height += titleViewSize.height;
  }

  self.contentScrollView.contentSize = contentRect.size;

  // Place content in contentScrollView
  CGSize titleBoundsSize = boundsSize;
  titleBoundsSize.width = boundsSize.width - (self.titleInsets.left + self.titleInsets.right);
  CGSize titleSize = [self.titleLabel sizeThatFits:titleBoundsSize];
  titleSize.width = titleBoundsSize.width;

  CGSize contentBoundsSize = boundsSize;
  contentBoundsSize.width = boundsSize.width - (self.contentInsets.left + self.contentInsets.right);
  CGSize messageSize = [self messageTextViewSizeThatFits:contentBoundsSize];
  messageSize.width = contentBoundsSize.width;

  CGSize accessoryViewSize =
      [self.accessoryView systemLayoutSizeFittingSize:contentBoundsSize
                        withHorizontalFittingPriority:UILayoutPriorityRequired
                              verticalFittingPriority:UILayoutPriorityFittingSizeLevel];
  accessoryViewSize.width = contentBoundsSize.width;

  CGRect titleIconImageViewRect = [self titleIconFrameWithTitleSize:titleSize
                                                         boundsSize:boundsSize];
  if (self.titleIconView != nil) {
    self.titleIconView.frame = titleIconImageViewRect;
  } else if (self.titleIconImageView != nil) {
    // Match the title icon alignment to the title alignment.
    self.titleIconImageView.frame = titleIconImageViewRect;
  }

  // Calculate the title frame after the title icon size has been determined.
  CGRect titleFrame = [self titleFrameWithTitleSize:titleSize];

  CGRect messageFrame = [self messageFrameWithMessageSize:messageSize titleFrame:titleFrame];
  CGRect accessoryViewFrame = CGRectMake(
      self.contentInsets.left + self.accessoryViewHorizontalInset,
      CGRectGetMaxY(messageFrame) + [self accessoryVerticalInset],
      accessoryViewSize.width - self.accessoryViewHorizontalInset * 2.0, accessoryViewSize.height);

  self.titleLabel.frame = titleFrame;
  self.messageTextView.frame = messageFrame;
  self.accessoryView.frame = accessoryViewFrame;

  // Actions
  NSArray<UIButton *> *buttons = self.actionManager.buttonsInActionOrder;
  CGSize actionSize = [self calculateActionsSizeThatFitsWidth:boundsSize.width];

  CGRect actionsFrame = CGRectZero;
  actionsFrame.size.width = CGRectGetWidth(self.bounds);
  if (buttons.count > 0) {
    actionsFrame.size.height = actionSize.height;
  }
  self.actionsScrollView.contentSize = actionsFrame.size;

  for (UIButton *button in buttons) {
    [button sizeToFit];
    CGRect buttonFrame = button.frame;
    button.frame = CGRectMake(buttonFrame.origin.x, buttonFrame.origin.y,
                              MAX(MDCDialogActionMinTouchTarget, CGRectGetWidth(buttonFrame)),
                              MAX(MDCDialogActionMinTouchTarget, CGRectGetHeight(buttonFrame)));
  }

  if (self.isVerticalActionsLayout) {
    [self layoutVerticalButtons:buttons];
  } else {
    [self layoutHorizontalButtons:buttons actionSize:actionSize];
  }

  // Place scrollviews
  CGRect contentScrollViewRect = CGRectZero;
  contentScrollViewRect.size = self.contentScrollView.contentSize;
  contentScrollViewRect.origin.y =
      self.titlePinsToTop ? [self messageTopInsetWithTitleFrame:titleFrame] : 0.0f;

  CGRect actionsScrollViewRect = CGRectZero;
  actionsScrollViewRect.size = self.actionsScrollView.contentSize;
  actionsScrollViewRect.origin.y = CGRectGetHeight(self.bounds) - actionsScrollViewRect.size.height;

  const CGFloat requestedHeight = contentScrollViewRect.origin.y +
                                  self.contentScrollView.contentSize.height +
                                  self.actionsScrollView.contentSize.height;
  // Check the layout: do both content and actions fit on the screen at once?
  if (requestedHeight > CGRectGetHeight(self.bounds)) {
    // Actions take up max 1/2 Dialog height
    CGFloat maxActionsHeight = CGRectGetHeight(self.bounds) / 2.0f;
    CGFloat actionsHeight = MIN(maxActionsHeight, actionsScrollViewRect.size.height);
    actionsScrollViewRect.size.height = actionsHeight;
    actionsScrollViewRect.origin.y = CGRectGetHeight(self.bounds) - actionsHeight;
    contentScrollViewRect.size.height =
        MAX(0.f, CGRectGetHeight(self.bounds) - actionsScrollViewRect.size.height -
                     contentScrollViewRect.origin.y);

    self.messageTextView.accessibilityFrame = UIAccessibilityConvertFrameToScreenCoordinates(
        CGRectMake(messageFrame.origin.x, contentScrollViewRect.origin.y, messageFrame.size.width,
                   MIN(contentScrollViewRect.size.height, messageFrame.size.height)),
        self);
  }
  self.actionsScrollView.frame = actionsScrollViewRect;
  self.contentScrollView.frame = contentScrollViewRect;
}

- (void)layoutHorizontalButtons:(NSArray<UIButton *> *)buttons actionSize:(CGSize)actionSize {
  UIEdgeInsets actionsInsets = [self actionsInsetsForButtons:buttons isHorizontalLayout:YES];
  CGFloat maxButtonWidth =
      self.actionsScrollView.contentSize.width - (actionsInsets.left + actionsInsets.right);
  CGPoint buttonOrigin = CGPointZero;
  CGFloat buttonWidth = 0.f;
  CGFloat multiplier =
      self.actionsHorizontalAlignment == MDCContentHorizontalAlignmentLeading ? 1.f : -1.f;
  if (self.actionsHorizontalAlignment == MDCContentHorizontalAlignmentLeading) {
    buttonOrigin.x = actionsInsets.left;
  } else if (self.actionsHorizontalAlignment == MDCContentHorizontalAlignmentCenter) {
    CGFloat actionWidthNoInsets = actionSize.width - actionsInsets.left - actionsInsets.right;
    buttonOrigin.x = ((self.actionsScrollView.contentSize.width - actionWidthNoInsets) / 2.f) +
                     actionWidthNoInsets;
  } else {  // trailing or justified
    buttonOrigin.x = self.actionsScrollView.contentSize.width - actionsInsets.right;
  }
  buttonOrigin.y = actionsInsets.top;
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
      if (!self.isM3CButtonEnabled) {
        MDCButton *castedButton = (MDCButton *)button;
        // Adjust minimumSize based on maxButtonWidth to increase the visible area of button.
        castedButton.minimumSize = CGSizeMake(MAX(buttonWidth, MDCDialogActionButtonMinimumWidth),
                                              castedButton.minimumSize.height);
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
  if (self.effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
    for (UIButton *button in buttons) {
      CGRect flippedRect = MDFRectFlippedHorizontally(button.frame, CGRectGetWidth(self.bounds));
      button.frame = flippedRect;
    }
  }
}

- (void)layoutVerticalButtons:(NSArray<UIButton *> *)buttons {
  UIEdgeInsets actionsInsets = [self actionsInsetsForButtons:buttons isHorizontalLayout:NO];
  CGFloat maxButtonWidth =
      self.actionsScrollView.contentSize.width - (actionsInsets.left + actionsInsets.right);
  CGFloat multiplier = self.orderVerticalActionsByEmphasis ? 1.f : -1.f;
  CGPoint buttonCenter;
  CGPoint buttonOrigin;
  buttonOrigin.y = self.orderVerticalActionsByEmphasis
                       ? actionsInsets.top
                       : self.actionsScrollView.contentSize.height - actionsInsets.top;
  if (self.actionsHorizontalAlignmentInVerticalLayout == MDCContentHorizontalAlignmentCenter ||
      self.actionsHorizontalAlignmentInVerticalLayout == MDCContentHorizontalAlignmentJustified) {
    buttonCenter.x = self.actionsScrollView.contentSize.width / 2.0f;
    buttonCenter.y = buttonOrigin.y;
    for (NSUInteger index = 0; index < buttons.count; ++index) {
      UIButton *button = buttons[index];
      CGRect buttonRect = button.bounds;

      if (CGRectGetWidth(buttonRect) > maxButtonWidth ||
          self.actionsHorizontalAlignmentInVerticalLayout ==
              MDCContentHorizontalAlignmentJustified) {
        buttonRect.size.width = maxButtonWidth;
        button.bounds = buttonRect;
        if (self.actionsHorizontalAlignmentInVerticalLayout ==
            MDCContentHorizontalAlignmentJustified) {
          if (!self.isM3CButtonEnabled) {
            MDCButton *castedButton = (MDCButton *)button;
            // Adjust minimumSize based on maxButtonWidth to increase the visible area of button.
            castedButton.minimumSize =
                CGSizeMake(MAX(maxButtonWidth, MDCDialogActionButtonMinimumWidth),
                           castedButton.minimumSize.height);
          }
        }
      }

      buttonCenter.y += multiplier * (buttonRect.size.height / 2.0f);

      button.center = buttonCenter;

      if (button != buttons.lastObject) {
        buttonCenter.y += multiplier * (buttonRect.size.height / 2.0f);
        UIButton *nextButton = buttons[index + 1];
        CGFloat verticalMargin = [self actionsVerticalMarginBetweenTopButton:button
                                                                bottomButton:nextButton];
        buttonCenter.y += multiplier * verticalMargin;
      }
    }

  } else {  // Leading/Trailing alignment.
    for (NSUInteger index = 0; index < buttons.count; ++index) {
      UIButton *button = buttons[index];
      CGRect buttonRect = button.bounds;
      buttonOrigin.x = actionsInsets.left;
      if (self.actionsHorizontalAlignmentInVerticalLayout ==
          MDCContentHorizontalAlignmentTrailing) {
        buttonOrigin.x =
            self.actionsScrollView.contentSize.width - buttonRect.size.width - actionsInsets.right;
      }
      buttonRect.origin = buttonOrigin;
      button.frame = buttonRect;
      if (button != buttons.lastObject) {
        UIButton *nextButton = buttons[index + 1];
        CGFloat verticalMargin = [self actionsVerticalMarginBetweenTopButton:button
                                                                bottomButton:nextButton];
        buttonOrigin.y += multiplier * (buttonRect.size.height + verticalMargin);
      }
    }
    // Handle RTL
    if (self.effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft) {
      for (UIButton *button in buttons) {
        CGRect flippedRect = MDFRectFlippedHorizontally(button.frame, CGRectGetWidth(self.bounds));
        button.frame = flippedRect;
      }
    }
  }
}

#pragma mark - Dynamic Type

- (void)setAdjustsFontForContentSizeCategory:(BOOL)adjustsFontForContentSizeCategory {
  _adjustsFontForContentSizeCategory = adjustsFontForContentSizeCategory;
  self.titleLabel.adjustsFontForContentSizeCategory = adjustsFontForContentSizeCategory;
  for (UIButton *button in self.actionManager.buttonsInActionOrder) {
    button.titleLabel.adjustsFontForContentSizeCategory = adjustsFontForContentSizeCategory;
  }
  self.messageTextView.adjustsFontForContentSizeCategory = adjustsFontForContentSizeCategory;
}

// Update the fonts used based on whether Dynamic Type is enabled.
- (void)updateFonts {
  [self updateTitleFont];
  [self updateMessageFont];
  [self updateButtonFont];

  [self setNeedsLayout];
}

@end

@implementation MDCNonselectableTextView

#pragma mark - UITextView

- (void)setAttributedText:(NSAttributedString *)attributedText {
  if ([self.attributedText isEqual:attributedText]) {
    return;
  }

  [super setAttributedText:attributedText];
  [self updateTopInsetAndTextContainerInset:self.textContainerInset];
}

- (void)setFont:(UIFont *)font {
  if ([self.font isEqual:font]) {
    return;
  }

  [super setFont:font];
  [self updateTopInsetAndTextContainerInset:self.textContainerInset];
}

- (void)setText:(NSString *)text {
  if ([self.text isEqual:text]) {
    return;
  }

  [super setText:text];
  [self updateTopInsetAndTextContainerInset:self.textContainerInset];
}

- (void)setTextContainerInset:(UIEdgeInsets)textContainerInset {
  [self updateTopInsetAndTextContainerInset:textContainerInset];
}

#pragma mark - UIView

// Disabling text selection when selectable is YES, while allowing gestures for inlined links.
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
  if (UIAccessibilityIsVoiceOverRunning()) {
    return [super pointInside:point withEvent:event];
  }

  if (![super pointInside:point withEvent:event]) {
    return NO;
  }

  UITextPosition *position = [self closestPositionToPoint:point];
  if (!position) {
    return NO;
  }

  UITextRange *range = [self.tokenizer rangeEnclosingPosition:position
                                              withGranularity:UITextGranularityCharacter
                                                  inDirection:UITextLayoutDirectionLeft];
  if (!range) {
    return NO;
  }

  NSInteger offset = [self offsetFromPosition:self.beginningOfDocument toPosition:range.start];
  id link = [self.attributedText attribute:NSLinkAttributeName atIndex:offset effectiveRange:nil];
  return link != nil;
}

#pragma mark - Private

/**
 * Updates the top text inset of the UITextView to avoid rendering text outside the view
 * boundary. We need to calculate the text margin when we change the text or the text font.
 *
 * @note Our title UILabel already has a top margin, so its text won't exceed the parent view's
 * boundary.
 *
 * @param textContainerInset The target text insets to display. It will update the following text
 * margin: left, right and bottom.
 */
- (void)updateTopInsetAndTextContainerInset:(UIEdgeInsets)textContainerInset {
  // To avoid changing the top margin when the view width changes, we only compare the text height
  // for a single line text.
  UIFont *font = self.font;
  CGFloat singleLineTextViewHeight = SingleLineTextViewHeight(self.text, font);
  textContainerInset.top = MAX(0.0f, singleLineTextViewHeight - font.lineHeight);
  if (!UIEdgeInsetsEqualToEdgeInsets(super.textContainerInset, textContainerInset)) {
    // Note that |self setTextContainerInset:| will call this method.
    super.textContainerInset = textContainerInset;
  }
}

@end
