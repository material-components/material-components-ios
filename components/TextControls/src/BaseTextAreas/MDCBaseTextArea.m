// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCBaseTextArea.h"

#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>

#import "MDCBaseTextAreaDelegate.h"
#import "MDCTextControlLabelBehavior.h"
#import "MDCTextControlState.h"
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wprivate-header"
#import "MDCBaseTextAreaLayout.h"
#import "MDCBaseTextAreaTextView.h"
#import "MDCTextControlStyleBase.h"
#import "MDCTextControl.h"
#import "MDCTextControlAssistiveLabelDrawPriority.h"
#import "MDCTextControlAssistiveLabelView.h"
#import "MDCTextControlColorViewModel.h"
#import "MDCTextControlGradientManager.h"
#import "MDCTextControlHorizontalPositioning.h"
#import "MDCTextControlHorizontalPositioningReference.h"
#import "MDCTextControlLabelAnimation.h"
#import "MDCTextControlLabelSupport.h"
#import "MDCTextControlPlaceholderSupport.h"
#pragma clang diagnostic pop

static char *const kKVOContextMDCBaseTextArea = "kKVOContextMDCBaseTextArea";

static const CGFloat kMDCBaseTextAreaDefaultMinimumNumberOfVisibleLines = (CGFloat)2.0;
static const CGFloat kMDCBaseTextAreaDefaultMaximumNumberOfVisibleLines = (CGFloat)4.0;

@interface MDCBaseTextArea () <MDCTextControl,
                               MDCBaseTextAreaTextViewDelegate,
                               UIGestureRecognizerDelegate>

#pragma mark MDCTextControl properties
@property(strong, nonatomic) UILabel *label;
@property(nonatomic, strong) UILabel *placeholderLabel;
@property(nonatomic, strong) MDCTextControlAssistiveLabelView *assistiveLabelView;
@property(strong, nonatomic) MDCBaseTextAreaLayout *layout;
@property(nonatomic, assign) MDCTextControlState textControlState;
@property(nonatomic, assign) MDCTextControlLabelPosition labelPosition;
@property(nonatomic, assign) CGRect normalLabelFrame;
@property(nonatomic, assign) CGRect floatingLabelFrame;
@property(nonatomic, assign) NSTimeInterval animationDuration;
/**
 * This property is set in every layout cycle, in preLayoutSubviews, right after the current
 * labelPosition is determined . It's set to YES if the labelPosition changed and NO if it didn't.
 * It's referred to in animateLabel (called from postLayoutSubviews) when deciding on a label
 * animation duration. If it's NO, the label gets an animation duration of 0, to avoid buggy looking
 * frame/text animations. Otherwise, it uses the value in the animationDuration property.
 */
@property(nonatomic, assign) BOOL labelPositionChanged;

@property(nonatomic, strong)
    NSMutableDictionary<NSNumber *, MDCTextControlColorViewModel *> *colorViewModels;

@property(strong, nonatomic) UIView *maskedTextViewContainerView;
@property(strong, nonatomic) MDCBaseTextAreaTextView *baseTextAreaTextView;

@property(nonatomic, strong) MDCTextControlGradientManager *gradientManager;

@property(strong, nonatomic) UITapGestureRecognizer *tapGesture;
@property(nonatomic, assign) CGSize cachedIntrinsicContentSize;
@property(nonatomic, assign) CGFloat cachedNumberOfLinesOfText;

@end

@implementation MDCBaseTextArea
@synthesize containerStyle = _containerStyle;
@synthesize assistiveLabelDrawPriority = _assistiveLabelDrawPriority;
@synthesize customAssistiveLabelDrawPriority = _customAssistiveLabelDrawPriority;
@synthesize adjustsFontForContentSizeCategory = _adjustsFontForContentSizeCategory;

#pragma mark Object Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCBaseTextAreaInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCBaseTextAreaInit];
  }
  return self;
}

- (void)commonMDCBaseTextAreaInit {
  [self initializeProperties];
  [self setUpTapGesture];
  [self setUpColorViewModels];
  [self setUpLabel];
  [self setUpAssistiveLabels];
  [self setUpTextView];
  [self setUpPlaceholderLabel];
  [self observeTextViewNotifications];
  [self observeLabelKeyPaths];
}

- (void)dealloc {
  [self removeObservers];
}

#pragma mark Setup

- (void)initializeProperties {
  self.animationDuration = kMDCTextControlDefaultAnimationDuration;
  self.labelBehavior = MDCTextControlLabelBehaviorFloats;
  self.labelPosition = [self determineCurrentLabelPosition];
  self.textControlState = [self determineCurrentTextControlState];
  self.containerStyle = [[MDCTextControlStyleBase alloc] init];
  self.colorViewModels = [[NSMutableDictionary alloc] init];
  self.minimumNumberOfVisibleRows = kMDCBaseTextAreaDefaultMinimumNumberOfVisibleLines;
  self.maximumNumberOfVisibleRows = kMDCBaseTextAreaDefaultMaximumNumberOfVisibleLines;
  self.gradientManager = [[MDCTextControlGradientManager alloc] init];
  self.placeholderColor = [self defaultPlaceholderColor];
}

- (void)setUpTapGesture {
  self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                            action:@selector(handleTap:)];
  [self addGestureRecognizer:self.tapGesture];
}

- (void)setUpColorViewModels {
  self.colorViewModels = [[NSMutableDictionary alloc] init];
  self.colorViewModels[@(MDCTextControlStateNormal)] =
      [[MDCTextControlColorViewModel alloc] initWithState:MDCTextControlStateNormal];
  self.colorViewModels[@(MDCTextControlStateEditing)] =
      [[MDCTextControlColorViewModel alloc] initWithState:MDCTextControlStateEditing];
  self.colorViewModels[@(MDCTextControlStateDisabled)] =
      [[MDCTextControlColorViewModel alloc] initWithState:MDCTextControlStateDisabled];
}

- (void)setUpAssistiveLabels {
  self.assistiveLabelDrawPriority = MDCTextControlAssistiveLabelDrawPriorityTrailing;
  self.assistiveLabelView = [[MDCTextControlAssistiveLabelView alloc] init];
  [self addSubview:self.assistiveLabelView];
}

- (void)setUpLabel {
  self.label = [[UILabel alloc] init];
  [self addSubview:self.label];
}

- (void)setUpPlaceholderLabel {
  self.placeholderLabel = [[UILabel alloc] init];
  [self.textView addSubview:self.placeholderLabel];
}

- (void)setUpTextView {
  self.maskedTextViewContainerView = [[UIView alloc] init];
  [self addSubview:self.maskedTextViewContainerView];

  self.baseTextAreaTextView = [[MDCBaseTextAreaTextView alloc] init];
  self.baseTextAreaTextView.textAreaTextViewDelegate = self;
  [self.maskedTextViewContainerView addSubview:self.baseTextAreaTextView];
}

#pragma mark UIView Overrides

- (void)layoutSubviews {
  [self preLayoutSubviews];
  [super layoutSubviews];
  [self postLayoutSubviews];
}

- (CGSize)sizeThatFits:(CGSize)size {
  return [self preferredSizeWithWidth:size.width];
}

- (CGSize)intrinsicContentSize {
  self.cachedIntrinsicContentSize = [self preferredSizeWithWidth:CGRectGetWidth(self.bounds)];
  return self.cachedIntrinsicContentSize;
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];
  [self setNeedsLayout];
}

- (void)setSemanticContentAttribute:(UISemanticContentAttribute)semanticContentAttribute {
  [super setSemanticContentAttribute:semanticContentAttribute];

  self.textView.semanticContentAttribute = semanticContentAttribute;
  self.placeholderLabel.semanticContentAttribute = semanticContentAttribute;
  [self setNeedsLayout];
}

- (void)setEnabled:(BOOL)enabled {
  [super setEnabled:enabled];
  self.textView.editable = enabled;
  [self setNeedsLayout];
}

#pragma mark Private Layout

- (void)preLayoutSubviews {
  self.textControlState = [self determineCurrentTextControlState];
  MDCTextControlLabelPosition previousLabelPosition = self.labelPosition;
  self.labelPosition = [self determineCurrentLabelPosition];
  self.labelPositionChanged = previousLabelPosition != self.labelPosition;
  self.placeholderLabel.attributedText = [self determineAttributedPlaceholder];
  self.placeholderLabel.numberOfLines = (NSInteger)self.numberOfLinesOfVisibleText;
  MDCTextControlColorViewModel *colorViewModel =
      [self textControlColorViewModelForState:self.textControlState];
  [self applyColorViewModel:colorViewModel withLabelPosition:self.labelPosition];
  CGSize fittingSize = CGSizeMake(CGRectGetWidth(self.frame), CGFLOAT_MAX);
  self.layout = [self calculateLayoutWithSize:fittingSize];
  self.floatingLabelFrame = self.layout.labelFrameFloating;
  self.normalLabelFrame = self.layout.labelFrameNormal;
}

- (void)postLayoutSubviews {
  self.maskedTextViewContainerView.frame = self.containerFrame;
  self.textView.frame = self.layout.textViewFrame;
  self.placeholderLabel.hidden = self.layout.placeholderLabelHidden;
  self.placeholderLabel.frame = self.layout.placeholderLabelFrame;
  self.assistiveLabelView.frame = self.layout.assistiveLabelViewFrame;
  self.assistiveLabelView.layout = self.layout.assistiveLabelViewLayout;
  [self.assistiveLabelView setNeedsLayout];
  [self animateLabel];
  [self updateSideViews];
  [self.containerStyle applyStyleToTextControl:self animationDuration:self.animationDuration];
  [self layoutGradientLayers];
  [self scrollToSelectedText];
  if ([self widthHasChanged] || [self calculatedHeightHasChanged]) {
    [self handleIntrinsicContentSizeChange];
  }
}

- (void)updateSideViews {
  if (self.layout.displaysLeadingView) {
    if (self.leadingView) {
      if (self.leadingView.superview != self) {
        [self addSubview:self.leadingView];
      }
      self.leadingView.frame = self.layout.leadingViewFrame;
    }
  } else {
    [self.leadingView removeFromSuperview];
  }

  if (self.layout.displaysTrailingView) {
    if (self.trailingView) {
      if (self.trailingView.superview != self) {
        [self addSubview:self.trailingView];
      }
      self.trailingView.frame = self.layout.trailingViewFrame;
    }
  } else {
    [self.trailingView removeFromSuperview];
  }
}

- (void)scrollToSelectedText {
  //  Undesirable things happen to the text view's contentOffset when adding new lines in a growing
  //  MDCBaseTextArea in iOS versions 11 and 12. Specifically, hitting return will appear to result
  //  in two newlines, instead of one, but it's really just contentOffset being set. This line seems
  //  to prevent this issue without creating any others.
  [self.textView scrollRangeToVisible:self.textView.selectedRange];
}

- (MDCBaseTextAreaLayout *)calculateLayoutWithSize:(CGSize)size {
  CGFloat clampedCustomAssistiveLabelDrawPriority =
      [self clampedCustomAssistiveLabelDrawPriority:self.customAssistiveLabelDrawPriority];
  id<MDCTextControlVerticalPositioningReference> verticalPositioningReference =
      [self createVerticalPositioningReference];
  id<MDCTextControlHorizontalPositioning> horizontalPositioningReference =
      [self createHorizontalPositioningReference];
  return [[MDCBaseTextAreaLayout alloc] initWithSize:size
                        verticalPositioningReference:verticalPositioningReference
                      horizontalPositioningReference:horizontalPositioningReference
                                                text:self.baseTextAreaTextView.text
                                                font:self.normalFont
                                        floatingFont:self.floatingFont
                                               label:self.label
                                       labelPosition:self.labelPosition
                                       labelBehavior:self.labelBehavior
                                    placeholderLabel:self.placeholderLabel
                                         leadingView:self.leadingView
                                     leadingViewMode:self.leadingViewMode
                                        trailingView:self.trailingView
                                    trailingViewMode:self.trailingViewMode
                               leadingAssistiveLabel:self.assistiveLabelView.leadingAssistiveLabel
                              trailingAssistiveLabel:self.assistiveLabelView.trailingAssistiveLabel
                          assistiveLabelDrawPriority:self.assistiveLabelDrawPriority
                    customAssistiveLabelDrawPriority:clampedCustomAssistiveLabelDrawPriority
                                               isRTL:self.shouldLayoutForRTL
                                           isEditing:self.textView.isFirstResponder];
}

- (id<MDCTextControlVerticalPositioningReference>)createVerticalPositioningReference {
  return [self.containerStyle
      positioningReferenceWithFloatingFontLineHeight:self.floatingFont.lineHeight
                                normalFontLineHeight:self.normalFont.lineHeight
                                       textRowHeight:(self.normalFont.lineHeight +
                                                      self.normalFont.leading)
                                    numberOfTextRows:self.numberOfLinesOfVisibleText
                                             density:self.verticalDensity
                            preferredContainerHeight:self.preferredContainerHeight
                              isMultilineTextControl:YES];
}

- (id<MDCTextControlHorizontalPositioning>)createHorizontalPositioningReference {
  id<MDCTextControlHorizontalPositioning> horizontalPositioningReference =
      self.containerStyle.horizontalPositioningReference;
  if (self.leadingEdgePaddingOverride) {
    horizontalPositioningReference.leadingEdgePadding =
        (CGFloat)[self.leadingEdgePaddingOverride doubleValue];
  }
  if (self.trailingEdgePaddingOverride) {
    horizontalPositioningReference.trailingEdgePadding =
        (CGFloat)[self.trailingEdgePaddingOverride doubleValue];
  }
  if (self.horizontalInterItemSpacingOverride) {
    horizontalPositioningReference.horizontalInterItemSpacing =
        (CGFloat)[self.horizontalInterItemSpacingOverride doubleValue];
  }
  return horizontalPositioningReference;
}

- (CGFloat)clampedCustomAssistiveLabelDrawPriority:(CGFloat)customPriority {
  CGFloat value = customPriority;
  if (value < 0) {
    value = 0;
  } else if (value > 1) {
    value = 1;
  }
  return value;
}

- (CGSize)preferredSizeWithWidth:(CGFloat)width {
  CGSize fittingSize = CGSizeMake(width, CGFLOAT_MAX);
  MDCBaseTextAreaLayout *layout = [self calculateLayoutWithSize:fittingSize];
  return CGSizeMake(width, layout.calculatedHeight);
}

- (BOOL)widthHasChanged {
  return CGRectGetWidth(self.bounds) != self.cachedIntrinsicContentSize.width;
}

- (BOOL)calculatedHeightHasChanged {
  return self.layout.calculatedHeight != self.cachedIntrinsicContentSize.height;
}

- (void)handleIntrinsicContentSizeChange {
  [self invalidateIntrinsicContentSize];
  if ([self.baseTextAreaDelegate respondsToSelector:@selector(baseTextArea:shouldChangeSize:)]) {
    CGSize preferredSize = CGSizeMake(CGRectGetWidth(self.bounds), self.layout.calculatedHeight);
    [self.baseTextAreaDelegate baseTextArea:self shouldChangeSize:preferredSize];
  }
}

- (void)layoutGradientLayers {
  CGRect gradientLayerFrame = self.containerFrame;
  self.gradientManager.horizontalGradient.frame = gradientLayerFrame;
  self.gradientManager.verticalGradient.frame = gradientLayerFrame;
  self.gradientManager.horizontalGradient.locations = self.layout.horizontalGradientLocations;
  self.gradientManager.verticalGradient.locations = self.layout.verticalGradientLocations;
  self.maskedTextViewContainerView.layer.mask = [self.gradientManager combinedGradientMaskLayer];
}

- (CGFloat)numberOfLinesOfText {
  // For more context on measuring the lines in a UITextView see here:
  // https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/TextLayout/Tasks/CountLines.html
  NSLayoutManager *layoutManager = self.textView.layoutManager;
  NSUInteger numberOfGlyphs = layoutManager.numberOfGlyphs;
  NSRange lineRange = NSMakeRange(0, 1);
  NSUInteger index = 0;
  NSUInteger numberOfLines = 0;
  while (index < numberOfGlyphs) {
    [layoutManager lineFragmentRectForGlyphAtIndex:index effectiveRange:&lineRange];
    index = NSMaxRange(lineRange);
    numberOfLines += 1;
  }

  BOOL textEndsInNewLine =
      self.textView.text.length > 0 &&
      [self.textView.text characterAtIndex:self.textView.text.length - 1] == '\n';
  if (textEndsInNewLine) {
    numberOfLines += 1;
  }
  BOOL numberOfLinesChanged = self.cachedNumberOfLinesOfText != (CGFloat)numberOfLines;
  if (numberOfLinesChanged) {
    [self setNeedsLayout];
  }
  self.cachedNumberOfLinesOfText = (CGFloat)numberOfLines;
  return (CGFloat)numberOfLines;
}

- (CGFloat)numberOfLinesOfVisibleText {
  CGFloat numberOfLinesOfText = [self numberOfLinesOfText];
  if (numberOfLinesOfText < self.minimumNumberOfVisibleRows) {
    return self.minimumNumberOfVisibleRows;
  } else if (numberOfLinesOfText > self.maximumNumberOfVisibleRows) {
    return self.maximumNumberOfVisibleRows;
  }
  return numberOfLinesOfText;
}

#pragma mark Dynamic Type

- (void)setAdjustsFontForContentSizeCategory:(BOOL)adjustsFontForContentSizeCategory {
  _adjustsFontForContentSizeCategory = adjustsFontForContentSizeCategory;
  self.textView.adjustsFontForContentSizeCategory = adjustsFontForContentSizeCategory;
  self.leadingAssistiveLabel.adjustsFontForContentSizeCategory = adjustsFontForContentSizeCategory;
  self.trailingAssistiveLabel.adjustsFontForContentSizeCategory = adjustsFontForContentSizeCategory;
}

#pragma mark MDCTextControlState

- (MDCTextControlState)determineCurrentTextControlState {
  BOOL isEnabled = self.enabled && self.baseTextAreaTextView.isEditable;
  BOOL isEditing = self.textView.isFirstResponder;
  return MDCTextControlStateWith(isEnabled, isEditing);
}

#pragma mark Placeholder

- (NSAttributedString *)determineAttributedPlaceholder {
  if ([self shouldPlaceholderBeVisible]) {
    NSDictionary<NSAttributedStringKey, id> *attributes = @{
      NSParagraphStyleAttributeName : [self defaultPlaceholderParagraphStyle],
      NSForegroundColorAttributeName : self.placeholderColor,
      NSFontAttributeName : self.normalFont
    };
    return [[NSAttributedString alloc] initWithString:self.placeholder attributes:attributes];
  } else {
    return nil;
  }
}

- (BOOL)shouldPlaceholderBeVisible {
  return MDCTextControlShouldPlaceholderBeVisibleWithPlaceholder(
      self.placeholder, self.textView.text, self.labelPosition);
}

/**
 This method provides the default paragraph style object for the placeholder label. Without this
 it's much harder to get the placeholder to be perfectly vertically aligned with the text in the
 text view.
 */
- (NSParagraphStyle *)defaultPlaceholderParagraphStyle {
  static NSParagraphStyle *paragraphStyle = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    id attribute =
        [self defaultUiTextFieldPlaceholderAttributeWithKey:NSParagraphStyleAttributeName];
    if ([attribute isKindOfClass:[NSParagraphStyle class]]) {
      paragraphStyle = (NSParagraphStyle *)attribute;
    }
  });
  return paragraphStyle;
}

- (UIColor *)defaultPlaceholderColor {
  static UIColor *placeholderColor = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    id attribute =
        [self defaultUiTextFieldPlaceholderAttributeWithKey:NSForegroundColorAttributeName];
    if ([attribute isKindOfClass:[UIColor class]]) {
      placeholderColor = (UIColor *)attribute;
    }
  });
  return placeholderColor;
}

- (id)defaultUiTextFieldPlaceholderAttributeWithKey:(NSAttributedStringKey)attributedStringKey {
  UITextField *textField = [[UITextField alloc] init];
  textField.placeholder = @"placeholder";
  NSAttributedString *attributedPlaceholder = textField.attributedPlaceholder;
  NSDictionary *attributeKeysToAttributes =
      [attributedPlaceholder attributesAtIndex:0
                         longestEffectiveRange:nil
                                       inRange:NSMakeRange(0, attributedPlaceholder.length)];
  for (NSAttributedStringKey key in attributeKeysToAttributes) {
    if (key == attributedStringKey) {
      return attributeKeysToAttributes[attributedStringKey];
    }
  }
  return nil;
}

#pragma mark Label

- (void)animateLabel {
  NSTimeInterval animationDuration = self.labelPositionChanged ? self.animationDuration : 0.0f;
  __weak MDCBaseTextArea *weakSelf = self;
  [MDCTextControlLabelAnimation animateLabel:self.label
                                       state:self.labelPosition
                            normalLabelFrame:self.layout.labelFrameNormal
                          floatingLabelFrame:self.layout.labelFrameFloating
                                  normalFont:self.normalFont
                                floatingFont:self.floatingFont
                    labelTruncationIsPresent:self.layout.labelTruncationIsPresent
                           animationDuration:animationDuration
                                  completion:^(BOOL finished) {
                                    if (finished) {
                                      // Ensure that the label position is correct in case of
                                      // competing animations.
                                      weakSelf.label.frame = [weakSelf.layout
                                          labelFrameWithLabelPosition:self.labelPosition];
                                    }
                                  }];
}

- (BOOL)canLabelFloat {
  return self.labelBehavior == MDCTextControlLabelBehaviorFloats;
}

- (MDCTextControlLabelPosition)determineCurrentLabelPosition {
  return MDCTextControlLabelPositionWith(self.label.text.length > 0, self.textView.text.length > 0,
                                         self.canLabelFloat, self.textView.isFirstResponder);
}

#pragma mark Custom Accessors

- (void)setLeadingEdgePaddingOverride:(NSNumber *)leadingEdgePaddingOverride {
  _leadingEdgePaddingOverride = leadingEdgePaddingOverride;
  [self setNeedsLayout];
}

- (void)setTrailingEdgePaddingOverride:(NSNumber *)trailingEdgePaddingOverride {
  _trailingEdgePaddingOverride = trailingEdgePaddingOverride;
  [self setNeedsLayout];
}

- (UITextView *)textView {
  return self.baseTextAreaTextView;
}

- (void)setPlaceholder:(NSString *)placeholder {
  _placeholder = placeholder;
  [self setNeedsLayout];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
  _placeholderColor = placeholderColor ?: [self defaultPlaceholderColor];
}

- (void)setVerticalDensity:(CGFloat)verticalDensity {
  _verticalDensity = verticalDensity;
  [self setNeedsLayout];
}

#pragma mark MDCTextControl Protocol Accessors

- (void)setLeadingView:(UIView *)leadingView {
  [_leadingView removeFromSuperview];
  _leadingView = leadingView;
  [self setNeedsLayout];
}

- (void)setTrailingView:(UIView *)trailingView {
  [_trailingView removeFromSuperview];
  _trailingView = trailingView;
  [self setNeedsLayout];
}

- (void)setLeadingViewMode:(UITextFieldViewMode)leadingViewMode {
  _leadingViewMode = leadingViewMode;
  [self setNeedsLayout];
}

- (void)setTrailingViewMode:(UITextFieldViewMode)trailingViewMode {
  _trailingViewMode = trailingViewMode;
  [self setNeedsLayout];
}

- (void)setContainerStyle:(id<MDCTextControlStyle>)containerStyle {
  id<MDCTextControlStyle> oldStyle = _containerStyle;
  if (oldStyle) {
    [oldStyle removeStyleFrom:self];
  }
  _containerStyle = containerStyle;
  [_containerStyle applyStyleToTextControl:self animationDuration:self.animationDuration];
}

- (CGRect)containerFrame {
  return CGRectMake(0, 0, CGRectGetWidth(self.frame), self.layout.containerHeight);
}

- (UILabel *)leadingAssistiveLabel {
  return self.assistiveLabelView.leadingAssistiveLabel;
}

- (UILabel *)trailingAssistiveLabel {
  return self.assistiveLabelView.trailingAssistiveLabel;
}

#pragma mark Fonts

- (UIFont *)normalFont {
  return self.baseTextAreaTextView.font ?: MDCTextControlDefaultUITextFieldFont();
}

- (UIFont *)floatingFont {
  return [self.containerStyle floatingFontWithNormalFont:self.normalFont];
}

#pragma mark MDCBaseTextAreaTextViewDelegate

- (void)textAreaTextView:(MDCBaseTextAreaTextView *)textView
    willBecomeFirstResponder:(BOOL)willBecome {
  if (textView == self.baseTextAreaTextView) {
    [self setNeedsLayout];
  }
}

- (void)textAreaTextView:(MDCBaseTextAreaTextView *)textView
    willResignFirstResponder:(BOOL)willResign {
  if (textView == self.baseTextAreaTextView) {
    [self setNeedsLayout];
  }
}

#pragma mark Internationalization

- (BOOL)shouldLayoutForRTL {
  if (self.semanticContentAttribute == UISemanticContentAttributeForceRightToLeft) {
    return YES;
  } else if (self.semanticContentAttribute == UISemanticContentAttributeForceLeftToRight) {
    return NO;
  } else {
    return self.effectiveUserInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft;
  }
}

#pragma mark Coloring

- (void)applyColorViewModel:(MDCTextControlColorViewModel *)colorViewModel
          withLabelPosition:(MDCTextControlLabelPosition)labelPosition {
  UIColor *labelColor = [UIColor clearColor];
  if (labelPosition == MDCTextControlLabelPositionNormal) {
    labelColor = colorViewModel.normalLabelColor;
  } else if (labelPosition == MDCTextControlLabelPositionFloating) {
    labelColor = colorViewModel.floatingLabelColor;
  }
  if (![self.textView.textColor isEqual:colorViewModel.textColor]) {
    self.textView.textColor = colorViewModel.textColor;
  }
  if (![self.leadingAssistiveLabel.textColor isEqual:colorViewModel.leadingAssistiveLabelColor]) {
    self.leadingAssistiveLabel.textColor = colorViewModel.leadingAssistiveLabelColor;
  }
  if (![self.trailingAssistiveLabel.textColor isEqual:colorViewModel.trailingAssistiveLabelColor]) {
    self.trailingAssistiveLabel.textColor = colorViewModel.trailingAssistiveLabelColor;
  }
  if (![self.label.textColor isEqual:labelColor]) {
    self.label.textColor = labelColor;
  }
}

- (void)setTextControlColorViewModel:(MDCTextControlColorViewModel *)TextControlColorViewModel
                            forState:(MDCTextControlState)textControlState {
  self.colorViewModels[@(textControlState)] = TextControlColorViewModel;
}

- (MDCTextControlColorViewModel *)textControlColorViewModelForState:
    (MDCTextControlState)textControlState {
  MDCTextControlColorViewModel *colorViewModel = self.colorViewModels[@(textControlState)];
  if (!colorViewModel) {
    colorViewModel = [[MDCTextControlColorViewModel alloc] initWithState:textControlState];
  }
  return colorViewModel;
}

#pragma mark Color Accessors

- (void)setNormalLabelColor:(nonnull UIColor *)labelColor forState:(MDCTextControlState)state {
  MDCTextControlColorViewModel *colorViewModel = [self textControlColorViewModelForState:state];
  colorViewModel.normalLabelColor = labelColor;
  [self setNeedsLayout];
}

- (UIColor *)normalLabelColorForState:(MDCTextControlState)state {
  MDCTextControlColorViewModel *colorViewModel = [self textControlColorViewModelForState:state];
  return colorViewModel.normalLabelColor;
}

- (void)setFloatingLabelColor:(nonnull UIColor *)labelColor forState:(MDCTextControlState)state {
  MDCTextControlColorViewModel *colorViewModel = [self textControlColorViewModelForState:state];
  colorViewModel.floatingLabelColor = labelColor;
  [self setNeedsLayout];
}

- (UIColor *)floatingLabelColorForState:(MDCTextControlState)state {
  MDCTextControlColorViewModel *colorViewModel = [self textControlColorViewModelForState:state];
  return colorViewModel.floatingLabelColor;
}

- (void)setTextColor:(nonnull UIColor *)labelColor forState:(MDCTextControlState)state {
  MDCTextControlColorViewModel *colorViewModel = [self textControlColorViewModelForState:state];
  colorViewModel.textColor = labelColor;
  [self setNeedsLayout];
}

- (UIColor *)textColorForState:(MDCTextControlState)state {
  MDCTextControlColorViewModel *colorViewModel = [self textControlColorViewModelForState:state];
  return colorViewModel.textColor;
}

- (void)setLeadingAssistiveLabelColor:(nonnull UIColor *)assistiveLabelColor
                             forState:(MDCTextControlState)state {
  MDCTextControlColorViewModel *colorViewModel = [self textControlColorViewModelForState:state];
  colorViewModel.leadingAssistiveLabelColor = assistiveLabelColor;
  [self setNeedsLayout];
}

- (UIColor *)leadingAssistiveLabelColorForState:(MDCTextControlState)state {
  MDCTextControlColorViewModel *colorViewModel = [self textControlColorViewModelForState:state];
  return colorViewModel.leadingAssistiveLabelColor;
}

- (void)setTrailingAssistiveLabelColor:(nonnull UIColor *)assistiveLabelColor
                              forState:(MDCTextControlState)state {
  MDCTextControlColorViewModel *colorViewModel = [self textControlColorViewModelForState:state];
  colorViewModel.trailingAssistiveLabelColor = assistiveLabelColor;
  [self setNeedsLayout];
}

- (UIColor *)trailingAssistiveLabelColorForState:(MDCTextControlState)state {
  MDCTextControlColorViewModel *colorViewModel = [self textControlColorViewModelForState:state];
  return colorViewModel.trailingAssistiveLabelColor;
}

#pragma mark User Actions

- (void)handleTap:(UITapGestureRecognizer *)tap {
  if (tap.state == UIGestureRecognizerStateEnded) {
    if (!self.textView.isFirstResponder) {
      [self.textView becomeFirstResponder];
    }
  }
}

- (void)textViewChanged:(NSNotification *)notification {
  if (notification.object == self.baseTextAreaTextView) {
    [self setNeedsLayout];
  }
}

#pragma mark Notifications

- (void)observeTextViewNotifications {
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(textViewChanged:)
                                               name:UITextViewTextDidChangeNotification
                                             object:nil];
}

#pragma mark - Key-value observing

- (void)observeLabelKeyPaths {
  for (NSString *keyPath in [MDCBaseTextArea assistiveLabelKeyPaths]) {
    [self.leadingAssistiveLabel addObserver:self
                                 forKeyPath:keyPath
                                    options:NSKeyValueObservingOptionNew
                                    context:kKVOContextMDCBaseTextArea];
    [self.trailingAssistiveLabel addObserver:self
                                  forKeyPath:keyPath
                                     options:NSKeyValueObservingOptionNew
                                     context:kKVOContextMDCBaseTextArea];
  }
  for (NSString *keyPath in [MDCBaseTextArea labelKeyPaths]) {
    [self.label addObserver:self
                 forKeyPath:keyPath
                    options:NSKeyValueObservingOptionNew
                    context:kKVOContextMDCBaseTextArea];
  }
}

- (void)removeObservers {
  for (NSString *keyPath in [MDCBaseTextArea assistiveLabelKeyPaths]) {
    [self.leadingAssistiveLabel removeObserver:self
                                    forKeyPath:keyPath
                                       context:kKVOContextMDCBaseTextArea];
    [self.trailingAssistiveLabel removeObserver:self
                                     forKeyPath:keyPath
                                        context:kKVOContextMDCBaseTextArea];
  }
  for (NSString *keyPath in [MDCBaseTextArea labelKeyPaths]) {
    [self.label removeObserver:self forKeyPath:keyPath context:kKVOContextMDCBaseTextArea];
  }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey, id> *)change
                       context:(void *)context {
  if (context == kKVOContextMDCBaseTextArea) {
    if (object == self.leadingAssistiveLabel || object == self.trailingAssistiveLabel) {
      for (NSString *labelKeyPath in [MDCBaseTextArea assistiveLabelKeyPaths]) {
        if ([labelKeyPath isEqualToString:keyPath]) {
          [self setNeedsLayout];
          break;
        }
      }
    } else if (object == self.label)
      for (NSString *labelKeyPath in [MDCBaseTextArea labelKeyPaths]) {
        if ([labelKeyPath isEqualToString:keyPath]) {
          [self setNeedsLayout];
          break;
        }
      }
  }
}

+ (NSArray<NSString *> *)assistiveLabelKeyPaths {
  static NSArray<NSString *> *keyPaths = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    keyPaths = @[
      NSStringFromSelector(@selector(text)),
      NSStringFromSelector(@selector(font)),
    ];
  });
  return keyPaths;
}

+ (NSArray<NSString *> *)labelKeyPaths {
  static NSArray<NSString *> *keyPaths = nil;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    keyPaths = @[
      NSStringFromSelector(@selector(text)),
    ];
  });
  return keyPaths;
}

@end
