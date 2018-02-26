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

#import "MDCCardCollectionCell.h"

#import "MaterialMath.h"
#import "MaterialIcons+ic_check_circle.h"

static NSString *const MDCCardCellShadowElevationsKey = @"MDCCardCellShadowElevationsKey";
static NSString *const MDCCardCellShadowColorsKey = @"MDCCardCellShadowColorsKey";
static NSString *const MDCCardCellBorderWidthsKey = @"MDCCardCellBorderWidthsKey";
static NSString *const MDCCardCellBorderColorsKey = @"MDCCardCellBorderColorsKey";
static NSString *const MDCCardCellInkViewKey = @"MDCCardCellInkViewKey";
static NSString *const MDCCardCellSelectedImageViewKey = @"MDCCardCellSelectedImageViewKey";
static NSString *const MDCCardCellStateKey = @"MDCCardCellStateKey";
static NSString *const MDCCardCellSelectableKey = @"MDCCardCellSelectableKey";
static NSString *const MDCCardCellCornerRadiusKey = @"MDCCardCellCornerRadiusKey";

static const CGFloat MDCCardCellSelectedImagePadding = 8;
static const CGFloat MDCCardCellShadowElevationNormal = 1.f;
static const CGFloat MDCCardCellShadowElevationHighlighted = 8.f;
static const CGFloat MDCCardCellShadowElevationSelected = 8.f;
static const CGFloat MDCCardCellCornerRadiusDefault = 4.f;



@interface MDCCardCollectionCell ()
@property(nonatomic, strong, nullable) UIImageView *selectedImageView;
@end

@implementation MDCCardCollectionCell  {
  NSMutableDictionary<NSNumber *, NSNumber *> *_shadowElevations;
  NSMutableDictionary<NSNumber *, UIColor *> *_shadowColors;
  NSMutableDictionary<NSNumber *, NSNumber *> *_borderWidths;
  NSMutableDictionary<NSNumber *, UIColor *> *_borderColors;
  CGPoint _lastTouch;
}

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  if (self) {
    _shadowElevations = [coder decodeObjectOfClass:[NSMutableDictionary class]
                                            forKey:MDCCardCellShadowElevationsKey];
    _shadowColors = [coder decodeObjectOfClass:[NSMutableDictionary class]
                                        forKey:MDCCardCellShadowColorsKey];
    _borderWidths = [coder decodeObjectOfClass:[NSMutableDictionary class]
                                        forKey:MDCCardCellBorderWidthsKey];
    _borderColors = [coder decodeObjectOfClass:[NSMutableDictionary class]
                                        forKey:MDCCardCellBorderColorsKey];
    _inkView = [coder decodeObjectOfClass:[MDCInkView class] forKey:MDCCardCellInkViewKey];
    _selectedImageView = [coder decodeObjectOfClass:[UIImageView class]
                                             forKey:MDCCardCellSelectedImageViewKey];
    _state = [coder decodeIntegerForKey:MDCCardCellStateKey];
    _selectable = [coder decodeBoolForKey:MDCCardCellSelectableKey];
    if ([coder containsValueForKey:MDCCardCellCornerRadiusKey]) {
      self.layer.cornerRadius = (CGFloat)[coder decodeDoubleForKey:MDCCardCellCornerRadiusKey];
    } else {
      self.layer.cornerRadius = MDCCardCellCornerRadiusDefault;
    }
    [self commonMDCCardCollectionCellInit];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.layer.cornerRadius = MDCCardCellCornerRadiusDefault;
    [self commonMDCCardCollectionCellInit];
  }
  return self;
}

- (void)commonMDCCardCollectionCellInit {
  if (_inkView == nil) {
    _inkView = [[MDCInkView alloc] initWithFrame:self.bounds];
    _inkView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    _inkView.usesLegacyInkRipple = NO;
    _inkView.layer.zPosition = FLT_MAX;
    [self addSubview:_inkView];
  }

  if (_selectedImageView == nil) {
    UIImage *circledCheck = [MDCIcons imageFor_ic_check_circle];
    circledCheck = [circledCheck imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _selectedImageView = [[UIImageView alloc] initWithImage:circledCheck];
    _selectedImageView.layer.zPosition = _inkView.layer.zPosition - 1;
    _selectedImageView.autoresizingMask =
    (UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin |
     UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin);
    [self.contentView addSubview:_selectedImageView];
    _selectedImageView.hidden = YES;
  }

  if (_shadowElevations == nil) {
    _shadowElevations = [NSMutableDictionary dictionary];
    _shadowElevations[@(MDCCardCellStateNormal)] = @(MDCCardCellShadowElevationNormal);
    _shadowElevations[@(MDCCardCellStateHighlighted)] = @(MDCCardCellShadowElevationHighlighted);
    _shadowElevations[@(MDCCardCellStateSelected)] = @(MDCCardCellShadowElevationSelected);
  }

  if (_shadowColors == nil) {
    _shadowColors = [NSMutableDictionary dictionary];
    _shadowColors[@(MDCCardCellStateNormal)] = [UIColor blackColor];
  }

  if (_borderColors == nil) {
    _borderColors = [NSMutableDictionary dictionary];
  }

  if (_borderWidths == nil) {
    _borderWidths = [NSMutableDictionary dictionary];
  }

  [self updateShadowElevation];
  [self updateBorderColor];
  [self updateBorderWidth];
  [self updateShadowColor];
}

- (void)encodeWithCoder:(NSCoder *)coder {
  [super encodeWithCoder:coder];
  [coder encodeObject:_shadowElevations forKey:MDCCardCellShadowElevationsKey];
  [coder encodeObject:_shadowColors forKey:MDCCardCellShadowColorsKey];
  [coder encodeObject:_borderWidths forKey:MDCCardCellBorderWidthsKey];
  [coder encodeObject:_borderColors forKey:MDCCardCellBorderColorsKey];
  [coder encodeObject:_inkView forKey:MDCCardCellInkViewKey];
  [coder encodeObject:_selectedImageView forKey:MDCCardCellSelectedImageViewKey];
  [coder encodeInteger:_state forKey:MDCCardCellStateKey];
  [coder encodeBool:_selectable forKey:MDCCardCellSelectableKey];
  [coder encodeDouble:self.layer.cornerRadius forKey:MDCCardCellCornerRadiusKey];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  self.layer.shadowPath = [self boundingPath].CGPath;
  CGFloat xImgNoPadd = CGRectGetWidth(self.bounds) - CGRectGetWidth(self.selectedImageView.frame)/2;
  self.selectedImageView.center =
      CGPointMake(
          xImgNoPadd - MDCCardCellSelectedImagePadding,
          CGRectGetHeight(self.selectedImageView.frame)/2 + MDCCardCellSelectedImagePadding
      );
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
  self.layer.cornerRadius = cornerRadius;
  [self setNeedsLayout];
}

- (CGFloat)cornerRadius {
  return self.layer.cornerRadius;
}

- (void)setState:(MDCCardCellState)state animated:(BOOL)animated {
  switch (state) {
    case MDCCardCellStateSelected: {
      if (_state != MDCCardCellStateHighlighted) {
        if (animated) {
          [self.inkView startTouchBeganAnimationAtPoint:_lastTouch completion:nil];
        } else {
          [self.inkView cancelAllAnimationsAnimated:NO];
          [self.inkView startTouchBeganAtPoint:self.center
                                      animated:NO
                                withCompletion:nil];
        }
      }
      self.selectedImageView.hidden = NO;
      break;
    }
    case MDCCardCellStateNormal: {
      [self.inkView startTouchEndAtPoint:_lastTouch
                                animated:animated
                          withCompletion:nil];
      self.selectedImageView.hidden = YES;
      break;
    }
    case MDCCardCellStateHighlighted: {
      // Note: setHighlighted: can get getting more calls with YES than NO when clicking rapidly.
      // To guard against ink never going away and darkening our card we call
      // startTouchEndedAnimationAtPoint:completion:.
      [self.inkView startTouchEndedAnimationAtPoint:_lastTouch completion:nil];
      [self.inkView startTouchBeganAnimationAtPoint:_lastTouch completion:nil];
      self.selectedImageView.hidden = YES;
      break;
    }
  }
  _state = state;
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
  if (self.selectable) {
    if (selected) {
      [self setState:MDCCardCellStateSelected animated:NO];
    } else {
      [self setState:MDCCardCellStateNormal animated:NO];
    }
  }
}

- (UIBezierPath *)boundingPath {
  CGFloat cornerRadius = self.cornerRadius;
  return [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:cornerRadius];
}

- (MDCShadowElevation)shadowElevationForState:(MDCCardCellState)state {
  NSNumber *elevation = _shadowElevations[@(state)];
  if (state != MDCCardCellStateNormal && elevation == nil) {
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
  if (!MDCCGFloatEqual(((MDCShadowLayer *)self.layer).elevation, elevation)) {
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
  if (state != MDCCardCellStateNormal && borderWidth == nil) {
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
  if (state != MDCCardCellStateNormal && borderColor == nil) {
    borderColor = _borderColors[@(MDCCardCellStateNormal)];
  }
  return borderColor;
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
  if (state != MDCCardCellStateNormal && shadowColor == nil) {
    shadowColor = _shadowColors[@(MDCCardCellStateNormal)];
  }
  if (shadowColor != nil) {
    return shadowColor;
  }
  return [UIColor blackColor];
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];

  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  _lastTouch = location;
  if (!self.selected || !self.selectable) {
    [self setState:MDCCardCellStateHighlighted animated:YES];
  }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];
  if (!self.selected || !self.selectable) {
    [self setState:MDCCardCellStateNormal animated:YES];
  }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesCancelled:touches withEvent:event];
  if (!self.selected || !self.selectable) {
    [self setState:MDCCardCellStateNormal animated:YES];
  }
}

@end
