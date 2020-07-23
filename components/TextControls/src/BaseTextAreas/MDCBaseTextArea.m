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
#import <MDFInternationalization/MDFInternationalization.h>
#import <QuartzCore/QuartzCore.h>

#import "MaterialMath.h"
#import "MaterialTextControlsPrivate+BaseStyle.h"
#import "MaterialTextControlsPrivate+Shared.h"
#import "private/MDCBaseTextAreaLayout.h"
#import "private/MDCBaseTextAreaTextView.h"

static const CGFloat kMDCBaseTextAreaDefaultMinimumNumberOfVisibleLines = (CGFloat)2.0;
static const CGFloat kMDCBaseTextAreaDefaultMaximumNumberOfVisibleLines = (CGFloat)4.0;

@interface MDCBaseTextArea () <MDCTextControl,
                               MDCBaseTextAreaTextViewDelegate,
                               UIGestureRecognizerDelegate>

#pragma mark MDCTextControl properties
@property(strong, nonatomic) UILabel *label;
@property(nonatomic, strong) MDCTextControlAssistiveLabelView *assistiveLabelView;
@property(strong, nonatomic) MDCBaseTextAreaLayout *layout;
@property(nonatomic, assign) MDCTextControlState textControlState;
@property(nonatomic, assign) MDCTextControlLabelPosition labelPosition;
@property(nonatomic, assign) CGRect labelFrame;
@property(nonatomic, assign) NSTimeInterval animationDuration;

@property(nonatomic, strong)
    NSMutableDictionary<NSNumber *, MDCTextControlColorViewModel *> *colorViewModels;

@property(strong, nonatomic) UIView *maskedTextViewContainerView;
@property(strong, nonatomic) MDCBaseTextAreaTextView *baseTextAreaTextView;

@property(nonatomic, strong) MDCTextControlGradientManager *gradientManager;

@property(strong, nonatomic) UITapGestureRecognizer *tapGesture;
@property(nonatomic, assign) CGSize cachedIntrinsicContentSize;

@end

@implementation MDCBaseTextArea
@synthesize containerStyle = _containerStyle;
@synthesize assistiveLabelDrawPriority = _assistiveLabelDrawPriority;
@synthesize customAssistiveLabelDrawPriority = _customAssistiveLabelDrawPriority;
@synthesize preferredContainerHeight = _preferredContainerHeight;
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
  [self observeTextViewNotifications];
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
  [self setNeedsLayout];
}

- (void)setEnabled:(BOOL)enabled {
  [super setEnabled:enabled];
  self.textView.editable = enabled;
  [self setNeedsLayout];
}

#pragma mark Private Layout

- (void)preLayoutSubviews {
  if (![self validateWidth]) {
    [self invalidateIntrinsicContentSize];
  }
  self.textControlState = [self determineCurrentTextControlState];
  self.labelPosition = [self determineCurrentLabelPosition];
  MDCTextControlColorViewModel *colorViewModel =
      [self textControlColorViewModelForState:self.textControlState];
  [self applyColorViewModel:colorViewModel withLabelPosition:self.labelPosition];
  CGSize fittingSize = CGSizeMake(CGRectGetWidth(self.frame), CGFLOAT_MAX);
  self.layout = [self calculateLayoutWithSize:fittingSize];
  self.labelFrame = [self.layout labelFrameWithLabelPosition:self.labelPosition];
}

- (void)postLayoutSubviews {
  self.maskedTextViewContainerView.frame = self.containerFrame;
  self.textView.frame = self.layout.textViewFrame;
  self.assistiveLabelView.frame = self.layout.assistiveLabelViewFrame;
  self.assistiveLabelView.layout = self.layout.assistiveLabelViewLayout;
  [self.assistiveLabelView setNeedsLayout];
  [self animateLabel];
  [self.containerStyle applyStyleToTextControl:self animationDuration:self.animationDuration];
  [self layoutGradientLayers];
  if (![self validateHeight]) {
    [self invalidateIntrinsicContentSize];
  }
  [self scrollToVisibleText];
}

- (void)scrollToVisibleText {
  // This method was added to address b/161887902, with help from
  // https://stackoverflow.com/a/49631521
  NSRange range = NSMakeRange(self.textView.text.length - 1, 1);
  [self.textView scrollRangeToVisible:range];
  self.textView.scrollEnabled = NO;
  self.textView.scrollEnabled = YES;
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
                                             density:0
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

- (BOOL)validateWidth {
  return CGRectGetWidth(self.bounds) == self.cachedIntrinsicContentSize.width;
}

- (BOOL)validateHeight {
  return self.layout.calculatedHeight == self.cachedIntrinsicContentSize.height;
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
  if (@available(iOS 10.0, *)) {
    _adjustsFontForContentSizeCategory = adjustsFontForContentSizeCategory;
    self.textView.adjustsFontForContentSizeCategory = adjustsFontForContentSizeCategory;
    self.leadingAssistiveLabel.adjustsFontForContentSizeCategory =
        adjustsFontForContentSizeCategory;
    self.trailingAssistiveLabel.adjustsFontForContentSizeCategory =
        adjustsFontForContentSizeCategory;
  }
}

#pragma mark MDCTextControlState

- (MDCTextControlState)determineCurrentTextControlState {
  BOOL isEnabled = self.enabled && self.baseTextAreaTextView.isEditable;
  BOOL isEditing = self.textView.isFirstResponder;
  return MDCTextControlStateWith(isEnabled, isEditing);
}

#pragma mark Label

- (void)animateLabel {
  __weak MDCBaseTextArea *weakSelf = self;
  [MDCTextControlLabelAnimation animateLabel:self.label
                                       state:self.labelPosition
                            normalLabelFrame:self.layout.labelFrameNormal
                          floatingLabelFrame:self.layout.labelFrameFloating
                                  normalFont:self.normalFont
                                floatingFont:self.floatingFont
                           animationDuration:self.animationDuration
                                  completion:^(BOOL finished) {
                                    if (finished) {
                                      // Ensure that the label position is correct in case of
                                      // competing animations.
                                      weakSelf.label.frame = weakSelf.labelFrame;
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

#pragma mark MDCTextControl Protocol Accessors

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
    return self.mdf_effectiveUserInterfaceLayoutDirection ==
           UIUserInterfaceLayoutDirectionRightToLeft;
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

@end
