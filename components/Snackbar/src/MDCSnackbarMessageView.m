// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import <QuartzCore/QuartzCore.h>

#import "MaterialAnimationTiming.h"
#import "MaterialAvailability.h"
#import "MaterialButtons.h"
#import "MaterialElevation.h"
#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MDCSnackbarManager.h"
#import "MDCSnackbarMessage.h"
#import "MDCSnackbarMessageView.h"
#import "MDCSnackbarMessageViewInternal.h"
#import "MDCSnackbarOverlayView.h"
#import "MaterialSnackbarStrings.h"
#import "MaterialSnackbarStrings_table.h"
#import "MaterialTypography.h"
#import "MaterialMath.h"

NSString *const MDCSnackbarMessageTitleAutomationIdentifier =
    @"MDCSnackbarMessageTitleAutomationIdentifier";

// The Bundle for string resources.
static NSString *const kMaterialSnackbarBundle = @"MaterialSnackbar.bundle";

static inline UIColor *MDCRGBAColor(uint8_t r, uint8_t g, uint8_t b, float a) {
  return [UIColor colorWithRed:(r) / (CGFloat)255
                         green:(g) / (CGFloat)255
                          blue:(b) / (CGFloat)255
                         alpha:(a)];
}

/** Test whether any of the accessibility elements of a view is focused */
static BOOL UIViewHasFocusedAccessibilityElement(UIView *view) {
  for (NSInteger i = 0; i < [view accessibilityElementCount]; i++) {
    id accessibilityElement = [view accessibilityElementAtIndex:i];
    if ([accessibilityElement accessibilityElementIsFocused]) {
      return YES;
    }
  }
  return NO;
};

/**
 The thickness of the Snackbar border.
 */
static const CGFloat kBorderWidth = 0;

/**
 The radius of the corners.
 */
static const CGFloat kCornerRadius = 4;
static const CGFloat kLegacyCornerRadius = 0;

/**
 Padding between the edges of the Snackbar and any content.
 */
static const UIEdgeInsets kContentMarginSingleLineText = (UIEdgeInsets){6.0, 16.0, 6.0, 8.0};
static const UIEdgeInsets kContentMarginMutliLineText = (UIEdgeInsets){16.0, 16.0, 16.0, 8.0};
static const UIEdgeInsets kLegacyContentMargin = (UIEdgeInsets){18.0, 24.0, 18.0, 24.0};

/**
 Padding between the main title and the first button.
 */
static const CGFloat kTitleButtonPadding = 8;

/**
 Padding on the edges of the buttons.
 */
static const CGFloat kLegacyButtonPadding = 5;
static const CGFloat kButtonPadding = 8;

/**
 The width of the Snackbar.
 */
static const CGFloat kMinimumViewWidth_iPad = 288;
static const CGFloat kMaximumViewWidth_iPad = 568;
static const CGFloat kMinimumViewWidth_iPhone = 320;
static const CGFloat kMaximumViewWidth_iPhone = 320;

/**
 The maximimum ratio of the snackbar that can be occupied by the snackbar button.
 */
static const CGFloat kMaxButtonRatio = 0.333333;

/**
 The minimum height of the Snackbar.
 */
static const CGFloat kMinimumHeight = 48;

/**
 The minimum height of a multiline Snackbar.
 */
static const CGFloat kMinimumHeightMultiline = 68;

static const MDCFontTextStyle kMessageTextStyle = MDCFontTextStyleBody1;
static const MDCFontTextStyle kButtonTextStyle = MDCFontTextStyleButton;

/**
 The minimum font size at which to switch to a vertical layout for dynamic type. Picked to be 1
 larger then MDCFontTextStyleBody1 at the largest non-a11y size. Ideally we would not use a constant
 here, b/198825058 tracks work to make this more dynamic and less reliant on a magic number.
 */
static const CGFloat kMinimumAccessibiltyFontSize = 21;

#if MDC_AVAILABLE_SDK_IOS(10_0)
@interface MDCSnackbarMessageView () <CAAnimationDelegate>
@end
#endif  // MDC_AVAILABLE_SDK_IOS(10_0)

@interface MDCSnackbarMessageView ()

/**
 Holds the text label for the main message.
 */
@property(nonatomic, strong) UILabel *label;

/**
 The constraints managing this view.
 */
@property(nonatomic, strong) NSArray *viewConstraints;

/**
 The view containing all of the visual content. Inset by @c kBorderWidth from the view.
 */
@property(nonatomic, strong) UIControl *containerView;

/**
 The view containing the button view.
 */
@property(nonatomic, strong) UIView *buttonContainer;

/**
 The view containing the title view.
 */
@property(nonatomic, strong) UIView *contentView;

/**
 The accessibility element representing the dismissal touch affordance.
 */
@property(nonatomic, strong) UIButton *dismissalAccessibilityAffordance;

/**
 An invisible hit target to ensure that tapping the horizontal area between the button and the edge
 of the screen triggers a button tap instead of dismissing the snackbar.
 */
@property(nonatomic, strong) UIControl *buttonGutterTapTarget;

/**
 * The constraint for the snackbar button's width.
 */
@property(nonatomic, strong) NSLayoutConstraint *buttonWidthConstraint;

/**
 Holds onto the dismissal handler, called when the Snackbar should dismiss due to user interaction.
 */
@property(nonatomic, copy) MDCSnackbarMessageDismissHandler dismissalHandler;

@end

@interface MDCSnackbarMessageViewButton : MDCFlatButton
@end

@implementation MDCSnackbarMessageViewButton

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.inkColor = [UIColor colorWithWhite:1 alpha:(CGFloat)0.06];

    CGFloat buttonContentPadding =
        MDCSnackbarMessage.usesLegacySnackbar ? kLegacyButtonPadding : kButtonPadding;
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];

    // Style the text in the button.
    self.titleLabel.numberOfLines = 1;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.contentEdgeInsets = UIEdgeInsetsMake(buttonContentPadding, buttonContentPadding,
                                              buttonContentPadding, buttonContentPadding);
    // Minimum touch target size (44, 44).
    self.minimumSize = CGSizeMake(44, 44);
    // Make sure the button doesn't get too compressed.
    [self setContentCompressionResistancePriority:UILayoutPriorityRequired
                                          forAxis:UILayoutConstraintAxisHorizontal];
    [self setContentHuggingPriority:UILayoutPriorityDefaultHigh
                            forAxis:UILayoutConstraintAxisHorizontal];
  }
  return self;
}

@end

@implementation MDCSnackbarMessageView {
  UIFont *_messageFont;
  UIFont *_buttonFont;

  NSMutableDictionary<NSNumber *, UIColor *> *_buttonTitleColors;

  BOOL _shouldDismissOnOverlayTap;

  BOOL _isMultilineText;
}

@synthesize mdc_overrideBaseElevation = _mdc_overrideBaseElevation;
@synthesize mdc_elevationDidChangeBlock = _mdc_elevationDidChangeBlock;

- (instancetype)initWithFrame:(CGRect)frame {
  return [self initWithMessage:nil
                dismissHandler:nil
               snackbarManager:MDCSnackbarManager.defaultManager];
}

- (instancetype)initWithMessage:(MDCSnackbarMessage *)message
                 dismissHandler:(MDCSnackbarMessageDismissHandler)handler
                snackbarManager:(MDCSnackbarManager *)manager {
  self = [super initWithFrame:CGRectZero];

  if (self) {
    _snackbarMessageViewShadowColor = manager.snackbarMessageViewShadowColor ?: UIColor.blackColor;
    _snackbarMessageViewBackgroundColor =
        manager.snackbarMessageViewBackgroundColor ?: MDCRGBAColor(0x32, 0x32, 0x32, 1);
    _messageTextColor = manager.messageTextColor ?: UIColor.whiteColor;
    _buttonTitleColors = [NSMutableDictionary dictionary];
    _buttonTitleColors[@(UIControlStateNormal)] =
        [manager buttonTitleColorForState:UIControlStateNormal]
            ?: MDCRGBAColor(0xFF, 0xFF, 0xFF, (float)0.6);
    _buttonTitleColors[@(UIControlStateHighlighted)] =
        [manager buttonTitleColorForState:UIControlStateHighlighted] ?: UIColor.whiteColor;
#pragma clang diagnostic push
    _messageFont = manager.messageFont;
    _buttonFont = manager.buttonFont;
    _message = message;
    _shouldDismissOnOverlayTap = message.shouldDismissOnOverlayTap;
    _dismissalHandler = [handler copy];
    _mdc_overrideBaseElevation = manager.mdc_overrideBaseElevation;
    _enableDismissalAccessibilityAffordance = manager.enableDismissalAccessibilityAffordance;
    _traitCollectionDidChangeBlock = manager.traitCollectionDidChangeBlockForMessageView;
    _mdc_elevationDidChangeBlock = manager.mdc_elevationDidChangeBlockForMessageView;
    self.backgroundColor = _snackbarMessageViewBackgroundColor;
    if (MDCSnackbarMessage.usesLegacySnackbar) {
      self.layer.cornerRadius = kLegacyCornerRadius;
    } else {
      self.layer.cornerRadius = kCornerRadius;
    }
    _elevation = manager.messageElevation;
    [(MDCShadowLayer *)self.layer setElevation:_elevation];

    _anchoredToScreenBottom = YES;

    // Borders are drawn inside of the bounds of a layer. Because our border is translucent, we need
    // to have a view with transparent background and border only (@c self). Inside will be a
    // content view that has the dark grey color.
    _containerView = [[UIControl alloc] init];
    [self addSubview:_containerView];

    [_containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    _containerView.backgroundColor = [UIColor clearColor];
    _containerView.layer.cornerRadius =
        MDCSnackbarMessage.usesLegacySnackbar ? kLegacyCornerRadius : kCornerRadius;
    _containerView.layer.masksToBounds = YES;

    // Listen for taps on the background of the view.
    [_containerView addTarget:self
                       action:@selector(handleBackgroundTapped:)
             forControlEvents:UIControlEventTouchUpInside];

    _buttonGutterTapTarget = [[UIControl alloc] init];
    _buttonGutterTapTarget.translatesAutoresizingMaskIntoConstraints = NO;
    [_buttonGutterTapTarget addTarget:self
                               action:@selector(handleButtonGutterTapped:)
                     forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_buttonGutterTapTarget];

    if (MDCSnackbarMessage.usesLegacySnackbar) {
      UISwipeGestureRecognizer *swipeRightGesture =
          [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(handleBackgroundSwipedRight:)];
      [swipeRightGesture setDirection:UISwipeGestureRecognizerDirectionRight];
      [_containerView addGestureRecognizer:swipeRightGesture];

      UISwipeGestureRecognizer *swipeLeftGesture =
          [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                    action:@selector(handleBackgroundSwipedLeft:)];
      [swipeRightGesture setDirection:UISwipeGestureRecognizerDirectionLeft];
      [_containerView addGestureRecognizer:swipeLeftGesture];
    }

    NSString *dismissalAccessibilityLabelKey =
        kMaterialSnackbarStringTable[kStr_MaterialSnackbarMessageViewDismissalLabel];
    NSString *dismissalAccessibilityLabel = NSLocalizedStringFromTableInBundle(
        dismissalAccessibilityLabelKey, kMaterialSnackbarStringsTableName, [[self class] bundle],
        @"Dismissal accessibility label for Snackbar");
    NSString *dismissalAccessibilityHintKey =
        kMaterialSnackbarStringTable[kStr_MaterialSnackbarMessageViewTitleA11yHint];
    NSString *dismissalAccessibilityHint = NSLocalizedStringFromTableInBundle(
        dismissalAccessibilityHintKey, kMaterialSnackbarStringsTableName, [[self class] bundle],
        @"Dismissal accessibility hint for Snackbar");
    _dismissalAccessibilityAffordance = [[UIButton alloc] init];
    _dismissalAccessibilityAffordance.isAccessibilityElement = YES;
    _dismissalAccessibilityAffordance.accessibilityLabel = dismissalAccessibilityLabel;
    _dismissalAccessibilityAffordance.accessibilityHint = dismissalAccessibilityHint;
    [self addSubview:_dismissalAccessibilityAffordance];
    _dismissalAccessibilityAffordance.hidden = !_enableDismissalAccessibilityAffordance;
    _dismissalAccessibilityAffordance.accessibilityElementsHidden =
        !_enableDismissalAccessibilityAffordance;
    [_dismissalAccessibilityAffordance addTarget:self
                                          action:@selector(didTapDismissalTouchAffordance:)
                                forControlEvents:UIControlEventTouchUpInside];

    if (MDCSnackbarMessage.usesLegacySnackbar) {
      _contentView = [[UIView alloc] init];
      _contentView.userInteractionEnabled = NO;
    } else {
      UIScrollView *contentView = [[UIScrollView alloc] init];
      contentView.indicatorStyle =
          self.traitCollection.userInterfaceStyle == UIUserInterfaceStyleLight
              ? UIScrollViewIndicatorStyleWhite
              : UIScrollViewIndicatorStyleBlack;
      _contentView = contentView;

      // Use a separate gesture recognizer on the scroll view to allow for scrolling content without
      // dismissing the snackbar.
      UITapGestureRecognizer *tapGesture =
          [[UITapGestureRecognizer alloc] initWithTarget:self
                                                  action:@selector(handleContentTapped:)];
      tapGesture.cancelsTouchesInView = NO;

      [contentView addGestureRecognizer:tapGesture];
    }
    [_contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_containerView addSubview:_contentView];

    _buttonContainer = [[UIView alloc] init];
    [_buttonContainer setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_containerView addSubview:_buttonContainer];

    // Set up the title label.
    _label = [[UILabel alloc] initWithFrame:CGRectZero];
    [_contentView addSubview:_label];
    // TODO(#2709): Migrate to a single source of truth for fonts
    // If we are using the default (system) font loader, retrieve the
    // font from the UIFont standardFont API.
    [self updateMessageFont];

    NSMutableAttributedString *messageString = [message.attributedText mutableCopy];

    if (!_messageFont) {
      // Find any of the bold attributes in the string, and set the proper font for those ranges.
      // Use NSAttributedStringEnumerationLongestEffectiveRangeNotRequired as opposed to 0,
      // otherwise it will only work if bold text is in the end.
      [messageString
          enumerateAttribute:MDCSnackbarMessageBoldAttributeName
                     inRange:NSMakeRange(0, messageString.length)
                     options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
                  usingBlock:^(id value, NSRange range, __unused BOOL *stop) {
                    UIFont *font = [MDCTypography body1Font];
                    if ([value boolValue]) {
                      font = [MDCTypography body2Font];
                    }
                    [messageString setAttributes:@{NSFontAttributeName : font} range:range];
                  }];
    }

    // Apply 'global' attributes along the whole string.
    _label.backgroundColor = [UIColor clearColor];
    _label.textAlignment = NSTextAlignmentNatural;
    _label.adjustsFontSizeToFitWidth = MDCSnackbarMessage.usesLegacySnackbar;
    _label.adjustsFontForContentSizeCategory = !MDCSnackbarMessage.usesLegacySnackbar;
    _label.attributedText = messageString;
    _label.numberOfLines = 0;
    [_label setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_label setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh
                                            forAxis:UILayoutConstraintAxisHorizontal];
    [_label setContentHuggingPriority:UILayoutPriorityDefaultLow
                              forAxis:UILayoutConstraintAxisHorizontal];

    _label.accessibilityIdentifier = MDCSnackbarMessageTitleAutomationIdentifier;
    if (!_enableDismissalAccessibilityAffordance) {
      // For UIAccessibility purposes, the label is the primary 'button' for dismissing the
      // Snackbar, so we'll make sure the label is treated like a button.
      _label.accessibilityTraits = UIAccessibilityTraitButton;
      _label.accessibilityHint = dismissalAccessibilityHint;
    }

    // If an accessibility label or hint was set on the message model object, use that instead of
    // the text in the label or the default hint.
    if ([message.accessibilityLabel length]) {
      _label.accessibilityLabel = message.accessibilityLabel;
    }
    if (message.accessibilityHint.length) {
      _label.accessibilityHint = message.accessibilityHint;
    }

    _label.textColor = _messageTextColor;

    [self initializeMDCSnackbarMessageViewButtons:message withManager:manager];
  }

  return self;
}

- (void)initializeMDCSnackbarMessageViewButtons:(MDCSnackbarMessage *)message
                                    withManager:(MDCSnackbarManager *)manager {
  // Add button to the view. We'll use this opportunity to determine how much space a button will
  // need, to inform the layout direction.
  if (message.action) {
    MDCButton *button = [[MDCSnackbarMessageViewButton alloc] init];
    [button setTitleColor:_buttonTitleColors[@(UIControlStateNormal)]
                 forState:UIControlStateNormal];
    [button setTitleColor:_buttonTitleColors[@(UIControlStateHighlighted)]
                 forState:UIControlStateHighlighted];

    // TODO: Eventually remove this if statement, buttonTextColor is deprecated.
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    if (message.buttonTextColor) {
      [button setTitleColor:message.buttonTextColor forState:UIControlStateNormal];
    }
#pragma clang diagnostic pop

    button.enableRippleBehavior = message.enableRippleBehavior;
    [_buttonContainer addSubview:button];

    // Set up the button's accessibility values.
    button.accessibilityIdentifier = message.action.accessibilityIdentifier;
    button.accessibilityHint = message.action.accessibilityHint;

    [button setTitle:message.action.title forState:UIControlStateNormal];
    [button setTitle:message.action.title forState:UIControlStateHighlighted];

    [button addTarget:self
                  action:@selector(handleButtonTapped:)
        forControlEvents:UIControlEventTouchUpInside];

    button.uppercaseTitle = manager.uppercaseButtonTitle;
    button.disabledAlpha = manager.disabledButtonAlpha;
    button.titleLabel.adjustsFontForContentSizeCategory = !MDCSnackbarMessage.usesLegacySnackbar;
    button.titleLabel.adjustsFontSizeToFitWidth = !MDCSnackbarMessage.usesLegacySnackbar;
    if (manager.buttonInkColor) {
      button.inkColor = manager.buttonInkColor;
    }

    self.actionButton = button;
    [self updateButtonFont];
  }
}

- (void)dismissWithAction:(MDCSnackbarMessageAction *)action userInitiated:(BOOL)userInitiated {
  if (self.dismissalHandler) {
    self.dismissalHandler(userInitiated, action);

    // Change focus only if the focus is on this view.
    if (self.message.elementToFocusOnDismiss) {
      BOOL hasVoiceOverFocus =
          UIAccessibilityIsVoiceOverRunning() && UIViewHasFocusedAccessibilityElement(self);
      if (hasVoiceOverFocus) {
        UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification,
                                        self.message.elementToFocusOnDismiss);
      }
    }

    // In case our dismissal handler has a reference to us, release the block.
    self.dismissalHandler = nil;
  }
}

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

- (void)setElevation:(MDCShadowElevation)elevation {
  BOOL elevationChanged = !MDCCGFloatEqual(_elevation, elevation);
  _elevation = elevation;
  [(MDCShadowLayer *)self.layer setElevation:_elevation];
  if (elevationChanged) {
    [self mdc_elevationDidChange];
  }
}

- (void)setEnableDismissalAccessibilityAffordance:(BOOL)enableDismissalAccessibilityAffordance {
  if (_enableDismissalAccessibilityAffordance == enableDismissalAccessibilityAffordance) {
    return;
  }
  _enableDismissalAccessibilityAffordance = enableDismissalAccessibilityAffordance;
  _dismissalAccessibilityAffordance.hidden = !enableDismissalAccessibilityAffordance;
  _dismissalAccessibilityAffordance.accessibilityElementsHidden =
      !enableDismissalAccessibilityAffordance;
  NSString *accessibilityHintKey =
      kMaterialSnackbarStringTable[kStr_MaterialSnackbarMessageViewTitleA11yHint];
  NSString *accessibilityHint = NSLocalizedStringFromTableInBundle(
      accessibilityHintKey, kMaterialSnackbarStringsTableName, [[self class] bundle],
      @"Dismissal accessibility hint for Snackbar");
  if (enableDismissalAccessibilityAffordance) {
    _label.accessibilityTraits = UIAccessibilityTraitButton;
    if (![_label.accessibilityHint length]) {
      _label.accessibilityHint = accessibilityHint;
    }
  } else {
    _label.accessibilityTraits = UIAccessibilityTraitNone;
    if ([_label.accessibilityHint isEqualToString:accessibilityHint]) {
      _label.accessibilityHint = nil;
    }
  }
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];

  if (self.traitCollectionDidChangeBlock) {
    self.traitCollectionDidChangeBlock(self, previousTraitCollection);
  }
}

- (NSString *)description {
  NSString *messageString = self.message.description;
  NSMutableString *description = [[NSMutableString alloc] init];
  [description appendFormat:@"%@ {\n", [super description]];
  [description appendFormat:@"  message: %@;\n",
                            [messageString stringByReplacingOccurrencesOfString:@"\n"
                                                                     withString:@"\n  "]];
  [description appendString:@"}"];
  return [description copy];
}

#pragma mark - Subclass overrides

+ (BOOL)requiresConstraintBasedLayout {
  return YES;
}

- (CGFloat)minimumWidth {
  return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? kMinimumViewWidth_iPad
                                                              : kMinimumViewWidth_iPhone;
}

- (CGFloat)maximumWidth {
  return UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? kMaximumViewWidth_iPad
                                                              : kMaximumViewWidth_iPhone;
}

#pragma mark - Styling the view

- (void)setSnackbarMessageViewBackgroundColor:(UIColor *)snackbarMessageViewBackgroundColor {
  _snackbarMessageViewBackgroundColor = snackbarMessageViewBackgroundColor;
  self.backgroundColor = snackbarMessageViewBackgroundColor;
}

- (void)setSnackbarShadowColor:(UIColor *)snackbarMessageViewShadowColor {
  _snackbarMessageViewShadowColor = snackbarMessageViewShadowColor;
  self.layer.shadowColor = snackbarMessageViewShadowColor.CGColor;
}

- (void)setMessageTextColor:(UIColor *)messageTextColor {
  _messageTextColor = messageTextColor;
  if (_messageTextColor) {
    self.label.textColor = _messageTextColor;
  } else {
    self.label.textColor = UIColor.whiteColor;
  }
}

- (nullable UIColor *)buttonTitleColorForState:(UIControlState)state {
  return _buttonTitleColors[@(state)];
}

- (void)setButtonTitleColor:(nullable UIColor *)buttonTitleColor forState:(UIControlState)state {
  _buttonTitleColors[@(state)] = buttonTitleColor;
  if (self.actionButton) {
    if (_buttonTitleColors[@(state)]) {
      [self.actionButton setTitleColor:buttonTitleColor forState:state];
    } else {
      // Set to default
      UIColor *defaultButtonTitleColor;
      switch (state) {
        case UIControlStateHighlighted:
          defaultButtonTitleColor = UIColor.whiteColor;
          break;
        case UIControlStateNormal:
        default:
          defaultButtonTitleColor = MDCRGBAColor(0xFF, 0xFF, 0xFF, (float)0.6);
          break;
      }
      [self.actionButton setTitleColor:defaultButtonTitleColor forState:state];
    }
  }
}

- (void)addColorToMessageLabel:(UIColor *)color {
  NSMutableAttributedString *messageString = [_label.attributedText mutableCopy];
  [messageString addAttributes:@{
    NSForegroundColorAttributeName : color,
  }
                         range:NSMakeRange(0, messageString.length)];
  _label.attributedText = messageString;
}

- (UIFont *)messageFont {
  return _messageFont;
}

- (void)setMessageFont:(UIFont *)font {
  _messageFont = font;

  [self updateMessageFont];
}

- (void)updateMessageFont {
  // If we have a custom font apply it to the label.
  // If not, fall back to the Material specified font.
  if (_messageFont) {
    _label.font = _messageFont;
  } else {
    // If we are using the default (system) font loader, retrieve the
    // font from the UIFont standardFont API.
    if ([MDCTypography.fontLoader isKindOfClass:[MDCSystemFontLoader class]]) {
      _label.font = [UIFont mdc_standardFontForMaterialTextStyle:kMessageTextStyle];
    } else {
      // There is a custom font loader, retrieve the font from it.
      _label.font = [MDCTypography body1Font];
    }
  }
  [self setNeedsLayout];
}

- (UIFont *)buttonFont {
  return _buttonFont;
}

- (void)setButtonFont:(UIFont *)font {
  _buttonFont = font;

  [self updateButtonFont];
}

- (void)updateButtonFont {
  UIFont *finalButtonFont;

  // If we have a custom font apply it to the label.
  // If not, fall back to the Material specified font.
  if (_buttonFont) {
    finalButtonFont = _buttonFont;
  } else {
    // TODO(#2709): Migrate to a single source of truth for fonts
    // There is no custom font, so use the default font.
    // If we are using the default (system) font loader, retrieve the
    // font from the UIFont standardFont API.
    if ([MDCTypography.fontLoader isKindOfClass:[MDCSystemFontLoader class]]) {
      finalButtonFont = [UIFont mdc_standardFontForMaterialTextStyle:kButtonTextStyle];
    } else {
      // There is a custom font loader, retrieve the font from it.
      finalButtonFont = [MDCTypography buttonFont];
    }
  }

  [self.actionButton setTitleFont:finalButtonFont forState:UIControlStateNormal];
  [self.actionButton setTitleFont:finalButtonFont forState:UIControlStateHighlighted];

  [self setNeedsLayout];
}

- (BOOL)shouldWaitForDismissalDuringVoiceover {
  return self.message.action != nil;
}

- (NSArray<MDCButton *> *)actionButtons {
  return self.actionButton ? @[ self.actionButton ] : @[];
}

#pragma mark - Constraints and layout

- (NSInteger)numberOfLines {
  CGSize maxLabelSize = self.label.intrinsicContentSize;
  CGFloat lineHeight = self.label.font.lineHeight;
  return (NSInteger)round(maxLabelSize.height / lineHeight);
}

- (void)resetConstraints {
  [self removeConstraints:self.viewConstraints];
  self.viewConstraints = nil;
  [self setNeedsUpdateConstraints];
}

- (void)setAnchoredToScreenBottom:(BOOL)anchoredToScreenBottom {
  _anchoredToScreenBottom = anchoredToScreenBottom;
  [self invalidateIntrinsicContentSize];

  if (self.viewConstraints) {
    [self resetConstraints];
  }
}

- (void)updateConstraints {
  if (self.viewConstraints) {
    [super updateConstraints];
    return;
  }

  NSMutableArray *constraints = [NSMutableArray array];

  [constraints addObjectsFromArray:[self containerViewConstraints]];
  [constraints addObjectsFromArray:[self contentViewConstraints]];
  [constraints addObjectsFromArray:[self horizontalButtonLayoutConstraints]];

  [self addConstraints:constraints];

  [self updateButtonWidthConstraint];

  self.viewConstraints = constraints;

  [super updateConstraints];
}

- (void)updatePreferredMaxLayoutWidth {
  if (!MDCSnackbarMessage.usesLegacySnackbar) {
    CGFloat availableWidth =
        self.bounds.size.width - self.safeContentMargin.left - self.safeContentMargin.right;
    BOOL shouldUseHorizontalLayout = ![self shouldUseVerticalLayout];
    // Account for the action button if present and the layout is horizontal.
    if (shouldUseHorizontalLayout && self.actionButton) {
      availableWidth = availableWidth - [self actionButtonWidth] - kTitleButtonPadding;
    }
    self.label.preferredMaxLayoutWidth = availableWidth;
  }
}

- (void)updateButtonWidthConstraint {
  BOOL shouldUseHorizontalLayout = ![self shouldUseVerticalLayout];

  if (shouldUseHorizontalLayout && self.actionButton) {
    self.buttonWidthConstraint.constant = [self actionButtonWidth];
  }
}

- (CGFloat)actionButtonWidth {
  CGFloat availableWidth = self.bounds.size.width - self.safeContentMargin.left -
                           self.safeContentMargin.right - kTitleButtonPadding;

  if (availableWidth < 0) {
    return self.actionButton.intrinsicContentSize.width;
  }

  CGFloat textWidth =
      [self.label textRectForBounds:CGRectInfinite limitedToNumberOfLines:1].size.width;

  // Pick a size that is either, the remainder of the available space when the label is small and
  // fits on one line, 1/3 of the space when 1/3 of the space is larger than what is left by the
  // label or the button size itself when it is smaller than either the available spaced or 1/3 of
  // the width.
  return MIN(self.actionButton.intrinsicContentSize.width,
             MAX(kMaxButtonRatio * availableWidth, availableWidth - textWidth));
}

- (CGFloat)minimumLayoutHeight {
  if ([self shouldUseVerticalLayout]) {
    return self.actionButton.intrinsicContentSize.height + self.label.font.lineHeight +
           self.safeContentMargin.top + self.safeContentMargin.bottom;
  } else {
    return MAX(self.actionButton.intrinsicContentSize.height, self.label.font.lineHeight) +
           self.safeContentMargin.top + self.safeContentMargin.bottom;
  }
}

/**
 Provides constraints to pin the container view to the size of the Snackbar, inset by
 @c kBorderWidth. Also positions the content view and button view inside of the container view.
 */
- (NSArray *)containerViewConstraints {
  UIEdgeInsets safeContentMargin = self.safeContentMargin;
  CGFloat contentSafeBottomInset = kBorderWidth + self.contentSafeBottomInset;
  BOOL hasButtons = self.actionButton != nil;

  NSMutableArray *constraints = [NSMutableArray array];

  [constraints addObjectsFromArray:@[
    // Pin the left and right edges of the container view to the Snackbar.
    [self.containerView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor
                                                     constant:kBorderWidth],
    [self.containerView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor
                                                      constant:-kBorderWidth],

    // Pin the top and bottom edges of the container view to the Snackbar.
    [self.containerView.topAnchor constraintEqualToAnchor:self.topAnchor constant:kBorderWidth],
    [self.containerView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor
                                                    constant:-contentSafeBottomInset],

    // Pin the content to the top of the container view.
    [self.contentView.topAnchor constraintEqualToAnchor:self.containerView.topAnchor
                                               constant:self.safeContentMargin.top],

    // Pin the content view to the left side of the container.
    [self.contentView.leadingAnchor constraintEqualToAnchor:self.containerView.leadingAnchor
                                                   constant:self.safeContentMargin.left],
  ]];

  if (hasButtons) {
    if (MDCSnackbarMessage.usesLegacySnackbar) {
      [constraints addObjectsFromArray:@[
        // Align the content and buttons horizontally.
        [self.contentView.trailingAnchor constraintEqualToAnchor:self.buttonContainer.leadingAnchor
                                                        constant:-kTitleButtonPadding],
        [self.buttonGutterTapTarget.widthAnchor constraintEqualToConstant:safeContentMargin.right],
        [self.buttonContainer.trailingAnchor
            constraintEqualToAnchor:self.buttonGutterTapTarget.leadingAnchor],
        [self.buttonGutterTapTarget.trailingAnchor
            constraintEqualToAnchor:self.containerView.trailingAnchor],

        // The buttons should take up the entire height of the container view.
        [self.buttonContainer.topAnchor constraintEqualToAnchor:self.containerView.topAnchor],
        [self.buttonContainer.bottomAnchor constraintEqualToAnchor:self.containerView.bottomAnchor],

        // The button gutter tap target should take up the entire height of the container view.
        [self.buttonGutterTapTarget.topAnchor constraintEqualToAnchor:self.containerView.topAnchor],
        [self.buttonGutterTapTarget.bottomAnchor
            constraintEqualToAnchor:self.containerView.bottomAnchor],

        // Pin the content to the bottom of the container view, since there's nothing below.
        [self.contentView.bottomAnchor constraintEqualToAnchor:self.containerView.bottomAnchor
                                                      constant:-safeContentMargin.bottom]
      ]];
    } else {  // Modern snackbar layout.
      if ([self shouldUseVerticalLayout]) {
        [constraints addObjectsFromArray:@[
          // Align the content and buttons vertically.
          [self.contentView.bottomAnchor constraintEqualToAnchor:self.buttonContainer.topAnchor
                                                        constant:-kTitleButtonPadding],

          // Pin the trailing edge of the contentView to its superview.
          [self.contentView.trailingAnchor constraintEqualToAnchor:self.containerView.trailingAnchor
                                                          constant:-self.safeContentMargin.right],

          // Make the leading edge of the button container less than the size of the view.
          [self.buttonContainer.leadingAnchor
              constraintGreaterThanOrEqualToAnchor:self.containerView.leadingAnchor
                                          constant:self.safeContentMargin.left],

          // Pin the bottom edge of the button to the bottom of the container view.
          [self.buttonContainer.bottomAnchor constraintEqualToAnchor:self.containerView.bottomAnchor
                                                            constant:-safeContentMargin.bottom],
        ]];

        // Make sure the button takes up no more space than needed.
        [self.buttonContainer setContentHuggingPriority:UILayoutPriorityRequired
                                                forAxis:UILayoutConstraintAxisHorizontal];
      } else {  // Horizontal layout.
        [constraints addObjectsFromArray:@[
          // Align the content and buttons horizontally.
          [self.contentView.trailingAnchor
              constraintEqualToAnchor:self.buttonContainer.leadingAnchor
                             constant:-kTitleButtonPadding],

          // Pin the top/bottom of the button container to its parent view.
          [self.buttonContainer.topAnchor constraintEqualToAnchor:self.containerView.topAnchor],
          [self.buttonContainer.bottomAnchor
              constraintEqualToAnchor:self.containerView.bottomAnchor],

          // Pin the content to the bottom of the container view, since there's nothing below.
          [self.contentView.bottomAnchor constraintEqualToAnchor:self.containerView.bottomAnchor
                                                        constant:-safeContentMargin.bottom],

          // Constrain the button container to a third of the width of its parent view to ensure
          // button and text content are always visible.
          self.buttonWidthConstraint = [self.buttonContainer.widthAnchor
              constraintLessThanOrEqualToConstant:self.frame.size.width]
        ]];
      }

      // The below constraint is shared by both vertical and horizontal layouts.
      [constraints addObjectsFromArray:@[
        // Pin the button container to the trailing edge of the container view.
        [self.buttonContainer.trailingAnchor
            constraintEqualToAnchor:self.containerView.trailingAnchor
                           constant:-self.safeContentMargin.right],

      ]];
    }
  } else {  // There is not an action button present.
    [constraints addObjectsFromArray:@[
      // If there are no buttons, then go ahead and pin the content view to the bottom and trailing
      // edges of the container view.
      [self.contentView.bottomAnchor constraintEqualToAnchor:self.containerView.bottomAnchor
                                                    constant:-self.safeContentMargin.bottom],
      [self.contentView.trailingAnchor constraintEqualToAnchor:self.containerView.trailingAnchor
                                                      constant:-self.safeContentMargin.right]
    ]];
  }

  return constraints;
}

/**
 Provides constraints for the label within the content view.
 */
- (NSArray *)contentViewConstraints {
  NSMutableArray *constraints = [NSMutableArray array];

  [constraints addObjectsFromArray:@[
    // The label should take up the entire height of the content view.
    [self.label.topAnchor constraintEqualToAnchor:self.contentView.topAnchor],
    [self.label.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor],

    // Pin the label to the trailing edge of the content view.
    [self.label.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor],
    [self.label.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor],
    [self.label.widthAnchor constraintEqualToAnchor:self.contentView.widthAnchor],
  ]];

  // Allow the content height constraint to break so that label will take up the content view
  // height but will grow beyond it and scroll if needed.
  NSLayoutConstraint *heightConstraint =
      [self.contentView.heightAnchor constraintEqualToAnchor:self.label.heightAnchor];
  heightConstraint.priority = UILayoutPriorityDefaultHigh;

  [constraints addObject:heightConstraint];

  return constraints;
}

/**
 Provides constraints positioning the buttons horizontally within the button container.
 */
- (NSArray *)horizontalButtonLayoutConstraints {
  NSMutableArray *constraints = [NSMutableArray array];

  if (self.actionButton) {
    [constraints addObjectsFromArray:@[
      // Ensure that the button is vertically centered in its container view
      [self.actionButton.centerYAnchor constraintEqualToAnchor:self.buttonContainer.centerYAnchor],
      [self.buttonContainer.heightAnchor
          constraintGreaterThanOrEqualToAnchor:self.actionButton.heightAnchor],

      // Pin the button to the width of its container.
      [self.actionButton.leadingAnchor constraintEqualToAnchor:self.buttonContainer.leadingAnchor],
      [self.actionButton.trailingAnchor
          constraintEqualToAnchor:self.buttonContainer.trailingAnchor],
    ]];
  }

  return constraints;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  [self updatePreferredMaxLayoutWidth];
  [self updateButtonWidthConstraint];

  if (!self.dismissalAccessibilityAffordance.hidden) {
    // Update frame of the dismissal touch affordance.
    CGRect globalFrame = [self convertRect:self.bounds toView:nil];
    CGRect globalDismissalAreaFrame =
        CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), CGRectGetMinY(globalFrame));
    CGRect localDismissalAreaFrame = [self convertRect:globalDismissalAreaFrame fromView:nil];
    self.dismissalAccessibilityAffordance.frame = localDismissalAreaFrame;
  }

  BOOL isMultilineText = [self numberOfLines] > 1;
  if (_isMultilineText != isMultilineText) {
    _isMultilineText = isMultilineText;
    [self resetConstraints];
  }

  // As our layout changes, make sure that the shadow path is kept up-to-date.
  UIBezierPath *path = [UIBezierPath
      bezierPathWithRoundedRect:self.bounds
                   cornerRadius:MDCSnackbarMessage.usesLegacySnackbar ? kLegacyCornerRadius
                                                                      : kCornerRadius];
  self.layer.shadowPath = path.CGPath;
  self.layer.shadowColor = self.snackbarMessageViewShadowColor.CGColor;
  [self invalidateIntrinsicContentSize];
}

#pragma mark - Sizing

- (CGSize)intrinsicContentSize {
  CGFloat height = 0;

  [self updatePreferredMaxLayoutWidth];

  // Figure out which of the elements is tallest, and use that for calculating our preferred height.
  height = MAX(height, self.label.intrinsicContentSize.height);

  // Make sure that content margins are included in our calculation.
  height += self.safeContentMargin.top + self.safeContentMargin.bottom;

  // Make sure that the height of the text is larger than the minimum height;
  height = MAX(_isMultilineText ? kMinimumHeightMultiline : kMinimumHeight, height) +
           self.contentSafeBottomInset;

  if ([self shouldUseVerticalLayout]) {
    height += self.actionButton.intrinsicContentSize.height + kTitleButtonPadding;
  }

  return CGSizeMake(UIViewNoIntrinsicMetric, height);
}

- (CGFloat)contentSafeBottomInset {
  // If a bottom offset has been set to raise the HUD/Snackbar, e.g. above a tab bar, we should
  // ignore any safeAreaInsets, since it is no longer 'anchored' to the bottom of the screen. This
  // is set by the MDCSnackbarOverlayView whenever the bottomOffset is non-zero.
  if (!self.anchoredToScreenBottom || !MDCSnackbarMessage.usesLegacySnackbar) {
    return 0;
  }
  return self.window.safeAreaInsets.bottom;
  return 0;
}

- (UIEdgeInsets)safeContentMargin {
  UIEdgeInsets contentMargin = UIEdgeInsetsZero;
  if (MDCSnackbarMessage.usesLegacySnackbar) {
    contentMargin = kLegacyContentMargin;
  } else {
    contentMargin = _isMultilineText || [self shouldUseVerticalLayout]
                        ? kContentMarginMutliLineText
                        : kContentMarginSingleLineText;
  }

  UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
  safeAreaInsets = self.window.safeAreaInsets;

  // We only take the left and right safeAreaInsets in to account because the bottom is
  // handled by contentSafeBottomInset and we will never overlap the top inset.
  contentMargin.left = MAX(contentMargin.left, safeAreaInsets.left);
  contentMargin.right = MAX(contentMargin.right, safeAreaInsets.right);

  return contentMargin;
}

#pragma mark - Event Handlers

- (void)handleBackgroundSwipedRight:(__unused UIButton *)sender {
  CABasicAnimation *translationAnimation =
      [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
  translationAnimation.toValue = [NSNumber numberWithDouble:-self.frame.size.width];
  translationAnimation.duration = MDCSnackbarLegacyTransitionDuration;
  translationAnimation.timingFunction =
      [CAMediaTimingFunction mdc_functionWithType:MDCAnimationTimingFunctionTranslateOffScreen];
  translationAnimation.delegate = self;
  translationAnimation.fillMode = kCAFillModeForwards;
  translationAnimation.removedOnCompletion = NO;
  [self.layer addAnimation:translationAnimation forKey:@"transform.translation.x"];
}

- (void)handleBackgroundSwipedLeft:(__unused UIButton *)sender {
  CABasicAnimation *translationAnimation =
      [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
  translationAnimation.toValue = [NSNumber numberWithDouble:self.frame.size.width];
  translationAnimation.duration = MDCSnackbarLegacyTransitionDuration;
  translationAnimation.timingFunction =
      [CAMediaTimingFunction mdc_functionWithType:MDCAnimationTimingFunctionTranslateOffScreen];
  translationAnimation.delegate = self;
  translationAnimation.fillMode = kCAFillModeForwards;
  translationAnimation.removedOnCompletion = NO;
  [self.layer addAnimation:translationAnimation forKey:@"transform.translation.x"];
}

- (void)handleBackgroundTapped:(__unused UIButton *)sender {
  BOOL accessibilityEnabled =
      UIAccessibilityIsVoiceOverRunning() || UIAccessibilityIsSwitchControlRunning();
  if (accessibilityEnabled && self.enableDismissalAccessibilityAffordance &&
      self.label.accessibilityElementIsFocused) {
    // When enableDismissalAccessibilityAffordance is YES, tapping on background of the container
    // shouldn't dismiss snackbar.
    return;
  }
  [self dismissWithAction:nil userInitiated:YES];
}

- (void)handleContentTapped:(__unused UITapGestureRecognizer *)sender {
  BOOL scrollViewShouldScroll = NO;
  if (!MDCSnackbarMessage.usesLegacySnackbar &&
      [self.contentView isKindOfClass:UIScrollView.class]) {
    // If the scroll view can scroll allow touches to scroll content.
    UIScrollView *contentView = (UIScrollView *)self.contentView;
    scrollViewShouldScroll = contentView.contentSize.height > contentView.bounds.size.height;
  }

  if (!scrollViewShouldScroll) {
    BOOL accessibilityEnabled =
        UIAccessibilityIsVoiceOverRunning() || UIAccessibilityIsSwitchControlRunning();
    if (accessibilityEnabled && self.enableDismissalAccessibilityAffordance &&
        self.label.accessibilityElementIsFocused) {
      // When enableDismissalAccessibilityAffordance is YES, tapping on the content
      // shouldn't dismiss snackbar.
      return;
    }

    [self dismissWithAction:nil userInitiated:YES];
  }
}

- (void)handleButtonGutterTapped:(__unused UIControl *)sender {
  [self handleButtonTapped:nil];
}

- (void)handleButtonTapped:(__unused UIButton *)sender {
  [self dismissWithAction:self.message.action userInitiated:YES];
}

- (void)didTapDismissalTouchAffordance:(__unused UIControl *)sender {
  [self dismissWithAction:nil userInitiated:YES];
}

- (void)animationDidStop:(__unused CAAnimation *)theAnimation finished:(BOOL)flag {
  if (flag) {
    [self dismissWithAction:nil userInitiated:YES];
  }
}

#pragma mark - Accessibility

// Override regular accessibility element ordering and ensure label
// is read first before any buttons, if they exist.
- (NSInteger)accessibilityElementCount {
  return 1 + (self.actionButton ? 1 : 0) +
         (self.dismissalAccessibilityAffordance.accessibilityElementsHidden ? 0 : 1);
}

- (id)accessibilityElementAtIndex:(NSInteger)index {
  if (index == 0) {
    return _label;
  } else if (index == 1) {
    return self.actionButton;
  }
  if (!self.dismissalAccessibilityAffordance.accessibilityElementsHidden) {
    return self.dismissalAccessibilityAffordance;
  }
  return nil;
}

- (NSInteger)indexOfAccessibilityElement:(id)element {
  if (element == _label) {
    return 0;
  } else if (element == _actionButton) {
    return 1;
  } else if (element == _dismissalAccessibilityAffordance &&
             !self.dismissalAccessibilityAffordance.accessibilityElementsHidden) {
    return 2;
  }

  return NSNotFound;
}

#pragma mark - Animation

- (void)animateContentOpacityFrom:(CGFloat)fromOpacity
                               to:(CGFloat)toOpacity
                         duration:(NSTimeInterval)duration
                   timingFunction:(CAMediaTimingFunction *)timingFunction {
  [CATransaction begin];
  CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
  opacityAnimation.duration = duration;
  opacityAnimation.fromValue = @(fromOpacity);
  opacityAnimation.toValue = @(toOpacity);
  opacityAnimation.timingFunction = timingFunction;

  // The text and the button do not share a common view that can be animated independently of the
  // background color, so just animate them both independently here. If this becomes more
  // complicated, refactor to add a containing view for both and animate that.
  [self.contentView.layer addAnimation:opacityAnimation forKey:@"opacity"];
  [self.buttonContainer.layer addAnimation:opacityAnimation forKey:@"opacity"];
  [CATransaction commit];
}

- (CABasicAnimation *)animateSnackbarOpacityFrom:(CGFloat)fromOpacity to:(CGFloat)toOpacity {
  CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
  opacityAnimation.fromValue = @(fromOpacity);
  opacityAnimation.toValue = @(toOpacity);
  return opacityAnimation;
}

- (CABasicAnimation *)animateSnackbarScaleFrom:(CGFloat)fromScale toScale:(CGFloat)toScale {
  CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
  scaleAnimation.fromValue = [NSNumber numberWithDouble:fromScale];
  scaleAnimation.toValue = [NSNumber numberWithDouble:toScale];
  return scaleAnimation;
}

#pragma mark - Resource bundle

+ (NSBundle *)bundle {
  static NSBundle *bundle = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    bundle = [NSBundle bundleWithPath:[self bundlePathWithName:kMaterialSnackbarBundle]];
  });

  return bundle;
}

+ (NSString *)bundlePathWithName:(NSString *)bundleName {
  // In iOS 8+, we could be included by way of a dynamic framework, and our resource bundles may
  // not be in the main .app bundle, but rather in a nested framework, so figure out where we live
  // and use that as the search location.
  NSBundle *bundle = [NSBundle bundleForClass:[MDCSnackbarMessageView class]];
  NSString *resourcePath = [(nil == bundle ? [NSBundle mainBundle] : bundle) resourcePath];
  return [resourcePath stringByAppendingPathComponent:bundleName];
}

- (BOOL)shouldUseVerticalLayout {
  return !MDCSnackbarMessage.usesLegacySnackbar &&
         UIContentSizeCategoryIsAccessibilityCategory(
             self.traitCollection.preferredContentSizeCategory) &&
         self.traitCollection.verticalSizeClass == UIUserInterfaceSizeClassRegular &&
         self.label.font.pointSize > kMinimumAccessibiltyFontSize;
}

#pragma mark - Elevation

- (CGFloat)mdc_currentElevation {
  return self.elevation;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
  BOOL result = [super pointInside:point withEvent:event];
  BOOL accessibilityEnabled =
      UIAccessibilityIsVoiceOverRunning() || UIAccessibilityIsSwitchControlRunning();
  if (accessibilityEnabled && self.enableDismissalAccessibilityAffordance &&
      CGRectContainsPoint(self.dismissalAccessibilityAffordance.frame, point)) {
    // Count @c dismissalAccessibilitAffordance as hittable when VoiceOver is running.
    return YES;
  }
  if (!result && !accessibilityEnabled && _shouldDismissOnOverlayTap) {
    [self dismissWithAction:nil userInitiated:YES];
  }
  return result;
}

@end
