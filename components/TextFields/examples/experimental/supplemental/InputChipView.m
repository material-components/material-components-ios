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

#import <MDFInternationalization/MDFInternationalization.h>
#import <CoreGraphics/CoreGraphics.h>

#import "InputChipViewColorSchemeAdapter.h"

#import "MDCContainedInputView.h"

#import "MaterialMath.h"


@class InputChipViewTextField;
@protocol InputChipViewTextFieldDelegate <NSObject>
- (void)inputChipViewTextFieldDidDeleteBackward:(InputChipViewTextField *)textField
                                        oldText:(NSString *)oldText
                                        newText:(NSString *)newText;
@end


@interface InputChipViewTextField : UITextField
@property (nonatomic, weak) id<InputChipViewTextFieldDelegate> inputChipViewTextFieldDelegate;
@end

@implementation InputChipViewTextField

- (void)deleteBackward {
  NSString *oldText = self.text;
  [super deleteBackward];
  if ([self.inputChipViewTextFieldDelegate respondsToSelector:@selector(inputChipViewTextFieldDidDeleteBackward:oldText:newText:)]) {
    [self.inputChipViewTextFieldDelegate inputChipViewTextFieldDidDeleteBackward:self
                                                                         oldText:oldText
                                                                         newText:self.text];
  }
}

@end

static const CGFloat kChipAnimationDuration = (CGFloat)0.25;

@interface InputChipView () <InputChipViewTextFieldDelegate, UIGestureRecognizerDelegate>


#pragma mark MDCContainedInputView properties
@property(strong, nonatomic) UIButton *clearButton;
@property(strong, nonatomic) UIImageView *clearButtonImageView;
@property(strong, nonatomic) UILabel *placeholderLabel;

@property(strong, nonatomic) UILabel *leftUnderlineLabel;
@property(strong, nonatomic) UILabel *rightUnderlineLabel;



@property (strong, nonatomic) UIView *maskedScrollViewContainerView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *scrollViewContentViewTouchForwardingView;
@property (strong, nonatomic) InputChipViewTextField *inputChipViewTextField;

@property (strong, nonatomic) NSMutableArray *chips;
@property (strong, nonatomic) NSMutableArray *chipsToRemove;

@property (strong, nonatomic) InputChipViewLayout *layout;

@property (strong, nonatomic) UITouch *lastTouch;
@property (nonatomic, assign) CGPoint lastTouchInitialContentOffset;
@property (nonatomic, assign) CGPoint lastTouchInitialLocation;

@property (strong, nonatomic) InputChipViewColorSchemeAdapter *colorSchemeAdapter;

@property (strong, nonatomic) CALayer *horizontalGradientLayer;
@property (strong, nonatomic) CAGradientLayer *horizontalGradientLayerMask;
@property (strong, nonatomic) CALayer *verticalGradientLayer;
@property (strong, nonatomic) CAGradientLayer *verticalGradientLayerMask;


//@property(strong, nonatomic) UIButton *clearButton;
//@property(strong, nonatomic) UIImageView *clearButtonImageView;
//@property(strong, nonatomic) UILabel *placeholderLabel;
//
//@property(strong, nonatomic) UILabel *leftUnderlineLabel;
//@property(strong, nonatomic) UILabel *rightUnderlineLabel;

@property(nonatomic, assign) UIUserInterfaceLayoutDirection layoutDirection;

@property(nonatomic, assign) MDCContainedInputViewState containedInputViewState;
@property(nonatomic, assign) MDCContainedInputViewPlaceholderState placeholderState;

@property(nonatomic, strong)
NSMutableDictionary<NSNumber *, id<MDCContainedInputViewColorScheming>> *colorSchemes;

@property(nonatomic, assign) BOOL isAnimating;

@end

@implementation InputChipView

//@synthesize containedInputViewState = _containedInputViewState;

@synthesize underlineLabelDrawPriority = _underlineLabelDrawPriority;
@synthesize customUnderlineLabelDrawPriority = _customUnderlineLabelDrawPriority;
@synthesize containerStyle = _containerStyle;
@synthesize isActivated = _isActivated;
@synthesize isErrored = _isErrored;
@synthesize canPlaceholderFloat = _canPlaceholderFloat;


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
  
  [self setUpPlaceholderLabel];
  [self setUpUnderlineLabels];
  [self setUpClearButton];
  [self setUpContainerStyle];
  
}

- (void)setUpContainerStyle {
  self.containerStyle = [[MDCContainerStyleBase alloc] init];
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
  [[NSNotificationCenter defaultCenter]
   addObserver:self
   selector:@selector(textFieldDidChangeWithNotification:)
   name:UITextFieldTextDidChangeNotification
   object:nil];
}

- (void)initializeProperties {
  [self setUpLayoutDirection];
  [self setUpChipsArray];
  [self setUpChipsToRemoveArray];
  [self setUpContentInsets];
  
  self.chipRowHeight = [self determineEffectiveTextViewFont].lineHeight * 2;
}

- (void)setUpContentInsets {
  self.contentInsets = UIEdgeInsetsMake(8, 12, 8, 12);
}

- (void)setUpChipsArray {
  self.chips = [[NSMutableArray alloc] init];
}

- (void)setUpChipsToRemoveArray {
  self.chipsToRemove = [[NSMutableArray alloc] init];
}

- (void)setUpLayoutDirection {
  self.layoutDirection = self.mdf_effectiveUserInterfaceLayoutDirection;
}

- (void)createSubviews {
  self.maskedScrollViewContainerView = [[UIView  alloc] init];
  [self addSubview:self.maskedScrollViewContainerView];
  self.scrollView = [[UIScrollView alloc] init];
  self.scrollView.bounces = NO;
  [self.maskedScrollViewContainerView addSubview:self.scrollView];
  self.scrollViewContentViewTouchForwardingView = [[UIView alloc] init];
  [self.scrollView addSubview:self.scrollViewContentViewTouchForwardingView];
  self.inputChipViewTextField = [[InputChipViewTextField alloc] init];
  self.inputChipViewTextField.inputChipViewTextFieldDelegate = self;
  [self.scrollView addSubview:self.textField];
}

-(void)setContainerStyle:(id<MDCContainedInputViewStyle>)containerStyle {
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
  
  id<MDCContainedInputViewColorScheming> activatedColorScheme =
  [containerStyle defaultColorSchemeForState:MDCContainedInputViewStateActivated];
  [self setContainedInputViewColorScheming:activatedColorScheme
                                  forState:MDCContainedInputViewStateActivated];
  
  id<MDCContainedInputViewColorScheming> erroredColorScheme =
  [containerStyle defaultColorSchemeForState:MDCContainedInputViewStateErrored];
  [self setContainedInputViewColorScheming:erroredColorScheme
                                  forState:MDCContainedInputViewStateErrored];
  
  id<MDCContainedInputViewColorScheming> disabledColorScheme =
  [containerStyle defaultColorSchemeForState:MDCContainedInputViewStateDisabled];
  [self setContainedInputViewColorScheming:disabledColorScheme
                                  forState:MDCContainedInputViewStateDisabled];
}

- (void)setUpUnderlineLabels {
  CGFloat underlineFontSize = MDCRound([UIFont systemFontSize] * 0.75);
  UIFont *underlineFont = [UIFont systemFontOfSize:underlineFontSize];
  self.leftUnderlineLabel = [[UILabel alloc] init];
  self.leftUnderlineLabel.font = underlineFont;
  self.rightUnderlineLabel = [[UILabel alloc] init];
  self.rightUnderlineLabel.font = underlineFont;
  [self addSubview:self.leftUnderlineLabel];
  [self addSubview:self.rightUnderlineLabel];
}

- (void)setUpPlaceholderLabel {
  self.placeholderLabel = [[UILabel alloc] init];
  [self addSubview:self.placeholderLabel];
}

- (void)setUpClearButton {
  //  CGFloat clearButtonSideLength = MDCSimpleTextFieldLayout.clearButtonSideLength;
  //  CGRect clearButtonFrame = CGRectMake(0, 0, clearButtonSideLength, clearButtonSideLength);
  //  self.clearButton = [[UIButton alloc] initWithFrame:clearButtonFrame];
  //  [self.clearButton addTarget:self
  //                       action:@selector(clearButtonPressed:)
  //             forControlEvents:UIControlEventTouchUpInside];
  //
  //  CGFloat clearButtonImageViewSideLength = MDCSimpleTextFieldLayout.clearButtonImageViewSideLength;
  //  CGRect clearButtonImageViewRect =
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
  UIColor *outerColor = (id)UIColor.clearColor.CGColor;
  UIColor *innerColor = (id)UIColor.blackColor.CGColor;
  NSArray *colors = @[outerColor, innerColor, innerColor, outerColor];
  self.horizontalGradientLayerMask = [CAGradientLayer layer];
  self.horizontalGradientLayerMask.frame = self.bounds;
  self.horizontalGradientLayerMask.colors = colors;
  self.horizontalGradientLayerMask.startPoint = CGPointMake(0.0, 0.5);
  self.horizontalGradientLayerMask.endPoint = CGPointMake(1.0, 0.5);
  
  self.verticalGradientLayerMask = [CAGradientLayer layer];
  self.verticalGradientLayerMask.frame = self.bounds;
  self.verticalGradientLayerMask.colors = colors;
  self.verticalGradientLayerMask.startPoint = CGPointMake(0.5, 0.0);
  self.verticalGradientLayerMask.endPoint = CGPointMake(0.5, 1.0);
}

#pragma mark UIResponder Overrides

-(BOOL)resignFirstResponder {
  [self.textField resignFirstResponder];
  return [super resignFirstResponder];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];
  NSLog(@"touches began");
}


#pragma mark UIView Overrides

- (void)layoutSubviews {
  [self preLayoutSubviews];
  [super layoutSubviews];
  [self postLayoutSubviews];
}

- (CGSize)sizeThatFits:(CGSize)size {
  //TODO: Implement this
  return [super sizeThatFits:size];
}

- (CGSize)intrinsicContentSize {
  //TODO: Implement this
  return [super intrinsicContentSize];
}

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];
  [self setUpLayoutDirection];
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  UIView *result = [super hitTest:point withEvent:event];
  if (result == self.scrollViewContentViewTouchForwardingView) {
    return self;
  }
  return result;
}

#pragma mark UIControl Overrides

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
  BOOL result = [super beginTrackingWithTouch:touch withEvent:event];
  self.lastTouchInitialContentOffset = self.scrollView.contentOffset;
  self.lastTouchInitialLocation = [touch locationInView:self];
  //  NSLog(@"begin tracking: %@, radius: %@, pointInside: %@",@(result), @(touch.majorRadius), NSStringFromCGPoint([touch locationInView:self]));
  return result;
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
  BOOL result = [super continueTrackingWithTouch:touch withEvent:event];
  
  CGPoint location = [touch locationInView:self];
  CGPoint offsetFromStart = [self offsetOfPoint:location fromPoint:self.lastTouchInitialLocation];
  //  NSLog(@"offset from start: %@",NSStringFromCGPoint(offsetFromStart));
  
  CGPoint offset = self.lastTouchInitialContentOffset;
  if (self.canChipsWrap) {
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

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
  [super endTrackingWithTouch:touch withEvent:event];
  
  CGPoint location = [touch locationInView:self];
  CGPoint offset = [self offsetOfPoint:location fromPoint:self.lastTouchInitialLocation];
  CGPoint absoluteOffset = [self absoluteOffsetOfOffset:offset];
  BOOL isProbablyTap = absoluteOffset.x < 15 && absoluteOffset.y < 15;
  if (isProbablyTap) {
    if (![self.textField isFirstResponder]) {
      [self.textField becomeFirstResponder];
    }
    [self enforceCalculatedScrollViewContentOffset];
    //    NSLog(@"ended a tap!");
  } else {
    //    NSLog(@"ended a scroll at %@",NSStringFromCGPoint(self.scrollView.contentOffset));
  }
  //  NSLog(@"end tracking, radius: %@, pointInside: %@", @(touch.majorRadius), NSStringFromCGPoint([touch locationInView:self]));
}

-(void)cancelTrackingWithEvent:(UIEvent *)event {
  [super cancelTrackingWithEvent:event];
}

#pragma mark Layout

- (InputChipViewLayout *)calculateLayout {
  UIFont *textFieldFont = [self determineEffectiveTextViewFont];
  return [[InputChipViewLayout alloc] initWithBounds:self.bounds
                                               chips:self.chips
                                      staleChipViews:self.chips
                                        canChipsWrap:self.canChipsWrap
                                       chipRowHeight:self.chipRowHeight
                                       textFieldText:self.textField.text
                                       textFieldFont:textFieldFont
                                       contentInsets:self.contentInsets
                                               isRTL:[self isRTL]];
}

- (void)preLayoutSubviews {
    self.containedInputViewState = [self determineCurrentContainedInputViewState];
  //  self.placeholderState = [self determineCurrentPlaceholderState];
  self.layout = [self calculateLayout];
  //  InputChipViewColorSchemeAdapter *colorAdapter =
  //  [[InputChipViewColorSchemeAdapter alloc] initWithColorScheme:self.containerScheme.colorScheme];
  //                                                  textFieldState:self.textFieldState];
  //  [self applyColorAdapter:colorAdapter];
}

- (MDCContainedInputViewState)determineCurrentContainedInputViewState {
  return [self containedInputViewStateWithIsEnabled:(self.enabled && self.inputChipViewTextField.enabled)
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
  self.maskedScrollViewContainerView.frame = self.bounds;
  self.scrollView.frame = self.bounds;
  self.scrollViewContentViewTouchForwardingView.frame = self.layout.scrollViewContentViewTouchForwardingView;
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
  
  [self applyStyle];
  [self layOutGradientLayers];
}

- (CGRect)containerRect {
  return CGRectMake(0, 0, CGRectGetWidth(self.frame), 100/*self.layout.topRowBottomRowDividerY*/);
}


- (void)applyStyle {
  //  [self applyContainerViewStyle:self.containerStyle
  //                     viewBounds:self.bounds
  //       floatingPlaceholderFrame:CGRectZero
  //        topRowBottomRowDividerY:CGRectGetMaxY(self.bounds)
  //          isFloatingPlaceholder:NO];
}

//- (void)applyContainerViewStyle:(MDCInputViewContainerStyle)containerStyle
//                 textFieldState:(TextFieldState)textFieldState
//                     viewBounds:(CGRect)viewBounds
//       floatingPlaceholderFrame:(CGRect)floatingPlaceholderFrame
//        topRowBottomRowDividerY:(CGFloat)topRowBottomRowDividerY
//          isFloatingPlaceholder:(BOOL)isFloatingPlaceholder {
//}


- (void)layOutGradientLayers {
  self.horizontalGradientLayer.frame = self.bounds;
  self.horizontalGradientLayerMask.frame = self.bounds;
  CGFloat viewWidth = CGRectGetWidth(self.bounds);
  self.horizontalGradientLayerMask.locations = @[@(0),
                                                 @(self.contentInsets.left / viewWidth),
                                                 @((viewWidth - self.contentInsets.right) / viewWidth),
                                                 @(viewWidth)];
  self.verticalGradientLayer.frame = self.bounds;
  self.verticalGradientLayerMask.frame = self.bounds;
  CGFloat viewHeight = CGRectGetHeight(self.bounds);
  self.verticalGradientLayerMask.locations = @[@(0),
                                               @(self.contentInsets.top / viewHeight),
                                               @((viewHeight - self.contentInsets.bottom) / viewHeight),
                                               @(viewHeight)];
  // TODO: Figure out how to have both gradients at once
  // Maybe render both CALayers in a content, get an image from that context,
  // Create a layer that uses resulting image as its contents
  // then use that layer as a mask
  if (self.canChipsWrap) {
    self.maskedScrollViewContainerView.layer.mask = self.verticalGradientLayerMask;
  } else {
    self.maskedScrollViewContainerView.layer.mask = self.horizontalGradientLayerMask;
  }
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
    [UIView animateWithDuration:0//kChipAnimationDuration
                     animations:^{
                       for (MDCChipView *chip in self.chipsToRemove) {
                         chip.alpha = 0;
                       }
                     } completion:^(BOOL finished) {
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
  [UIView
   animateWithDuration:kChipAnimationDuration
   animations:^{
     for (NSUInteger idx = 0; idx < self.chips.count; idx++) {
       MDCChipView *chip = self.chips[idx];
       CGRect frame = CGRectZero;
       if (self.layout.chipFrames.count > idx) {
         frame = [self.layout.chipFrames[idx] CGRectValue];
       }
       chip.frame = frame;
     }
   } completion:^(BOOL finished) {
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
    [UIView animateWithDuration:0//kChipAnimationDuration
                     animations:^{
                       for (MDCChipView *chip in chipsToAdd) {
                         chip.alpha = 1;
                       }
                     } completion:^(BOOL finished) {
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

-(void)addChip:(MDCChipView *)chipView {
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

#pragma mark Accessors

-(UITextField *)textField {
  return self.inputChipViewTextField;
}

-(void)setContentInsets:(UIEdgeInsets)contentInsets {
  if (!UIEdgeInsetsEqualToEdgeInsets(contentInsets, _contentInsets)) {
    _contentInsets = contentInsets;
  }
  [self updateLayers];
}

- (void)updateLayers {
  
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


#pragma mark User Interaction

- (void)enforceCalculatedScrollViewContentOffset {
  [self.scrollView setContentOffset:self.layout.scrollViewContentOffset animated:NO];
}


#pragma mark Internationalization

- (BOOL)isRTL {
  return self.layoutDirection == UIUserInterfaceLayoutDirectionRightToLeft;
}

#pragma mark Fonts

- (UIFont *)determineEffectiveTextViewFont {
  return self.textField.font ?: [self uiTextFieldDefaultFont];
}

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

-(void)inputChipViewTextFieldDidDeleteBackward:(InputChipViewTextField *)textField
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


#pragma mark Theming


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
    colorScheme = [self.containerStyle defaultColorSchemeForState:containedInputViewState];
  }
  return colorScheme;
}

@end
