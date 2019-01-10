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

@class InputChipViewTextField;
@protocol InputChipViewTextFieldDelegate <NSObject>
- (void)inputChipViewTextFieldDidDeleteBackward:(InputChipViewTextField *)textField
                             withCursorPosition:(NSInteger)cursorPosition;
@end


@interface InputChipViewTextField : UITextField
@property (nonatomic, weak) id<InputChipViewTextFieldDelegate> inputChipViewTextFieldDelegate;
@end

@implementation InputChipViewTextField

- (void)deleteBackward {
  [super deleteBackward];
  NSInteger cursorPosition = [self offsetFromPosition:self.beginningOfDocument
                                           toPosition:self.selectedTextRange.start];
  if (cursorPosition == 0) {
    if ([self.inputChipViewTextFieldDelegate respondsToSelector:@selector(inputChipViewTextFieldDidDeleteBackward:withCursorPosition:)]) {
      [self.inputChipViewTextFieldDelegate inputChipViewTextFieldDidDeleteBackward:self
                                                                withCursorPosition:cursorPosition];
    }
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

@property (strong, nonatomic) UITapGestureRecognizer *tapRecognizer;

@property (strong, nonatomic) InputChipViewLayout *layout;
@property(nonatomic, assign) UIUserInterfaceLayoutDirection layoutDirection;

@property (strong, nonatomic) CAGradientLayer *gradientLayer;

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
    self.contentInsets = UIEdgeInsetsMake(8, 8, 8, 8);
    [self commonInputChipViewInit];
  }
  return self;
}

- (void)commonInputChipViewInit {
  [self addObservers];
  [self initializeProperties];
  [self createSubviews];
  [self setUpGradientLayer];
  
  
  [self addTarget:self action:@selector(handleTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
}

- (void)handleTouchUpInside {
  NSLog(@"handleTouchUpInside");
}

//- (void)setUpGradientLayer {
//  self.gradientLayer.frame = self.scrollView.bounds;
//  self.gradientLayer.locations = @[@0.0, @0.1, @0.9, @1.0];
//  self.scrollView.layer.mask = self.gradientLayer;
//
//}

- (void)setUpGradientLayer {
  self.gradientLayer = [CAGradientLayer layer];
  self.gradientLayer.frame = self.bounds;
  self.gradientLayer.colors = @[(id)UIColor.clearColor.CGColor,
                                (id)UIColor.blackColor.CGColor,
                                (id)UIColor.blackColor.CGColor,
                                (id)UIColor.clearColor.CGColor];
  self.gradientLayer.locations = @[@0.0, @0.1, @0.9, @1.0];
  self.gradientLayer.startPoint = CGPointMake(0.0, 0.5);
  self.gradientLayer.endPoint = CGPointMake(1.0, 0.5);

  self.scrollViewContainer.layer.mask = self.gradientLayer;
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
}

- (void)setUpContentInsets {
  self.contentInsets = UIEdgeInsetsMake(8, 8, 8, 8);
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
  self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapRecognizer:)];
  [self.tapRecognizerView addGestureRecognizer:self.tapRecognizer];
  self.tapRecognizer.delegate = self;
  self.inputChipViewTextField = [[InputChipViewTextField alloc] init];
  self.inputChipViewTextField.inputChipViewTextFieldDelegate = self;
  [self.scrollView addSubview:self.textField];
}

#pragma mark UIResponder Overrides

-(BOOL)becomeFirstResponder {
  return [super becomeFirstResponder];
  /*
   consider calling textField becomeFirstResponder here, and consider calling this method in touchesbegan.
   this would be a replacement of tap gesture
   */
}

-(BOOL)resignFirstResponder {
  [self.textField resignFirstResponder];
  return [super resignFirstResponder];
}

#pragma mark UIView Overrides

- (void)layoutSubviews {
  [self preLayoutSubviews];
  [super layoutSubviews];
  self.scrollView.frame = self.bounds;
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
                                       textFieldText:self.textField.text
                                       textFieldFont:textFieldFont
                                       contentInsets:self.contentInsets
                                               isRTL:[self isRTL]];
}

- (void)preLayoutSubviews {
  self.layout = [self calculateLayout];
}

- (void)postLayoutSubviews {
  self.scrollViewContainer.frame = self.bounds;
  self.scrollView.frame = self.bounds;
  self.textField.frame = self.layout.textFieldFrame;
  self.scrollView.contentOffset = self.layout.scrollViewContentOffset;
  self.scrollView.contentSize = self.layout.scrollViewContentSize;
  self.tapRecognizerView.frame = self.scrollView.bounds;
  [self animateChipLayoutChangesWithChips:self.chips
                               chipFrames:self.layout.chipFrames
                            chipsToRemove:self.chipsToRemove
                               chipsToAdd:self.chipsToAdd];
  NSLog(@"%@",NSStringFromCGRect(self.textField.frame));
  [self updateGradientLocations];
}

- (void)updateGradientLocations {
  self.gradientLayer.frame = self.bounds;
  CGFloat viewWidth = CGRectGetWidth(self.bounds);
  self.gradientLayer.locations = @[@(0),
                                   @(self.contentInsets.left / viewWidth),
                                   @((viewWidth - self.contentInsets.right) / viewWidth),
                                   @(viewWidth)];
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

#pragma mark - Chip Deleting

- (void)deselectAllChipsExceptChip:(MDCChipView *)chip {
  for (MDCChipView *otherChip in self.chips) {
    if (chip != otherChip) {
      otherChip.selected = NO;
    }
  }
}

- (void)selectLastChip {
  MDCChipView *lastChip = self.chips.lastObject;
  [self deselectAllChipsExceptChip:lastChip];
  lastChip.selected = YES;
  UIAccessibilityPostNotification(UIAccessibilityAnnouncementNotification,
                                  [lastChip accessibilityLabel]);
}

- (void)deselectAllChips {
  [self deselectAllChipsExceptChip:nil];
}

- (void)removeChips:(NSArray<MDCChipView *> *)chips {
  [self.chipsToRemove addObjectsFromArray:chips];
  [self.chips removeObjectsInArray:chips];
  [self setNeedsLayout];
}

- (void)removeSelectedChips {
  NSMutableArray *chipsToRemove = [NSMutableArray array];
  for (MDCChipView *chip in self.chips) {
    if (chip.isSelected) {
      [chipsToRemove addObject:chip];
    }
  }
//  for (MDCChipView *chip in chipsToRemove) {
//  }
  [self.chips removeObjectsInArray:chipsToRemove];
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

#pragma mark User Interaction

- (void)handleTapRecognizer:(UITapGestureRecognizer *)tap {
  CGPoint location = [tap locationInView:self];
  NSLog(@"tap at location: %@",NSStringFromCGPoint(location));
  if ([self.textField isFirstResponder]) {
//    MDCChipView *chipView = [self chipAtPoint:location];
//    if (chipView) {
//      NSLog(@"tap at chip: %@",chipView.titleLabel.text);
//    }
  } else {
    [self.textField becomeFirstResponder];
  }
}

- (MDCChipView *)chipAtPoint:(CGPoint)point {
  MDCChipView *chipAtPoint = nil;
  for (MDCChipView *chip in self.chips) {
    if (CGRectContainsPoint(chip.frame, point)) {
      chipAtPoint = chip;
      break;
    }
  }
  return chipAtPoint;
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
                            withCursorPosition:(NSInteger)cursorPosition {
  if (cursorPosition == 0) {
    NSArray *selectedChips = [self selectedChips];
    if (selectedChips.count > 0) {
      [self removeChips:selectedChips];
    } else if (self.chips.count > 0) {
      [self selectChip:self.chips.lastObject];
    }
  }
}

@end
