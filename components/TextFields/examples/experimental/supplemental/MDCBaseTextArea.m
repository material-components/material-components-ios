// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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
#import "MDCBaseTextAreaLayout.h"

#import <CoreGraphics/CoreGraphics.h>
#import <MDFInternationalization/MDFInternationalization.h>
#import <QuartzCore/QuartzCore.h>

#import "MDCContainedInputView.h"
#import "MDCContainedInputViewLabelAnimator.h"
#import "MDCContainedInputViewStyleBase.h"
#import "MaterialMath.h"

@class MDCBaseTextAreaTextView;
@protocol MDCBaseTextAreaTextViewDelegate <NSObject>
- (void)inputChipViewTextViewDidBecomeFirstResponder:(BOOL)didBecome;
- (void)inputChipViewTextViewDidResignFirstResponder:(BOOL)didResign;
@end

@interface MDCBaseTextAreaTextView : UITextView
@property(nonatomic, weak) id<MDCBaseTextAreaTextViewDelegate> inputChipViewTextViewDelegate;
@property(strong, nonatomic, readonly) UIFont *effectiveFont;
@end

@implementation MDCBaseTextAreaTextView

- (instancetype)init {
  self = [super init];
  if (self) {
    [self commonMDCBaseTextAreaTextViewInit];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCBaseTextAreaTextViewInit];
  }
  return self;
}

- (void)commonMDCBaseTextAreaTextViewInit {
  self.backgroundColor = [UIColor clearColor];
  self.textContainerInset = UIEdgeInsetsZero;
}

- (UIFont *)effectiveFont {
  return self.font ?: [UIFont systemFontOfSize:[UIFont systemFontSize]];
}

- (BOOL)resignFirstResponder {
  BOOL didResignFirstResponder = [super resignFirstResponder];
  [self.inputChipViewTextViewDelegate
      inputChipViewTextViewDidResignFirstResponder:didResignFirstResponder];
  return didResignFirstResponder;
}

- (BOOL)becomeFirstResponder {
  self.layer.borderColor = [UIColor redColor].CGColor;
  self.layer.borderWidth = 1;

  BOOL didBecomeFirstResponder = [super becomeFirstResponder];
  [self.inputChipViewTextViewDelegate
      inputChipViewTextViewDidBecomeFirstResponder:didBecomeFirstResponder];
  return didBecomeFirstResponder;
}

@end

@interface MDCBaseTextArea () <MDCContainedInputView,
                               MDCBaseTextAreaTextViewDelegate,
                               UIGestureRecognizerDelegate>

#pragma mark MDCContainedInputView properties
@property(strong, nonatomic) UILabel *label;

@property(strong, nonatomic) UILabel *leftAssistiveLabel;
@property(strong, nonatomic) UILabel *rightAssistiveLabel;

@property(strong, nonatomic) UIView *maskedScrollViewContainerView;
@property(strong, nonatomic) UIScrollView *scrollView;
@property(strong, nonatomic) UIView *scrollViewContentViewTouchForwardingView;
@property(strong, nonatomic) MDCBaseTextAreaTextView *inputChipViewTextView;

@property(strong, nonatomic) MDCBaseTextAreaLayout *layout;

@property(strong, nonatomic) UITouch *lastTouch;
@property(nonatomic, assign) CGPoint lastTouchInitialContentOffset;
@property(nonatomic, assign) CGPoint lastTouchInitialLocation;

@property(strong, nonatomic) CAGradientLayer *horizontalGradient;
@property(strong, nonatomic) CAGradientLayer *verticalGradient;

//@property(strong, nonatomic) UIButton *clearButton;
//@property(strong, nonatomic) UIImageView *clearButtonImageView;
//@property(strong, nonatomic) UILabel *floatingLabel;
//
//@property(strong, nonatomic) UILabel *leftAssistiveLabel;
//@property(strong, nonatomic) UILabel *rightAssistiveLabel;

@property(nonatomic, assign) UIUserInterfaceLayoutDirection layoutDirection;

@property(nonatomic, assign) MDCContainedInputViewState containedInputViewState;
@property(nonatomic, assign) MDCContainedInputViewLabelState labelState;

@property(nonatomic, strong)
    NSMutableDictionary<NSNumber *, id<MDCContainedInputViewColorScheming>> *colorSchemes;

@end

@implementation MDCBaseTextArea
@synthesize labelAnimator = _labelAnimator;
@synthesize preferredContainerHeight = _preferredContainerHeight;
@synthesize underlineLabelDrawPriority = _underlineLabelDrawPriority;
@synthesize customAssistiveLabelDrawPriority = _customAssistiveLabelDrawPriority;
@synthesize containerStyle = _containerStyle;
@synthesize label = _label;

#pragma mark Object Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonInputChipViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonInputChipViewInit];
  }
  return self;
}

- (void)commonInputChipViewInit {
  [self addObservers];
  [self initializeProperties];
  [self createSubviews];
  [self setUpGradientLayers];
  [self setUpColorSchemesDictionary];
  [self setUpAssistiveLabels];
  [self setUpClearButton];
  [self setUpContainerStyle];
}

- (void)setUpColorSchemesDictionary {
  self.colorSchemes = [[NSMutableDictionary alloc] init];
}

- (void)setUpContainerStyle {
  self.containerStyle = [[MDCContainedInputViewStyleBase alloc] init];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark Setup

- (void)addObservers {
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(textViewDidEndEditingWithNotification:)
             name:UITextViewTextDidEndEditingNotification
           object:nil];
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(textFieldDidBeginEditingWithNotification:)
             name:UITextViewTextDidBeginEditingNotification
           object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(textViewDidChangeWithNotification:)
                                               name:UITextViewTextDidChangeNotification
                                             object:nil];
}

- (void)initializeProperties {
  [self setUpLayoutDirection];
  [self setUpPlaceholderManager];
}

- (void)setUpPlaceholderManager {
  self.labelAnimator = [[MDCContainedInputViewLabelAnimator alloc] init];
}

- (void)setUpLayoutDirection {
  self.layoutDirection = self.mdf_effectiveUserInterfaceLayoutDirection;
}

- (void)createSubviews {
  self.maskedScrollViewContainerView = [[UIView alloc] init];
  [self addSubview:self.maskedScrollViewContainerView];

  self.scrollView = [[UIScrollView alloc] init];
  self.scrollView.bounces = NO;
  [self.maskedScrollViewContainerView addSubview:self.scrollView];

  self.scrollViewContentViewTouchForwardingView = [[UIView alloc] init];
  [self.scrollView addSubview:self.scrollViewContentViewTouchForwardingView];

  self.inputChipViewTextView = [[MDCBaseTextAreaTextView alloc] init];
  self.inputChipViewTextView.inputChipViewTextViewDelegate = self;
  [self.scrollView addSubview:self.inputChipViewTextView];

  self.label = [[UILabel alloc] init];
  [self addSubview:self.label];
}

- (void)setContainerStyle:(id<MDCContainedInputViewStyle>)containerStyle {
  id<MDCContainedInputViewStyle> oldStyle = _containerStyle;
  if (oldStyle) {
    [oldStyle removeStyleFrom:self];
  }
  _containerStyle = containerStyle;
  [self setUpStateDependentColorSchemesForStyle:_containerStyle];
  id<MDCContainedInputViewColorScheming> colorScheme =
      [self containedInputViewColorSchemingForState:self.containedInputViewState];
  [_containerStyle applyStyleToContainedInputView:self
              withContainedInputViewColorScheming:colorScheme];
}

- (void)setUpStateDependentColorSchemesForStyle:(id<MDCContainedInputViewStyle>)containerStyle {
  id<MDCContainedInputViewColorScheming> normalColorScheme =
      [containerStyle defaultColorSchemeForState:MDCContainedInputViewStateNormal];
  [self setContainedInputViewColorScheming:normalColorScheme
                                  forState:MDCContainedInputViewStateNormal];

  id<MDCContainedInputViewColorScheming> focusedColorScheme =
      [containerStyle defaultColorSchemeForState:MDCContainedInputViewStateFocused];
  [self setContainedInputViewColorScheming:focusedColorScheme
                                  forState:MDCContainedInputViewStateFocused];

  id<MDCContainedInputViewColorScheming> disabledColorScheme =
      [containerStyle defaultColorSchemeForState:MDCContainedInputViewStateDisabled];
  [self setContainedInputViewColorScheming:disabledColorScheme
                                  forState:MDCContainedInputViewStateDisabled];
}

- (void)setUpAssistiveLabels {
  //  CGFloat underlineFontSize = MDCRound([UIFont systemFontSize] * 0.75);
  //  UIFont *underlineFont = [UIFont systemFontOfSize:underlineFontSize];
  //  self.leftAssistiveLabel = [[UILabel alloc] init];
  //  self.leftAssistiveLabel.font = underlineFont;
  //  self.rightAssistiveLabel = [[UILabel alloc] init];
  //  self.rightAssistiveLabel.font = underlineFont;
  //  [self addSubview:self.leftAssistiveLabel];
  //  [self addSubview:self.rightAssistiveLabel];
}

- (void)setUpClearButton {
  // TODO: Use CIV clear button
}

- (void)setUpGradientLayers {
  UIColor *outer = (id)UIColor.clearColor.CGColor;
  UIColor *inner = (id)UIColor.blackColor.CGColor;
  NSArray *colors = @[ outer, outer, inner, inner, outer, outer ];
  self.horizontalGradient = [CAGradientLayer layer];
  self.horizontalGradient.frame = self.bounds;
  self.horizontalGradient.colors = colors;
  self.horizontalGradient.startPoint = CGPointMake(0.0, 0.5);
  self.horizontalGradient.endPoint = CGPointMake(1.0, 0.5);

  self.verticalGradient = [CAGradientLayer layer];
  self.verticalGradient.frame = self.bounds;
  self.verticalGradient.colors = colors;
  self.verticalGradient.startPoint = CGPointMake(0.5, 0.0);
  self.verticalGradient.endPoint = CGPointMake(0.5, 1.0);
}

#pragma mark UIResponder Overrides

- (BOOL)resignFirstResponder {
  BOOL textFieldDidResign = [self.textView resignFirstResponder];
  return textFieldDidResign;
}

- (BOOL)becomeFirstResponder {
  BOOL textFieldDidBecome = [self.textView becomeFirstResponder];
  return textFieldDidBecome;
}

- (void)handleResponderChange {
  [self setNeedsLayout];
}

- (BOOL)isFirstResponder {
  return self.textView.isFirstResponder;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];
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
  return [self preferredSizeWithWidth:CGRectGetWidth(self.bounds)];
}

- (CGSize)preferredSizeWithWidth:(CGFloat)width {
  CGSize fittingSize = CGSizeMake(width, CGFLOAT_MAX);
  MDCBaseTextAreaLayout *layout = [self calculateLayoutWithSize:fittingSize];
  return CGSizeMake(width, layout.calculatedHeight);
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];
  [self setUpLayoutDirection];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  UIView *result = [super hitTest:point withEvent:event];
  if (result == self.scrollViewContentViewTouchForwardingView) {
    return self;
  }
  return result;
}

#pragma mark UIControl Overrides

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
  BOOL result = [super beginTrackingWithTouch:touch withEvent:event];
  self.lastTouchInitialContentOffset = self.scrollView.contentOffset;
  self.lastTouchInitialLocation = [touch locationInView:self];
  //  NSLog(@"begin tracking: %@, radius: %@, pointInside: %@",@(result), @(touch.majorRadius),
  //  NSStringFromCGPoint([touch locationInView:self]));
  return result;
}

- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
  BOOL result = [super continueTrackingWithTouch:touch withEvent:event];

  CGPoint location = [touch locationInView:self];
  CGPoint offsetFromStart = [self offsetOfPoint:location fromPoint:self.lastTouchInitialLocation];
  //  NSLog(@"offset from start: %@",NSStringFromCGPoint(offsetFromStart));

  CGPoint offset = self.lastTouchInitialContentOffset;
  //  if (self.chipsWrap) {
  CGFloat height = CGRectGetHeight(self.frame);
  offset.y -= offsetFromStart.y;
  if (offset.y < 0) {
    offset.y = 0;
  }
  if (offset.y + height > self.scrollView.contentSize.height) {
    offset.y = self.scrollView.contentSize.height - height;
  }
  self.scrollView.contentOffset = offset;
  //  } else {
  //    CGFloat width = CGRectGetWidth(self.frame);
  //    offset.x -= offsetFromStart.x;
  //    if (offset.x < 0) {
  //      offset.x = 0;
  //    }
  //    if (offset.x + width > self.scrollView.contentSize.width) {
  //      offset.x = self.scrollView.contentSize.width - width;
  //    }
  //  }
  self.scrollView.contentOffset = offset;

  return result;
}

- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
  [super endTrackingWithTouch:touch withEvent:event];

  CGPoint location = [touch locationInView:self];
  CGPoint offset = [self offsetOfPoint:location fromPoint:self.lastTouchInitialLocation];
  CGPoint absoluteOffset = [self absoluteOffsetOfOffset:offset];
  BOOL isProbablyTap = absoluteOffset.x < 15 && absoluteOffset.y < 15;
  if (isProbablyTap) {
    if (!self.isFirstResponder) {
      [self becomeFirstResponder];
    }
    [self enforceCalculatedScrollViewContentOffset];
    //    NSLog(@"ended a tap!");
  } else {
    //    NSLog(@"ended a scroll at %@",NSStringFromCGPoint(self.scrollView.contentOffset));
  }
  //  NSLog(@"end tracking, radius: %@, pointInside: %@", @(touch.majorRadius),
  //  NSStringFromCGPoint([touch locationInView:self]));
}

- (void)cancelTrackingWithEvent:(UIEvent *)event {
  [super cancelTrackingWithEvent:event];
}

#pragma mark Layout

- (MDCBaseTextAreaLayout *)calculateLayoutWithSize:(CGSize)size {
  return [[MDCBaseTextAreaLayout alloc] initWithSize:size
                                      containerStyle:self.containerStyle
                                                text:self.inputChipViewTextView.text
                                                font:self.normalFont
                                        floatingFont:self.floatingFont
                                               label:self.label
                                          labelState:self.labelState
                                       labelBehavior:self.labelBehavior
                                  leftAssistiveLabel:self.leftAssistiveLabel
                                 rightAssistiveLabel:self.rightAssistiveLabel
                          underlineLabelDrawPriority:self.underlineLabelDrawPriority
                    customAssistiveLabelDrawPriority:self.customAssistiveLabelDrawPriority
                            preferredContainerHeight:self.preferredContainerHeight
                        preferredNumberOfVisibleRows:self.preferredNumberOfVisibleRows
                                               isRTL:self.isRTL
                                           isEditing:self.isFirstResponder];
}

- (void)preLayoutSubviews {
  self.containedInputViewState = [self determineCurrentContainedInputViewState];
  self.labelState = [self determineCurrentLabelState];
  id<MDCContainedInputViewColorScheming> colorScheming =
      [self containedInputViewColorSchemingForState:self.containedInputViewState];
  [self applyMDCContainedInputViewColorScheming:colorScheming];
  self.layout = [self calculateLayoutWithSize:self.bounds.size];
}

- (MDCContainedInputViewState)determineCurrentContainedInputViewState {
  return [self
      containedInputViewStateWithIsEnabled:(self.enabled && self.inputChipViewTextView.isEditable)
                                 isEditing:self.isFirstResponder];
}

- (MDCContainedInputViewState)containedInputViewStateWithIsEnabled:(BOOL)isEnabled
                                                         isEditing:(BOOL)isEditing {
  if (isEnabled) {
    if (isEditing) {
      return MDCContainedInputViewStateFocused;
    } else {
      return MDCContainedInputViewStateNormal;
    }
  } else {
    return MDCContainedInputViewStateDisabled;
  }
}

- (void)postLayoutSubviews {
  [self.labelAnimator layOutLabel:self.label
                            state:self.labelState
                 normalLabelFrame:self.layout.normalLabelFrame
               floatingLabelFrame:self.layout.floatingLabelFrame
                       normalFont:self.normalFont
                     floatingFont:self.floatingFont];
  id<MDCContainedInputViewColorScheming> colorScheming =
      [self containedInputViewColorSchemingForState:self.containedInputViewState];
  [self.containerStyle applyStyleToContainedInputView:self
                  withContainedInputViewColorScheming:colorScheming];

  //  self.clearButton.frame = [self clearButtonFrameFromLayout:self.layout
  //                                           labelState:self.labelState];
  //  self.clearButton.hidden = self.layout.clearButtonHidden;
  //  self.leftAssistiveLabel.frame = self.layout.leftAssistiveLabelFrame;
  //  self.rightAssistiveLabel.frame = self.layout.rightAssistiveLabelFrame;

  self.maskedScrollViewContainerView.frame = self.layout.maskedScrollViewContainerViewFrame;
  self.scrollView.frame = self.layout.scrollViewFrame;
  self.scrollViewContentViewTouchForwardingView.frame =
      self.layout.scrollViewContentViewTouchForwardingViewFrame;
  self.textView.frame = self.layout.textViewFrame;
  self.scrollView.contentOffset = self.layout.scrollViewContentOffset;
  self.scrollView.contentSize = self.layout.scrollViewContentSize;
  [self.scrollView setNeedsLayout];
  //  NSLog(@"inset: %@",NSStringFromUIEdgeInsets(self.scrollView.contentInset));
  //  NSLog(@"offset: %@",NSStringFromCGPoint(self.scrollView.contentOffset));
  //  NSLog(@"size: %@\n\n",NSStringFromCGSize(self.scrollView.contentSize));

  [self layOutGradientLayers];
}

- (CGRect)containerFrame {
  return CGRectMake(0, 0, CGRectGetWidth(self.frame), self.layout.contentAreaMaxY);
}

- (void)layOutGradientLayers {
  CGRect gradientLayerFrame = self.layout.maskedScrollViewContainerViewFrame;
  self.horizontalGradient.frame = gradientLayerFrame;
  self.verticalGradient.frame = gradientLayerFrame;
  self.horizontalGradient.locations = self.layout.horizontalGradientLocations;
  self.verticalGradient.locations = self.layout.verticalGradientLocations;
  CALayer *scrollViewBorderGradient = [self layerCombiningHorizontalGradient:self.horizontalGradient
                                                        withVerticalGradient:self.verticalGradient];
  self.maskedScrollViewContainerView.layer.mask = scrollViewBorderGradient;
}

- (CALayer *)layerCombiningHorizontalGradient:(CAGradientLayer *)horizontalGradient
                         withVerticalGradient:(CAGradientLayer *)verticalGradient {
  horizontalGradient.mask = verticalGradient;
  UIImage *image = [self createImageWithLayer:horizontalGradient];
  CALayer *layer = [self createLayerWithImage:image];
  return layer;
}

- (UIImage *)createImageWithLayer:(CALayer *)layer {
  UIGraphicsBeginImageContext(layer.frame.size);
  [layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

- (CALayer *)createLayerWithImage:(UIImage *)image {
  CALayer *layer = [[CALayer alloc] init];
  layer.frame = CGRectMake(0, 0, image.size.width, image.size.height);
  layer.contents = (__bridge id _Nullable)(image.CGImage);
  return layer;
}

#pragma mark Notification Listener Methods

- (void)textViewDidEndEditingWithNotification:(NSNotification *)notification {
  if (notification.object != self) {
    return;
  }
}

- (void)textViewDidChangeWithNotification:(NSNotification *)notification {
  if (notification.object != self.textView) {
    return;
  }
  //  NSLog(@"text did change");
  [self setNeedsLayout];
  // get size needed to display text.
  // size text field accordingly
  // alter text field frame and scroll view offset accordingly
}

- (void)textFieldDidBeginEditingWithNotification:(NSNotification *)notification {
  if (notification.object != self) {
    return;
  }
}

#pragma mark Label

- (BOOL)canLabelFloat {
  return self.labelBehavior == MDCTextControlLabelBehaviorFloats;
}

- (MDCContainedInputViewLabelState)determineCurrentLabelState {
  return [self labelStateWithLabelText:self.label.text
                                  text:self.textView.text
                         canLabelFloat:self.canLabelFloat
                             isEditing:self.isFirstResponder];
}

- (MDCContainedInputViewLabelState)labelStateWithLabelText:(NSString *)labelText
                                                      text:(NSString *)text
                                             canLabelFloat:(BOOL)canLabelFloat
                                                 isEditing:(BOOL)isEditing {
  BOOL hasLabelText = labelText.length > 0;
  BOOL hasText = text.length > 0;
  if (hasLabelText) {
    if (canLabelFloat) {
      if (isEditing) {
        return MDCContainedInputViewLabelStateFloating;
      } else {
        if (hasText) {
          return MDCContainedInputViewLabelStateFloating;
        } else {
          return MDCContainedInputViewLabelStateNormal;
        }
      }
    } else {
      if (hasText) {
        return MDCContainedInputViewLabelStateNone;
      } else {
        return MDCContainedInputViewLabelStateNormal;
      }
    }
  } else {
    return MDCContainedInputViewLabelStateNone;
  }
}

#pragma mark Accessors

- (UITextView *)textView {
  return self.inputChipViewTextView;
}

- (UILabel *)leadingAssistiveLabel {
  if ([self isRTL]) {
    return self.rightAssistiveLabel;
  } else {
    return self.leftAssistiveLabel;
  }
}

- (UILabel *)trailingAssistiveLabel {
  if ([self isRTL]) {
    return self.leftAssistiveLabel;
  } else {
    return self.rightAssistiveLabel;
  }
}

- (CGFloat)numberOfTextRows {
  return self.preferredNumberOfVisibleRows;
}

#pragma mark User Interaction

- (void)enforceCalculatedScrollViewContentOffset {
  [self.scrollView setContentOffset:self.layout.scrollViewContentOffset animated:NO];
}

#pragma mark Internationalization

- (BOOL)isRTL {
  return self.layoutDirection == UIUserInterfaceLayoutDirectionRightToLeft;
}

#pragma mark Fonts

- (UIFont *)normalFont {
  return self.inputChipViewTextView.effectiveFont;
}

- (UIFont *)floatingFont {
  return [self.containerStyle floatingFontWithFont:self.normalFont];
}

- (UIFont *)uiTextViewDefaultFont {
  static dispatch_once_t onceToken;
  static UIFont *font;
  dispatch_once(&onceToken, ^{
    font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
  });
  return font;
}

#pragma mark Custom UIView Geometry Methods

- (CGPoint)offsetOfPoint:(CGPoint)point1 fromPoint:(CGPoint)point2 {
  return CGPointMake(point1.x - point2.x, point1.y - point2.y);
}

- (CGPoint)absoluteOffsetOfOffset:(CGPoint)offset {
  if (offset.x < 0) {
    offset.x = offset.x * -1;
  }
  if (offset.y < 0) {
    offset.y = offset.y * -1;
  }
  return offset;
}

#pragma mark InputChipViewTextViewDelegate

- (void)inputChipViewTextViewDidResignFirstResponder:(BOOL)didBecome {
  [self handleResponderChange];
}

- (void)inputChipViewTextViewDidBecomeFirstResponder:(BOOL)didBecome {
  [self handleResponderChange];
}

#pragma mark Theming

- (void)applyMDCContainedInputViewColorScheming:
    (id<MDCContainedInputViewColorScheming>)colorScheming {
  self.textView.textColor = colorScheming.textColor;
  self.leadingAssistiveLabel.textColor = colorScheming.underlineLabelColor;
  self.trailingAssistiveLabel.textColor = colorScheming.underlineLabelColor;
  self.label.textColor = colorScheming.floatingLabelColor;
}

- (void)setContainedInputViewColorScheming:
            (id<MDCContainedInputViewColorScheming>)containedInputViewColorScheming
                                  forState:(MDCContainedInputViewState)containedInputViewState {
  self.colorSchemes[@(containedInputViewState)] = containedInputViewColorScheming;
}

- (id<MDCContainedInputViewColorScheming>)containedInputViewColorSchemingForState:
    (MDCContainedInputViewState)containedInputViewState {
  id<MDCContainedInputViewColorScheming> colorScheme =
      self.colorSchemes[@(containedInputViewState)];
  if (!colorScheme) {
    colorScheme = [self.containerStyle defaultColorSchemeForState:containedInputViewState];
  }
  return colorScheme;
}

@end
