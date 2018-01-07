/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCSlider.h"

#import "private/MDCSlider_Subclassable.h"
#import "MaterialPalettes.h"
#import "MaterialThumbTrack.h"

static const CGFloat kSliderDefaultWidth = 100.0f;
static const CGFloat kSliderFrameHeight = 27.0f;
static const CGFloat kSliderMinTouchSize = 48.0f;
static const CGFloat kSliderDefaultThumbRadius = 6.0f;
static const CGFloat kSliderAccessibilityIncrement = 0.1f;  // Matches UISlider's percent increment.
static const CGFloat kSliderLightThemeTrackAlpha = 0.26f;

static inline UIColor *MDCThumbTrackDefaultColor(void) {
  return MDCPalette.bluePalette.tint500;
}

@interface MDCSlider () <MDCThumbTrackDelegate>

@end

@implementation MDCSlider

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCSliderInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCSliderInit];
  }
  return self;
}

- (void)commonMDCSliderInit {
  _thumbTrack =
      [[MDCThumbTrack alloc] initWithFrame:self.bounds onTintColor:MDCThumbTrackDefaultColor()];
  _thumbTrack.delegate = self;
  _thumbTrack.disabledTrackHasThumbGaps = YES;
  _thumbTrack.trackEndsAreInset = YES;
  _thumbTrack.thumbRadius = kSliderDefaultThumbRadius;
  _thumbTrack.thumbIsSmallerWhenDisabled = YES;
  _thumbTrack.thumbIsHollowAtStart = YES;
  _thumbTrack.thumbGrowsWhenDragging = YES;
  _thumbTrack.shouldDisplayInk = NO;
  _thumbTrack.shouldDisplayDiscreteDots = YES;
  _thumbTrack.shouldDisplayDiscreteValueLabel = YES;
  _thumbTrack.trackOffColor = [[self class] defaultTrackOffColor];
  _thumbTrack.thumbDisabledColor = [[self class] defaultDisabledColor];
  _thumbTrack.trackDisabledColor = [[self class] defaultDisabledColor];
  [_thumbTrack addTarget:self
                  action:@selector(thumbTrackValueChanged:)
        forControlEvents:UIControlEventValueChanged];
  [_thumbTrack addTarget:self
                  action:@selector(thumbTrackTouchDown:)
        forControlEvents:UIControlEventTouchDown];
  [_thumbTrack addTarget:self
                  action:@selector(thumbTrackTouchUpInside:)
        forControlEvents:UIControlEventTouchUpInside];
  [_thumbTrack addTarget:self
                  action:@selector(thumbTrackTouchUpOutside:)
        forControlEvents:UIControlEventTouchUpOutside];
  [_thumbTrack addTarget:self
                  action:@selector(thumbTrackTouchCanceled:)
        forControlEvents:UIControlEventTouchCancel];
  [self addSubview:_thumbTrack];
}

#pragma mark - ThumbTrack passthrough methods

- (void)setTrackBackgroundColor:(UIColor *)trackBackgroundColor {
  _thumbTrack.trackOffColor =
      trackBackgroundColor ? trackBackgroundColor : [[self class] defaultTrackOffColor];
}

- (UIColor *)trackBackgroundColor {
  return _thumbTrack.trackOffColor;
}

- (void)setDisabledColor:(UIColor *)disabledColor {
  _thumbTrack.trackDisabledColor =
      disabledColor ?: [[self class] defaultDisabledColor];
  _thumbTrack.thumbDisabledColor =
      disabledColor ?: [[self class] defaultDisabledColor];
}

- (UIColor *)disabledColor {
  return _thumbTrack.trackDisabledColor;
}

- (void)setColor:(UIColor *)color {
  _thumbTrack.primaryColor = color ? color : MDCThumbTrackDefaultColor();
}

- (UIColor *)color {
  return _thumbTrack.primaryColor;
}

- (void)setThumbRadius:(CGFloat)thumbRadius {
  _thumbTrack.thumbRadius = thumbRadius;
}

- (CGFloat)thumbRadius {
  return _thumbTrack.thumbRadius;
}

- (void)setThumbElevation:(MDCShadowElevation)thumbElevation {
  _thumbTrack.thumbElevation = thumbElevation;
}

- (MDCShadowElevation)thumbElevation {
  return _thumbTrack.thumbElevation;
}

- (NSUInteger)numberOfDiscreteValues {
  return _thumbTrack.numDiscreteValues;
}

- (void)setNumberOfDiscreteValues:(NSUInteger)numberOfDiscreteValues {
  _thumbTrack.numDiscreteValues = numberOfDiscreteValues;
}

- (BOOL)isContinuous {
  return _thumbTrack.continuousUpdateEvents;
}

- (void)setContinuous:(BOOL)continuous {
  _thumbTrack.continuousUpdateEvents = continuous;
}

- (CGFloat)value {
  return _thumbTrack.value;
}

- (void)setValue:(CGFloat)value {
  _thumbTrack.value = value;
}

- (void)setValue:(CGFloat)value animated:(BOOL)animated {
  [_thumbTrack setValue:value animated:animated];
}

- (CGFloat)minimumValue {
  return _thumbTrack.minimumValue;
}

- (void)setMinimumValue:(CGFloat)minimumValue {
  _thumbTrack.minimumValue = minimumValue;
}

- (CGFloat)maximumValue {
  return _thumbTrack.maximumValue;
}

- (void)setMaximumValue:(CGFloat)maximumValue {
  _thumbTrack.maximumValue = maximumValue;
}

- (CGFloat)filledTrackAnchorValue {
  return _thumbTrack.filledTrackAnchorValue;
}

- (void)setFilledTrackAnchorValue:(CGFloat)filledTrackAnchorValue {
  _thumbTrack.filledTrackAnchorValue = filledTrackAnchorValue;
}

- (BOOL)shouldDisplayDiscreteValueLabel {
  return _thumbTrack.shouldDisplayDiscreteValueLabel;
}

- (void)setShouldDisplayDiscreteValueLabel:(BOOL)shouldDisplayDiscreteValueLabel {
  _thumbTrack.shouldDisplayDiscreteValueLabel = shouldDisplayDiscreteValueLabel;
}

- (BOOL)isThumbHollowAtStart {
  return _thumbTrack.thumbIsHollowAtStart;
}

- (void)setThumbHollowAtStart:(BOOL)thumbHollowAtStart {
  _thumbTrack.thumbIsHollowAtStart = thumbHollowAtStart;
}

#pragma mark - MDCThumbTrackDelegate methods

- (NSString *)thumbTrack:(__unused MDCThumbTrack *)thumbTrack stringForValue:(CGFloat)value {
  if ([_delegate respondsToSelector:@selector(slider:displayedStringForValue:)]) {
    return [_delegate slider:self displayedStringForValue:value];
  }

  // Default behavior

  static dispatch_once_t onceToken;
  static NSNumberFormatter *numberFormatter;
  dispatch_once(&onceToken, ^{
    numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.maximumFractionDigits = 3;
    numberFormatter.minimumIntegerDigits = 1;  // To get 0.5 instead of .5
  });
  return [numberFormatter stringFromNumber:@(value)];
}

- (BOOL)thumbTrack:(__unused MDCThumbTrack *)thumbTrack shouldJumpToValue:(CGFloat)value {
  return ![_delegate respondsToSelector:@selector(slider:shouldJumpToValue:)] ||
         [_delegate slider:self shouldJumpToValue:value];
}

#pragma mark - UIControl methods

- (void)setEnabled:(BOOL)enabled {
  [super setEnabled:enabled];
  _thumbTrack.enabled = enabled;
}

- (BOOL)isTracking {
  return _thumbTrack.isTracking;
}

#pragma mark - UIView methods

- (CGSize)intrinsicContentSize {
  return CGSizeMake(kSliderDefaultWidth, kSliderFrameHeight);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(__unused UIEvent *)event {
  CGFloat dx = MIN(0, self.thumbRadius - kSliderMinTouchSize / 2);
  CGFloat dy = MIN(0, (self.bounds.size.height - kSliderMinTouchSize) / 2);
  CGRect rect = CGRectInset(self.bounds, dx, dy);
  return CGRectContainsPoint(rect, point);
}

- (void)layoutSubviews {
  [super layoutSubviews];
  _thumbTrack.frame = self.bounds;
}

- (CGSize)sizeThatFits:(__unused CGSize)size {
  CGSize result = self.bounds.size;
  result.height = kSliderFrameHeight;
  return result;
}

#pragma mark - Accessibility

- (BOOL)isAccessibilityElement {
  return YES;
}

- (NSString *)accessibilityValue {
  if ([_delegate respondsToSelector:@selector(slider:accessibilityLabelForValue:)]) {
    return [_delegate slider:self accessibilityLabelForValue:self.value];
  }

  // Default behavior

  static dispatch_once_t onceToken;
  static NSNumberFormatter *numberFormatter;
  dispatch_once(&onceToken, ^{
    numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterPercentStyle;
  });
  CGFloat percentage = (self.value - self.minimumValue) / (self.maximumValue - self.minimumValue);
  return [numberFormatter stringFromNumber:@(percentage)];
}

- (UIAccessibilityTraits)accessibilityTraits {
  // Adding UIAccessibilityTraitAdjustable also causes an iOS accessibility hint to be spoken:
  // "Swipe up or down with one finger to adjust the value."
  UIAccessibilityTraits traits = super.accessibilityTraits | UIAccessibilityTraitAdjustable;
  if (!self.enabled) {
    traits |= UIAccessibilityTraitNotEnabled;
  }
  return traits;
}

- (void)accessibilityIncrement {
  if (self.enabled) {
    CGFloat range = self.maximumValue - self.minimumValue;
    CGFloat newValue = self.value + kSliderAccessibilityIncrement * range;
    [_thumbTrack setValue:newValue
                     animated:NO
        animateThumbAfterMove:NO
                userGenerated:YES
                   completion:NULL];

    [self sendActionsForControlEvents:UIControlEventValueChanged];
  }
}

- (void)accessibilityDecrement {
  if (self.enabled) {
    CGFloat range = self.maximumValue - self.minimumValue;
    CGFloat newValue = self.value - kSliderAccessibilityIncrement * range;
    [_thumbTrack setValue:newValue
                     animated:NO
        animateThumbAfterMove:NO
                userGenerated:YES
                   completion:NULL];

    [self sendActionsForControlEvents:UIControlEventValueChanged];
  }
}

#pragma mark - NSSecureCoding

+ (BOOL)supportsSecureCoding {
  return YES;
}

#pragma mark - Private

- (void)thumbTrackValueChanged:(__unused MDCThumbTrack *)thumbTrack {
  [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)thumbTrackTouchDown:(__unused MDCThumbTrack *)thumbTrack {
  [self sendActionsForControlEvents:UIControlEventTouchDown];
}

- (void)thumbTrackTouchUpInside:(__unused MDCThumbTrack *)thumbTrack {
  [self sendActionsForControlEvents:UIControlEventTouchUpInside];
}

- (void)thumbTrackTouchUpOutside:(__unused MDCThumbTrack *)thumbTrack {
  [self sendActionsForControlEvents:UIControlEventTouchUpOutside];
}

- (void)thumbTrackTouchCanceled:(__unused MDCThumbTrack *)thumbTrack {
  [self sendActionsForControlEvents:UIControlEventTouchCancel];
}

+ (UIColor *)defaultTrackOffColor {
  return [[UIColor blackColor] colorWithAlphaComponent:kSliderLightThemeTrackAlpha];
}

+ (UIColor *)defaultDisabledColor {
  return [[UIColor blackColor] colorWithAlphaComponent:kSliderLightThemeTrackAlpha];
}

@end
