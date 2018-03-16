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

#import "MDCButton.h"

#import <MDFTextAccessibility/MDFTextAccessibility.h>
#import "MaterialInk.h"
#import "MaterialMath.h"
#import "MaterialShadowElevations.h"
#import "MaterialShadowLayer.h"
#import "MaterialTypography.h"
#import "private/MDCButton+Subclassing.h"

// TODO(ajsecord): Animate title color when animating between enabled/disabled states.
// Non-trivial: http://corecocoa.wordpress.com/2011/10/04/animatable-text-color-of-uilabel/

static NSString *const MDCButtonEnabledBackgroundColorKey = @"MDCButtonEnabledBackgroundColorKey";
static NSString *const MDCButtonDisabledBackgroundColorLightKey =
    @"MDCButtonDisabledBackgroundColorLightKey";
static NSString *const MDCButtonDisabledBackgroundColorDarkKey =
    @"MDCButtonDisabledBackgroundColorDarkKey";
static NSString *const MDCButtonInkViewInkStyleKey = @"MDCButtonInkViewInkStyleKey";
static NSString *const MDCButtonInkViewInkColorKey = @"MDCButtonInkViewInkColorKey";
static NSString *const MDCButtonInkViewInkMaxRippleRadiusKey =
    @"MDCButtonInkViewInkMaxRippleRadiusKey";
static NSString *const MDCButtonShouldRaiseOnTouchKey = @"MDCButtonShouldRaiseOnTouchKey";
// Previous value kept for backwards compatibility.
static NSString *const MDCButtonUppercaseTitleKey = @"MDCButtonShouldCapitalizeTitleKey";
// Previous value kept for backwards compatibility.
static NSString *const MDCButtonUnderlyingColorHintKey = @"MDCButtonUnderlyingColorKey";
static NSString *const MDCButtonDisableAlphaKey = @"MDCButtonDisableAlphaKey";
static NSString *const MDCButtonEnableAlphaKey = @"MDCButtonEnableAlphaKey";
static NSString *const MDCButtonCustomTitleColorKey = @"MDCButtonCustomTitleColorKey";
static NSString *const MDCButtonAreaInsetKey = @"MDCButtonAreaInsetKey";
static NSString *const MDCButtonMinimumSizeKey = @"MDCButtonMinimumSizeKey";
static NSString *const MDCButtonMaximumSizeKey = @"MDCButtonMaximumSizeKey";

static NSString *const MDCButtonUserElevationsKey = @"MDCButtonUserElevationsKey";
static NSString *const MDCButtonBackgroundColorsKey = @"MDCButtonBackgroundColorsKey";
// Previous value kept for backwards compatibility.
static NSString *const MDCButtonNontransformedTitlesKey = @"MDCButtonAccessibilityLabelsKey";

static NSString *const MDCButtonBorderColorsKey = @"MDCButtonBorderColorsKey";
static NSString *const MDCButtonBorderWidthsKey = @"MDCButtonBorderWidthsKey";

static NSString *const MDCButtonShadowColorsKey = @"MDCButtonShadowColorsKey";

static NSString *const MDCButtonFontsKey = @"MDCButtonFontsKey";

// Specified in Material Guidelines
// https://material.io/guidelines/layout/metrics-keylines.html#metrics-keylines-touch-target-size
static const CGFloat MDCButtonMinimumTouchTargetHeight = 48;
static const CGFloat MDCButtonMinimumTouchTargetWidth = 48;
static const CGFloat MDCButtonDefaultCornerRadius = 2.0;

static const NSTimeInterval MDCButtonAnimationDuration = 0.2;

// https://material.io/guidelines/components/buttons.html#buttons-main-buttons
static const CGFloat MDCButtonDisabledAlpha = 0.12f;

// Blue 500 from https://material.io/guidelines/style/color.html#color-color-palette .
static const uint32_t MDCButtonDefaultBackgroundColor = 0x191919;

// Creates a UIColor from a 24-bit RGB color encoded as an integer.
static inline UIColor *MDCColorFromRGB(uint32_t rgbValue) {
  return [UIColor colorWithRed:((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255
                         green:((CGFloat)((rgbValue & 0x00FF00) >> 8)) / 255
                          blue:((CGFloat)((rgbValue & 0x0000FF) >> 0)) / 255
                         alpha:1];
}

static NSAttributedString *uppercaseAttributedString(NSAttributedString *string) {
  // Store the attributes.
  NSMutableArray<NSDictionary *> *attributes = [NSMutableArray array];
  [string enumerateAttributesInRange:NSMakeRange(0, [string length])
                             options:0
                          usingBlock:^(NSDictionary *attrs, NSRange range, __unused BOOL *stop) {
                            [attributes addObject:@{
                              @"attrs" : attrs,
                              @"range" : [NSValue valueWithRange:range]
                            }];
                          }];

  // Make the string uppercase.
  NSString *uppercaseString = [[string string] uppercaseStringWithLocale:[NSLocale currentLocale]];

  // Apply the text and attributes to a mutable copy of the title attributed string.
  NSMutableAttributedString *mutableString = [string mutableCopy];
  [mutableString replaceCharactersInRange:NSMakeRange(0, [string length])
                               withString:uppercaseString];
  for (NSDictionary *attribute in attributes) {
    [mutableString setAttributes:attribute[@"attrs"] range:[attribute[@"range"] rangeValue]];
  }

  return [mutableString copy];
}

@interface MDCButton () {
  // For each UIControlState.
  NSMutableDictionary<NSNumber *, NSNumber *> *_userElevations;
  NSMutableDictionary<NSNumber *, UIColor *> *_backgroundColors;
  NSMutableDictionary<NSNumber *, UIColor *> *_borderColors;
  NSMutableDictionary<NSNumber *, NSNumber *> *_borderWidths;
  NSMutableDictionary<NSNumber *, UIColor *> *_shadowColors;
  NSMutableDictionary<NSNumber *, UIFont *> *_fonts;

  CGFloat _enabledAlpha;
  BOOL _hasCustomDisabledTitleColor;

  // Cached accessibility settings.
  NSMutableDictionary<NSNumber *, NSString *> *_nontransformedTitles;
  NSString *_accessibilityLabelExplicitValue;

  BOOL _mdc_adjustsFontForContentSizeCategory;
}
@property(nonatomic, strong) MDCInkView *inkView;
@property(nonatomic, readonly, strong) MDCShadowLayer *layer;
@end

@implementation MDCButton

@dynamic layer;

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

- (instancetype)init {
  return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    // Set up title label attributes.
    // TODO(#2709): Have a single source of truth for fonts
    // Migrate to [UIFont standardFont] when possible
    self.titleLabel.font = [MDCTypography buttonFont];

    [self commonMDCButtonInit];
    [self updateBackgroundColor];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCButtonInit];

    if (self.titleLabel.font) {
      _fonts = [@{} mutableCopy];
      _fonts[@(UIControlStateNormal)] = self.titleLabel.font;
    }

    if ([aDecoder containsValueForKey:MDCButtonInkViewInkStyleKey]) {
      self.inkView.inkStyle = [aDecoder decodeIntegerForKey:MDCButtonInkViewInkStyleKey];
    }

    if ([aDecoder containsValueForKey:MDCButtonInkViewInkColorKey]) {
      self.inkView.inkColor = [aDecoder decodeObjectOfClass:[UIColor class]
                                                     forKey:MDCButtonInkViewInkColorKey];
    }

    if ([aDecoder containsValueForKey:MDCButtonInkViewInkMaxRippleRadiusKey]) {
      self.inkView.maxRippleRadius =
          (CGFloat)[aDecoder decodeDoubleForKey:MDCButtonInkViewInkMaxRippleRadiusKey];
    }

    if ([aDecoder containsValueForKey:MDCButtonShouldRaiseOnTouchKey]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
      self.shouldRaiseOnTouch = [aDecoder decodeBoolForKey:MDCButtonShouldRaiseOnTouchKey];
#pragma clang diagnostic pop
    }

    if ([aDecoder containsValueForKey:MDCButtonUppercaseTitleKey]) {
      self.uppercaseTitle = [aDecoder decodeBoolForKey:MDCButtonUppercaseTitleKey];
    }

    if ([aDecoder containsValueForKey:MDCButtonUnderlyingColorHintKey]) {
      _underlyingColorHint = [aDecoder decodeObjectOfClass:[UIColor class]
                                                    forKey:MDCButtonUnderlyingColorHintKey];
    }

    if ([aDecoder containsValueForKey:MDCButtonDisableAlphaKey]) {
      _disabledAlpha = (CGFloat)[aDecoder decodeDoubleForKey:MDCButtonDisableAlphaKey];
    }

    if ([aDecoder containsValueForKey:MDCButtonEnableAlphaKey]) {
      _enabledAlpha = (CGFloat)[aDecoder decodeDoubleForKey:MDCButtonEnableAlphaKey];
    }

    if ([aDecoder containsValueForKey:MDCButtonAreaInsetKey]) {
      self.hitAreaInsets = [aDecoder decodeUIEdgeInsetsForKey:MDCButtonAreaInsetKey];
    }

    if ([aDecoder containsValueForKey:MDCButtonMinimumSizeKey]) {
      self.minimumSize = [aDecoder decodeCGSizeForKey:MDCButtonMinimumSizeKey];
    }

    if ([aDecoder containsValueForKey:MDCButtonMaximumSizeKey]) {
      self.maximumSize = [aDecoder decodeCGSizeForKey:MDCButtonMaximumSizeKey];
    }

    if ([aDecoder containsValueForKey:MDCButtonUserElevationsKey]) {
      _userElevations = [aDecoder decodeObjectOfClass:[NSMutableDictionary class]
                                               forKey:MDCButtonUserElevationsKey];
    }

    if ([aDecoder containsValueForKey:MDCButtonBorderColorsKey]) {
      _borderColors = [aDecoder decodeObjectOfClass:[NSMutableDictionary class]
                                             forKey:MDCButtonBorderColorsKey];
    }

    if ([aDecoder containsValueForKey:MDCButtonBorderWidthsKey]) {
      _borderWidths = [aDecoder  decodeObjectOfClass:[NSMutableDictionary class]
                                              forKey:MDCButtonBorderWidthsKey];
    }

    if ([aDecoder containsValueForKey:MDCButtonBackgroundColorsKey]) {
      _backgroundColors = [aDecoder  decodeObjectOfClass:[NSMutableDictionary class]
                                                  forKey:MDCButtonBackgroundColorsKey];
    } else {
      // Storyboards will set the backgroundColor via the UIView backgroundColor setter, so we have
      // to write that in to our _backgroundColors dictionary.
      _backgroundColors[@(UIControlStateNormal)] = super.backgroundColor;
    }
    [self updateBackgroundColor];

    if ([aDecoder containsValueForKey:MDCButtonFontsKey]) {
      _fonts = [aDecoder  decodeObjectOfClass:[NSMutableDictionary class] forKey:MDCButtonFontsKey];
    }

    if ([aDecoder containsValueForKey:MDCButtonNontransformedTitlesKey]) {
      _nontransformedTitles = [aDecoder  decodeObjectOfClass:[NSMutableDictionary class]
                                                      forKey:MDCButtonNontransformedTitlesKey];
    }

    if ([aDecoder containsValueForKey:MDCButtonShadowColorsKey]) {
      _shadowColors = [aDecoder  decodeObjectOfClass:[NSMutableDictionary class]
                                              forKey:MDCButtonShadowColorsKey];
    }
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
  [super encodeWithCoder:aCoder];

  [aCoder encodeInteger:_inkView.inkStyle forKey:MDCButtonInkViewInkStyleKey];
  if (_inkView.inkColor) {
    [aCoder encodeObject:_inkView.inkColor forKey:MDCButtonInkViewInkColorKey];
  }

  [aCoder encodeDouble:_inkView.maxRippleRadius forKey:MDCButtonInkViewInkMaxRippleRadiusKey];
  [aCoder encodeBool:_shouldRaiseOnTouch forKey:MDCButtonShouldRaiseOnTouchKey];
  [aCoder encodeBool:_uppercaseTitle forKey:MDCButtonUppercaseTitleKey];
  if (_underlyingColorHint) {
    [aCoder encodeObject:_underlyingColorHint forKey:MDCButtonUnderlyingColorHintKey];
  }
  [aCoder encodeDouble:self.disabledAlpha forKey:MDCButtonDisableAlphaKey];
  [aCoder encodeDouble:_enabledAlpha forKey:MDCButtonEnableAlphaKey];
  [aCoder encodeUIEdgeInsets:self.hitAreaInsets forKey:MDCButtonAreaInsetKey];
  [aCoder encodeCGSize:self.minimumSize forKey:MDCButtonMinimumSizeKey];
  [aCoder encodeCGSize:self.maximumSize forKey:MDCButtonMaximumSizeKey];
  [aCoder encodeObject:_userElevations forKey:MDCButtonUserElevationsKey];
  [aCoder encodeObject:_backgroundColors forKey:MDCButtonBackgroundColorsKey];
  [aCoder encodeObject:_nontransformedTitles forKey:MDCButtonNontransformedTitlesKey];
  [aCoder encodeObject:_borderColors forKey:MDCButtonBorderColorsKey];
  [aCoder encodeObject:_borderWidths forKey:MDCButtonBorderWidthsKey];
  [aCoder encodeObject:_fonts forKey:MDCButtonFontsKey];
  if (_shadowColors) {
    [aCoder encodeObject:_shadowColors forKey:MDCButtonShadowColorsKey];
  }
}

- (void)commonMDCButtonInit {
  _disabledAlpha = MDCButtonDisabledAlpha;
  _enabledAlpha = self.alpha;
  _shouldRaiseOnTouch = YES;
  _uppercaseTitle = YES;
  _userElevations = [NSMutableDictionary dictionary];
  _nontransformedTitles = [NSMutableDictionary dictionary];
  _borderColors = [NSMutableDictionary dictionary];
  _borderWidths = [NSMutableDictionary dictionary];
  _fonts = [NSMutableDictionary dictionary];

  if (!_backgroundColors) {
    // _backgroundColors may have already been initialized by setting the backgroundColor setter.
    _backgroundColors = [NSMutableDictionary dictionary];
    _backgroundColors[@(UIControlStateNormal)] = MDCColorFromRGB(MDCButtonDefaultBackgroundColor);
  }

  // Disable default highlight state.
  self.adjustsImageWhenHighlighted = NO;
  self.showsTouchWhenHighlighted = NO;

  // Default content insets
  self.contentEdgeInsets = [self defaultContentEdgeInsets];
  _minimumSize = CGSizeZero;
  _maximumSize = CGSizeZero;

  self.layer.cornerRadius = MDCButtonDefaultCornerRadius;
  MDCShadowLayer *shadowLayer = self.layer;
  shadowLayer.shadowPath = [self boundingPath].CGPath;
  shadowLayer.shadowColor = [UIColor blackColor].CGColor;
  shadowLayer.elevation = [self elevationForState:self.state];

  _shadowColors = [NSMutableDictionary dictionary];
  _shadowColors[@(UIControlStateNormal)] = [UIColor colorWithCGColor:shadowLayer.shadowColor];

  // Set up ink layer.
  _inkView = [[MDCInkView alloc] initWithFrame:self.bounds];
  _inkView.usesLegacyInkRipple = NO;
  [self insertSubview:_inkView belowSubview:self.imageView];

  // UIButton has a drag enter/exit boundary that is outside of the frame of the button itself.
  // Because this is not exposed externally, we can't use -touchesMoved: to calculate when to
  // change ink state. So instead we fall back on adding target/actions for these specific events.
  [self addTarget:self
                action:@selector(touchDragEnter:forEvent:)
      forControlEvents:UIControlEventTouchDragEnter];
  [self addTarget:self
                action:@selector(touchDragExit:forEvent:)
      forControlEvents:UIControlEventTouchDragExit];

  // Block users from activating multiple buttons simultaneously by default.
  self.exclusiveTouch = YES;

  _inkView.inkColor = [UIColor colorWithWhite:1 alpha:0.2f];

  // Uppercase all titles
  if (_uppercaseTitle) {
    [self updateTitleCase];
  }
}

- (void)dealloc {
  [self removeTarget:self action:NULL forControlEvents:UIControlEventAllEvents];

  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIContentSizeCategoryDidChangeNotification
                                                object:nil];
}

- (void)setUnderlyingColorHint:(UIColor *)underlyingColorHint {
  _underlyingColorHint = underlyingColorHint;
  [self updateAlphaAndBackgroundColorAnimated:NO];
}

- (void)setAlpha:(CGFloat)alpha {
  if (self.enabled) {
    _enabledAlpha = alpha;
  }
  [super setAlpha:alpha];
}

- (void)setDisabledAlpha:(CGFloat)disabledAlpha {
  _disabledAlpha = disabledAlpha;
  [self updateAlphaAndBackgroundColorAnimated:NO];
}

#pragma mark - UIView

- (void)layoutSubviews {
  [super layoutSubviews];
  self.layer.shadowPath = [self boundingPath].CGPath;
  if ([self respondsToSelector:@selector(cornerRadius)]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    self.layer.cornerRadius = [self cornerRadius];
#pragma clang diagnostic pop
  }

  // Center unbounded ink view frame taking into account possible insets using contentRectForBounds.
  if (_inkView.inkStyle == MDCInkStyleUnbounded && _inkView.usesLegacyInkRipple) {
    CGRect contentRect = [self contentRectForBounds:self.bounds];
    CGPoint contentCenterPoint =
        CGPointMake(CGRectGetMidX(contentRect), CGRectGetMidY(contentRect));
    CGPoint boundsCenterPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));

    CGFloat offsetX = contentCenterPoint.x - boundsCenterPoint.x;
    CGFloat offsetY = contentCenterPoint.y - boundsCenterPoint.y;
    _inkView.frame = CGRectMake(offsetX, offsetY, self.bounds.size.width, self.bounds.size.height);
  } else {
    _inkView.frame = self.bounds;
  }
  self.titleLabel.frame = MDCRectAlignToScale(self.titleLabel.frame, [UIScreen mainScreen].scale);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
  // If there are custom hitAreaInsets, use those
  if (!UIEdgeInsetsEqualToEdgeInsets(self.hitAreaInsets, UIEdgeInsetsZero)) {
    return CGRectContainsPoint(
        UIEdgeInsetsInsetRect(CGRectStandardize(self.bounds), self.hitAreaInsets), point);
  }

  // If the bounds are smaller than the minimum touch target, produce a warning once
  CGFloat width = CGRectGetWidth(self.bounds);
  CGFloat height = CGRectGetHeight(self.bounds);
  if (width < MDCButtonMinimumTouchTargetWidth || height < MDCButtonMinimumTouchTargetHeight) {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      NSLog(
          @"Button touch target does not meet minimum size guidlines of (%0.f, %0.f). Button: %@, "
          @"Touch Target: %@",
          MDCButtonMinimumTouchTargetWidth,
          MDCButtonMinimumTouchTargetHeight,
          [self description],
          NSStringFromCGSize(CGSizeMake(width, height)));
    });
  }
  return [super pointInside:point withEvent:event];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
  [super willMoveToSuperview:newSuperview];
  [self.inkView cancelAllAnimationsAnimated:NO];
}

- (CGSize)sizeThatFits:(CGSize)size {
  CGSize superSize = [super sizeThatFits:size];
  if (self.minimumSize.height > 0) {
    superSize.height = MAX(self.minimumSize.height, superSize.height);
  }
  if (self.maximumSize.height > 0) {
    superSize.height = MIN(self.maximumSize.height, superSize.height);
  }
  if (self.minimumSize.width > 0) {
    superSize.width = MAX(self.minimumSize.width, superSize.width);
  }
  if (self.maximumSize.width > 0) {
    superSize.width = MIN(self.maximumSize.width, superSize.width);
  }
  return superSize;
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];

  [self handleBeginTouches:touches];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesMoved:touches withEvent:event];

  // Drag events handled by -touchDragExit:forEvent: and -touchDragEnter:forEvent:
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];

  CGPoint location = [self locationFromTouches:touches];
  [_inkView startTouchEndedAnimationAtPoint:location completion:nil];
}

// Note - in some cases, event may be nil (e.g. view removed from window).
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesCancelled:touches withEvent:event];

  [self evaporateInkToPoint:[self locationFromTouches:touches]];
}

#pragma mark - UIControl methods

- (void)setEnabled:(BOOL)enabled {
  [self setEnabled:enabled animated:NO];
}

- (void)setEnabled:(BOOL)enabled animated:(BOOL)animated {
  [super setEnabled:enabled];

  [self updateAfterStateChange:animated];
}

- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];

  [self updateAfterStateChange:NO];
}

- (void)setSelected:(BOOL)selected {
  [super setSelected:selected];

  [self updateAfterStateChange:NO];
}

- (void)updateAfterStateChange:(BOOL)animated {
  [self updateAlphaAndBackgroundColorAnimated:animated];
  [self animateButtonToHeightForState:self.state];
  [self updateBorderColor];
  [self updateBorderWidth];
  [self updateShadowColor];
  [self updateTitleFont];
}

#pragma mark - Title Uppercasing

- (void)setUppercaseTitle:(BOOL)uppercaseTitle {
  _uppercaseTitle = uppercaseTitle;

  [self updateTitleCase];
}

- (void)updateTitleCase {
  // This calls setTitle or setAttributedTitle for every title value we have stored. In each
  // respective setter the title is upcased if _uppercaseTitle is YES.
  for (NSNumber *key in _nontransformedTitles.keyEnumerator) {
    UIControlState state = key.unsignedIntegerValue;
    NSString *title = _nontransformedTitles[key];
    if ([title isKindOfClass:[NSAttributedString class]]) {
      [self setAttributedTitle:(NSAttributedString *)title forState:state];
    } else {
      [self setTitle:title forState:state];
    }
  }
}

- (void)updateShadowColor {
  self.layer.shadowColor = [self shadowColorForState:self.state].CGColor;
}

- (void)setShadowColor:(UIColor *)shadowColor forState:(UIControlState)state {
  if (shadowColor) {
    _shadowColors[@(state)] = shadowColor;
  } else {
    [_shadowColors removeObjectForKey:@(state)];
  }

  if (state == self.state) {
    [self updateShadowColor];
  }
}

- (UIColor *)shadowColorForState:(UIControlState)state {
  UIColor *shadowColor = _shadowColors[@(state)];
  if (state != UIControlStateNormal && !shadowColor) {
    shadowColor = _shadowColors[@(UIControlStateNormal)];
  }
  return shadowColor;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
  // Intercept any setting of the title and store a copy in case the accessibilityLabel
  // is requested and the original non-uppercased version needs to be returned.
  if ([title length]) {
    _nontransformedTitles[@(state)] = [title copy];
  } else {
    [_nontransformedTitles removeObjectForKey:@(state)];
  }

  if (_uppercaseTitle) {
    title = [title uppercaseStringWithLocale:[NSLocale currentLocale]];
  }
  [super setTitle:title forState:state];
}

- (void)setAttributedTitle:(NSAttributedString *)title forState:(UIControlState)state {
  // Intercept any setting of the title and store a copy in case the accessibilityLabel
  // is requested and the original non-uppercased version needs to be returned.
  if ([title length]) {
    _nontransformedTitles[@(state)] = [[title string] copy];
  } else {
    [_nontransformedTitles removeObjectForKey:@(state)];
  }

  if (_uppercaseTitle) {
    title = uppercaseAttributedString(title);
  }
  [super setAttributedTitle:title forState:state];
}

#pragma mark - Accessibility

- (void)setAccessibilityLabel:(NSString *)accessibilityLabel {
  // Intercept any explicit setting of the accessibilityLabel so it can be returned
  // later before the accessibiilityLabel is inferred from the setTitle:forState:
  // argument values.
  _accessibilityLabelExplicitValue = [accessibilityLabel copy];
  [super setAccessibilityLabel:accessibilityLabel];
}

- (NSString *)accessibilityLabel {
  if (!_uppercaseTitle) {
    return [super accessibilityLabel];
  }

  NSString *label = _accessibilityLabelExplicitValue;
  if ([label length]) {
    return label;
  }

  label = _nontransformedTitles[@(self.state)];
  if ([label length]) {
    return label;
  }

  label = _nontransformedTitles[@(UIControlStateNormal)];
  if ([label length]) {
    return label;
  }

  label = [super accessibilityLabel];
  if ([label length]) {
    return label;
  }

  return nil;
}

- (UIAccessibilityTraits)accessibilityTraits {
  return [super accessibilityTraits] | UIAccessibilityTraitButton;
}

#pragma mark - Ink

- (MDCInkStyle)inkStyle {
  return _inkView.inkStyle;
}

- (void)setInkStyle:(MDCInkStyle)inkStyle {
  _inkView.inkStyle = inkStyle;
}

- (UIColor *)inkColor {
  return _inkView.inkColor;
}

- (void)setInkColor:(UIColor *)inkColor {
  _inkView.inkColor = inkColor;
}

- (CGFloat)inkMaxRippleRadius {
  return _inkView.maxRippleRadius;
}

- (void)setInkMaxRippleRadius:(CGFloat)inkMaxRippleRadius {
  _inkView.maxRippleRadius = inkMaxRippleRadius;
}

#pragma mark - Shadows

- (void)animateButtonToHeightForState:(UIControlState)state {
  CGFloat newElevation = [self elevationForState:state];
  if (self.layer.elevation == newElevation) {
    return;
  }
  [CATransaction begin];
  [CATransaction setAnimationDuration:MDCButtonAnimationDuration];
  self.layer.elevation = newElevation;
  [CATransaction commit];
}

#pragma mark - BackgroundColor

- (void)setBackgroundColor:(nullable UIColor *)backgroundColor {
  // Since setBackgroundColor can be called in the initializer we need to optionally build the dict.
  if (!_backgroundColors) {
    _backgroundColors = [NSMutableDictionary dictionary];
  }
  _backgroundColors[@(UIControlStateNormal)] = backgroundColor;
  [self updateBackgroundColor];
}

- (UIColor *)backgroundColorForState:(UIControlState)state {
  return _backgroundColors[@(state)];
}

- (void)setBackgroundColor:(UIColor *)backgroundColor forState:(UIControlState)state {
  _backgroundColors[@(state)] = backgroundColor;
  [self updateAlphaAndBackgroundColorAnimated:NO];
}

#pragma mark - Elevations

- (CGFloat)elevationForState:(UIControlState)state {
  NSNumber *elevation = _userElevations[@(state)];
  if (state != UIControlStateNormal && !elevation) {
    elevation = _userElevations[@(UIControlStateNormal)];
  }
  if (elevation) {
    return (CGFloat)[elevation doubleValue];
  }
  return 0;
}

- (void)setElevation:(CGFloat)elevation forState:(UIControlState)state {
  _userElevations[@(state)] = @(elevation);
  MDCShadowElevation newElevation = [self elevationForState:self.state];
  // If no change to the current elevation, don't perform updates
  if (MDCCGFloatEqual(newElevation, self.layer.elevation)) {
    return;
  }
  self.layer.elevation = newElevation;

  // The elevation of the normal state controls whether this button is flat or not, and flat buttons
  // have different background color requirements than raised buttons.
  // TODO(ajsecord): Move to MDCFlatButton and update this comment.
  if (state == UIControlStateNormal) {
    [self updateAlphaAndBackgroundColorAnimated:NO];
  }
}

#pragma mark - Border Color

- (UIColor *)borderColorForState:(UIControlState)state {
  return _borderColors[@(state)];
}

- (void)setBorderColor:(UIColor *)borderColor forState:(UIControlState)state {
  _borderColors[@(state)] = borderColor;

  [self updateBorderColor];
}

#pragma mark - Border Width

- (CGFloat)borderWidthForState:(UIControlState)state {
  NSNumber *borderWidth = _borderWidths[@(state)];
  if (borderWidth) {
    return (CGFloat)borderWidth.doubleValue;
  }
  return 0;
}

- (void)setBorderWidth:(CGFloat)borderWidth forState:(UIControlState)state {
  _borderWidths[@(state)] = @(borderWidth);

  [self updateBorderWidth];
}

- (void)updateBorderWidth {
  NSNumber *width = _borderWidths[@(self.state)];
  if (!width && self.state != UIControlStateNormal) {
    // We fall back to UIControlStateNormal if there is no value for the current state.
    width = _borderWidths[@(UIControlStateNormal)];
  }
  self.layer.borderWidth = width ? (CGFloat)width.doubleValue : 0;
}

#pragma mark - Title Font

- (nullable UIFont *)titleFontForState:(UIControlState)state {
  return _fonts[@(state)];
}

- (void)setTitleFont:(nullable UIFont *)font forState:(UIControlState)state {
  _fonts[@(state)] = font;

  [self updateTitleFont];
}

#pragma mark - Private methods

- (UIColor *)currentBackgroundColor {
  UIColor *color = _backgroundColors[@(self.state)];
  if (color) {
    return color;
  }
  return [self backgroundColorForState:UIControlStateNormal];
}

/**
 The background color that a user would see for this button. If self.backgroundColor is not
 transparent, then returns that. Otherwise, returns self.underlyingColorHint.
 @note If self.underlyingColorHint is not set, then this method will return nil.
 */
- (UIColor *)effectiveBackgroundColor {
  if (![self isTransparentColor:self.currentBackgroundColor]) {
    return self.currentBackgroundColor;
  } else {
    return self.underlyingColorHint;
  }
}

/** Returns YES if the color is not transparent and is a "dark" color. */
- (BOOL)isDarkColor:(UIColor *)color {
  // TODO: have a components/private/ColorCalculations/MDCColorCalculations.h|m
  //  return ![self isTransparentColor:color] && [QTMColorGroup luminanceOfColor:color] < 0.5f;
  return ![self isTransparentColor:color];
}

/** Returns YES if the color is transparent (including a nil color). */
- (BOOL)isTransparentColor:(UIColor *)color {
  return !color || [color isEqual:[UIColor clearColor]] || CGColorGetAlpha(color.CGColor) == 0.0f;
}

- (void)touchDragEnter:(__unused MDCButton *)button forEvent:(UIEvent *)event {
  [self handleBeginTouches:event.allTouches];
}

- (void)touchDragExit:(__unused MDCButton *)button forEvent:(UIEvent *)event {
  CGPoint location = [self locationFromTouches:event.allTouches];
  [self evaporateInkToPoint:location];
}

- (void)handleBeginTouches:(NSSet *)touches {
  [_inkView startTouchBeganAnimationAtPoint:[self locationFromTouches:touches] completion:nil];
}

- (CGPoint)locationFromTouches:(NSSet *)touches {
  UITouch *touch = [touches anyObject];
  return [touch locationInView:self];
}

- (void)evaporateInkToPoint:(CGPoint)toPoint {
  [_inkView startTouchEndedAnimationAtPoint:toPoint completion:nil];
}

- (UIBezierPath *)boundingPath {
  CGFloat cornerRadius = self.layer.cornerRadius;

  if ([self respondsToSelector:@selector(cornerRadius)]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    cornerRadius = [self cornerRadius];
#pragma clang diagnostic pop
  }


  return [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
}

- (UIEdgeInsets)defaultContentEdgeInsets {
  return UIEdgeInsetsMake(8, 16, 8, 16);
}

- (BOOL)shouldHaveOpaqueBackground {
  BOOL isFlatButton = MDCCGFloatIsExactlyZero([self elevationForState:UIControlStateNormal]);
  return !isFlatButton;
}

- (void)updateAlphaAndBackgroundColorAnimated:(BOOL)animated {
  void (^animations)(void) = ^{
    self.alpha = self.enabled ? self->_enabledAlpha : self.disabledAlpha;
    [self updateBackgroundColor];
  };

  if (animated) {
    [UIView animateWithDuration:MDCButtonAnimationDuration animations:animations];
  } else {
    animations();
  }
}

- (void)updateBackgroundColor {
  super.backgroundColor = self.currentBackgroundColor;
  [self updateDisabledTitleColor];
}

- (void)updateDisabledTitleColor {
  // We only want to automatically set a disabled title color if the user hasn't already provided a
  // value.
  if (_hasCustomDisabledTitleColor) {
    return;
  }
  // Disabled buttons have very low opacity, so we full-opacity text color here to make the text
  // readable. Also, even for non-flat buttons with opaque backgrounds, the correct background color
  // to examine is the underlying color, since disabled buttons are so transparent.
  BOOL darkBackground = [self isDarkColor:[self underlyingColorHint]];
  // We call super here to distinguish between automatic title color assignments and that of users.
  [super setTitleColor:darkBackground ? [UIColor whiteColor] : [UIColor blackColor]
              forState:UIControlStateDisabled];
}

- (void)setTitleColor:(UIColor *)color forState:(UIControlState)state {
  [super setTitleColor:color forState:state];
  if (state == UIControlStateDisabled) {
    _hasCustomDisabledTitleColor = color != nil;
    if (!_hasCustomDisabledTitleColor) {
      [self updateDisabledTitleColor];
    }
  }
}

- (void)updateBorderColor {
  UIColor *color = _borderColors[@(self.state)];
  if (!color && self.state != UIControlStateNormal) {
    // We fall back to UIControlStateNormal if there is no value for the current state.
    color = _borderColors[@(UIControlStateNormal)];
  }
  self.layer.borderColor = color ? color.CGColor : NULL;
}

- (void)updateTitleFont {
  // Retreive any custom font that has been set
  UIFont *font = _fonts[@(self.state)];
  if (!font && self.state != UIControlStateNormal) {
    // We fall back to UIControlStateNormal if there is no value for the current state.
    font = _fonts[@(UIControlStateNormal)];
  }

  if (!font) {
    // TODO(#2709): Have a single source of truth for fonts
    // Migrate to [UIFont standardFont] when possible
    font = [MDCTypography buttonFont];
  }

  if (_mdc_adjustsFontForContentSizeCategory) {
    // Dynamic type is enabled so apply scaling
    font = [font mdc_fontSizedForMaterialTextStyle:MDCFontTextStyleButton
                              scaledForDynamicType:YES];
  }

  self.titleLabel.font = font;

  [self setNeedsLayout];
}

#pragma mark - Dynamic Type

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

  [self updateTitleFont];
}

- (void)contentSizeCategoryDidChange:(__unused NSNotification *)notification {
  [self updateTitleFont];

  [self sizeToFit];
}

#pragma mark - Deprecations

- (void)setCustomTitleColor:(UIColor *)customTitleColor {
  [self setTitleColor:customTitleColor forState:UIControlStateNormal];
}

- (UIColor *)customTitleColor {
  return [self titleColorForState:UIControlStateNormal];
}

- (BOOL)shouldCapitalizeTitle {
  return [self isUppercaseTitle];
}

- (void)setShouldCapitalizeTitle:(BOOL)shouldCapitalizeTitle {
  [self setUppercaseTitle:shouldCapitalizeTitle];
}

- (UIColor *)underlyingColor {
  return [self underlyingColorHint];
}

- (void)setUnderlyingColor:(UIColor *)underlyingColor {
  [self setUnderlyingColorHint:underlyingColor];
}

@end
