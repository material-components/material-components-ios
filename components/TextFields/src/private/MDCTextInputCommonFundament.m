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

#import "MaterialTextFields.h"

#import "MDCPaddedLabel.h"
#import "MDCTextInputArt.h"
#import "MDCTextInputBorderView.h"
#import "MDCTextInputCommonFundament.h"

#import "MaterialAnimationTiming.h"
#import "MaterialMath.h"
#import "MaterialPalettes.h"
#import "MaterialTypography.h"

static NSString *const MDCTextInputFundamentBorderPathKey = @"MDCTextInputFundamentBorderPathKey";
static NSString *const MDCTextInputFundamentBorderViewKey = @"MDCTextInputFundamentBorderViewKey";
static NSString *const MDCTextInputFundamentClearButtonKey = @"MDCTextInputFundamentClearButtonKey";
static NSString *const MDCTextInputFundamentHidesPlaceholderKey =
    @"MDCTextInputFundamentHidesPlaceholderKey";
static NSString *const MDCTextInputFundamentLeadingLabelKey =
    @"MDCTextInputFundamentLeadingLabelKey";
static NSString *const MDCTextInputFundamentMDCAdjustsFontsKey =
    @"MDCTextInputFundamentMDCAdjustsFontsKey";
static NSString *const MDCTextInputFundamentPlaceholderLabelKey =
    @"MDCTextInputFundamentPlaceholderLabelKey";
static NSString *const MDCTextInputFundamentPositioningDelegateKey =
    @"MDCTextInputFundamentPositioningDelegateKey";
static NSString *const MDCTextInputFundamentTextColorKey = @"MDCTextInputFundamentTextColorKey";
static NSString *const MDCTextInputFundamentTextInputKey = @"MDCTextInputFundamentTextInputKey";
static NSString *const MDCTextInputFundamentTextInsetsModeKey =
    @"MDCTextInputFundamentTextInsetsModeKey";
static NSString *const MDCTextInputFundamentTrailingLabelKey =
    @"MDCTextInputFundamentTrailingLabelKey";
static NSString *const MDCTextInputFundamentTrailingViewKey =
    @"MDCTextInputFundamentTrailingViewKey";
static NSString *const MDCTextInputFundamentUnderlineViewKey =
    @"MDCTextInputFundamentUnderlineViewKey";

static NSString *const MDCTextInputUnderlineKVOKeyColor = @"color";
static NSString *const MDCTextInputUnderlineKVOKeyLineHeight = @"lineHeight";

const CGFloat MDCTextInputBorderRadius = 4.f;
static const CGFloat MDCTextInputClearButtonImageSquareWidthHeight = 24.f;
static const CGFloat MDCTextInputHintTextOpacity = 0.54f;
static const CGFloat MDCTextInputOverlayViewToEditingRectPadding = 2.f;
const CGFloat MDCTextInputFullPadding = 16.f;
const CGFloat MDCTextInputHalfPadding = 8.f;

static inline UIColor *_Nonnull MDCTextInputCursorColor() {
  return [MDCPalette bluePalette].accent700;
}

static inline UIColor *MDCTextInputDefaultPlaceholderTextColor() {
  return [UIColor colorWithWhite:0 alpha:MDCTextInputHintTextOpacity];
}

static inline UIColor *MDCTextInputTextColor() {
  return [UIColor colorWithWhite:0 alpha:[MDCTypography body1FontOpacity]];
}

static inline UIColor *MDCTextInputUnderlineColor() {
  return [UIColor lightGrayColor];
}

@interface MDCTextInputCommonFundament () {
  BOOL _mdc_adjustsFontForContentSizeCategory;
}

@property(nonatomic, assign) BOOL isRegisteredForKVO;

@property(nonatomic, strong) NSLayoutConstraint *clearButtonCenterY;
@property(nonatomic, strong) NSLayoutConstraint *clearButtonTrailing;
@property(nonatomic, strong) NSLayoutConstraint *clearButtonWidth;
@property(nonatomic, strong) NSLayoutConstraint *leadingUnderlineLeading;
@property(nonatomic, strong) NSLayoutConstraint *trailingUnderlineTrailing;
@property(nonatomic, strong) NSLayoutConstraint *placeholderLeading;
@property(nonatomic, strong) NSLayoutConstraint *placeholderLeadingLeftViewTrailing;
@property(nonatomic, strong) NSLayoutConstraint *placeholderTop;
@property(nonatomic, strong) NSLayoutConstraint *placeholderTrailing;
@property(nonatomic, strong) NSLayoutConstraint *placeholderTrailingRightViewLeading;

@property(nonatomic, weak) UIView<MDCTextInput> *textInput;

@end

@implementation MDCTextInputCommonFundament

// We never use the text property. Instead always read from the text field.

@synthesize attributedText = _do_no_use_attributedText;
@synthesize borderPath = _borderPath;
@synthesize borderView = _borderView;
@synthesize clearButton = _clearButton;
@synthesize clearButtonMode = _clearButtonMode;
@synthesize enabled = _enabled;
@synthesize hidesPlaceholderOnInput = _hidesPlaceholderOnInput;
@synthesize leadingUnderlineLabel = _leadingUnderlineLabel;
@synthesize placeholderLabel = _placeholderLabel;
@synthesize positioningDelegate = _positioningDelegate;
@synthesize textColor = _textColor;
@synthesize trailingUnderlineLabel = _trailingUnderlineLabel;
@synthesize trailingViewMode = _trailingViewMode;
@synthesize underline = _underline;
@synthesize textInsetsMode = _textInsetsMode;

- (instancetype)init {
  [self doesNotRecognizeSelector:_cmd];
  return nil;
}

- (nonnull instancetype)initWithTextInput:(UIView<MDCTextInput> *_Nonnull)textInput {
  self = [super init];
  if (self) {
    _textInput = textInput;

    [self commonMDCTextInputCommonFundamentInit];
    self.textInput.font = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleBody1];

    // Initialize elements of UI
    [self setupPlaceholderLabel];
    [self setupUnderlineView];
    [self setupClearButton];
    [self setupUnderlineLabels];

    [self updateColors];
    [self mdc_setAdjustsFontForContentSizeCategory:NO];

    [self setupBorder];
    [self subscribeForKVO];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    [self commonMDCTextInputCommonFundamentInit];

    _borderPath = [aDecoder decodeObjectForKey:MDCTextInputFundamentBorderPathKey];
    _borderView = [aDecoder decodeObjectForKey:MDCTextInputFundamentBorderViewKey];
    _clearButton = [aDecoder decodeObjectForKey:MDCTextInputFundamentClearButtonKey];
    _hidesPlaceholderOnInput = [aDecoder decodeBoolForKey:MDCTextInputFundamentHidesPlaceholderKey];
    _leadingUnderlineLabel = [aDecoder decodeObjectForKey:MDCTextInputFundamentLeadingLabelKey];
    _mdc_adjustsFontForContentSizeCategory =
        [aDecoder decodeBoolForKey:MDCTextInputFundamentMDCAdjustsFontsKey];
    _placeholderLabel = [aDecoder decodeObjectForKey:MDCTextInputFundamentPlaceholderLabelKey];
    _positioningDelegate =
        [aDecoder decodeObjectForKey:MDCTextInputFundamentPositioningDelegateKey];
    _textInput = [aDecoder decodeObjectForKey:MDCTextInputFundamentTextInputKey];
    _textColor = [aDecoder decodeObjectForKey:MDCTextInputFundamentTextColorKey];
    if ([aDecoder containsValueForKey:MDCTextInputFundamentTextInsetsModeKey]) {
      _textInsetsMode = (MDCTextInputTextInsetsMode)
          [aDecoder decodeIntegerForKey:MDCTextInputFundamentTextInsetsModeKey];
    }
    _trailingUnderlineLabel = [aDecoder decodeObjectForKey:MDCTextInputFundamentTrailingLabelKey];
    _trailingViewMode =
        (UITextFieldViewMode)[aDecoder decodeIntegerForKey:MDCTextInputFundamentTrailingViewKey];
    _underline = [aDecoder decodeObjectForKey:MDCTextInputFundamentUnderlineViewKey];

    [self setupBorder];
    [self subscribeForKVO];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.borderPath forKey:MDCTextInputFundamentBorderPathKey];
  [aCoder encodeObject:self.borderView forKey:MDCTextInputFundamentBorderViewKey];
  [aCoder encodeObject:self.clearButton forKey:MDCTextInputFundamentClearButtonKey];
  [aCoder encodeBool:self.hidesPlaceholderOnInput forKey:MDCTextInputFundamentHidesPlaceholderKey];
  [aCoder encodeObject:self.leadingUnderlineLabel forKey:MDCTextInputFundamentLeadingLabelKey];
  [aCoder encodeBool:self.mdc_adjustsFontForContentSizeCategory
              forKey:MDCTextInputFundamentMDCAdjustsFontsKey];
  [aCoder encodeObject:self.placeholderLabel forKey:MDCTextInputFundamentPlaceholderLabelKey];
  [aCoder encodeObject:self.positioningDelegate forKey:MDCTextInputFundamentPositioningDelegateKey];
  [aCoder encodeConditionalObject:self.textInput forKey:MDCTextInputFundamentTextInputKey];
  [aCoder encodeObject:self.textColor forKey:MDCTextInputFundamentTextColorKey];
  [aCoder encodeInteger:self.textInsetsMode forKey:MDCTextInputFundamentTextInsetsModeKey];
  [aCoder encodeObject:self.trailingUnderlineLabel forKey:MDCTextInputFundamentTrailingLabelKey];
  [aCoder encodeInteger:self.trailingViewMode forKey:MDCTextInputFundamentTrailingViewKey];
  [aCoder encodeObject:self.underline forKey:MDCTextInputFundamentUnderlineViewKey];
}

- (instancetype)copyWithZone:(__unused NSZone *)zone {
  MDCTextInputCommonFundament *copy =
      [[MDCTextInputCommonFundament alloc] initWithTextInput:self.textInput];

  copy.borderPath = self.borderPath.copy;
  if ([self.borderView conformsToProtocol:@protocol(NSCopying)]) {
    copy.borderView = self.borderView.copy;
  }
  copy.clearButtonMode = self.clearButtonMode;
  copy.enabled = self.isEnabled;
  copy.hidesPlaceholderOnInput = self.hidesPlaceholderOnInput;
  copy.mdc_adjustsFontForContentSizeCategory = self.mdc_adjustsFontForContentSizeCategory;
  copy.positioningDelegate = self.positioningDelegate;
  copy.text = [self.text copy];
  copy.textColor = self.textColor;
  copy.textInsetsMode = self.textInsetsMode;
  copy.trailingViewMode = self.trailingViewMode;
  copy.underline.lineHeight = self.underline.lineHeight;
  copy.underline.color = self.underline.color;

  return copy;
}

- (void)dealloc {
  [self unsubscribeFromNotifications];
  [self unsubscribeFromKVO];
}

- (void)commonMDCTextInputCommonFundamentInit {
  _cursorColor = MDCTextInputCursorColor();
  _textColor = MDCTextInputTextColor();
  _textInsetsMode = MDCTextInputTextInsetsModeIfContent;
  _clearButtonMode = UITextFieldViewModeWhileEditing;
}

- (void)setupClearButton {
  _clearButton = [[UIButton alloc] initWithFrame:CGRectZero];
  _clearButton.translatesAutoresizingMaskIntoConstraints = NO;
  [_clearButton setContentCompressionResistancePriority:UILayoutPriorityDefaultLow - 1
                                                forAxis:UILayoutConstraintAxisHorizontal];
  [_clearButton setContentCompressionResistancePriority:UILayoutPriorityDefaultLow - 1
                                                forAxis:UILayoutConstraintAxisVertical];
  [_clearButton setContentHuggingPriority:UILayoutPriorityDefaultLow + 1
                                  forAxis:UILayoutConstraintAxisHorizontal];
  [_clearButton setContentHuggingPriority:UILayoutPriorityDefaultLow + 1
                                  forAxis:UILayoutConstraintAxisVertical];

  _clearButton.opaque = NO;

  [_textInput addSubview:_clearButton];
  [_textInput sendSubviewToBack:_clearButton];

  NSLayoutConstraint *height = [NSLayoutConstraint constraintWithItem:_clearButton
                                                            attribute:NSLayoutAttributeHeight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:_clearButton
                                                            attribute:NSLayoutAttributeWidth
                                                           multiplier:1
                                                             constant:0];
  height.priority = UILayoutPriorityDefaultLow;

  self.clearButtonWidth =
      [NSLayoutConstraint constraintWithItem:_clearButton
                                   attribute:NSLayoutAttributeWidth
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:nil
                                   attribute:NSLayoutAttributeNotAnAttribute
                                  multiplier:1
                                    constant:MDCTextInputClearButtonImageSquareWidthHeight];
  self.clearButtonWidth.priority = UILayoutPriorityDefaultLow;

  UIEdgeInsets insets = [self textInsets];
  CGFloat scale = UIScreen.mainScreen.scale;
  CGFloat centerYConstant = insets.top +
      (MDCCeil(self.textInput.font.lineHeight * scale) / scale) / 2.f;
  self.clearButtonCenterY = [NSLayoutConstraint
      constraintWithItem:_clearButton
               attribute:NSLayoutAttributeCenterY
               relatedBy:NSLayoutRelationEqual
                  toItem:_textInput
               attribute:NSLayoutAttributeTop
              multiplier:1
                constant:centerYConstant];
  self.clearButtonCenterY.priority = UILayoutPriorityDefaultLow;

  self.placeholderTrailing = [NSLayoutConstraint constraintWithItem:_placeholderLabel
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationLessThanOrEqual
                                                             toItem:_clearButton
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1
                                                           constant:MDCTextInputHalfPadding];
  self.placeholderTrailing.priority = UILayoutPriorityDefaultLow;

  self.clearButtonTrailing = [NSLayoutConstraint
      constraintWithItem:_clearButton
               attribute:NSLayoutAttributeTrailing
               relatedBy:NSLayoutRelationEqual
                  toItem:_textInput
               attribute:NSLayoutAttributeTrailing
              multiplier:1
                constant:-1 *
                         (MDCTextInputClearButtonImageBuiltInPadding + insets.right)];
  self.clearButtonTrailing.priority = UILayoutPriorityDefaultLow;

  [NSLayoutConstraint activateConstraints:@[
    height, self.clearButtonWidth, self.clearButtonCenterY, self.placeholderLeading,
    self.clearButtonTrailing
  ]];

  [_clearButton addTarget:self
                   action:@selector(clearButtonDidTouch)
         forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupPlaceholderLabel {
  _placeholderLabel = [[MDCPaddedLabel alloc] initWithFrame:CGRectZero];
  _placeholderLabel.translatesAutoresizingMaskIntoConstraints = NO;
  [_placeholderLabel setContentCompressionResistancePriority:UILayoutPriorityDefaultLow - 1
                                                     forAxis:UILayoutConstraintAxisHorizontal];
  _placeholderLabel.textAlignment = NSTextAlignmentNatural;

  _placeholderLabel.userInteractionEnabled = NO;
  _placeholderLabel.opaque = NO;

  _placeholderLabel.textColor = MDCTextInputDefaultPlaceholderTextColor();
  _placeholderLabel.font = _textInput.font;

  [_textInput addSubview:_placeholderLabel];
  [_textInput sendSubviewToBack:_placeholderLabel];

  [NSLayoutConstraint activateConstraints:[self placeholderDefaultConstaints]];

  _hidesPlaceholderOnInput = YES;
}

- (void)setupUnderlineLabels {
  _leadingUnderlineLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  _trailingUnderlineLabel = [[UILabel alloc] initWithFrame:CGRectZero];

  _leadingUnderlineLabel.textColor = MDCTextInputDefaultPlaceholderTextColor();
  _leadingUnderlineLabel.font = _textInput.font;
  _leadingUnderlineLabel.textAlignment = NSTextAlignmentNatural;

  _leadingUnderlineLabel.opaque = NO;

  [_leadingUnderlineLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
  [_textInput addSubview:_leadingUnderlineLabel];

  _trailingUnderlineLabel.textColor = [UIColor grayColor];
  _trailingUnderlineLabel.font = _textInput.font;

  _trailingUnderlineLabel.opaque = NO;

  [_trailingUnderlineLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
  [_textInput addSubview:_trailingUnderlineLabel];

  _leadingUnderlineLeading = [NSLayoutConstraint constraintWithItem:_leadingUnderlineLabel
                                                          attribute:NSLayoutAttributeLeading
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:_textInput
                                                          attribute:NSLayoutAttributeLeading
                                                         multiplier:1
                                                           constant:0];
  _leadingUnderlineLeading.priority = UILayoutPriorityDefaultLow;

  _trailingUnderlineTrailing = [NSLayoutConstraint constraintWithItem:_trailingUnderlineLabel
                                                            attribute:NSLayoutAttributeTrailing
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:_textInput
                                                            attribute:NSLayoutAttributeTrailing
                                                           multiplier:1
                                                             constant:0];
  _trailingUnderlineTrailing.priority = UILayoutPriorityDefaultLow;

  NSLayoutConstraint *labelSpacing =
      [NSLayoutConstraint constraintWithItem:_leadingUnderlineLabel
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:_trailingUnderlineLabel
                                   attribute:NSLayoutAttributeLeading
                                  multiplier:1
                                    constant:0];
  labelSpacing.priority = UILayoutPriorityDefaultLow;

  [NSLayoutConstraint
      activateConstraints:@[ labelSpacing, _leadingUnderlineLeading, _trailingUnderlineTrailing ]];

  NSLayoutConstraint *leadingBottom = [NSLayoutConstraint constraintWithItem:_leadingUnderlineLabel
                                                                   attribute:NSLayoutAttributeBottom
                                                                   relatedBy:NSLayoutRelationEqual
                                                                      toItem:_textInput
                                                                   attribute:NSLayoutAttributeBottom
                                                                  multiplier:1
                                                                    constant:0];
  leadingBottom.priority = UILayoutPriorityDefaultLow;

  NSLayoutConstraint *trailingBottom =
      [NSLayoutConstraint constraintWithItem:_trailingUnderlineLabel
                                   attribute:NSLayoutAttributeBottom
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:_textInput
                                   attribute:NSLayoutAttributeBottom
                                  multiplier:1
                                    constant:0];
  trailingBottom.priority = UILayoutPriorityDefaultLow;

  [NSLayoutConstraint activateConstraints:@[ leadingBottom, trailingBottom ]];

  [_trailingUnderlineLabel
      setContentCompressionResistancePriority:UILayoutPriorityRequired
                                      forAxis:UILayoutConstraintAxisHorizontal];
  [_trailingUnderlineLabel setContentHuggingPriority:UILayoutPriorityRequired
                                             forAxis:UILayoutConstraintAxisHorizontal];
}

- (void)setupUnderlineView {
  _underline =
      [[MDCTextInputUnderlineView alloc] initWithFrame:CGRectZero];
  _underline.color = MDCTextInputUnderlineColor();
  _underline.translatesAutoresizingMaskIntoConstraints = NO;

  [self.textInput addSubview:_underline];
  [self.textInput sendSubviewToBack:_underline];
}

#pragma mark - Border implementation

- (void)setupBorder {
  if (!_borderView) {
    _borderView = [[MDCTextInputBorderView alloc] initWithFrame:CGRectZero];
    ;
    [self.textInput addSubview:_borderView];
    [self.textInput sendSubviewToBack:_borderView];
    _borderView.translatesAutoresizingMaskIntoConstraints = NO;

    NSArray<NSLayoutConstraint *> *constraints =
        [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[border]|"
                                                options:0
                                                metrics:nil
                                                  views:@{
                                                    @"border" : _borderView
                                                  }];
    constraints = [constraints
        arrayByAddingObjectsFromArray:[NSLayoutConstraint
                                          constraintsWithVisualFormat:@"H:|[border]|"
                                                              options:0
                                                              metrics:nil
                                                                views:@{
                                                                  @"border" : _borderView
                                                                }]];
    for (NSLayoutConstraint *constraint in constraints) {
      constraint.priority = UILayoutPriorityDefaultLow;
    }
    [NSLayoutConstraint activateConstraints:constraints];
  }
}

- (void)unsubscribeFromNotifications {
  NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
  [defaultCenter removeObserver:self];
}

#pragma mark - KVO Subscription

- (void)subscribeForKVO {
  if (!_underline) {
    return;
  }
  [self.underline addObserver:self
                   forKeyPath:MDCTextInputUnderlineKVOKeyColor
                      options:0
                      context:nil];
  [self.underline addObserver:self
                   forKeyPath:MDCTextInputUnderlineKVOKeyLineHeight
                      options:0
                      context:nil];
  _isRegisteredForKVO = YES;
}

- (void)unsubscribeFromKVO {
  if (!_underline || !self.isRegisteredForKVO) {
    return;
  }
  @try {
    [_underline removeObserver:self forKeyPath:MDCTextInputUnderlineKVOKeyColor];
    [_underline removeObserver:self forKeyPath:MDCTextInputUnderlineKVOKeyLineHeight];
  } @catch (__unused NSException *exception) {
    NSLog(@"Tried to unsubscribe from KVO in MDCTextInputCommonFundament but could not.");
  }
  _isRegisteredForKVO = NO;
}

#pragma mark - Mirrored Layout Methods

- (void)layoutSubviewsOfInput {
  [self updatePlaceholderAlpha];
  [self.textInput sendSubviewToBack:_borderView];

  if ([self needsUpdateConstraintsForPlaceholderToOverlayViewsPosition]) {
    [self.textInput setNeedsUpdateConstraints];
  }

  [self updateColors];
  [self updateClearButton];
}

- (void)updateConstraintsOfInput {
  [self updateClearButtonConstraints];
  [self updatePlaceholderPosition];
  [self updateUnderlineLabels];
}

#pragma mark - Clear Button Implementation

- (void)updateClearButton {
  UIImage *image = self.clearButton.currentImage
                       ? self.clearButton.currentImage
                       : [self drawnClearButtonImage:self.clearButton.tintColor];

  if (![self.clearButton imageForState:UIControlStateNormal]) {
    [self.clearButton setImage:image forState:UIControlStateNormal];
    [self.clearButton setImage:image forState:UIControlStateHighlighted];
    [self.clearButton setImage:image forState:UIControlStateSelected];
  }

  CGFloat clearButtonAlpha = [self clearButtonAlpha];
  self.clearButton.alpha = clearButtonAlpha;

  if (self.clearButtonWidth.constant !=
      MDCTextInputClearButtonImageSquareWidthHeight * clearButtonAlpha) {
    [self.textInput setNeedsUpdateConstraints];
  }

  [self.clearButton.superview bringSubviewToFront:self.clearButton];
}

- (void)updateClearButtonConstraints {
  BOOL shouldInvalidateSize = NO;
  CGFloat widthConstant = MDCTextInputClearButtonImageSquareWidthHeight * [self clearButtonAlpha];
  if (self.clearButtonWidth.constant != widthConstant) {
    self.clearButtonWidth.constant = widthConstant;
    shouldInvalidateSize = YES;
  }

  UIEdgeInsets insets = [self textInsets];

  CGFloat trailingConstant = MDCTextInputClearButtonImageBuiltInPadding - insets.right;
  if (self.clearButtonTrailing.constant != trailingConstant) {
    self.clearButtonTrailing.constant = trailingConstant;
    shouldInvalidateSize = YES;
  }

  CGFloat scale = UIScreen.mainScreen.scale;
  CGFloat centerYConstant = insets.top +
      (MDCCeil(self.textInput.font.lineHeight * scale) / scale) / 2.f;
  if (self.clearButtonCenterY.constant != centerYConstant) {
    self.clearButtonCenterY.constant = centerYConstant;
    shouldInvalidateSize = YES;
  }

  if (shouldInvalidateSize) {
    [self.textInput invalidateIntrinsicContentSize];
  }
}

- (CGFloat)clearButtonAlpha {
  CGFloat clearButtonAlpha = 0;
  if (self.text.length > 0) {
    switch (self.clearButtonMode) {
      case UITextFieldViewModeAlways:
        clearButtonAlpha = 1;
        break;
      case UITextFieldViewModeWhileEditing:
        if (self.isEditing) {
          clearButtonAlpha = 1;
        }
        break;
      case UITextFieldViewModeUnlessEditing:
        if (!self.isEditing) {
          clearButtonAlpha = 1;
        }
        break;
      default:
        break;
    }
  }

  if (self.trailingView.superview &&
      !MDCCGFloatEqual(self.trailingView.alpha, 0.f)) {
    clearButtonAlpha = 0;
  }

  return clearButtonAlpha;
}

- (UIImage *)drawnClearButtonImage:(UIColor *)color {
  CGSize clearButtonSize = CGSizeMake(MDCTextInputClearButtonImageSquareWidthHeight,
                                      MDCTextInputClearButtonImageSquareWidthHeight);

  CGFloat scale = [UIScreen mainScreen].scale;
  CGRect bounds = CGRectMake(0, 0, clearButtonSize.width * scale, clearButtonSize.height * scale);
  UIGraphicsBeginImageContextWithOptions(bounds.size, false, scale);
  [color setFill];

  [MDCPathForClearButtonImageFrame(bounds) fill];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  return image;
}

- (void)clearButtonDidTouch {
  self.textInput.text = nil;
}

#pragma mark - Properties Implementation

- (void)setTextInsetsMode:(MDCTextInputTextInsetsMode)textInsetsMode {
  if (_textInsetsMode != textInsetsMode) {
    _textInsetsMode = textInsetsMode;
    [self.textInput invalidateIntrinsicContentSize];
  }
}

- (NSAttributedString *)attributedPlaceholder {
  id placeholderString = self.placeholderLabel.text;
  if ([placeholderString isKindOfClass:[NSString class]]) {
    // TODO: (larche) Return string attributes also. Tho I feel like that should come from the
    // placeholderLabel itself somehow.
    NSAttributedString *constructedString =
        [[NSAttributedString alloc] initWithString:(NSString *)placeholderString attributes:nil];
    return constructedString;
  } else if ([placeholderString isKindOfClass:[NSAttributedString class]]) {
    return (NSAttributedString *)placeholderString;
  }

  return nil;
}

- (void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
  self.placeholderLabel.text = attributedPlaceholder.string;
  // TODO: (larche) Read string attributes also. Tho I feel like that should come from the
  // placeholderLabel itself somehow.

  [self updatePlaceholderAlpha];
  [self.textInput setNeedsUpdateConstraints];
}

- (void)setBorderPath:(UIBezierPath *)borderPath {
  if (_borderPath != borderPath) {
    _borderPath = [UIBezierPath bezierPathWithCGPath:borderPath.CGPath];
  }
}

- (void)setClearButtonMode:(UITextFieldViewMode)clearButtonMode {
  _clearButtonMode = clearButtonMode;
  [self updateClearButton];
}

- (void)setEnabled:(BOOL)enabled {
  _enabled = enabled;
  self.underline.enabled = enabled;
}

- (UIFont *)font {
  return self.textInput.font;
}

- (void)setFont:(UIFont *)font {
  [self.textInput setFont:font];
}

- (void)setHidesPlaceholderOnInput:(BOOL)hidesPlaceholderOnInput {
  _hidesPlaceholderOnInput = hidesPlaceholderOnInput;
  [self updatePlaceholderAlpha];
}

- (BOOL)isEditing {
  return self.textInput.isEditing;
}

- (NSString *)placeholder {
  id placeholderString = self.placeholderLabel.text;
  if ([placeholderString isKindOfClass:[NSString class]]) {
    return (NSString *)placeholderString;
  } else if ([placeholderString isKindOfClass:[NSAttributedString class]]) {
    return [(NSAttributedString *)placeholderString string];
  }

  return nil;
}

- (void)setPlaceholder:(NSString *)placeholder {
  self.placeholderLabel.text = placeholder;
  [self updatePlaceholderAlpha];
  [self.textInput setNeedsLayout];
}

- (NSString *)text {
  return self.textInput.text;
}

- (void)setText:(NSString *)text {
  [self.textInput setText:text];
}

- (void)setTextColor:(UIColor *)textColor {
  if (!textColor) {
    textColor = MDCTextInputTextColor();
  }

  if (_textColor != textColor) {
    _textColor = textColor;
    [self updateColors];
  }
}

- (void)setTextInput:(UIView<MDCTextInput> *)textInput {
  _textInput = textInput;

  [_textInput setNeedsLayout];
}

- (UIEdgeInsets)textInsets {
  UIEdgeInsets textInsets = UIEdgeInsetsZero;

  textInsets.top = MDCTextInputFullPadding;

  CGFloat scale = UIScreen.mainScreen.scale;
  CGFloat leadingOffset = MDCCeil(self.leadingUnderlineLabel.font.lineHeight * scale) / scale;
  CGFloat trailingOffset = MDCCeil(self.trailingUnderlineLabel.font.lineHeight * scale) / scale;

  // The amount of space underneath the underline is variable. It could just be
  // MDCTextInputHalfPadding or the biggest estimated underlineLabel height +
  // MDCTextInputHalfPadding. It's also dependent on the .textInsetsMode.

  // contentConditionalOffset will have the estimated text height for the largest underline label
  // that also has text.
  CGFloat contentConditionalOffset = 0;
  if (self.leadingUnderlineLabel.text.length) {
    contentConditionalOffset = leadingOffset;
  }
  if (self.trailingUnderlineLabel.text.length) {
    contentConditionalOffset = MAX(contentConditionalOffset, trailingOffset);
  }

  CGFloat underlineOffset = MDCTextInputHalfPadding;
  switch (self.textInsetsMode) {
    case MDCTextInputTextInsetsModeAlways:
      underlineOffset += MAX(leadingOffset, trailingOffset);
      break;
    case MDCTextInputTextInsetsModeIfContent:
      underlineOffset += contentConditionalOffset;
      break;
    case MDCTextInputTextInsetsModeNever:
      break;
  }

  // .bottom = underlineOffset + the half padding ABOVE the line but below the text field
  textInsets.bottom = underlineOffset + MDCTextInputHalfPadding;

  if ([self.positioningDelegate respondsToSelector:@selector(textInsets:)]) {
    return [self.positioningDelegate textInsets:textInsets];
  }
  return textInsets;
}

- (UIView *)trailingView {
  return self.textInput.trailingView;
}

- (void)setTrailingView:(UIView *)trailingView {
  self.textInput.trailingView = trailingView;
}

#pragma mark - Layout

- (void)updateColors {
  self.textInput.tintColor = self.cursorColor;
  self.textInput.textColor = self.textColor;
}

- (void)updateFontsForDynamicType {
  if (self.mdc_adjustsFontForContentSizeCategory) {
    UIFont *textFont = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleBody1];
    self.textInput.font = textFont;
    self.leadingUnderlineLabel.font = textFont;
    self.trailingUnderlineLabel.font = textFont;
    self.placeholderLabel.font = textFont;
  }
}

- (BOOL)needsUpdateConstraintsForPlaceholderToOverlayViewsPosition {
  if (![self.textInput isKindOfClass:[MDCTextField class]]) {
    return NO;
  }

  MDCTextField *textField = (MDCTextField *)self.textInput;

  return (textField.leftView.superview && !self.placeholderLeadingLeftViewTrailing) ||
         (!textField.leftView.superview && self.placeholderLeadingLeftViewTrailing) ||
         (textField.rightView.superview && !self.placeholderTrailingRightViewLeading) ||
         (!textField.rightView.superview && self.placeholderTrailingRightViewLeading);
}

- (void)updatePlaceholderToOverlayViewsPosition {
  if (![self.textInput isKindOfClass:[MDCTextField class]]) {
    return;
  }

  MDCTextField *textField = (MDCTextField *)self.textInput;
  if (textField.leftView.superview && !self.placeholderLeadingLeftViewTrailing) {
    self.placeholderLeadingLeftViewTrailing =
        [NSLayoutConstraint constraintWithItem:textField.placeholderLabel
                                     attribute:NSLayoutAttributeLeading
                                     relatedBy:NSLayoutRelationEqual
                                        toItem:textField.leftView
                                     attribute:NSLayoutAttributeTrailing
                                    multiplier:1
                                      constant:MDCTextInputOverlayViewToEditingRectPadding];
    self.placeholderLeadingLeftViewTrailing.priority = UILayoutPriorityDefaultLow + 1;
    self.placeholderLeadingLeftViewTrailing.active = YES;
  } else if (!textField.leftView.superview && self.placeholderLeadingLeftViewTrailing) {
    self.placeholderLeadingLeftViewTrailing = nil;
  }

  if (textField.rightView.superview && !self.placeholderTrailingRightViewLeading) {
    self.placeholderTrailingRightViewLeading =
        [NSLayoutConstraint constraintWithItem:textField.placeholderLabel
                                     attribute:NSLayoutAttributeTrailing
                                     relatedBy:NSLayoutRelationLessThanOrEqual
                                        toItem:textField.rightView
                                     attribute:NSLayoutAttributeLeading
                                    multiplier:1
                                      constant:MDCTextInputOverlayViewToEditingRectPadding];
    self.placeholderTrailingRightViewLeading.priority = UILayoutPriorityDefaultLow + 1;
    self.placeholderTrailingRightViewLeading.active = YES;
  } else if (!textField.rightView.superview && self.placeholderTrailingRightViewLeading) {
    self.placeholderTrailingRightViewLeading = nil;
  }

  [textField invalidateIntrinsicContentSize];
}

- (void)updatePlaceholderAlpha {
  CGFloat opacity = (self.hidesPlaceholderOnInput && self.textInput.text.length > 0) ? 0 : 1;
  self.placeholderLabel.alpha = opacity;
}

- (void)updatePlaceholderPosition {
  self.placeholderTop.constant = _textInput.textInsets.top;
  self.placeholderLeading.constant = _textInput.textInsets.left;
  self.placeholderTrailing.constant = -1 * _textInput.textInsets.right;

  [self updatePlaceholderToOverlayViewsPosition];
  [self.textInput invalidateIntrinsicContentSize];
}

- (NSArray<NSLayoutConstraint *> *)placeholderDefaultConstaints {
  UIEdgeInsets insets = ((MDCTextField *)_textInput).textInsets;

  self.placeholderTop = [NSLayoutConstraint constraintWithItem:_placeholderLabel
                                                     attribute:NSLayoutAttributeTop
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:_textInput
                                                     attribute:NSLayoutAttributeTop
                                                    multiplier:1
                                                      constant:insets.top];
  [self.placeholderTop setPriority:UILayoutPriorityDefaultLow];

  // This can be affected by .leftView and .rightView.
  // See updatePlaceholderToOverlayViewsPosition()
  self.placeholderLeading = [NSLayoutConstraint constraintWithItem:_placeholderLabel
                                                         attribute:NSLayoutAttributeLeading
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:_textInput
                                                         attribute:NSLayoutAttributeLeading
                                                        multiplier:1
                                                          constant:insets.left];
  [self.placeholderLeading setPriority:UILayoutPriorityDefaultLow];

  NSLayoutConstraint *placeholderTrailing =
      [NSLayoutConstraint constraintWithItem:_placeholderLabel
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationLessThanOrEqual
                                      toItem:_textInput
                                   attribute:NSLayoutAttributeTrailing
                                  multiplier:1
                                    constant:-1 * insets.right];
  placeholderTrailing.priority = UILayoutPriorityDefaultLow;

  return @[ self.placeholderTop, self.placeholderLeading, placeholderTrailing ];
}

- (void)updateUnderlineLabels {
  UIEdgeInsets textInsets = self.textInsets;

  self.leadingUnderlineLeading.constant = textInsets.left;
  self.trailingUnderlineTrailing.constant = -1 * textInsets.right;
}

#pragma mark - Text Input Events

- (void)didBeginEditing {
  [self updateClearButton];
  [self.textInput invalidateIntrinsicContentSize];
}

- (void)didChange {
  [self updateClearButton];
  [self updatePlaceholderAlpha];
  [self updatePlaceholderPosition];
}

- (void)didEndEditing {
  [self updateClearButton];
}

- (void)didSetFont {
  UIFont *font = self.textInput.font;
  self.placeholderLabel.font = font;

  [self updatePlaceholderPosition];
}

- (void)didSetText {
  [self didChange];
  [self.textInput setNeedsLayout];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(__unused NSDictionary<NSKeyValueChangeKey, id> *)change
                       context:(__unused void *)context {
  // Listening to outside setting of underline properties.
  if (object != self.underline) {
    return;
  }

  if ([keyPath isEqualToString:MDCTextInputUnderlineKVOKeyColor]) {
    if (!self.underline.color) {
      self.underline.color = MDCTextInputUnderlineColor();
    }
    [self updateColors];
  } else if ([keyPath isEqualToString:MDCTextInputUnderlineKVOKeyLineHeight]) {
    [self.textInput setNeedsUpdateConstraints];
  } else {
    return;
  }
}

#pragma mark - Accessibility

- (BOOL)mdc_adjustsFontForContentSizeCategory {
  return _mdc_adjustsFontForContentSizeCategory;
}

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  _mdc_adjustsFontForContentSizeCategory = adjusts;

  if (adjusts) {
    [self updateFontsForDynamicType];
  }

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
}

- (void)contentSizeCategoryDidChange:(__unused NSNotification *)notification {
  [self updateFontsForDynamicType];
}

@end
