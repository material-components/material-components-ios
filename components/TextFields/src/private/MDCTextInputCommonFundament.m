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

#import "MDCTextInputArt.h"
#import "MDCTextInputCommonFundament.h"

#import "MaterialAnimationTiming.h"
#import "MaterialMath.h"
#import "MaterialPalettes.h"
#import "MaterialTypography.h"

static NSString *const MDCTextInputFundamentTextInputKey = @"MDCTextInputFundamentTextInputKey";
static NSString *const MDCTextInputFundamentClearButtonKey = @"MDCTextInputFundamentClearButtonKey";
static NSString *const MDCTextInputFundamentClearButtonColorKey =
    @"MDCTextInputFundamentClearButtonColorKey";
static NSString *const MDCTextInputFundamentClearButtonImageKey =
    @"MDCTextInputFundamentClearButtonImageKey";
static NSString *const MDCTextInputFundamentHidesPlaceholderKey =
    @"MDCTextInputFundamentHidesPlaceholderKey";
static NSString *const MDCTextInputFundamentLeadingLabelKey =
    @"MDCTextInputFundamentLeadingLabelKey";
static NSString *const MDCTextInputFundamentMDCAdjustsFontsKey =
    @"MDCTextInputFundamentMDCAdjustsFontsKey";
static NSString *const MDCTextInputPositioningDelegateKey = @"MDCTextInputPositioningDelegateKey";
static NSString *const MDCTextInputFundamentPlaceholderLabelKey =
    @"MDCTextInputFundamentPlaceholderLabelKey";
static NSString *const MDCTextInputFundamentTextColorKey = @"MDCTextInputFundamentTextColorKey";
static NSString *const MDCTextInputFundamentTrailingLabelKey =
    @"MDCTextInputFundamentTrailingLabelKey";
static NSString *const MDCTextInputFundamentTrailingViewKey =
    @"MDCTextInputFundamentTrailingViewKey";
static NSString *const MDCTextInputFundamentUnderlineViewKey =
    @"MDCTextInputFundamentUnderlineViewKey";

static NSString *const MDCTextInputUnderlineKVOKeyColor = @"color";
static NSString *const MDCTextInputUnderlineKVOKeyLineHeight = @"lineHeight";

static const CGFloat MDCTextInputClearButtonImageBuiltInPadding = 2.5f;
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

@property(nonatomic, strong) NSLayoutConstraint *clearButtonWidth;
@property(nonatomic, strong) NSLayoutConstraint *placeholderHeight;
@property(nonatomic, strong) NSLayoutConstraint *placeholderLeading;
@property(nonatomic, strong) NSLayoutConstraint *placeholderLeadingLeftViewTrailing;
@property(nonatomic, strong) NSLayoutConstraint *placeholderTop;
@property(nonatomic, strong) NSLayoutConstraint *placeholderTrailing;
@property(nonatomic, strong) NSLayoutConstraint *placeholderTrailingRightViewLeading;
@property(nonatomic, strong) NSLayoutConstraint *underlineY;

@property(nonatomic, strong) UIImage *clearButtonImage;

@property(nonatomic, weak) UIView<MDCTextInput> *textInput;

@end

@implementation MDCTextInputCommonFundament

// We never use the text property. Instead always read from the text field.

@synthesize attributedText = _do_no_use_attributedText;
@synthesize clearButton = _clearButton;
@synthesize clearButtonColor = _clearButtonColor;
@synthesize clearButtonMode = _clearButtonMode;
@synthesize enabled = _enabled;
@synthesize hidesPlaceholderOnInput = _hidesPlaceholderOnInput;
@synthesize leadingUnderlineLabel = _leadingUnderlineLabel;
@synthesize placeholderLabel = _placeholderLabel;
@synthesize positioningDelegate = _positioningDelegate;
@synthesize textColor = _textColor;
@synthesize trailingUnderlineLabel = _trailingUnderlineLabel;
@synthesize trailingView = _trailingView;
@synthesize trailingViewMode = _trailingViewMode;
@synthesize underline = _underline;

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
    [self setupClearButton];
    [self setupUnderlineLabels];

    [self updateColors];
    [self mdc_setAdjustsFontForContentSizeCategory:NO];

    [self subscribeForKVO];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super init];
  if (self) {
    [self commonMDCTextInputCommonFundamentInit];

    _clearButton = [aDecoder decodeObjectForKey:MDCTextInputFundamentClearButtonKey];
    _clearButtonImage = [aDecoder decodeObjectForKey:MDCTextInputFundamentClearButtonImageKey];
    _clearButtonColor = [aDecoder decodeObjectForKey:MDCTextInputFundamentClearButtonColorKey];
    _hidesPlaceholderOnInput = [aDecoder decodeBoolForKey:MDCTextInputFundamentHidesPlaceholderKey];
    _leadingUnderlineLabel = [aDecoder decodeObjectForKey:MDCTextInputFundamentLeadingLabelKey];
    _mdc_adjustsFontForContentSizeCategory =
        [aDecoder decodeBoolForKey:MDCTextInputFundamentMDCAdjustsFontsKey];
    _placeholderLabel = [aDecoder decodeObjectForKey:MDCTextInputFundamentPlaceholderLabelKey];
    _positioningDelegate = [aDecoder decodeObjectForKey:MDCTextInputPositioningDelegateKey];
    _textInput = [aDecoder decodeObjectForKey:MDCTextInputFundamentTextInputKey];
    _textColor = [aDecoder decodeObjectForKey:MDCTextInputFundamentTextColorKey];
    _trailingUnderlineLabel = [aDecoder decodeObjectForKey:MDCTextInputFundamentTrailingLabelKey];
    _trailingViewMode =
        (UITextFieldViewMode)[aDecoder decodeIntegerForKey:MDCTextInputFundamentTrailingViewKey];
    _underline = [aDecoder decodeObjectForKey:MDCTextInputFundamentUnderlineViewKey];

    [self subscribeForKVO];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [aCoder encodeObject:self.clearButton forKey:MDCTextInputFundamentClearButtonKey];
  [aCoder encodeObject:self.clearButtonColor forKey:MDCTextInputFundamentClearButtonColorKey];
  [aCoder encodeObject:self.clearButtonImage forKey:MDCTextInputFundamentClearButtonImageKey];
  [aCoder encodeBool:self.hidesPlaceholderOnInput forKey:MDCTextInputFundamentHidesPlaceholderKey];
  [aCoder encodeObject:self.leadingUnderlineLabel forKey:MDCTextInputFundamentLeadingLabelKey];
  [aCoder encodeBool:self.mdc_adjustsFontForContentSizeCategory
              forKey:MDCTextInputFundamentMDCAdjustsFontsKey];
  [aCoder encodeObject:self.placeholderLabel forKey:MDCTextInputFundamentPlaceholderLabelKey];
  [aCoder encodeObject:self.positioningDelegate forKey:MDCTextInputPositioningDelegateKey];
  [aCoder encodeConditionalObject:self.textInput forKey:MDCTextInputFundamentTextInputKey];
  [aCoder encodeObject:self.textColor forKey:MDCTextInputFundamentTextColorKey];
  [aCoder encodeObject:self.trailingUnderlineLabel forKey:MDCTextInputFundamentTrailingLabelKey];
  [aCoder encodeInteger:self.trailingViewMode forKey:MDCTextInputFundamentTrailingViewKey];
  [aCoder encodeObject:self.underline forKey:MDCTextInputFundamentUnderlineViewKey];
}

- (instancetype)copyWithZone:(NSZone *)zone {
  MDCTextInputCommonFundament *copy =
      [[MDCTextInputCommonFundament alloc] initWithTextInput:self.textInput];

  copy.clearButtonColor = self.clearButtonColor;
  copy.clearButtonImage = self.clearButtonImage;
  copy.clearButtonMode = self.clearButtonMode;
  copy.enabled = self.isEnabled;
  copy.hidesPlaceholderOnInput = self.hidesPlaceholderOnInput;
  copy.mdc_adjustsFontForContentSizeCategory = self.mdc_adjustsFontForContentSizeCategory;
  copy.positioningDelegate = self.positioningDelegate;
  copy.text = [self.text copy];
  copy.textColor = self.textColor;
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

  NSLayoutConstraint *bottom = [NSLayoutConstraint
      constraintWithItem:_clearButton
               attribute:NSLayoutAttributeBottom
               relatedBy:NSLayoutRelationEqual
                  toItem:self.underline
               attribute:NSLayoutAttributeTop
              multiplier:1
                constant:-1 * MDCTextInputHalfPadding + MDCTextInputClearButtonImageBuiltInPadding];
  bottom.priority = UILayoutPriorityDefaultLow;

  self.placeholderTrailing = [NSLayoutConstraint constraintWithItem:_placeholderLabel
                                                          attribute:NSLayoutAttributeTrailing
                                                          relatedBy:NSLayoutRelationLessThanOrEqual
                                                             toItem:_clearButton
                                                          attribute:NSLayoutAttributeTrailing
                                                         multiplier:1
                                                           constant:MDCTextInputHalfPadding];
  self.placeholderTrailing.priority = UILayoutPriorityDefaultLow;

  NSLayoutConstraint *trailingSuperview =
      [NSLayoutConstraint constraintWithItem:_clearButton
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:_textInput
                                   attribute:NSLayoutAttributeTrailing
                                  multiplier:1
                                    constant:MDCTextInputClearButtonImageBuiltInPadding];
  trailingSuperview.priority = UILayoutPriorityDefaultLow;

  [NSLayoutConstraint activateConstraints:@[
    height, self.clearButtonWidth, bottom, self.placeholderLeading, trailingSuperview
  ]];

  [_clearButton addTarget:self
                   action:@selector(clearButtonDidTouch)
         forControlEvents:UIControlEventTouchUpInside];
}

- (void)setupPlaceholderLabel {
  _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectZero];
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

  NSLayoutConstraint *leadingLeading =
      [NSLayoutConstraint constraintWithItem:_leadingUnderlineLabel
                                   attribute:NSLayoutAttributeLeading
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:_textInput
                                   attribute:NSLayoutAttributeLeading
                                  multiplier:1
                                    constant:0];
  leadingLeading.priority = UILayoutPriorityDefaultLow;

  NSLayoutConstraint *trailingTrailing =
      [NSLayoutConstraint constraintWithItem:_trailingUnderlineLabel
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:_textInput
                                   attribute:NSLayoutAttributeTrailing
                                  multiplier:1
                                    constant:0];
  trailingTrailing.priority = UILayoutPriorityDefaultLow;

  NSLayoutConstraint *labelSpacing =
      [NSLayoutConstraint constraintWithItem:_leadingUnderlineLabel
                                   attribute:NSLayoutAttributeTrailing
                                   relatedBy:NSLayoutRelationEqual
                                      toItem:_trailingUnderlineLabel
                                   attribute:NSLayoutAttributeLeading
                                  multiplier:1
                                    constant:0];
  labelSpacing.priority = UILayoutPriorityDefaultLow;

  [NSLayoutConstraint activateConstraints:@[ labelSpacing, leadingLeading, trailingTrailing ]];

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

- (MDCTextInputUnderlineView *)setupUnderlineView {
  MDCTextInputUnderlineView *underline =
      [[MDCTextInputUnderlineView alloc] initWithFrame:CGRectZero];
  underline.color = MDCTextInputUnderlineColor();
  underline.translatesAutoresizingMaskIntoConstraints = NO;

  [self.textInput addSubview:underline];
  [self.textInput sendSubviewToBack:underline];

  return underline;
}

- (void)unsubscribeFromNotifications {
  NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
  [defaultCenter removeObserver:self];
}

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
  } @catch (NSException *exception) {
    NSLog(@"Tried to unsubscribe from KVO in MDCTextInputCommonFundament but could not.");
  }
  _isRegisteredForKVO = NO;
}

#pragma mark - Mirrored Layout Methods

- (void)layoutSubviewsOfInput {
  [self updatePlaceholderAlpha];

  if ([self needsUpdateConstraintsForPlaceholderToOverlayViewsPosition]) {
    [self.textInput setNeedsUpdateConstraints];
  }

  [self updateColors];
  [self updateClearButton];
}

- (void)updateConstraintsOfInput {
  [self updateClearButtonConstraint];
  [self updatePlaceholderPosition];
}

#pragma mark - Clear Button Implementation

- (void)updateClearButton {
  CGSize clearButtonSize = CGSizeMake(MDCTextInputClearButtonImageSquareWidthHeight,
                                      MDCTextInputClearButtonImageSquareWidthHeight);
  if (!self.clearButtonImage || !CGSizeEqualToSize(self.clearButtonImage.size, clearButtonSize)) {
    self.clearButtonImage =
        [self drawnClearButtonImage:clearButtonSize color:self.clearButtonColor];
  }

  if (![self.clearButton imageForState:UIControlStateNormal]) {
    [self.clearButton setImage:self.clearButtonImage forState:UIControlStateNormal];
    [self.clearButton setImage:self.clearButtonImage forState:UIControlStateHighlighted];
    [self.clearButton setImage:self.clearButtonImage forState:UIControlStateSelected];
  }

  CGFloat clearButtonAlpha = [self clearButtonAlpha];
  self.clearButton.alpha = clearButtonAlpha;

  if (self.clearButtonWidth.constant !=
      MDCTextInputClearButtonImageSquareWidthHeight * clearButtonAlpha) {
    [self.textInput setNeedsUpdateConstraints];
  }

  [self.clearButton.superview bringSubviewToFront:self.clearButton];
}

- (void)updateClearButtonConstraint {
  CGFloat constant = MDCTextInputClearButtonImageSquareWidthHeight * [self clearButtonAlpha];
  if (self.clearButtonWidth.constant != constant) {
    self.clearButtonWidth.constant = constant;
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

  if (self.textInput.trailingView.superview && !MDCCGFloatEqual(self.textInput.trailingView.alpha, 0.f)) {
    clearButtonAlpha = 0;
  }

  return clearButtonAlpha;
}

- (UIImage *)drawnClearButtonImage:(CGSize)size color:(UIColor *)color {
  NSAssert1(size.width >= 0, @"drawnClearButtonImage was passed a size with a width less than 0 %@",
            NSStringFromCGSize(size));
  NSAssert1(size.height >= 0,
            @"drawnClearButtonImage was passed a size with a height less than 0 %@",
            NSStringFromCGSize(size));

  if (CGSizeEqualToSize(size, CGSizeZero)) {
    size = CGSizeMake(MDCTextInputClearButtonImageSquareWidthHeight,
                      MDCTextInputClearButtonImageSquareWidthHeight);
  }
  CGFloat scale = [UIScreen mainScreen].scale;
  CGRect bounds = CGRectMake(0, 0, size.width * scale, size.height * scale);
  UIGraphicsBeginImageContextWithOptions(bounds.size, false, scale);
  [color setFill];
  [MDCPathForClearButtonImageFrame(bounds) fill];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();

  return image;
}

- (void)clearButtonDidTouch {
  self.textInput.text = nil;
}

#pragma mark - Properties Implementation

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

- (void)setClearButtonColor:(UIColor *)clearButtonColor {
  if (![_clearButtonColor isEqual:clearButtonColor]) {
    _clearButtonColor = clearButtonColor;
    self.clearButtonImage =
        [self drawnClearButtonImage:self.clearButtonImage.size color:_clearButtonColor];
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
  return _textInput.textInsets;
}

- (void)setTrailingView:(UIView *)trailingView {
  if (_trailingView != trailingView) {
    [_trailingView removeFromSuperview];
    [self.textInput addSubview:trailingView];
    _trailingView = trailingView;
    [self.textInput setNeedsUpdateConstraints];
  }
}

- (MDCTextInputUnderlineView *)underline {
  if (!_underline) {
    _underline = [self setupUnderlineView];
  }

  return _underline;
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
                                    constant:insets.right];
  placeholderTrailing.priority = UILayoutPriorityDefaultLow;

  return @[ self.placeholderTop, self.placeholderLeading, placeholderTrailing ];
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
                        change:(NSDictionary<NSKeyValueChangeKey, id> *)change
                       context:(void *)context {
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

- (void)contentSizeCategoryDidChange:(NSNotification *)notification {
  [self updateFontsForDynamicType];
}

@end
