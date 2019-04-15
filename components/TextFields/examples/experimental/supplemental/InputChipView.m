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

#import "InputChipView.h"
#import "InputChipViewLayout.h"

#import <CoreGraphics/CoreGraphics.h>
#import <MDFInternationalization/MDFInternationalization.h>
#import <QuartzCore/QuartzCore.h>

#import "MDCContainedInputView.h"

#import "MaterialMath.h"

@class InputChipViewTextField;
@protocol InputChipViewTextFieldDelegate <NSObject>
- (void)inputChipViewTextFieldDidDeleteBackward:(InputChipViewTextField *)textField
                                        oldText:(NSString *)oldText
                                        newText:(NSString *)newText;
- (void)inputChipViewTextFieldDidBecomeFirstResponder:(BOOL)didBecome;
- (void)inputChipViewTextFieldDidResignFirstResponder:(BOOL)didResign;
- (void)inputChipViewTextFieldDidSetPlaceholder:(NSString *)placeholder;
@end

@interface InputChipViewTextField : UITextField
@property(nonatomic, weak) id<InputChipViewTextFieldDelegate> inputChipViewTextFieldDelegate;
@property(strong, nonatomic, readonly) UIFont *effectiveFont;
@end

@implementation InputChipViewTextField

- (UIFont *)effectiveFont {
  return self.font ?: [UIFont systemFontOfSize:[UIFont systemFontSize]];
}

- (void)deleteBackward {
  NSString *oldText = self.text;
  [super deleteBackward];
  if ([self.inputChipViewTextFieldDelegate
          respondsToSelector:@selector(inputChipViewTextFieldDidDeleteBackward:oldText:newText:)]) {
    [self.inputChipViewTextFieldDelegate inputChipViewTextFieldDidDeleteBackward:self
                                                                         oldText:oldText
                                                                         newText:self.text];
  }
}

- (BOOL)resignFirstResponder {
  BOOL didResignFirstResponder = [super resignFirstResponder];
  [self.inputChipViewTextFieldDelegate
      inputChipViewTextFieldDidResignFirstResponder:didResignFirstResponder];
  return didResignFirstResponder;
}

- (BOOL)becomeFirstResponder {
  BOOL didBecomeFirstResponder = [super becomeFirstResponder];
  [self.inputChipViewTextFieldDelegate
      inputChipViewTextFieldDidBecomeFirstResponder:didBecomeFirstResponder];
  return didBecomeFirstResponder;
}

- (void)setPlaceholder:(NSString *)placeholder {
  [super setPlaceholder:placeholder];
  [self.inputChipViewTextFieldDelegate inputChipViewTextFieldDidSetPlaceholder:placeholder];
}

// we don't want to display the placeholder, we have a label that we create and manage to do that.
- (CGRect)placeholderRectForBounds:(CGRect)bounds {
  return CGRectZero;
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
  return CGRectZero;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
  return CGRectZero;
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
  return CGRectZero;
}

@end

static const CGFloat kChipAnimationDuration = (CGFloat)0.25;

@interface InputChipView () <InputChipViewTextFieldDelegate, UIGestureRecognizerDelegate>

#pragma mark MDCContainedInputView properties
@property(strong, nonatomic) UIButton *clearButton;
@property(strong, nonatomic) UIImageView *clearButtonImageView;
@property(strong, nonatomic) UILabel *floatingLabel;

@property(strong, nonatomic) UILabel *leftUnderlineLabel;
@property(strong, nonatomic) UILabel *rightUnderlineLabel;

@property(strong, nonatomic) UIView *maskedScrollViewContainerView;
@property(strong, nonatomic) UIScrollView *scrollView;
@property(strong, nonatomic) UIView *scrollViewContentViewTouchForwardingView;
@property(strong, nonatomic) InputChipViewTextField *inputChipViewTextField;

@property(strong, nonatomic) NSMutableArray *chips;
@property(strong, nonatomic) NSMutableArray *chipsToRemove;

@property(strong, nonatomic) InputChipViewLayout *layout;

@property(strong, nonatomic) UITouch *lastTouch;
@property(nonatomic, assign) CGPoint lastTouchInitialContentOffset;
@property(nonatomic, assign) CGPoint lastTouchInitialLocation;

@property(strong, nonatomic) CAGradientLayer *horizontalGradient;
@property(strong, nonatomic) CAGradientLayer *verticalGradient;

//@property(strong, nonatomic) UIButton *clearButton;
//@property(strong, nonatomic) UIImageView *clearButtonImageView;
//@property(strong, nonatomic) UILabel *floatingLabel;
//
//@property(strong, nonatomic) UILabel *leftUnderlineLabel;
//@property(strong, nonatomic) UILabel *rightUnderlineLabel;

@property(nonatomic, assign) UIUserInterfaceLayoutDirection layoutDirection;

@property(nonatomic, assign) MDCContainedInputViewState containedInputViewState;
@property(nonatomic, assign) MDCContainedInputViewFloatingLabelState floatingLabelState;

@property(nonatomic, strong)
    NSMutableDictionary<NSNumber *, id<MDCContainedInputViewColorScheming>> *colorSchemes;

@property(nonatomic, strong) MDCContainedInputViewFloatingLabelManager *floatingLabelManager;

@property(nonatomic, assign) BOOL isAnimating;

@end

@implementation InputChipView
@synthesize preferredMainContentAreaHeight = _preferredMainContentAreaHeight;
@synthesize preferredUnderlineLabelAreaHeight = _preferredUnderlineLabelAreaHeight;
@synthesize underlineLabelDrawPriority = _underlineLabelDrawPriority;
@synthesize customUnderlineLabelDrawPriority = _customUnderlineLabelDrawPriority;
@synthesize containerStyler = _containerStyler;
@synthesize isActivated = _isActivated;
@synthesize isErrored = _isErrored;
@synthesize canFloatingLabelFloat = _canFloatingLabelFloat;

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
  [self setUpChipRowHeight];
  [self setUpGradientLayers];
  [self setUpColorSchemesDictionary];
  [self setUpUnderlineLabels];
  [self setUpClearButton];
  [self setUpContainerStyler];
}

- (void)setUpColorSchemesDictionary {
  self.colorSchemes = [[NSMutableDictionary alloc] init];
}

- (void)setUpContainerStyler {
  self.containerStyler = [[MDCContainerStylerBase alloc] init];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark Setup

- (void)addObservers {
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(textFieldDidEndEditingWithNotification:)
             name:UITextFieldTextDidEndEditingNotification
           object:nil];
  [[NSNotificationCenter defaultCenter]
      addObserver:self
         selector:@selector(textFieldDidBeginEditingWithNotification:)
             name:UITextFieldTextDidBeginEditingNotification
           object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(textFieldDidChangeWithNotification:)
                                               name:UITextFieldTextDidChangeNotification
                                             object:nil];
}

- (void)initializeProperties {
  [self setUpLayoutDirection];
  [self setUpChipsArray];
  [self setUpChipsToRemoveArray];
  [self setUpPlaceholderManager];
}

- (void)setUpChipsArray {
  self.chips = [[NSMutableArray alloc] init];
}

- (void)setUpChipsToRemoveArray {
  self.chipsToRemove = [[NSMutableArray alloc] init];
}

- (void)setUpPlaceholderManager {
  self.floatingLabelManager = [[MDCContainedInputViewFloatingLabelManager alloc] init];
}

- (void)setUpLayoutDirection {
  self.layoutDirection = self.mdf_effectiveUserInterfaceLayoutDirection;
}

- (void)setUpChipRowHeight {
  CGFloat textHeight = (CGFloat)ceil((double)self.inputChipViewTextField.effectiveFont.lineHeight);
  self.chipRowHeight = textHeight * 2;

  self.chipRowSpacing = 7;
}

- (void)createSubviews {
  self.maskedScrollViewContainerView = [[UIView alloc] init];
  [self addSubview:self.maskedScrollViewContainerView];

  self.scrollView = [[UIScrollView alloc] init];
  self.scrollView.bounces = NO;
  [self.maskedScrollViewContainerView addSubview:self.scrollView];

  self.scrollViewContentViewTouchForwardingView = [[UIView alloc] init];
  [self.scrollView addSubview:self.scrollViewContentViewTouchForwardingView];

  self.inputChipViewTextField = [[InputChipViewTextField alloc] init];
  self.inputChipViewTextField.inputChipViewTextFieldDelegate = self;
  [self.scrollView addSubview:self.inputChipViewTextField];

  self.floatingLabel = [[UILabel alloc] init];
  [self addSubview:self.floatingLabel];
}

- (void)setContainerStyler:(id<MDCContainedInputViewStyler>)containerStyler {
  id<MDCContainedInputViewStyler> oldStyle = _containerStyler;
  if (oldStyle) {
    [oldStyle removeStyleFrom:self];
  }
  _containerStyler = containerStyler;
  [self setUpStateDependentColorSchemesForStyle:_containerStyler];
  id<MDCContainedInputViewColorScheming> colorScheme =
      [self containedInputViewColorSchemingForState:self.containedInputViewState];
  [_containerStyler applyStyleToContainedInputView:self
               withContainedInputViewColorScheming:colorScheme];
}

- (void)setUpStateDependentColorSchemesForStyle:(id<MDCContainedInputViewStyler>)containerStyler {
  id<MDCContainedInputViewColorScheming> normalColorScheme =
      [containerStyler defaultColorSchemeForState:MDCContainedInputViewStateNormal];
  [self setContainedInputViewColorScheming:normalColorScheme
                                  forState:MDCContainedInputViewStateNormal];

  id<MDCContainedInputViewColorScheming> focusedColorScheme =
      [containerStyler defaultColorSchemeForState:MDCContainedInputViewStateFocused];
  [self setContainedInputViewColorScheming:focusedColorScheme
                                  forState:MDCContainedInputViewStateFocused];

  id<MDCContainedInputViewColorScheming> activatedColorScheme =
      [containerStyler defaultColorSchemeForState:MDCContainedInputViewStateActivated];
  [self setContainedInputViewColorScheming:activatedColorScheme
                                  forState:MDCContainedInputViewStateActivated];

  id<MDCContainedInputViewColorScheming> erroredColorScheme =
      [containerStyler defaultColorSchemeForState:MDCContainedInputViewStateErrored];
  [self setContainedInputViewColorScheming:erroredColorScheme
                                  forState:MDCContainedInputViewStateErrored];

  id<MDCContainedInputViewColorScheming> disabledColorScheme =
      [containerStyler defaultColorSchemeForState:MDCContainedInputViewStateDisabled];
  [self setContainedInputViewColorScheming:disabledColorScheme
                                  forState:MDCContainedInputViewStateDisabled];
}

- (void)setUpUnderlineLabels {
  //  CGFloat underlineFontSize = MDCRound([UIFont systemFontSize] * 0.75);
  //  UIFont *underlineFont = [UIFont systemFontOfSize:underlineFontSize];
  //  self.leftUnderlineLabel = [[UILabel alloc] init];
  //  self.leftUnderlineLabel.font = underlineFont;
  //  self.rightUnderlineLabel = [[UILabel alloc] init];
  //  self.rightUnderlineLabel.font = underlineFont;
  //  [self addSubview:self.leftUnderlineLabel];
  //  [self addSubview:self.rightUnderlineLabel];
}

- (void)setUpClearButton {
  //  CGFloat clearButtonSideLength = MDCInputTextFieldLayout.clearButtonSideLength;
  //  CGRect clearButtonFrame = CGRectMake(0, 0, clearButtonSideLength, clearButtonSideLength);
  //  self.clearButton = [[UIButton alloc] initWithFrame:clearButtonFrame];
  //  [self.clearButton addTarget:self
  //                       action:@selector(clearButtonPressed:)
  //             forControlEvents:UIControlEventTouchUpInside];
  //
  //  CGFloat clearButtonImageViewSideLength =
  //  MDCInputTextFieldLayout.clearButtonImageViewSideLength; CGRect clearButtonImageViewRect =
  //  CGRectMake(0, 0, clearButtonImageViewSideLength, clearButtonImageViewSideLength);
  //  self.clearButtonImageView = [[UIImageView alloc] initWithFrame:clearButtonImageViewRect];
  //  UIImage *clearButtonImage =
  //  [[self untintedClearButtonImage] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  //  self.clearButtonImageView.image = clearButtonImage;
  //  [self.clearButton addSubview:self.clearButtonImageView];
  //  [self addSubview:self.clearButton];
  //  self.clearButtonImageView.center = self.clearButton.center;
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
  BOOL textFieldDidResign = [self.textField resignFirstResponder];
  return textFieldDidResign;
}

- (BOOL)becomeFirstResponder {
  BOOL textFieldDidBecome = [self.textField becomeFirstResponder];
  return textFieldDidBecome;
}

- (void)handleResponderChange {
  [self setNeedsLayout];
}

- (BOOL)isFirstResponder {
  return self.textField.isFirstResponder;
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
  InputChipViewLayout *layout = [self calculateLayoutWithSize:fittingSize];
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
  if (self.chipsWrap) {
    CGFloat height = CGRectGetHeight(self.frame);
    offset.y -= offsetFromStart.y;
    if (offset.y < 0) {
      offset.y = 0;
    }
    if (offset.y + height > self.scrollView.contentSize.height) {
      offset.y = self.scrollView.contentSize.height - height;
    }
    self.scrollView.contentOffset = offset;
  } else {
    CGFloat width = CGRectGetWidth(self.frame);
    offset.x -= offsetFromStart.x;
    if (offset.x < 0) {
      offset.x = 0;
    }
    if (offset.x + width > self.scrollView.contentSize.width) {
      offset.x = self.scrollView.contentSize.width - width;
    }
  }
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

- (InputChipViewLayout *)calculateLayoutWithSize:(CGSize)size {
  UIFont *normalFont = self.inputChipViewTextField.effectiveFont;
  UIFont *floatingFont = [self.floatingLabelManager floatingFontWithFont:normalFont
                                                         containerStyler:self.containerStyler];
  return [[InputChipViewLayout alloc] initWithSize:size
                                   containerStyler:self.containerStyler
                                              text:self.inputChipViewTextField.text
                                       placeholder:self.inputChipViewTextField.placeholder
                                              font:self.inputChipViewTextField.effectiveFont
                                      floatingFont:floatingFont
                                floatingLabelState:self.floatingLabelState
                                             chips:self.chips
                                    staleChipViews:self.chips
                                         chipsWrap:self.chipsWrap
                                     chipRowHeight:self.chipRowHeight
                                  interChipSpacing:self.chipRowSpacing
                                       clearButton:self.clearButton
                               clearButtonViewMode:self.textField.clearButtonMode
                                leftUnderlineLabel:self.leftUnderlineLabel
                               rightUnderlineLabel:self.rightUnderlineLabel
                        underlineLabelDrawPriority:self.underlineLabelDrawPriority
                  customUnderlineLabelDrawPriority:self.customUnderlineLabelDrawPriority
                    preferredMainContentAreaHeight:self.preferredMainContentAreaHeight
                 preferredUnderlineLabelAreaHeight:self.preferredUnderlineLabelAreaHeight
                                             isRTL:self.isRTL
                                         isEditing:self.inputChipViewTextField.isEditing];
}

- (void)preLayoutSubviews {
  self.containedInputViewState = [self determineCurrentContainedInputViewState];
  self.floatingLabelState = [self determineCurrentFloatingLabelState];
  id<MDCContainedInputViewColorScheming> colorScheming =
      [self containedInputViewColorSchemingForState:self.containedInputViewState];
  [self applyMDCContainedInputViewColorScheming:colorScheming];
  self.layout = [self calculateLayoutWithSize:self.bounds.size];
}

- (MDCContainedInputViewState)determineCurrentContainedInputViewState {
  return [self
      containedInputViewStateWithIsEnabled:(self.enabled && self.inputChipViewTextField.enabled)
                                 isErrored:self.isErrored
                                 isEditing:self.inputChipViewTextField.isEditing
                                isSelected:self.isSelected
                               isActivated:self.isActivated];
}

- (MDCContainedInputViewState)containedInputViewStateWithIsEnabled:(BOOL)isEnabled
                                                         isErrored:(BOOL)isErrored
                                                         isEditing:(BOOL)isEditing
                                                        isSelected:(BOOL)isSelected
                                                       isActivated:(BOOL)isActivated {
  if (isEnabled) {
    if (isErrored) {
      return MDCContainedInputViewStateErrored;
    } else {
      if (isEditing) {
        return MDCContainedInputViewStateFocused;
      } else {
        if (isSelected || isActivated) {
          return MDCContainedInputViewStateActivated;
        } else {
          return MDCContainedInputViewStateNormal;
        }
      }
    }
  } else {
    return MDCContainedInputViewStateDisabled;
  }
}

- (void)postLayoutSubviews {
  UIFont *normalFont = self.inputChipViewTextField.effectiveFont;
  UIFont *floatingFont = [self.floatingLabelManager floatingFontWithFont:normalFont
                                                         containerStyler:self.containerStyler];
  [self.floatingLabelManager layOutFloatingLabel:self.floatingLabel
                                           state:self.floatingLabelState
                                     normalFrame:self.layout.floatingLabelFrameNormal
                                   floatingFrame:self.layout.floatingLabelFrameFloating
                                      normalFont:normalFont
                                    floatingFont:floatingFont];
  id<MDCContainedInputViewColorScheming> colorScheming =
      [self containedInputViewColorSchemingForState:self.containedInputViewState];
  [self.containerStyler applyStyleToContainedInputView:self
                   withContainedInputViewColorScheming:colorScheming];

  //  self.clearButton.frame = [self clearButtonFrameFromLayout:self.layout
  //                                           floatingLabelState:self.floatingLabelState];
  //  self.clearButton.hidden = self.layout.clearButtonHidden;
  //  self.leftUnderlineLabel.frame = self.layout.leftUnderlineLabelFrame;
  //  self.rightUnderlineLabel.frame = self.layout.rightUnderlineLabelFrame;

  self.maskedScrollViewContainerView.frame = self.layout.maskedScrollViewContainerViewFrame;
  self.scrollView.frame = self.layout.scrollViewFrame;
  self.scrollViewContentViewTouchForwardingView.frame =
      self.layout.scrollViewContentViewTouchForwardingViewFrame;
  self.textField.frame = self.layout.textFieldFrame;
  self.scrollView.contentOffset = self.layout.scrollViewContentOffset;
  self.scrollView.contentSize = self.layout.scrollViewContentSize;
  [self animateChipLayoutChangesWithChips:self.chips
                               chipFrames:self.layout.chipFrames
                            chipsToRemove:self.chipsToRemove
                               chipsToAdd:self.chipsToAdd];
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
  CGFloat viewWidth = CGRectGetWidth(gradientLayerFrame);
  CGFloat viewHeight = CGRectGetHeight(gradientLayerFrame);

  CGFloat magicNumber = 6;

  CGFloat leftFadeStart = (self.layout.globalChipRowMinX - magicNumber) / viewWidth;
  if (leftFadeStart < 0) {
    leftFadeStart = 0;
  }
  CGFloat leftFadeEnd = self.layout.globalChipRowMinX / viewWidth;
  if (leftFadeEnd < 0) {
    leftFadeEnd = 0;
  }
  CGFloat rightFadeStart = (self.layout.globalChipRowMaxX) / viewWidth;
  if (rightFadeStart >= 1) {
    rightFadeStart = 1;
  }
  CGFloat rightFadeEnd = (self.layout.globalChipRowMaxX + magicNumber) / viewWidth;
  if (rightFadeEnd >= 1) {
    rightFadeEnd = 1;
  }

  self.horizontalGradient.locations = @[
    @(0),
    @(leftFadeStart),
    @(leftFadeEnd),
    @(rightFadeStart),
    @(rightFadeEnd),
    @(1),
  ];

  CGFloat floatingLabelMaxY = CGRectGetMaxY(self.floatingLabel.frame);
  CGFloat topSpacing = [self.containerStyler.positioningDelegate
      contentAreaTopPaddingFloatingLabelWithFloatingLabelMaxY:floatingLabelMaxY];
  CGFloat topFadeStart = (floatingLabelMaxY + ((CGFloat)0.0 * topSpacing)) / viewHeight;
  if (topFadeStart <= 0) {
    topFadeStart = 0;
  }
  CGFloat topFadeEnd = (floatingLabelMaxY + magicNumber) / viewHeight;
  if (topFadeEnd <= 0) {
    topFadeEnd = 0;
  }
  CGFloat bottomSpacing = [self.containerStyler.positioningDelegate
      contentAreaVerticalPaddingNormalWithFloatingLabelMaxY:floatingLabelMaxY];
  CGFloat bottomFadeStart = (viewHeight - bottomSpacing) / viewHeight;
  if (bottomFadeStart >= 1) {
    bottomFadeStart = 1;
  }
  CGFloat bottomFadeEnd = (viewHeight - magicNumber) / viewHeight;
  if (bottomFadeEnd >= 1) {
    bottomFadeEnd = 1;
  }

  self.verticalGradient.locations = @[
    @(0),
    @(topFadeStart),
    @(topFadeEnd),
    @(bottomFadeStart),
    @(bottomFadeEnd),
    @(1),
  ];

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

- (NSArray<MDCChipView *> *)chipsToAdd {
  NSMutableArray *chips = [[NSMutableArray alloc] init];
  for (MDCChipView *chip in self.chips) {
    if (!chip.superview) {
      [chips addObject:chip];
    }
  }
  return [chips copy];
}

- (void)animateChipLayoutChangesWithChips:(NSArray<MDCChipView *> *)chips
                               chipFrames:(NSArray<NSValue *> *)frames
                            chipsToRemove:(NSArray<MDCChipView *> *)chipsToRemove
                               chipsToAdd:(NSArray<MDCChipView *> *)chipsToAdd {
  // iterate through views, calculate a frame and an isHidden value for each.
  // If the chip is going to be removed don't change the frame.
  // go through and animate each views new status

  [self performChipRemovalOnCompletion:^{
    [self performChipPositioningOnCompletion:^{
      [self performChipAdditionsOnCompletion:^{
      }];
    }];
  }];
}

- (void)performChipRemovalOnCompletion:(void (^)(void))completion {
  if (self.chipsToRemove.count > 0) {
    [UIView animateWithDuration:0  // kChipAnimationDuration
        animations:^{
          for (MDCChipView *chip in self.chipsToRemove) {
            chip.alpha = 0;
          }
        }
        completion:^(BOOL finished) {
          for (MDCChipView *chip in self.chipsToRemove) {
            [chip removeFromSuperview];
          }
          [self.chipsToRemove removeAllObjects];
          if (completion) {
            completion();
          }
        }];
  } else if (completion) {
    completion();
  }
}

- (void)performChipPositioningOnCompletion:(void (^)(void))completion {
  [UIView animateWithDuration:kChipAnimationDuration
      animations:^{
        for (NSUInteger idx = 0; idx < self.chips.count; idx++) {
          MDCChipView *chip = self.chips[idx];
          CGRect frame = CGRectZero;
          if (self.layout.chipFrames.count > idx) {
            frame = [self.layout.chipFrames[idx] CGRectValue];
          }
          chip.frame = frame;
        }
      }
      completion:^(BOOL finished) {
        if (completion) {
          completion();
        }
      }];
}

- (void)performChipAdditionsOnCompletion:(void (^)(void))completion {
  NSArray<MDCChipView *> *chipsToAdd = self.chipsToAdd;
  for (MDCChipView *chip in chipsToAdd) {
    [self.scrollView addSubview:chip];
    chip.alpha = 0;
  }
  if (chipsToAdd.count > 0) {
    [UIView animateWithDuration:0  // kChipAnimationDuration
        animations:^{
          for (MDCChipView *chip in chipsToAdd) {
            chip.alpha = 1;
          }
        }
        completion:^(BOOL finished) {
          if (completion) {
            completion();
          }
        }];
  } else if (completion) {
    completion();
  }
}

#pragma mark Chip Selecting

- (void)selectChip:(MDCChipView *)chip {
  chip.selected = YES;
  UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification,
                                  [chip accessibilityLabel]);
}

#pragma mark Chip Adding

- (void)addChip:(MDCChipView *)chipView {
  [self.chips addObject:chipView];
  self.textField.text = nil;
  [self setNeedsLayout];
}

- (void)removeChips:(NSArray<MDCChipView *> *)chips {
  [self.chipsToRemove addObjectsFromArray:chips];
  [self.chips removeObjectsInArray:chips];
  [self setNeedsLayout];
}

- (NSArray<MDCChipView *> *)selectedChips {
  NSMutableArray *selectedChips = [NSMutableArray new];
  for (MDCChipView *chip in self.chips) {
    if (chip.isSelected) {
      [selectedChips addObject:chip];
    }
  }
  return [selectedChips copy];
}

#pragma mark Notification Listener Methods

- (void)textFieldDidEndEditingWithNotification:(NSNotification *)notification {
  if (notification.object != self) {
    return;
  }
}

- (void)textFieldDidChangeWithNotification:(NSNotification *)notification {
  if (notification.object != self.textField) {
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

#pragma mark Placeholder

- (MDCContainedInputViewFloatingLabelState)determineCurrentFloatingLabelState {
  return [self floatingLabelStateWithPlaceholder:self.textField.placeholder
                                            text:self.textField.text
                           canFloatingLabelFloat:self.canFloatingLabelFloat
                                       isEditing:self.textField.isEditing
                                           chips:self.chips];
}

- (MDCContainedInputViewFloatingLabelState)
    floatingLabelStateWithPlaceholder:(NSString *)placeholder
                                 text:(NSString *)text
                canFloatingLabelFloat:(BOOL)canFloatingLabelFloat
                            isEditing:(BOOL)isEditing
                                chips:(NSArray<UIView *> *)chips {
  BOOL hasPlaceholder = placeholder.length > 0;
  BOOL hasText = text.length > 0;
  BOOL hasChips = chips.count > 0;
  if (hasPlaceholder) {
    if (canFloatingLabelFloat) {
      if (isEditing) {
        return MDCContainedInputViewFloatingLabelStateFloating;
      } else {
        if (hasText || hasChips) {
          return MDCContainedInputViewFloatingLabelStateFloating;
        } else {
          return MDCContainedInputViewFloatingLabelStateNormal;
        }
      }
    } else {
      if (hasText || hasChips) {
        return MDCContainedInputViewFloatingLabelStateNone;
      } else {
        return MDCContainedInputViewFloatingLabelStateNormal;
      }
    }
  } else {
    return MDCContainedInputViewFloatingLabelStateNone;
  }
}

#pragma mark Accessors

- (UITextField *)textField {
  return self.inputChipViewTextField;
}

- (UILabel *)leadingUnderlineLabel {
  if ([self isRTL]) {
    return self.rightUnderlineLabel;
  } else {
    return self.leftUnderlineLabel;
  }
}

- (UILabel *)trailingUnderlineLabel {
  if ([self isRTL]) {
    return self.leftUnderlineLabel;
  } else {
    return self.rightUnderlineLabel;
  }
}

- (void)setIsErrored:(BOOL)isErrored {
  if (_isErrored == isErrored) {
    return;
  }
  _isErrored = isErrored;
  [self setNeedsLayout];
}

- (void)setIsActivated:(BOOL)isActivated {
  if (_isActivated == isActivated) {
    return;
  }
  _isActivated = isActivated;
  [self setNeedsLayout];
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

- (UIFont *)uiTextFieldDefaultFont {
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

#pragma mark InputChipViewTextFieldDelegate

- (void)inputChipViewTextFieldDidDeleteBackward:(InputChipViewTextField *)textField
                                        oldText:(NSString *)oldText
                                        newText:(NSString *)newText {
  BOOL isEmpty = newText.length == 0;
  BOOL isNewlyEmpty = oldText.length > 0 && newText.length == 0;
  if (isEmpty) {
    if (!isNewlyEmpty) {
      NSArray *selectedChips = [self selectedChips];
      if (selectedChips.count > 0) {
        [self removeChips:selectedChips];
      } else if (self.chips.count > 0) {
        [self selectChip:self.chips.lastObject];
      }
    }
  }
}

- (void)inputChipViewTextFieldDidResignFirstResponder:(BOOL)didBecome {
  [self handleResponderChange];
}

- (void)inputChipViewTextFieldDidBecomeFirstResponder:(BOOL)didBecome {
  [self handleResponderChange];
}

- (void)inputChipViewTextFieldDidSetPlaceholder:(NSString *)placeholder {
  self.floatingLabel.text = placeholder;
  [self setNeedsLayout];
}

#pragma mark Theming

- (void)applyMDCContainedInputViewColorScheming:
    (id<MDCContainedInputViewColorScheming>)colorScheming {
  self.textField.textColor = colorScheming.textColor;
  self.leadingUnderlineLabel.textColor = colorScheming.underlineLabelColor;
  self.trailingUnderlineLabel.textColor = colorScheming.underlineLabelColor;
  self.floatingLabel.textColor = colorScheming.floatingLabelColor;
  self.clearButtonImageView.tintColor = colorScheming.clearButtonTintColor;
}

- (void)setContainedInputViewColorScheming:
            (id<MDCContainedInputViewColorScheming>)simpleTextFieldColorScheming
                                  forState:(MDCContainedInputViewState)containedInputViewState {
  self.colorSchemes[@(containedInputViewState)] = simpleTextFieldColorScheming;
}

- (id<MDCContainedInputViewColorScheming>)containedInputViewColorSchemingForState:
    (MDCContainedInputViewState)containedInputViewState {
  id<MDCContainedInputViewColorScheming> colorScheme =
      self.colorSchemes[@(containedInputViewState)];
  if (!colorScheme) {
    colorScheme = [self.containerStyler defaultColorSchemeForState:containedInputViewState];
  }
  return colorScheme;
}

@end
