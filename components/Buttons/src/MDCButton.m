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

#import "MDFTextAccessibility.h"
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
static NSString *const MDCButtonCustomTitleColorKey = @"MDCButtonCustomTitleColorKey";
static NSString *const MDCButtonAreaInsetKey = @"MDCButtonAreaInsetKey";

static NSString *const MDCButtonUserElevationsKey = @"MDCButtonUserElevationsKey";
static NSString *const MDCButtonBackgroundColorsKey = @"MDCButtonBackgroundColorsKey";
static NSString *const MDCButtonAccessibilityLabelsKey = @"MDCButtonAccessibilityLabelsKey";

static const NSTimeInterval MDCButtonAnimationDuration = 0.2;

// https://material.io/guidelines/components/buttons.html#buttons-main-buttons
static const CGFloat MDCButtonDisabledAlpha = 0.1f;

// Blue 500 from https://material.io/guidelines/style/color.html#color-color-palette .
static const uint32_t MDCButtonDefaultBackgroundColor = 0x2196F3;

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
                          usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
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
  NSMutableDictionary<NSNumber *, NSNumber *> *_userElevations;   // For each UIControlState.
  NSMutableDictionary<NSNumber *, UIColor *> *_backgroundColors;  // For each UIControlState.

  // Cached accessibility settings.
  NSMutableDictionary<NSNumber *, NSString *> *_accessibilityLabelForState;
  NSString *_accessibilityLabelExplicitValue;

  BOOL _mdc_adjustsFontForContentSizeCategory;
}
@property(nonatomic, strong) MDCInkView *inkView;
@end

@implementation MDCButton

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCButtonInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCButtonInit];

    // TODO(randallli): Add backward compatibility to background colors
    //    if ([aDecoder containsValueForKey:MDCButtonEnabledBackgroundColorKey]) {
    //      self.enabledBackgroundColor =
    //          [aDecoder decodeObjectForKey:MDCButtonEnabledBackgroundColorKey];
    //    }
    //    if ([aDecoder containsValueForKey:MDCButtonDisabledBackgroundColorLightKey]) {
    //      self.disabledBackgroundColorLight =
    //          [aDecoder decodeObjectForKey:MDCButtonDisabledBackgroundColorLightKey];
    //    }
    //    if ([aDecoder containsValueForKey:MDCButtonDisabledBackgroundColorDarkKey]) {
    //      self.disabledBackgroundColorDark =
    //          [aDecoder decodeObjectForKey:MDCButtonDisabledBackgroundColorDarkKey];
    //    }
    if ([aDecoder containsValueForKey:MDCButtonInkViewInkStyleKey]) {
      self.inkView.inkStyle = [aDecoder decodeIntegerForKey:MDCButtonInkViewInkStyleKey];
    }

    if ([aDecoder containsValueForKey:MDCButtonInkViewInkColorKey]) {
      self.inkView.inkColor = [aDecoder decodeObjectForKey:MDCButtonInkViewInkColorKey];
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
      self.underlyingColorHint = [aDecoder decodeObjectForKey:MDCButtonUnderlyingColorHintKey];
    }

    if ([aDecoder containsValueForKey:MDCButtonCustomTitleColorKey]) {
      self.customTitleColor = [aDecoder decodeObjectForKey:MDCButtonCustomTitleColorKey];
    }

    if ([aDecoder containsValueForKey:MDCButtonDisableAlphaKey]) {
      self.disabledAlpha = (CGFloat)[aDecoder decodeDoubleForKey:MDCButtonDisableAlphaKey];
    }

    if ([aDecoder containsValueForKey:MDCButtonAreaInsetKey]) {
      self.hitAreaInsets = [aDecoder decodeUIEdgeInsetsForKey:MDCButtonAreaInsetKey];
    }

    if ([aDecoder containsValueForKey:MDCButtonUserElevationsKey]) {
      _userElevations = [aDecoder decodeObjectForKey:MDCButtonUserElevationsKey];
    }

    if ([aDecoder containsValueForKey:MDCButtonBackgroundColorsKey]) {
      _backgroundColors = [aDecoder decodeObjectForKey:MDCButtonBackgroundColorsKey];
    }

    if ([aDecoder containsValueForKey:MDCButtonAccessibilityLabelsKey]) {
      _accessibilityLabelForState = [aDecoder decodeObjectForKey:MDCButtonAccessibilityLabelsKey];
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
  if (self.customTitleColor) {
    [aCoder encodeObject:self.customTitleColor forKey:MDCButtonCustomTitleColorKey];
  }
  [aCoder encodeUIEdgeInsets:self.hitAreaInsets forKey:MDCButtonAreaInsetKey];
  [aCoder encodeObject:_userElevations forKey:MDCButtonUserElevationsKey];
  [aCoder encodeObject:_backgroundColors forKey:MDCButtonBackgroundColorsKey];
  [aCoder encodeObject:_accessibilityLabelForState forKey:MDCButtonAccessibilityLabelsKey];
}

- (void)commonMDCButtonInit {
  _disabledAlpha = MDCButtonDisabledAlpha;
  _shouldRaiseOnTouch = YES;
  _uppercaseTitle = YES;
  _userElevations = [NSMutableDictionary dictionary];
  _backgroundColors = [NSMutableDictionary dictionary];
  _accessibilityLabelForState = [NSMutableDictionary dictionary];

  // Disable default highlight state.
  self.adjustsImageWhenHighlighted = NO;
  self.showsTouchWhenHighlighted = NO;

  // Set up title label attributes.
  self.titleLabel.font = [MDCTypography buttonFont];
  [self updateAlphaAndBackgroundColorAnimated:NO];

  // Default content insets
  self.contentEdgeInsets = [self defaultContentEdgeInsets];

  MDCShadowLayer *shadowLayer = [self shadowLayer];
  shadowLayer.shadowPath = [self boundingPath].CGPath;
  shadowLayer.shadowColor = [UIColor blackColor].CGColor;
  shadowLayer.elevation = [self elevationForState:self.state];

  // Set up ink layer.
  _inkView = [[MDCInkView alloc] initWithFrame:self.bounds];
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

  // Default background colors.
  [self setBackgroundColor:MDCColorFromRGB(MDCButtonDefaultBackgroundColor)
                  forState:UIControlStateNormal];

  self.inkColor = [UIColor colorWithWhite:1 alpha:0.2f];

  // Uppercase all titles
  if (_uppercaseTitle) {
    [self uppercaseAllTitles];
  }
}

- (void)dealloc {
  [self removeTarget:self action:NULL forControlEvents:UIControlEventAllEvents];

  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIContentSizeCategoryDidChangeNotification
                                                object:nil];
}

- (void)setCustomTitleColor:(UIColor *)customTitleColor {
  _customTitleColor = customTitleColor;
  [self updateTitleColor];
}

- (void)setUnderlyingColorHint:(UIColor *)underlyingColorHint {
  _underlyingColorHint = underlyingColorHint;
  [self updateAlphaAndBackgroundColorAnimated:NO];
}

- (void)setDisabledAlpha:(CGFloat)disabledAlpha {
  _disabledAlpha = disabledAlpha;
  [self updateAlphaAndBackgroundColorAnimated:NO];
}

#pragma mark - UIView

- (void)layoutSubviews {
  [super layoutSubviews];
  self.layer.shadowPath = [self boundingPath].CGPath;
  self.layer.cornerRadius = [self cornerRadius];

  // Center the ink view frame taking into account possible insets using contentRectForBounds.

  CGRect contentRect = [self contentRectForBounds:self.bounds];
  CGPoint contentCenterPoint = CGPointMake(CGRectGetMidX(contentRect), CGRectGetMidY(contentRect));
  CGPoint boundsCenterPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));

  CGFloat offsetX = contentCenterPoint.x - boundsCenterPoint.x;
  CGFloat offsetY = contentCenterPoint.y - boundsCenterPoint.y;
  _inkView.frame = CGRectMake(offsetX, offsetY, self.bounds.size.width, self.bounds.size.height);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
  return CGRectContainsPoint(UIEdgeInsetsInsetRect(self.bounds, _hitAreaInsets), point);
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

  BOOL inside = CGRectContainsPoint(self.bounds, location);
  if (inside && _shouldRaiseOnTouch) {
    [self animateButtonToHeightForState:UIControlStateNormal];
  }
}

// Note - in some cases, event may be nil (e.g. view removed from window).
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesCancelled:touches withEvent:event];

  [self evaporateInkToPoint:[self locationFromTouches:touches]];
}

#pragma mark - UIButton methods

- (void)setEnabled:(BOOL)enabled {
  [self setEnabled:enabled animated:NO];
}

- (void)setEnabled:(BOOL)enabled animated:(BOOL)animated {
  [super setEnabled:enabled];
  [self updateAlphaAndBackgroundColorAnimated:animated];
}

#pragma mark - Title Uppercasing

- (void)setUppercaseTitle:(BOOL)uppercaseTitle {
  _uppercaseTitle = uppercaseTitle;
  if (_uppercaseTitle) {
    [self uppercaseAllTitles];
  }
}

- (void)uppercaseAllTitles {
  // This ensures existing titles will get uppercased.
  UIControlState allControlStates = UIControlStateNormal | UIControlStateHighlighted |
                                    UIControlStateDisabled | UIControlStateSelected;
  for (UIControlState state = 0; state <= allControlStates; ++state) {
    NSString *title = [self titleForState:state];
    if (title) {
      [self setTitle:[title uppercaseStringWithLocale:[NSLocale currentLocale]] forState:state];
    }

    NSAttributedString *attributedTitle = [self attributedTitleForState:state];
    if (attributedTitle) {
      [self setAttributedTitle:uppercaseAttributedString(attributedTitle) forState:state];
    }
  }
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state {
  // Intercept any setting of the title and store a copy in case the accessibilityLabel
  // is requested and the original non-uppercased version needs to be returned.
  if ([title length]) {
    _accessibilityLabelForState[@(state)] = [title copy];
  } else {
    [_accessibilityLabelForState removeObjectForKey:@(state)];
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
    _accessibilityLabelForState[@(state)] = [[title string] copy];
  } else {
    [_accessibilityLabelForState removeObjectForKey:@(state)];
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

  label = _accessibilityLabelForState[@(self.state)];
  if ([label length]) {
    return label;
  }

  label = _accessibilityLabelForState[@(UIControlStateNormal)];
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

- (MDCShadowLayer *)shadowLayer {
  return (MDCShadowLayer *)self.layer;
}

- (void)animateButtonToHeightForState:(UIControlState)state {
  [CATransaction begin];
  [CATransaction setAnimationDuration:MDCButtonAnimationDuration];
  [self shadowLayer].elevation = [self elevationForState:state];
  [CATransaction commit];
}

#pragma mark - BackgroundColor

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
  return elevation ? (CGFloat)[elevation doubleValue] : [self defaultElevationForState:state];
}

- (void)setElevation:(CGFloat)elevation forState:(UIControlState)state {
  _userElevations[@(state)] = @(elevation);
  [self shadowLayer].elevation = [self elevationForState:self.state];

  // The elevation of the normal state controls whether this button is flat or not, and flat buttons
  // have different background color requirements than raised buttons.
  // TODO(ajsecord): Move to MDCFlatButton and update this comment.
  if (state == UIControlStateNormal) {
    [self updateAlphaAndBackgroundColorAnimated:NO];
  }
}

- (void)resetElevationForState:(UIControlState)state {
  [_userElevations removeObjectForKey:@(state)];
  [self shadowLayer].elevation = [self elevationForState:self.state];
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

- (void)touchDragEnter:(MDCButton *)button forEvent:(UIEvent *)event {
  [self handleBeginTouches:event.allTouches];
}

- (void)touchDragExit:(MDCButton *)button forEvent:(UIEvent *)event {
  CGPoint location = [self locationFromTouches:event.allTouches];
  [self evaporateInkToPoint:location];
}

- (void)handleBeginTouches:(NSSet *)touches {
  [_inkView startTouchBeganAnimationAtPoint:[self locationFromTouches:touches] completion:nil];
  if (_shouldRaiseOnTouch) {
    [self animateButtonToHeightForState:UIControlStateSelected];
  }
}

- (CGPoint)locationFromTouches:(NSSet *)touches {
  UITouch *touch = [touches anyObject];
  return [touch locationInView:self];
}

- (void)evaporateInkToPoint:(CGPoint)toPoint {
  [_inkView startTouchEndedAnimationAtPoint:toPoint completion:nil];
  if (_shouldRaiseOnTouch) {
    [self animateButtonToHeightForState:UIControlStateNormal];
  }
}

- (UIBezierPath *)boundingPath {
  return [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
}

- (CGFloat)cornerRadius {
  return 2.0f;
}

- (UIEdgeInsets)defaultContentEdgeInsets {
  return UIEdgeInsetsMake(8, 16, 8, 16);
}

- (CGFloat)defaultElevationForState:(UIControlState)state {
  if (state == UIControlStateNormal) {
    return 0;
  }

  if ((state & UIControlStateSelected) == UIControlStateSelected) {
    CGFloat normalElevation = [self elevationForState:UIControlStateNormal];
    return normalElevation > 0 ? 2 * normalElevation : 1;
  }

  return [self elevationForState:UIControlStateNormal];
}

- (BOOL)shouldHaveOpaqueBackground {
  BOOL isFlatButton = MDCCGFloatIsExactlyZero([self elevationForState:UIControlStateNormal]);
  return !isFlatButton;
}

- (void)updateAlphaAndBackgroundColorAnimated:(BOOL)animated {
  void (^animations)() = ^{
    self.alpha = self.enabled ? 1.0f : _disabledAlpha;
    [self updateBackgroundColor];
  };

  if (animated) {
    [UIView animateWithDuration:MDCButtonAnimationDuration animations:animations];
  } else {
    animations();
  }
}

- (void)updateBackgroundColor {
  //  UIColor *color = nil;
  //  if ([self shouldHaveOpaqueBackground]) {
  //    if (self.enabled) {
  ////      color = self.enabledBackgroundColor;
  //    } else {
  //      color = [self isDarkColor:_underlyingColorHint] ? _disabledBackgroundColorLight
  //                                                  : _disabledBackgroundColorDark;
  //    }
  //  }
  [self updateTitleColor];
  [self updateDisabledTitleColor];
  super.backgroundColor = self.currentBackgroundColor;
}

- (void)updateDisabledTitleColor {
  // Disabled buttons have very low opacity, so we full-opacity text color here to make the text
  // readable. Also, even for non-flat buttons with opaque backgrounds, the correct background color
  // to examine is the underlying color, since disabled buttons are so transparent.
  BOOL darkBackground = [self isDarkColor:[self underlyingColorHint]];
  [self setTitleColor:darkBackground ? [UIColor whiteColor] : [UIColor blackColor]
             forState:UIControlStateDisabled];
}

- (void)updateTitleColor {
  if (_customTitleColor) {
    [self setTitleColor:_customTitleColor forState:UIControlStateNormal];
    return;
  }

  if (![self isTransparentColor:[self effectiveBackgroundColor]]) {
    MDFTextAccessibilityOptions options = 0;
    if ([MDFTextAccessibility isLargeForContrastRatios:self.titleLabel.font]) {
      options = MDFTextAccessibilityOptionsLargeFont;
    }
    UIColor *color =
        [MDFTextAccessibility textColorOnBackgroundColor:[self effectiveBackgroundColor]
                                         targetTextAlpha:[MDCTypography buttonFontOpacity]
                                                 options:options];
    [self setTitleColor:color forState:UIControlStateNormal];
  }
}

- (BOOL)mdc_adjustsFontForContentSizeCategory {
  return _mdc_adjustsFontForContentSizeCategory;
}

- (void)mdc_setAdjustsFontForContentSizeCategory:(BOOL)adjusts {
  _mdc_adjustsFontForContentSizeCategory = adjusts;
  if (_mdc_adjustsFontForContentSizeCategory) {
    UIFont *font = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleButton];
    self.titleLabel.font = font;
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
  UIFont *font = [UIFont mdc_preferredFontForMaterialTextStyle:MDCFontTextStyleButton];
  self.titleLabel.font = font;
  [self sizeToFit];
}

#pragma mark - Deprecations

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
