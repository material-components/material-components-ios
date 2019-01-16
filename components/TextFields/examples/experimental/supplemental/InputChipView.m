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

#import "MDCInputViewContainerStyler.h"


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

@property (strong, nonatomic) InputChipViewTextField *inputChipViewTextField;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIView *scrollViewContainer;
@property (strong, nonatomic) UIView *tapRecognizerView;
@property (strong, nonatomic) NSMutableArray *chips;
@property (strong, nonatomic) NSMutableArray *chipsToRemove;

@property (strong, nonatomic) InputChipViewLayout *layout;
@property(nonatomic, assign) UIUserInterfaceLayoutDirection layoutDirection;

@property (strong, nonatomic) CALayer *horizontalGradientLayer;
@property (strong, nonatomic) CAGradientLayer *horizontalGradientLayerMask;
@property (strong, nonatomic) CALayer *verticalGradientLayer;
@property (strong, nonatomic) CAGradientLayer *verticalGradientLayerMask;

@property (strong, nonatomic) UITouch *lastTouch;
//@property (strong, nonatomic) BOOL lastTouchBeganInside;
//@property (strong, nonatomic) BOOL lastTouchEndedInside;

@property (nonatomic, assign) CGPoint lastTouchStartingContentOffset;
@property (nonatomic, assign) CGPoint lastTouchStartingLocation;

@property (strong, nonatomic) InputChipViewColorSchemeAdapter *colorSchemeAdapter;

@property (nonatomic, strong) MDCInputViewContainerStyler *containerStyler;

@end


@implementation InputChipView

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
  self.colorSchemeAdapter = [[InputChipViewColorSchemeAdapter alloc] init];
  
  [self setUpContainerScheme];
  
  self.containerStyler = [[MDCInputViewContainerStyler alloc] init];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark View Setup


- (void)setUpContainerScheme {
  self.containerScheme = [[MDCContainerScheme alloc] init];
  self.containerScheme.colorScheme = [[MDCSemanticColorScheme alloc] init];
  self.containerScheme.typographyScheme = [[MDCTypographyScheme alloc] init];
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
//  self.verticalGradientLayerMask.colors = @[(id)UIColor.clearColor.CGColor,
//                                            (id)UIColor.blackColor.CGColor,
//                                            (id)UIColor.blackColor.CGColor,
//                                            (id)UIColor.clearColor.CGColor];
  self.verticalGradientLayerMask.colors = colors;
  self.verticalGradientLayerMask.startPoint = CGPointMake(0.5, 0.0);
  self.verticalGradientLayerMask.endPoint = CGPointMake(0.5, 1.0);
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
  
  self.chipRowHeight = [self determineEffectiveTextFieldFont].lineHeight * 2;
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
  self.scrollViewContainer = [[UIView  alloc] init];
  [self addSubview:self.scrollViewContainer];
  self.scrollView = [[UIScrollView alloc] init];
  self.scrollView.bounces = NO;
  [self.scrollViewContainer addSubview:self.scrollView];
  self.tapRecognizerView = [[UIView alloc] init];
  [self.scrollView addSubview:self.tapRecognizerView];
  self.inputChipViewTextField = [[InputChipViewTextField alloc] init];
  self.inputChipViewTextField.inputChipViewTextFieldDelegate = self;
  [self.scrollView addSubview:self.textField];
}

#pragma mark UIResponder Overrides

-(BOOL)resignFirstResponder {
  [self.textField resignFirstResponder];
  return [super resignFirstResponder];
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


#pragma mark Layout

- (InputChipViewLayout *)calculateLayout {
  UIFont *textFieldFont = [self determineEffectiveTextFieldFont];
  return [[InputChipViewLayout alloc] initWithBounds:self.bounds
                                               chips:self.chips
                                        canChipsWrap:self.canChipsWrap
                                       chipRowHeight:self.chipRowHeight
                                       textFieldText:self.textField.text
                                       textFieldFont:textFieldFont
                                       contentInsets:self.contentInsets
                                               isRTL:[self isRTL]];
}

- (void)preLayoutSubviews {
  self.layout = [self calculateLayout];
  InputChipViewColorSchemeAdapter *colorAdapter =
  [[InputChipViewColorSchemeAdapter alloc] initWithColorScheme:self.containerScheme.colorScheme];
//                                                  textFieldState:self.textFieldState];
  [self applyColorAdapter:colorAdapter];
}

- (void)postLayoutSubviews {
  self.scrollViewContainer.frame = self.bounds;
  self.scrollView.frame = self.bounds;
  self.tapRecognizerView.frame = self.layout.tapRecognizerViewFrame;
  self.textField.frame = self.layout.textFieldFrame;
  self.scrollView.contentOffset = self.layout.scrollViewContentOffset;
  self.scrollView.contentSize = self.layout.scrollViewContentSize;
  [self animateChipLayoutChangesWithChips:self.chips
                               chipFrames:self.layout.chipFrames
                            chipsToRemove:self.chipsToRemove
                               chipsToAdd:self.chipsToAdd];
  //  NSLog(@"%@",NSStringFromCGRect(self.textField.frame));
  [self.scrollView setNeedsLayout];
  //  NSLog(@"inset: %@",NSStringFromUIEdgeInsets(self.scrollView.contentInset));
  //  NSLog(@"offset: %@",NSStringFromCGPoint(self.scrollView.contentOffset));
  //  NSLog(@"size: %@\n\n",NSStringFromCGSize(self.scrollView.contentSize));

  [self applyStyle];
  [self layOutGradientLayers];
}

- (void)applyStyle {
  [self applyContainerViewStyle:self.containerStyle
                     viewBounds:self.bounds
       floatingPlaceholderFrame:CGRectZero
        topRowBottomRowDividerY:CGRectGetMaxY(self.bounds)
          isFloatingPlaceholder:NO];
}

- (void)applyContainerViewStyle:(MDCInputViewContainerStyle)containerStyle
//                 textFieldState:(TextFieldState)textFieldState
                     viewBounds:(CGRect)viewBounds
       floatingPlaceholderFrame:(CGRect)floatingPlaceholderFrame
        topRowBottomRowDividerY:(CGFloat)topRowBottomRowDividerY
          isFloatingPlaceholder:(BOOL)isFloatingPlaceholder {
//  CGFloat outlineLineWidth = [self outlineLineWidthForState:textFieldState];
  CGFloat outlineLineWidth = 2;
  [self.containerStyler applyOutlinedStyle:containerStyle == MDCInputViewContainerStyleOutline
                                      view:self
                  floatingPlaceholderFrame:floatingPlaceholderFrame
                   topRowBottomRowDividerY:topRowBottomRowDividerY
                     isFloatingPlaceholder:isFloatingPlaceholder
                          outlineLineWidth:outlineLineWidth];
//  CGFloat underlineThickness = [self underlineThicknessWithTextFieldState:textFieldState];
  CGFloat underlineThickness = 2;
  [self.containerStyler applyFilledStyle:containerStyle == MDCInputViewContainerStyleFilled
                                    view:self
                 topRowBottomRowDividerY:topRowBottomRowDividerY
                      underlineThickness:underlineThickness];
}


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
  
  if (self.canChipsWrap) {
    self.scrollViewContainer.layer.mask = self.verticalGradientLayerMask;
  } else {
    self.scrollViewContainer.layer.mask = self.horizontalGradientLayerMask;
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
  self.textField.text = 0;
  [self setNeedsLayout];
//  NSInteger chipIndex = self.chips.count;
//  CGRect newChipFrame = [self frameFor]
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



#pragma mark User Interaction

- (void)enforceCalculatedScrollViewContentOffset {
  [self.scrollView setContentOffset:self.layout.scrollViewContentOffset animated:NO];
}


#pragma mark Internationalization

- (BOOL)isRTL {
  return self.layoutDirection == UIUserInterfaceLayoutDirectionRightToLeft;
}

#pragma mark Fonts

- (UIFont *)determineEffectiveTextFieldFont {
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

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];
  NSLog(@"touches began");
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  UIView *result = [super hitTest:point withEvent:event];
  NSLog(@"self: %@, scrollViewContainer: %@, scrollView: %@, tapRecognizerView: %@, testField: %@",@(self == result),@(self.scrollViewContainer == result),@(self.scrollView == result), @(self.tapRecognizerView == result), @(self.textField == result));
  if (result == self.tapRecognizerView) {
    return self;
  }
  return result;
}

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
  BOOL result = [super beginTrackingWithTouch:touch withEvent:event];

  self.lastTouchStartingContentOffset = self.scrollView.contentOffset;
  self.lastTouchStartingLocation = [touch locationInView:self];

//  NSLog(@"begin tracking: %@, radius: %@, pointInside: %@",@(result), @(touch.majorRadius), NSStringFromCGPoint([touch locationInView:self]));
  return result;
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event {
  BOOL result = [super continueTrackingWithTouch:touch withEvent:event];

  CGPoint location = [touch locationInView:self];
  CGPoint offsetFromStart = [self offsetOfPoint:location fromPoint:self.lastTouchStartingLocation];
//  NSLog(@"offset from start: %@",NSStringFromCGPoint(offsetFromStart));

  CGPoint offset = self.lastTouchStartingContentOffset;
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
  CGPoint offset = [self offsetOfPoint:location fromPoint:self.lastTouchStartingLocation];
  CGPoint absoluteOffset = [self absoluteOffsetOfPoint:offset];
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

- (CGPoint)offsetOfPoint:(CGPoint)point1 fromPoint:(CGPoint)point2 {
  return CGPointMake(point1.x - point2.x, point1.y - point2.y);
}

- (CGPoint)absoluteOffsetOfPoint:(CGPoint)point {
  if (point.x < 0) {
    point.x = point.x * -1;
  }
  if (point.y < 0) {
    point.y = point.y * -1;
  }
  return point;
}


-(void)cancelTrackingWithEvent:(UIEvent *)event {
  [super cancelTrackingWithEvent:event];
}


#pragma mark Theming

- (void)applyColorAdapter:(InputChipViewColorSchemeAdapter *)colorAdapter {
//  self.textColor = colorAdapter.textColor;
//  self.leadingUnderlineLabel.textColor = colorAdapter.underlineLabelColor;
//  self.trailingUnderlineLabel.textColor = colorAdapter.underlineLabelColor;
//  self.placeholderLabel.textColor = colorAdapter.placeholderLabelColor;
//  self.clearButtonImageView.tintColor = colorAdapter.clearButtonTintColor;
  
  self.containerStyler.outlinedSublayer.strokeColor = colorAdapter.outlineColor.CGColor;
  self.containerStyler.filledSublayerUnderline.fillColor = colorAdapter.filledSublayerUnderlineFillColor.CGColor;
  self.containerStyler.filledSublayer.fillColor = colorAdapter.filledSublayerFillColor.CGColor;
}


@end
