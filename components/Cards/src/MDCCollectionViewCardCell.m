/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCCollectionViewCardCell.h"

#import "MaterialIcons+ic_check_circle.h"
#import <MDFTextAccessibility/MDFTextAccessibility.h>
#import "private/MDCCardView+Private.h"

@interface MDCCollectionViewCardCell ()

@property(nonatomic, strong, nullable) UIImageView *selectedImageView;

@end

@implementation MDCCollectionViewCardCell  {
  NSMutableDictionary<NSNumber *, NSNumber *> *_shadowElevations;
  NSMutableDictionary<NSNumber *, UIColor *> *_shadowColors;
  NSMutableDictionary<NSNumber *, NSNumber *> *_borderWidths;
  NSMutableDictionary<NSNumber *, UIColor *> *_borderColors;
  CGPoint _lastTouch;
  BOOL _inkAnimating;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCCollectionViewCardCellInit];
  }
  return self;
}

- (void)commonMDCCollectionViewCardCellInit {
  _inkView = [[MDCInkView alloc] initWithFrame:self.bounds];
  _inkView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
  _inkView.usesLegacyInkRipple = NO;
  _inkView.layer.zPosition = 101;
  [self addSubview:self.inkView];

  _inkAnimating = NO;
  self.selecting = NO;

  [self initializeSelectedImage];

  self.cornerRadius = 4.f;

  _shadowElevations = [[NSMutableDictionary alloc] init];
  _shadowElevations[@(MDCCardCellStateNormal)] = @(1.f);
  _shadowElevations[@(MDCCardCellStateHighlighted)] = @(8.f);
  _shadowElevations[@(MDCCardCellStateSelected)] = @(8.f);
  [self updateShadowElevation];

  _shadowColors = [[NSMutableDictionary alloc] init];
  _shadowColors[@(MDCCardCellStateNormal)] = [UIColor blackColor];
  _shadowColors[@(MDCCardCellStateHighlighted)] = [UIColor blackColor];
  _shadowColors[@(MDCCardCellStateSelected)] = [UIColor blackColor];
  [self updateShadowColor];

  _borderColors = [[NSMutableDictionary alloc] init];
  _borderColors[@(MDCCardCellStateNormal)] = [UIColor clearColor];
  _borderColors[@(MDCCardCellStateHighlighted)] = [UIColor clearColor];
  _borderColors[@(MDCCardCellStateSelected)] = [UIColor blackColor];
  [self updateBorderColor];

  _borderWidths = [[NSMutableDictionary alloc] init];
  _borderWidths[@(MDCCardCellStateNormal)] = @(0.f);
  _borderWidths[@(MDCCardCellStateHighlighted)] = @(0.f);
  _borderWidths[@(MDCCardCellStateSelected)] = @(0.f);
  [self updateBorderWidth];
}

- (void)initializeSelectedImage {
  UIImage *circledCheck = [MDCIcons imageFor_ic_check_circle];
  circledCheck = [circledCheck imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  self.selectedImageView = [[UIImageView alloc] initWithImage:circledCheck];
  self.selectedImageView.center = CGPointMake(
                                    CGRectGetWidth(self.bounds) - (circledCheck.size.width/2) - 8,
                                    (circledCheck.size.height/2) + 8);
  self.selectedImageView.layer.zPosition = MAXFLOAT - 1;
  self.selectedImageView.autoresizingMask =
  (UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin |
   UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin);
  [self.contentView addSubview:self.selectedImageView];
  self.selectedImageView.hidden = YES;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
  super.backgroundColor = backgroundColor;

  /**
   currently the selected check image uses the color
   based on MDFTextAccessibility to fit the background color.
   */
  UIColor *checkColor =
  [MDFTextAccessibility textColorOnBackgroundColor:backgroundColor
                                   targetTextAlpha:1.f
                                           options:MDFTextAccessibilityOptionsNone];
  self.selectedImageTintColor = checkColor;
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
  self.layer.cornerRadius = cornerRadius;
  [self setNeedsLayout];
}

- (CGFloat)cornerRadius {
  return self.layer.cornerRadius;
}

- (void)setState:(MDCCardCellState)state withAnimation:(BOOL)animation {
  _state = state;
  switch (state) {
    case MDCCardCellStateSelected: {
      if (animation) {
        _inkAnimating = YES;
        [self.inkView startTouchBeganAnimationAtPoint:_lastTouch completion:nil];
      } else {
        if (!_inkAnimating) {
          [self.inkView cancelAllAnimationsAnimated:NO];
          [self.inkView startTouchBeganAtPoint:self.center
                                          withAnimation:NO
                                          andCompletion:nil];
        }
        _inkAnimating = NO;
        self.selectedImageView.hidden = NO;
      }
      break;
    }
    case MDCCardCellStateNormal: {
      [self.inkView startTouchEndAtPoint:_lastTouch
                                    withAnimation:animation
                                    andCompletion:nil];
      self.selectedImageView.hidden = YES;
      break;

    }
    case MDCCardCellStateHighlighted: {
      /**
       Note: setHighlighted might get more touches began than touches ended hence the call
       hence the call to startTouchEndedAnimationAtPoint before.
       */
      [self.inkView startTouchEndedAnimationAtPoint:_lastTouch completion:nil];
      [self.inkView startTouchBeganAnimationAtPoint:_lastTouch completion:nil];
      self.selectedImageView.hidden = YES;
      break;
    }
  }
  [self updateShadowElevation];
  [self updateBorderColor];
  [self updateBorderWidth];
  [self updateShadowColor];
}

- (void)setSelectedImage:(UIImage *)selectedImage {
  [self.selectedImageView setImage:selectedImage];
}

- (UIImage *)selectedImage {
  return self.selectedImageView.image;
}

- (void)setSelectedImageTintColor:(UIColor *)selectedImageTintColor {
  [self.selectedImageView setTintColor:selectedImageTintColor];
}

- (UIColor *)selectedImageTintColor {
  return self.selectedImageView.tintColor;
}

- (void)setSelected:(BOOL)selected {
  [super setSelected:selected];
  if (self.selecting) {
    if (selected) {
      [self setState:MDCCardCellStateSelected withAnimation:NO];
    } else {
      [self setState:MDCCardCellStateNormal withAnimation:NO];
    }
  }
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.layer.shadowPath = [self boundingPath].CGPath;
}

- (UIBezierPath *)boundingPath {
  CGFloat cornerRadius = self.cornerRadius;
  return [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
}

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

- (MDCShadowElevation)shadowElevationForState:(MDCCardCellState)state {
  NSNumber *elevation = _shadowElevations[@(state)];
  if (elevation == nil) {
    elevation = _shadowElevations[@(MDCCardCellStateNormal)];
  }
  if (elevation != nil) {
    return (CGFloat)[elevation doubleValue];
  }
  return 0;
}

- (void)setShadowElevation:(MDCShadowElevation)shadowElevation forState:(MDCCardCellState)state {
  _shadowElevations[@(state)] = @(shadowElevation);

  [self updateShadowElevation];
}

- (void)updateShadowElevation {
  CGFloat elevation = [self shadowElevationForState:self.state];
  if (((MDCShadowLayer *)self.layer).elevation != elevation) {
    self.layer.shadowPath = [self boundingPath].CGPath;
    [(MDCShadowLayer *)self.layer setElevation:elevation];
  }
}

- (void)setBorderWidth:(CGFloat)borderWidth forState:(MDCCardCellState)state {
  _borderWidths[@(state)] = @(borderWidth);

  [self updateBorderWidth];
}

- (void)updateBorderWidth {
  CGFloat borderWidth = [self borderWidthForState:self.state];
  self.layer.borderWidth = borderWidth;
}

- (CGFloat)borderWidthForState:(MDCCardCellState)state {
  NSNumber *borderWidth = _borderWidths[@(state)];
  if (borderWidth == nil) {
    borderWidth = _borderWidths[@(MDCCardCellStateNormal)];
  }
  if (borderWidth != nil) {
    return (CGFloat)[borderWidth doubleValue];
  }
  return 0;
}

- (void)setBorderColor:(UIColor *)borderColor forState:(MDCCardCellState)state {
  _borderColors[@(state)] = borderColor;

  [self updateBorderColor];
}

- (void)updateBorderColor {
  CGColorRef borderColorRef = [self borderColorForState:self.state].CGColor;
  self.layer.borderColor = borderColorRef;
}

- (UIColor *)borderColorForState:(MDCCardCellState)state {
  UIColor *borderColor = _borderColors[@(state)];
  if (borderColor == nil) {
    borderColor = _borderColors[@(MDCCardCellStateNormal)];
  }
  if (borderColor != nil) {
    return borderColor;
  }
  return [UIColor clearColor];
}

- (void)setShadowColor:(UIColor *)shadowColor forState:(MDCCardCellState)state {
  _shadowColors[@(state)] = shadowColor;

  [self updateShadowColor];
}

- (void)updateShadowColor {
  CGColorRef shadowColor = [self shadowColorForState:self.state].CGColor;
  self.layer.shadowColor = shadowColor;
}

- (UIColor *)shadowColorForState:(MDCCardCellState)state {
  UIColor *shadowColor = _shadowColors[@(state)];
  if (shadowColor == nil) {
    shadowColor = _shadowColors[@(MDCCardCellStateNormal)];
  }
  if (shadowColor != nil) {
    return shadowColor;
  }
  return [UIColor clearColor];
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];

  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  _lastTouch = location;
  if (self.selecting) {
    if (!self.selected) {
      [self setState:MDCCardCellStateSelected withAnimation:YES];
    }
  } else {
    [self setState:MDCCardCellStateHighlighted withAnimation:YES];
  }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];
  if (self.selecting) {
    if (!self.selected) {
      [self setState:MDCCardCellStateNormal withAnimation:YES];
    }
  } else {
    [self setState:MDCCardCellStateNormal withAnimation:YES];
  }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesCancelled:touches withEvent:event];
  if (self.selecting) {
    if (!self.selected) {
      [self setState:MDCCardCellStateNormal withAnimation:YES];
    }
  } else {
    [self setState:MDCCardCellStateNormal withAnimation:YES];
  }
}

@end
