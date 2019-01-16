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

#import "MDCTextAreaView.h"
#import "MDCTextAreaViewLayout.h"

#import <MDFInternationalization/MDFInternationalization.h>
#import <CoreGraphics/CoreGraphics.h>

#import "InputChipViewColorSchemeAdapter.h"

#import "MDCInputViewContainerStyler.h"


@interface MDCTextAreaView ()

@property (strong, nonatomic) MDCTextAreaViewLayout *layout;
@property(nonatomic, assign) UIUserInterfaceLayoutDirection layoutDirection;

@property (strong, nonatomic) CALayer *horizontalGradientLayer;
@property (strong, nonatomic) CAGradientLayer *horizontalGradientLayerMask;
@property (strong, nonatomic) CALayer *verticalGradientLayer;
@property (strong, nonatomic) CAGradientLayer *verticalGradientLayerMask;

@property (strong, nonatomic) UITouch *lastTouch;

@property (nonatomic, assign) CGPoint lastTouchStartingContentOffset;
@property (nonatomic, assign) CGPoint lastTouchStartingLocation;

@property (strong, nonatomic) InputChipViewColorSchemeAdapter *colorSchemeAdapter;

@property (nonatomic, strong) MDCInputViewContainerStyler *containerStyler;

@end


@implementation MDCTextAreaView

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
  self.containerStyler = [[MDCInputViewContainerStyler alloc] init];
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
   selector:@selector(textViewDidBeginEditingWithNotification:)
   name:UITextViewTextDidBeginEditingNotification
   object:nil];
  [[NSNotificationCenter defaultCenter]
   addObserver:self
   selector:@selector(textViewDidChangeWithNotification:)
   name:UITextViewTextDidChangeNotification
   object:nil];
}

- (void)initializeProperties {
  [self setUpLayoutDirection];
  [self setUpContentInsets];
  
}

- (void)setUpContentInsets {

}


- (void)setUpLayoutDirection {
  self.layoutDirection = self.mdf_effectiveUserInterfaceLayoutDirection;
}

- (void)createSubviews {
}

#pragma mark UIResponder Overrides

-(void)handleTouchUpInside {
//  if (![self.textField isFirstResponder]) {
//    [self.textField becomeFirstResponder];
//  }
//  [self enforceCalculatedScrollViewContentOffset];
//  BOOL result = [super becomeFirstResponder];
//  [self.textField becomeFirstResponder];
//  return result;
  /*
   consider calling textField becomeFirstResponder here, and consider calling this method in touchesbegan.
   this would be a replacement of tap gesture
   */
}

-(BOOL)resignFirstResponder {
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

- (MDCTextAreaViewLayout *)calculateLayout {
  return [[MDCTextAreaViewLayout alloc] initWithViewBounds:self.bounds
                                                     isRTL:[self isRTL]];
}

- (void)preLayoutSubviews {
  self.layout = [self calculateLayout];
}

- (void)postLayoutSubviews {

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

-(void)setBounds:(CGRect)bounds {
  NSLog(@"setBounds!");
  [super setBounds:bounds];
  [self updateLayers];
}


- (void)updateLayers {

}

#pragma mark Accessors



#pragma mark User Interaction


#pragma mark Internationalization

- (BOOL)isRTL {
  return self.layoutDirection == UIUserInterfaceLayoutDirectionRightToLeft;
}

#pragma mark Fonts

- (UIFont *)determineEffectiveTextFieldFont {
  return self.font ?: [self uiTextViewDefaultFont];
}

- (UIFont *)uiTextViewDefaultFont {
  static dispatch_once_t onceToken;
  static UIFont *font;
  dispatch_once(&onceToken, ^{
    // TODO: Is this the body style? It's supposed to be
    font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
  });
  return font;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];
  NSLog(@"touches began");
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  UIView *result = [super hitTest:point withEvent:event];
  return result;
}


#pragma mark Notification Listener Methods

- (void)textViewDidEndEditingWithNotification:(NSNotification *)notification {
  if (notification.object != self) {
    return;
  }
}

- (void)textViewDidChangeWithNotification:(NSNotification *)notification {
  if (notification.object != self) {
    return;
  }
//  [self setNeedsLayout];
}

- (void)textViewDidBeginEditingWithNotification:(NSNotification *)notification {
  if (notification.object != self) {
    return;
  }
}


#pragma mark Theming

- (void)applyColorAdapter:(InputChipViewColorSchemeAdapter *)colorAdapter {
  
  self.containerStyler.outlinedSublayer.strokeColor = colorAdapter.outlineColor.CGColor;
  self.containerStyler.filledSublayerUnderline.fillColor = colorAdapter.filledSublayerUnderlineFillColor.CGColor;
  self.containerStyler.filledSublayer.fillColor = colorAdapter.filledSublayerFillColor.CGColor;
}


@end
