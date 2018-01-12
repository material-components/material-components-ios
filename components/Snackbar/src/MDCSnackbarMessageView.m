/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import <QuartzCore/QuartzCore.h>

#import "MDCSnackbarMessage.h"
#import "MDCSnackbarMessageView.h"
#import "MaterialAnimationTiming.h"
#import "MaterialButtons.h"
#import "MaterialTypography.h"
#import "private/MaterialSnackbarStrings.h"
#import "private/MaterialSnackbarStrings_table.h"
#import "private/MDCSnackbarMessageViewInternal.h"
#import "private/MDCSnackbarOverlayView.h"

NSString *const MDCSnackbarMessageTitleAutomationIdentifier =
    @"MDCSnackbarMessageTitleAutomationIdentifier";

// The Bundle for string resources.
static NSString *const kMaterialSnackbarBundle = @"MaterialSnackbar.bundle";

static inline UIColor *MDCRGBAColor(uint8_t r, uint8_t g, uint8_t b, float a) {
  return [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:(a)];
}

/**
 The thickness of the snackbar border.
 */
static const CGFloat kBorderWidth = 0;

/**
 Shadow coloring.
 */
static const CGFloat kShadowAlpha = 0.24f;
static const CGSize kShadowOffset = (CGSize){0.0, 1.0};
static const CGFloat kShadowSpread = 1.0f;

/**
 The radius of the corners.
 */
static const CGFloat kCornerRadius = 0;

/**
 Padding between the edges of the snackbar and any content.
 */
static UIEdgeInsets kContentMargin = (UIEdgeInsets){18.0, 24.0, 18.0, 24.0};

/**
 Padding between the image and the main title.
 */
static const CGFloat kTitleImagePadding = 8.0f;

/**
 Padding between the main title and the first button.
 */
static const CGFloat kTitleButtonPadding = 8.0f;

/**
 Padding on the edges of the buttons.
 */
static const CGFloat kButtonPadding = 5.0f;

/**
 The width of the snackbar.
 */
static const CGFloat kMinimumViewWidth_iPad = 288.0f;
static const CGFloat kMaximumViewWidth_iPad = 568.0f;
static const CGFloat kMinimumViewWidth_iPhone = 320.0f;
static const CGFloat kMaximumViewWidth_iPhone = 320.0f;

/**
 The minimum height of the snackbar.
 */
static const CGFloat kMinimumHeight = 48.0f;

/**
 Each button will have a tag indexed starting from this value.
 */
static const NSInteger kButtonTagStart = 20000;

/**
 The ink radius of the action button.
 */
static const CGFloat kButtonInkRadius = 64.0f;

#if defined(__IPHONE_10_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0)
@interface MDCSnackbarMessageView () <CAAnimationDelegate>
@end
#endif

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
 Holds onto the dismissal handler, called when the snackbar should dismiss due to user interaction.
 */
@property(nonatomic, copy) MDCSnackbarMessageDismissHandler dismissalHandler;

@end

@interface MDCSnackbarMessageViewButton : MDCFlatButton
@end

@implementation MDCSnackbarMessageViewButton

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.inkMaxRippleRadius = kButtonInkRadius;
    self.inkColor = [UIColor colorWithWhite:1 alpha:0.06f];
    self.inkStyle = MDCInkStyleUnbounded;
  }
  return self;
}

@end

@implementation MDCSnackbarMessageView {
  UIFont *_messageFont;
  UIFont *_buttonFont;

  // Holds the instances of MDCButton
  NSMutableArray<MDCButton *> *_actionButtons;
}

+ (void)initialize {
  [[self appearance] setSnackbarMessageViewShadowColor:MDCRGBAColor(0x00, 0x00, 0x00, 1.0f)];
  [[self appearance] setSnackbarMessageViewBackgroundColor:MDCRGBAColor(0x32, 0x32, 0x32, 1.0f)];
  [[self appearance] setSnackbarMessageViewTextColor:MDCRGBAColor(0xFF, 0xFF, 0xFF, 1.0f)];
}

- (void)dismissWithAction:(MDCSnackbarMessageAction *)action userInitiated:(BOOL)userInitiated {
  if (self.dismissalHandler) {
    self.dismissalHandler(userInitiated, action);

    // In case our dismissal handler has a reference to us, release the block.
    self.dismissalHandler = nil;
  }
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

- (UIColor *)snackbarButtonTextColor {
  return MDCRGBAColor(0xFF, 0xFF, 0xFF, 0.6f);
}

- (UIColor *)snackbarButtonTextColorHighlighted {
  return MDCRGBAColor(0xFF, 0xFF, 0xFF, 1.0f);
}

- (UIColor *)snackbarSeparatorColor {
  return MDCRGBAColor(0xFF, 0xFF, 0xFF, 0.5f);
}

- (void)setSnackbarMessageViewBackgroundColor:(UIColor *)snackbarMessageViewBackgroundColor {
  _snackbarMessageViewBackgroundColor = snackbarMessageViewBackgroundColor;
  self.backgroundColor = snackbarMessageViewBackgroundColor;
}

- (void)setSnackbarShadowColor:(UIColor *)snackbarMessageViewShadowColor {
  _snackbarMessageViewShadowColor = snackbarMessageViewShadowColor;
  self.layer.shadowColor = snackbarMessageViewShadowColor.CGColor;
}

- (void)setSnackbarMessageViewTextColor:(UIColor *)snackbarMessageViewTextColor {
  _snackbarMessageViewTextColor = snackbarMessageViewTextColor;
  self.label.textColor = _snackbarMessageViewTextColor;
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
    // TODO(#2709): Migrate to a single source of truth for fonts
    // There is no custom font, so use the default font.
    // If we are using the default (system) font loader, retrieve the
    // font from the UIFont standardFont API.
    if ([MDCTypography.fontLoader isKindOfClass:[MDCSystemFontLoader class]]) {
      _label.font = [UIFont mdc_standardFontForMaterialTextStyle:MDCFontTextStyleBody2];
    } else {
      // There is a custom font loader, retrieve the font from it.
      _label.font = [MDCTypography body2Font];
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

  // If we have a custom font apply it to the button.
  // If not, fall back to the Material specified font.
  if (_buttonFont) {
    finalButtonFont = _buttonFont;
  } else {
    // TODO(#2709): Migrate to a single source of truth for fonts
    // There is no custom font, so use the default font.
    // If we are using the default (system) font loader, retrieve the
    // font from the UIFont standardFont API.
    if ([MDCTypography.fontLoader isKindOfClass:[MDCSystemFontLoader class]]) {
      finalButtonFont = [UIFont mdc_standardFontForMaterialTextStyle:MDCFontTextStyleButton];
    } else {
      // There is a custom font loader, retrieve the font from it.
      finalButtonFont = [MDCTypography buttonFont];
    }
  }

  for (MDCButton *button in _actionButtons) {
    [button setTitleFont:finalButtonFont forState:UIControlStateNormal];
    [button setTitleFont:finalButtonFont forState:UIControlStateHighlighted];
  }

  [self setNeedsLayout];
}

- (instancetype)initWithMessage:(MDCSnackbarMessage *)message
                 dismissHandler:(MDCSnackbarMessageDismissHandler)handler {
  self = [super init];
  if (self) {
    _message = message;
    _dismissalHandler = [handler copy];

    self.backgroundColor = _snackbarMessageViewBackgroundColor;
    self.layer.cornerRadius = kCornerRadius;
    self.layer.shadowColor = _snackbarMessageViewShadowColor.CGColor;
    self.layer.shadowOpacity = kShadowAlpha;
    self.layer.shadowOffset = kShadowOffset;
    self.layer.shadowRadius = kShadowSpread;

    _anchoredToScreenEdge = YES;

    // Borders are drawn inside of the bounds of a layer. Because our border is translucent, we need
    // to have a view with transparent background and border only (@c self). Inside will be a
    // content view that has the dark grey color.
    _containerView = [[UIControl alloc] init];
    [self addSubview:_containerView];

    [_containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    _containerView.backgroundColor = [UIColor clearColor];
    _containerView.layer.cornerRadius = kCornerRadius;
    _containerView.layer.masksToBounds = YES;

    // Listen for taps on the background of the view.
    [_containerView addTarget:self
                       action:@selector(handleBackgroundTapped:)
             forControlEvents:UIControlEventTouchUpInside];

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

    NSMutableAttributedString *messageString = [message.attributedText mutableCopy];

    // Find any of the bold attributes in the string, and set the proper font for those ranges.
    // Use NSAttributedStringEnumerationLongestEffectiveRangeNotRequired as opposed to 0, otherwise
    // it will only work if bold text is in the end.
    [messageString
        enumerateAttribute:MDCSnackbarMessageBoldAttributeName
                   inRange:NSMakeRange(0, messageString.length)
                   options:NSAttributedStringEnumerationLongestEffectiveRangeNotRequired
                usingBlock:^(id value, NSRange range, __unused BOOL *stop) {
                  UIFont *font = [MDCTypography body1Font];
                  if ([value boolValue]) {
                    font = [MDCTypography body2Font];
                  }
                  [messageString setAttributes:@{ NSFontAttributeName : font } range:range];
                }];

    // Apply 'global' attributes along the whole string.
    _label.backgroundColor = [UIColor clearColor];
    _label.textAlignment = NSTextAlignmentNatural;
    _label.attributedText = messageString;
    _label.numberOfLines = 0;
    [_label setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_label setContentCompressionResistancePriority:UILayoutPriorityDefaultHigh
                                            forAxis:UILayoutConstraintAxisHorizontal];
    [_label setContentHuggingPriority:UILayoutPriorityDefaultLow
                              forAxis:UILayoutConstraintAxisHorizontal];

    NSString *accessibilityHintKey =
        kMaterialSnackbarStringTable[kStr_MaterialSnackbarMessageViewTitleA11yHint];
    NSString *accessibilityHint =
        NSLocalizedStringFromTableInBundle(accessibilityHintKey,
                                           kMaterialSnackbarStringsTableName,
                                           [[self class] bundle],
                                           @"Dismissal accessibility hint for Snackbar");

    // For VoiceOver purposes, the label is the primary 'button' for dismissing the snackbar, so
    // we'll make sure the label looks like a button.
    _label.accessibilityTraits = UIAccessibilityTraitButton;
    _label.accessibilityIdentifier = MDCSnackbarMessageTitleAutomationIdentifier;
    _label.accessibilityHint = accessibilityHint;

    // If an accessibility label was set on the message model object, use that instead of the text
    // in the label.
    if ([message.accessibilityLabel length]) {
      _label.accessibilityLabel = message.accessibilityLabel;
    }

    // Figure out how much horizontal space the main text needs, in order to decide if the buttons
    // are laid out horizontally or vertically.
    __block CGFloat availableTextWidth = UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad
                                             ? kMaximumViewWidth_iPad
                                             : kMaximumViewWidth_iPhone;

    // Take into account the content padding.
    availableTextWidth -= (self.safeContentMargin.left + self.safeContentMargin.right);

    // If there are buttons, account for the padding between the title and the buttons.
    if (message.action) {
      availableTextWidth -= kTitleButtonPadding;
    }

    UIColor *textColor = [self snackbarButtonTextColor];
    UIColor *textColorHighlighted = [self snackbarButtonTextColorHighlighted];

    _label.textColor = textColor;

    if (message.buttonTextColor) {
      textColor = message.buttonTextColor;
    }

    if (message.highlightedButtonTextColor) {
      textColorHighlighted = message.highlightedButtonTextColor;
    }

    // Add buttons to the view. We'll use this opportunity to determine how much space a button will
    // need, to inform the layout direction.
    NSMutableArray *actions = [NSMutableArray array];
    if (message.action) {
      UIView *buttonView = [[UIView alloc] init];
      [buttonView setTranslatesAutoresizingMaskIntoConstraints:NO];
      [_buttonView addSubview:buttonView];

      MDCButton *button = [[MDCSnackbarMessageViewButton alloc] init];
      if (_buttonFont) {
        [button setTitleFont:_buttonFont forState:UIControlStateNormal];
        [button setTitleFont:_buttonFont forState:UIControlStateHighlighted];
      }
      [button setTitleColor:textColor forState:UIControlStateNormal];
      [button setTitleColor:textColorHighlighted forState:UIControlStateHighlighted];
      [button setTranslatesAutoresizingMaskIntoConstraints:NO];
      button.tag = kButtonTagStart;
      [buttonView addSubview:button];
      [_actionButtons addObject:button];

      // Style the text in the button.
      button.titleLabel.numberOfLines = 1;
      button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
      button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
      button.contentEdgeInsets = UIEdgeInsetsMake(0, kButtonPadding, 0, kButtonPadding);

      // Set up the button's accessibility values.
      button.accessibilityIdentifier = message.action.accessibilityIdentifier;
      button.accessibilityHint = message.action.accessibilityHint;

      [button setTitle:message.action.title forState:UIControlStateNormal];
      [button setTitle:message.action.title forState:UIControlStateHighlighted];

      if (message.buttonTextColor) {
        [button setTitleColor:textColor forState:UIControlStateNormal];
      }

      // Make sure the button doesn't get too compressed.
      [button setContentCompressionResistancePriority:UILayoutPriorityRequired
                                              forAxis:UILayoutConstraintAxisHorizontal];
      [button setContentHuggingPriority:UILayoutPriorityDefaultHigh
                                forAxis:UILayoutConstraintAxisHorizontal];
      [button addTarget:self
                    action:@selector(handleButtonTapped:)
          forControlEvents:UIControlEventTouchUpInside];

      CGSize buttonSize = [button sizeThatFits:CGSizeMake(CGFLOAT_MAX,CGFLOAT_MAX)];
      availableTextWidth -= buttonSize.width;
      availableTextWidth -= 2 * kButtonPadding;

      [actions addObject:buttonView];
    }

    self.buttons = actions;
  }

  return self;
}

- (BOOL)shouldWaitForDismissalDuringVoiceover {
  return self.message.action != nil;
}

#pragma mark - Constraints and layout

- (void)setAnchoredToScreenEdge:(BOOL)anchoredToScreenEdge {
  _anchoredToScreenEdge = anchoredToScreenEdge;
  [self invalidateIntrinsicContentSize];

  if (self.viewConstraints) {
    [self removeConstraints:self.viewConstraints];
    self.viewConstraints = nil;
    [self updateConstraints];
  }
}

- (void)updateConstraints {
  [super updateConstraints];

  if (self.viewConstraints) {
    return;
  }

  NSMutableArray *constraints = [NSMutableArray array];

  [constraints addObjectsFromArray:[self containerViewConstraints]];
  [constraints addObjectsFromArray:[self contentViewConstraints]];
  [constraints addObjectsFromArray:[self horizontalButtonLayoutConstraints]];

  [self addConstraints:constraints];
  self.viewConstraints = constraints;
}

/**
 Provides constraints to pin the container view to the size of the snackbar, inset by
 @c kBorderWidth. Also positions the content view and button view inside of the container view.
 */
- (NSArray *)containerViewConstraints {
  NSDictionary *metrics = @{
    @"kBorderMargin" : @(kBorderWidth),
    @"kBottomMargin" : @(self.safeContentMargin.bottom),
    @"kLeftMargin" : @(self.safeContentMargin.left),
    @"kRightMargin" : @(self.safeContentMargin.right),
    @"kTitleImagePadding" : @(kTitleImagePadding),
    @"kTopMargin" : @(self.safeContentMargin.top),
    @"kTitleButtonPadding" : @(kTitleButtonPadding),
    @"kContentSafeBottomInset" : @(kBorderWidth +  self.contentSafeBottomInset),
  };
  NSDictionary *views = @{
    @"container" : self.containerView,
    @"content" : self.contentView,
    @"buttons" : self.buttonView,
  };

  BOOL hasButtons = (self.buttons.count > 0);

  NSString *formatString = nil;  // Scratch variable.
  NSMutableArray *constraints = [NSMutableArray array];

  // Pin the left and right edges of the container view to the snackbar.
  formatString = @"H:|-(==kBorderMargin)-[container]-(==kBorderMargin)-|";
  [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                           options:0
                                                                           metrics:metrics
                                                                             views:views]];

  // Pin the top and bottom edges of the container view to the snackbar.
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
    // Align the content and buttons horizontally.
    formatString = @"H:[content]-(==kTitleButtonPadding)-[buttons]-(==kRightMargin)-|";
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];

    // The buttons should take up the entire height of the container view.
    formatString = @"V:|[buttons]|";
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:formatString
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];

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
  NSDictionary *metrics = @{
    @"kBottomMargin" : @(self.safeContentMargin.bottom),
    @"kLeftMargin" : @(self.safeContentMargin.left),
    @"kRightMargin" : @(self.safeContentMargin.right),
    @"kTitleImagePadding" : @(kTitleImagePadding),
    @"kTopMargin" : @(self.safeContentMargin.top),
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

  NSDictionary *metrics = @{
    @"kLeftMargin" : @(self.safeContentMargin.left),
    @"kRightMargin" : @(self.safeContentMargin.right),
    @"kTopMargin" : @(self.safeContentMargin.top),
    @"kBottomMargin" : @(self.safeContentMargin.bottom),
    @"kTitleImagePadding" : @(kTitleImagePadding),
    @"kBorderMargin" : @(kBorderWidth),
    @"kTitleButtonPadding" : @(kTitleButtonPadding),
    @"kButtonPadding" : @(kButtonPadding),
  };

  __block UIView *previousButton = nil;
  [self.buttons enumerateObjectsUsingBlock:^(UIView *button, NSUInteger idx, __unused BOOL *stop) {
    // Convenience dictionary of views.
    NSMutableDictionary *views = [NSMutableDictionary dictionary];
    views[@"buttonContainer"] = button;
    views[@"button"] = [button viewWithTag:kButtonTagStart + idx];
    if (previousButton) {
      views[@"previousButton"] = previousButton;
    }

    // In a horizontal layout, the button takes on the height of the snackbar.
    [constraints
        addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[buttonContainer]|"
                                                                    options:0
                                                                    metrics:metrics
                                                                      views:views]];

    // Pin the button to the height of its container.
    [constraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[button]|"
                                                                             options:0
                                                                             metrics:metrics
                                                                               views:views]];

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

  // As our layout changes, make sure that the shadow path is kept up-to-date.
  UIBezierPath *path =
      [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:kCornerRadius];
  self.layer.shadowPath = path.CGPath;
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
  height = MAX(kMinimumHeight, height);

  height = MAX(kMinimumHeight, height) + self.contentSafeBottomInset;
  return CGSizeMake(UIViewNoIntrinsicMetric, height);
}

- (CGFloat)contentSafeBottomInset {
  // If a bottom offset has been set to raise the HUD, e.g. above a tab bar, we should ignore
  // any safeAreaInsets, since it is no longer 'anchored' to the bottom of the screen. This is set
  // by the MDCSnackbarOverlayView whenever the bottomOffset is non-zero.
  if (!self.anchoredToScreenEdge) {
    return 0;
  }
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    return self.window.safeAreaInsets.bottom;
  }
#endif
  return 0;
}

- (UIEdgeInsets)safeContentMargin {
  UIEdgeInsets contentMargin = kContentMargin;

  UIEdgeInsets safeAreaInsets = UIEdgeInsetsZero;
#if defined(__IPHONE_11_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_11_0)
  if (@available(iOS 11.0, *)) {
    safeAreaInsets = self.window.safeAreaInsets;
  }
#endif

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
  translationAnimation.duration = MDCSnackbarTransitionDuration;
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
  translationAnimation.duration = MDCSnackbarTransitionDuration;
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

@end
