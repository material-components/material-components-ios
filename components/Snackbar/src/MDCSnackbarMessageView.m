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

#import "MDCSnackbarManager.h"
#import "MDCSnackbarMessage.h"
#import "MDCSnackbarMessageView.h"

#import "MaterialAnimationTiming.h"
#import "MaterialAvailability.h"
#import "MaterialMath.h"
#import "MaterialShadowLayer.h"
#import "MaterialTypography.h"
#import "private/MDCSnackbarMessageViewInternal.h"
#import "private/MDCSnackbarOverlayView.h"
#import "private/MaterialSnackbarStrings.h"
#import "private/MaterialSnackbarStrings_table.h"

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
 Padding between the image and the main title.
 */
static const CGFloat kTitleImagePadding = 8;

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
 The minimum height of the Snackbar.
 */
static const CGFloat kMinimumHeight = 48;

/**
 The minimum height of a multiline Snackbar.
 */
static const CGFloat kMinimumHeightMultiline = 68;

/**
 Each button will have a tag indexed starting from this value.
 */
static const NSInteger kButtonTagStart = 20000;

static const MDCFontTextStyle kMessageTextStyle = MDCFontTextStyleBody1;
static const MDCFontTextStyle kButtonTextStyle = MDCFontTextStyleButton;

#if MDC_AVAILABLE_SDK_IOS(10_0)
@interface MDCSnackbarMessageView () <CAAnimationDelegate>
@end
#endif  // MDC_AVAILABLE_SDK_IOS(10_0)

@interface MDCSnackbarMessageView ()

/**
 Holds the icon for the image.
 */
@property(nonatomic, strong) UIImageView *imageView;

/**
 Holds the button views.
 */
@property(nonatomic, strong) NSArray *buttons;

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
 The view containing all of the buttons.
 */
@property(nonatomic, strong) UIView *buttonView;

/**
 The view containing the title and image views.
 */
@property(nonatomic, strong) UIView *contentView;

/**
 An invisible hit target to ensure that tapping the horizontal area between the button and the edge
 of the screen triggers a button tap instead of dismissing the snackbar.
 */
@property(nonatomic, strong) UIControl *buttonGutterTapTarget;

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
    self.tag = kButtonTagStart;

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

  // Holds the instances of MDCButton
  NSMutableArray<MDCButton *> *_actionButtons;

  NSMutableDictionary<NSNumber *, UIColor *> *_buttonTitleColors;

  BOOL _mdc_adjustsFontForContentSizeCategory;

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
    _mdc_adjustsFontForContentSizeCategory = manager.mdc_adjustsFontForContentSizeCategory;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    _adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable =
        manager.adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable;
#pragma clang diagnostic pop
    _messageFont = manager.messageFont;
    _buttonFont = manager.buttonFont;
    _message = message;
    _shouldDismissOnOverlayTap = message.shouldDismissOnOverlayTap;
    _dismissalHandler = [handler copy];
    _mdc_overrideBaseElevation = manager.mdc_overrideBaseElevation;
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

    _contentView = [[UIView alloc] init];
    [_contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_containerView addSubview:_contentView];
    _contentView.userInteractionEnabled = NO;

    _buttonView = [[UIView alloc] init];
    [_buttonView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_containerView addSubview:_buttonView];

    _actionButtons = [[NSMutableArray alloc] init];

    // Set up the title label.
    _label = [[UILabel alloc] initWithFrame:CGRectZero];
    [_contentView addSubview:_label];
    // TODO(#2709): Migrate to a single source of truth for fonts
    // If we are using the default (system) font loader, retrieve the
    // font from the UIFont standardFont API.
    [self updateMessageFont];

    NSMutableAttributedString *messageString = [message.attributedText mutableCopy];

    if (!_messageFont && !_mdc_adjustsFontForContentSizeCategory) {
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
    _label.adjustsFontSizeToFitWidth = YES;
    _label.attributedText = messageString;
    _label.numberOfLines = 0;
    [_label setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_label setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh
                                            forAxis:UILayoutConstraintAxisHorizontal];
    [_label setContentHuggingPriority:UILayoutPriorityDefaultLow
                              forAxis:UILayoutConstraintAxisHorizontal];

    NSString *accessibilityHintKey =
        kMaterialSnackbarStringTable[kStr_MaterialSnackbarMessageViewTitleA11yHint];
    NSString *accessibilityHint = NSLocalizedStringFromTableInBundle(
        accessibilityHintKey, kMaterialSnackbarStringsTableName, [[self class] bundle],
        @"Dismissal accessibility hint for Snackbar");

    // For UIAccessibility purposes, the label is the primary 'button' for dismissing the Snackbar,
    // so we'll make sure the label is treated like a button.
    _label.accessibilityTraits = UIAccessibilityTraitButton;
    _label.accessibilityIdentifier = MDCSnackbarMessageTitleAutomationIdentifier;
    _label.accessibilityHint = accessibilityHint;

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
  // Add buttons to the view. We'll use this opportunity to determine how much space a button will
  // need, to inform the layout direction.
  NSMutableArray *actions = [NSMutableArray array];
  if (message.action) {
    UIView *buttonView = [[UIView alloc] init];
    [buttonView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_buttonView addSubview:buttonView];

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
    [buttonView addSubview:button];
    [_actionButtons addObject:button];

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
    if (manager.buttonInkColor) {
      button.inkColor = manager.buttonInkColor;
    }

    [actions addObject:buttonView];
  }

  self.buttons = actions;
  [self updateButtonFont];
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
  for (MDCButton *button in _actionButtons) {
    if (_buttonTitleColors[@(state)]) {
      [button setTitleColor:buttonTitleColor forState:state];
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
      [button setTitleColor:defaultButtonTitleColor forState:state];
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
    // If we are automatically adjusting for Dynamic Type resize the font based on the text style
    if (_mdc_adjustsFontForContentSizeCategory) {
      if (_messageFont.mdc_scalingCurve) {
        _label.font = [_messageFont mdc_scaledFontForTraitEnvironment:self];
      } else if (_adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable) {
        _label.font =
            [_messageFont mdc_fontSizedForMaterialTextStyle:kMessageTextStyle
                                       scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
      }
    } else {
      _label.font = _messageFont;
    }
  } else {
    // TODO(#2709): Migrate to a single source of truth for fonts
    // There is no custom font, so use the default font.
    if (_mdc_adjustsFontForContentSizeCategory) {
      // If we are using the default (system) font loader, retrieve the
      // font from the UIFont preferredFont API.
      if ([MDCTypography.fontLoader isKindOfClass:[MDCSystemFontLoader class]]) {
        _label.font = [UIFont mdc_preferredFontForMaterialTextStyle:kMessageTextStyle];
      } else {
        // There is a custom font loader, retrieve the font and scale it.
        UIFont *customTypographyFont = [MDCTypography body1Font];
        _label.font = [customTypographyFont
            mdc_fontSizedForMaterialTextStyle:kMessageTextStyle
                         scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
      }
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
    // If we are automatically adjusting for Dynamic Type resize the font based on the text style
    if (_mdc_adjustsFontForContentSizeCategory) {
      if (_buttonFont.mdc_scalingCurve) {
        finalButtonFont = [_buttonFont mdc_scaledFontForTraitEnvironment:self];
      } else if (_adjustsFontForContentSizeCategoryWhenScaledFontIsUnavailable) {
        finalButtonFont =
            [_buttonFont mdc_fontSizedForMaterialTextStyle:kButtonTextStyle
                                      scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
      }
    }
  } else {
    // TODO(#2709): Migrate to a single source of truth for fonts
    // There is no custom font, so use the default font.
    if (_mdc_adjustsFontForContentSizeCategory) {
      // If we are using the default (system) font loader, retrieve the
      // font from the UIFont preferredFont API.
      if ([MDCTypography.fontLoader isKindOfClass:[MDCSystemFontLoader class]]) {
        finalButtonFont = [UIFont mdc_preferredFontForMaterialTextStyle:kButtonTextStyle];
      } else {
        // There is a custom font loader, retrieve the font and scale it.
        UIFont *customTypographyFont = [MDCTypography buttonFont];
        finalButtonFont = [customTypographyFont
            mdc_fontSizedForMaterialTextStyle:kButtonTextStyle
                         scaledForDynamicType:_mdc_adjustsFontForContentSizeCategory];
      }
    } else {
      // If we are using the default (system) font loader, retrieve the
      // font from the UIFont standardFont API.
      if ([MDCTypography.fontLoader isKindOfClass:[MDCSystemFontLoader class]]) {
        finalButtonFont = [UIFont mdc_standardFontForMaterialTextStyle:kButtonTextStyle];
      } else {
        // There is a custom font loader, retrieve the font from it.
        finalButtonFont = [MDCTypography buttonFont];
      }
    }
  }

  for (MDCButton *button in _actionButtons) {
    [button setTitleFont:finalButtonFont forState:UIControlStateNormal];
    [button setTitleFont:finalButtonFont forState:UIControlStateHighlighted];
  }

  [self setNeedsLayout];
}

- (BOOL)shouldWaitForDismissalDuringVoiceover {
  return self.message.action != nil;
}

#pragma mark - Constraints and layout

- (NSInteger)numberOfLines {
  CGSize maxLabelSize = self.label.intrinsicContentSize;
  CGFloat lineHeight = self.label.font.lineHeight;
  return (NSInteger)MDCRound(maxLabelSize.height / lineHeight);
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
  self.viewConstraints = constraints;

  [super updateConstraints];
}

/**
 Provides constraints to pin the container view to the size of the Snackbar, inset by
 @c kBorderWidth. Also positions the content view and button view inside of the container view.
 */
- (NSArray *)containerViewConstraints {
  UIEdgeInsets safeContentMargin = self.safeContentMargin;
  NSDictionary *metrics = @{
    @"kBorderMargin" : @(kBorderWidth),
    @"kBottomMargin" : @(safeContentMargin.bottom),
    @"kLeftMargin" : @(safeContentMargin.left),
    @"kRightMargin" : @(safeContentMargin.right),
    @"kTitleImagePadding" : @(kTitleImagePadding),
    @"kTopMargin" : @(safeContentMargin.top),
    @"kTitleButtonPadding" : @(kTitleButtonPadding),
    @"kContentSafeBottomInset" : @(kBorderWidth + self.contentSafeBottomInset),
  };
  NSDictionary *views = @{
    @"container" : self.containerView,
    @"content" : self.contentView,
    @"buttons" : self.buttonView,
    @"buttonGutter" : self.buttonGutterTapTarget,
  };

  BOOL hasButtons = (self.buttons.count > 0);

  NSString *formatString = nil;  // Scratch variable.
  NSMutableArray *constraints = [NSMutableArray array];

  // Pin the left and right edges of the container view to the Snackbar.
  formatString = @"H:|-(==kBorderMargin)-[container]-(==kBorderMargin)-|";
  [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                           options:0
                                                                           metrics:metrics
                                                                             views:views]];

  // Pin the top and bottom edges of the container view to the Snackbar.
  formatString = @"V:|-(==kBorderMargin)-[container]-(==kContentSafeBottomInset)-|";
  [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                           options:0
                                                                           metrics:metrics
                                                                             views:views]];

  // Pin the content to the top of the container view.
  formatString = @"V:|-(==kTopMargin)-[content]";
  [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                           options:0
                                                                           metrics:metrics
                                                                             views:views]];

  // Pin the content view to the left side of the container.
  formatString = @"H:|-(==kLeftMargin)-[content]";
  [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                           options:0
                                                                           metrics:metrics
                                                                             views:views]];

  // If there are no buttons, or the buttons are below the main content, then the content view
  // should be pinned to the right side of the container. If there are horizontal buttons, the
  // leftmost button will take care of positioning the trailing edge of the label view.

  // If there are no buttons, then go ahead and pin the content view to the bottom of the
  // container view.
  if (!hasButtons) {
    formatString = @"V:[content]-(==kBottomMargin)-|";
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];
  }

  if (!hasButtons) {
    // There is nothing to the right of the content, so go ahead and pin it to the trailing edge of
    // the container view.
    formatString = @"H:[content]-(==kRightMargin)-|";
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];
  } else {  // This is a horizontal layout, and there are buttons present.
    if (MDCSnackbarMessage.usesLegacySnackbar) {
      // Align the content and buttons horizontally.
      formatString =
          @"H:[content]-(==kTitleButtonPadding)-[buttons][buttonGutter(==kRightMargin)]|";
      [constraints addObjectsFromArray:[NSLayoutConstraint
                                           constraintsWithVisualFormat:formatString
                                                               options:NSLayoutFormatAlignAllCenterY
                                                               metrics:metrics
                                                                 views:views]];

      // The buttons should take up the entire height of the container view.
      formatString = @"V:|[buttons]|";
      [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                               options:0
                                                                               metrics:metrics
                                                                                 views:views]];

      // The button gutter tap target should take up the entire height of the container view.
      formatString = @"V:|[buttonGutter]|";
      [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                               options:0
                                                                               metrics:metrics
                                                                                 views:views]];
    } else {
      // Align the content and buttons horizontally.
      formatString = @"H:[content]-(==kTitleButtonPadding)-[buttons]-(==kRightMargin)-|";
      [constraints addObjectsFromArray:[NSLayoutConstraint
                                           constraintsWithVisualFormat:formatString
                                                               options:NSLayoutFormatAlignAllCenterY
                                                               metrics:metrics
                                                                 views:views]];

      formatString = @"V:|[buttons]|";
      [constraints addObjectsFromArray:[NSLayoutConstraint
                                           constraintsWithVisualFormat:formatString
                                                               options:NSLayoutFormatAlignAllCenterY
                                                               metrics:metrics
                                                                 views:views]];
    }

    // Pin the content to the bottom of the container view, since there's nothing below.
    formatString = @"V:[content]-(==kBottomMargin)-|";
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];
  }

  return constraints;
}

/**
 Provides constraints for the image view and label within the content view.
 */
- (NSArray *)contentViewConstraints {
  UIEdgeInsets safeContentMargin = self.safeContentMargin;
  NSDictionary *metrics = @{
    @"kBottomMargin" : @(safeContentMargin.bottom),
    @"kLeftMargin" : @(safeContentMargin.left),
    @"kRightMargin" : @(safeContentMargin.right),
    @"kTitleImagePadding" : @(kTitleImagePadding),
    @"kTopMargin" : @(safeContentMargin.top),
  };

  NSMutableDictionary *views = [NSMutableDictionary dictionary];
  views[@"label"] = self.label;
  if (self.imageView) {
    views[@"imageView"] = self.imageView;
  }

  NSString *formatString = nil;  // Scratch variable.
  NSMutableArray *constraints = [NSMutableArray array];

  // The label should take up the entire height of the content view.
  formatString = @"V:|[label]|";
  [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                           options:0
                                                                           metrics:metrics
                                                                             views:views]];

  // Pin the label to the trailing edge of the content view.
  formatString = @"H:[label]|";
  [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                           options:0
                                                                           metrics:metrics
                                                                             views:views]];

  if (self.imageView) {
    // Constrain the image view to be no taller than @c kMaximumImageSize.
    formatString = @"V:[imageView(<=kMaximumImageSize)]";
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];

    // Vertically center the image view within the content view.
    [constraints addObject:[NSLayoutConstraint constraintWithItem:self.imageView
                                                        attribute:NSLayoutAttributeCenterY
                                                        relatedBy:NSLayoutRelationEqual
                                                           toItem:self.contentView
                                                        attribute:NSLayoutAttributeCenterY
                                                       multiplier:1.0
                                                         constant:0]];

    // Constrain the image view to be no wider than @c kMaximumImageSize, and pin it to the leading
    // edge of the content view. Pin the label to the trailing edge of the image.
    formatString = @"H:|[imageView(<=kMaximumImageSize)]-(==kTitleImagePadding)-[label]";
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];
  } else {
    formatString = @"H:|[label]";
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];
  }

  return constraints;
}

/**
 Provides constraints positioning the buttons horizontally within the button container.
 */
- (NSArray *)horizontalButtonLayoutConstraints {
  NSMutableArray *constraints = [NSMutableArray array];
  UIEdgeInsets safeContentMargin = self.safeContentMargin;
  NSDictionary *metrics = @{
    @"kLeftMargin" : @(safeContentMargin.left),
    @"kRightMargin" : @(safeContentMargin.right),
    @"kTopMargin" : @(safeContentMargin.top),
    @"kBottomMargin" : @(safeContentMargin.bottom),
    @"kTitleImagePadding" : @(kTitleImagePadding),
    @"kBorderMargin" : @(kBorderWidth),
    @"kTitleButtonPadding" : @(kTitleButtonPadding),
    @"kButtonPadding" :
        @(MDCSnackbarMessage.usesLegacySnackbar ? kLegacyButtonPadding : kButtonPadding),
  };

  __block UIView *previousButton = nil;
  [self.buttons enumerateObjectsUsingBlock:^(UIView *buttonContainer, NSUInteger idx,
                                             __unused BOOL *stop) {
    // Convenience dictionary of views.
    NSMutableDictionary *views = [NSMutableDictionary dictionary];
    views[@"buttonContainer"] = buttonContainer;
    MDCButton *currentButton = [buttonContainer viewWithTag:kButtonTagStart + idx];
    views[@"button"] = currentButton;
    if (previousButton) {
      views[@"previousButton"] = previousButton;
    }

    // In a horizontal layout, the button takes on the height of the Snackbar.
    [constraints
        addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[buttonContainer]|"
                                                                    options:0
                                                                    metrics:metrics
                                                                      views:views]];

    // Ensure that the button is vertically centered in its container view
    NSLayoutConstraint *verticallyCenterConstraint =
        [NSLayoutConstraint constraintWithItem:currentButton
                                     attribute:NSLayoutAttributeCenterY
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:buttonContainer
                                     attribute:NSLayoutAttributeCenterY
                                    multiplier:1.0
                                      constant:0];
    [constraints addObject:verticallyCenterConstraint];

    // Pin the button to the width of its container.
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[button]|"
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];

    if (idx == 0) {
      // The first button should be pinned to the leading edge of the button view.
      [constraints addObjectsFromArray:[NSLayoutConstraint
                                           constraintsWithVisualFormat:@"H:|[buttonContainer]"
                                                               options:0
                                                               metrics:metrics
                                                                 views:views]];
    }

    if (idx == ([self.buttons count] - 1)) {
      // The last button should be pinned to the trailing edge of the button view.
      [constraints addObjectsFromArray:[NSLayoutConstraint
                                           constraintsWithVisualFormat:@"H:[buttonContainer]|"
                                                               options:0
                                                               metrics:metrics
                                                                 views:views]];
    }

    if (previousButton) {
      // If there was a button before this one, pin this one to it.
      NSString *formatString = @"H:[previousButton]-(==kButtonPadding)-[buttonContainer]";
      [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                               options:0
                                                                               metrics:metrics
                                                                                 views:views]];
    }
  }];

  return constraints;
}

- (void)layoutSubviews {
  [super layoutSubviews];

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

  // Figure out which of the elements is tallest, and use that for calculating our preferred height.
  // Images are forced to be no bigger than @c kMaximumImageSize.
  height = MAX(height, self.label.intrinsicContentSize.height);

  // Make sure that content margins are included in our calculation.
  height += self.safeContentMargin.top + self.safeContentMargin.bottom;

  // Make sure that the height of the image and text is larger than the minimum height;
  height = MAX(_isMultilineText ? kMinimumHeightMultiline : kMinimumHeight, height) +
           self.contentSafeBottomInset;

  return CGSizeMake(UIViewNoIntrinsicMetric, height);
}

- (CGFloat)contentSafeBottomInset {
  // If a bottom offset has been set to raise the HUD/Snackbar, e.g. above a tab bar, we should
  // ignore any safeAreaInsets, since it is no longer 'anchored' to the bottom of the screen. This
  // is set by the MDCSnackbarOverlayView whenever the bottomOffset is non-zero.
  if (!self.anchoredToScreenBottom || !MDCSnackbarMessage.usesLegacySnackbar) {
    return 0;
  }
  if (@available(iOS 11.0, *)) {
    return self.window.safeAreaInsets.bottom;
  }
  return 0;
}

- (UIEdgeInsets)safeContentMargin {
  UIEdgeInsets contentMargin = UIEdgeInsetsZero;
  if (MDCSnackbarMessage.usesLegacySnackbar) {
    contentMargin = kLegacyContentMargin;
  } else {
    contentMargin = _isMultilineText ? kContentMarginMutliLineText : kContentMarginSingleLineText;
  }

  UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
  if (@available(iOS 11.0, *)) {
    safeAreaInsets = self.window.safeAreaInsets;
  }

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
  [self dismissWithAction:nil userInitiated:YES];
}

- (void)handleButtonGutterTapped:(__unused UIControl *)sender {
  [self handleButtonTapped:nil];
}

- (void)handleButtonTapped:(__unused UIButton *)sender {
  [self dismissWithAction:self.message.action userInitiated:YES];
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
  return 1 + [self.buttons count];
}

- (id)accessibilityElementAtIndex:(NSInteger)index {
  if (index == 0) {
    return _label;
  }
  return [self.buttons objectAtIndex:(index - 1)];
}

- (NSInteger)indexOfAccessibilityElement:(id)element {
  if (element == _label) {
    return 0;
  }

  NSInteger buttonIndex = [self.buttons indexOfObject:element];
  if (buttonIndex == NSNotFound) {
    return NSNotFound;
  }
  return buttonIndex + 1;
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
  [self.buttonView.layer addAnimation:opacityAnimation forKey:@"opacity"];
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

#pragma mark - Dynamic Type Support

- (BOOL)mdc_adjustsFontForContentSizeCategory {
  return _mdc_adjustsFontForContentSizeCategory;
}

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  _mdc_adjustsFontForContentSizeCategory = adjusts;

  if (_mdc_adjustsFontForContentSizeCategory) {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(contentSizeCategoryDidChange:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
  } else {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
  }

  [self updateMessageFont];
  [self updateButtonFont];
}

// Handles UIContentSizeCategoryDidChangeNotifications
- (void)contentSizeCategoryDidChange:(__unused NSNotification *)notification {
  [self updateMessageFont];
  [self updateButtonFont];
}

#pragma mark - Elevation

- (CGFloat)mdc_currentElevation {
  return self.elevation;
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
  BOOL result = [super pointInside:point withEvent:event];
  BOOL accessibilityEnabled =
      UIAccessibilityIsVoiceOverRunning() || UIAccessibilityIsSwitchControlRunning();
  if (!result && !accessibilityEnabled && _shouldDismissOnOverlayTap) {
    [self dismissWithAction:nil userInitiated:YES];
  }
  return result;
}

@end
