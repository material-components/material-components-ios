// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCCardCollectionCell.h"
#import "private/MDCCardCollectionCell+Private.h"

#import "MaterialIcons+ic_check_circle.h"
#import "MaterialMath.h"
#import "MaterialShapes.h"

static const CGFloat MDCCardCellCornerRadiusDefault = 4;
static const CGFloat MDCCardCellSelectedImagePadding = 8;
static const CGFloat MDCCardCellShadowElevationHighlighted = 8;
static const CGFloat MDCCardCellShadowElevationNormal = 1;
static const CGFloat MDCCardCellShadowElevationSelected = 8;
static const CGFloat MDCCardCellShadowElevationDragged = 8;  // Used for Ripple Beta
static const BOOL MDCCardCellIsInteractableDefault = YES;

@interface MDCCardCollectionCell ()
@property(nonatomic, strong, nullable) UIImageView *selectedImageView;
@property(nonatomic, readonly, strong) MDCShapedShadowLayer *layer;

// Used for Ripple Beta
@property(nonatomic, strong) UIView *rippleView;
@property(nonatomic, getter=isDragged) BOOL dragged;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@property(nonatomic, weak) id<MDCCardCollectionCellRippleDelegate> rippleDelegate;
#pragma clang diagnostic pop
@property(nonatomic, assign) BOOL enableBetaBehavior;
@end

@implementation MDCCardCollectionCell {
  NSMutableDictionary<NSNumber *, NSNumber *> *_shadowElevations;
  NSMutableDictionary<NSNumber *, UIColor *> *_shadowColors;
  NSMutableDictionary<NSNumber *, NSNumber *> *_borderWidths;
  NSMutableDictionary<NSNumber *, UIColor *> *_borderColors;
  NSMutableDictionary<NSNumber *, UIImage *> *_images;
  NSMutableDictionary<NSNumber *, NSNumber *> *_horizontalImageAlignments;
  NSMutableDictionary<NSNumber *, NSNumber *> *_verticalImageAlignments;
  NSMutableDictionary<NSNumber *, UIColor *> *_imageTintColors;
  UIColor *_backgroundColor;
  CGPoint _lastTouch;
}

@synthesize state = _state;
@dynamic layer;

+ (Class)layerClass {
  return [MDCShapedShadowLayer class];
}

- (instancetype)initWithCoder:(NSCoder *)coder {
  self = [super initWithCoder:coder];
  if (self) {
    self.layer.cornerRadius = MDCCardCellCornerRadiusDefault;
    _interactable = MDCCardCellIsInteractableDefault;
    [self commonMDCCardCollectionCellInit];
  }
  return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    self.layer.cornerRadius = MDCCardCellCornerRadiusDefault;
    _interactable = MDCCardCellIsInteractableDefault;
    [self commonMDCCardCollectionCellInit];
  }
  return self;
}

- (void)commonMDCCardCollectionCellInit {
  if (_inkView == nil) {
    _inkView = [[MDCInkView alloc] initWithFrame:self.bounds];
    _inkView.autoresizingMask =
        (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
    _inkView.usesLegacyInkRipple = NO;
    _inkView.layer.zPosition = FLT_MAX;
    [self addSubview:_inkView];
  }

  if (_selectedImageView == nil) {
    _selectedImageView = [[UIImageView alloc] init];
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
    _shadowElevations[@(MDCCardCellStateDragged)] = @(MDCCardCellShadowElevationDragged);
  }

  if (_shadowColors == nil) {
    _shadowColors = [NSMutableDictionary dictionary];
    _shadowColors[@(MDCCardCellStateNormal)] = UIColor.blackColor;
  }

  if (_borderColors == nil) {
    _borderColors = [NSMutableDictionary dictionary];
  }

  if (_borderWidths == nil) {
    _borderWidths = [NSMutableDictionary dictionary];
  }

  if (_images == nil) {
    _images = [NSMutableDictionary dictionary];
    UIImage *circledCheck = [MDCIcons imageFor_ic_check_circle];
    circledCheck = [circledCheck imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    _images[@(MDCCardCellStateSelected)] = circledCheck;
  }

  if (_horizontalImageAlignments == nil) {
    _horizontalImageAlignments = [NSMutableDictionary dictionary];
    _horizontalImageAlignments[@(MDCCardCellStateNormal)] =
        @(MDCCardCellHorizontalImageAlignmentRight);
  }

  if (_verticalImageAlignments == nil) {
    _verticalImageAlignments = [NSMutableDictionary dictionary];
    _verticalImageAlignments[@(MDCCardCellStateNormal)] = @(MDCCardCellVerticalImageAlignmentTop);
  }

  if (_imageTintColors == nil) {
    _imageTintColors = [NSMutableDictionary dictionary];
  }

  if (_backgroundColor == nil) {
    _backgroundColor = UIColor.whiteColor;
  }

  [self updateShadowElevation];
  [self updateBorderColor];
  [self updateBorderWidth];
  [self updateShadowColor];
  [self updateImage];
  [self updateImageTintColor];
  [self updateBackgroundColor];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  if (!self.layer.shapeGenerator) {
    self.layer.shadowPath = [self boundingPath].CGPath;
  }
  [self updateImageAlignment];
}

- (void)setCornerRadius:(CGFloat)cornerRadius {
  self.layer.cornerRadius = cornerRadius;
  [self setNeedsLayout];
}

- (CGFloat)cornerRadius {
  return self.layer.cornerRadius;
}

- (void)setState:(MDCCardCellState)state animated:(BOOL)animated {
  if (self.rippleDelegate != nil) {
    // Used for Ripple Beta
    return;
  }
  switch (state) {
    case MDCCardCellStateSelected: {
      if (_state != MDCCardCellStateHighlighted) {
        if (animated) {
          [self.inkView startTouchBeganAnimationAtPoint:_lastTouch completion:nil];
        } else {
          [self.inkView cancelAllAnimationsAnimated:NO];
          [self.inkView startTouchBeganAtPoint:self.center animated:NO withCompletion:nil];
        }
      }
      break;
    }
    case MDCCardCellStateNormal: {
      [self.inkView startTouchEndAtPoint:_lastTouch animated:animated withCompletion:nil];
      break;
    }
    case MDCCardCellStateHighlighted: {
      // Note: setHighlighted: can get getting more calls with YES than NO when clicking rapidly.
      // To guard against ink never going away and darkening our card we call
      // startTouchEndedAnimationAtPoint:completion:.
      [self.inkView startTouchEndAtPoint:_lastTouch animated:animated withCompletion:nil];
      [self.inkView startTouchBeganAtPoint:_lastTouch animated:animated withCompletion:nil];
      break;
    }
    default:
      break;
  }
  _state = state;
  [self updateShadowElevation];
  [self updateBorderColor];
  [self updateBorderWidth];
  [self updateShadowColor];
  [self updateImage];
  [self updateImageAlignment];
  [self updateImageTintColor];
}

- (MDCCardCellState)state {
  return self.rippleDelegate ? [self.rippleDelegate cardCellRippleDelegateState] : _state;
}

- (void)setSelected:(BOOL)selected {
  [super setSelected:selected];
  if (self.rippleDelegate != nil) {
    [self.rippleDelegate cardCellRippleDelegateSetSelected:selected];
    return;
  }
  if (self.selectable) {
    if (selected) {
      [self setState:MDCCardCellStateSelected animated:NO];
    } else {
      [self setState:MDCCardCellStateNormal animated:NO];
    }
  }
}

- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];
  [self.rippleDelegate cardCellRippleDelegateSetHighlighted:highlighted];
}

- (void)setSelectable:(BOOL)selectable {
  _selectable = selectable;
  if (self.rippleDelegate != nil) {
    [self.rippleDelegate cardCellRippleDelegateSetSelectable:selectable];
    return;
  }
  self.selectedImageView.hidden = !selectable;
}

- (void)setDragged:(BOOL)dragged {
  _dragged = dragged;
  [self.rippleDelegate cardCellRippleDelegateSetDragged:dragged];
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
    if (!self.layer.shapeGenerator) {
      self.layer.shadowPath = [self boundingPath].CGPath;
    }
    [(MDCShadowLayer *)self.layer setElevation:elevation];
  }
}

- (void)setBorderWidth:(CGFloat)borderWidth forState:(MDCCardCellState)state {
  _borderWidths[@(state)] = @(borderWidth);

  [self updateBorderWidth];
}

- (void)updateBorderWidth {
  CGFloat borderWidth = [self borderWidthForState:self.state];
  self.layer.shapedBorderWidth = borderWidth;
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
  UIColor *borderColor = [self borderColorForState:self.state];
  self.layer.shapedBorderColor = borderColor;
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

- (void)setImage:(UIImage *)image forState:(MDCCardCellState)state {
  _images[@(state)] = image;

  [self updateImage];
}

- (void)updateImage {
  UIImage *image = [self imageForState:self.state];
  if (self.rippleDelegate != nil) {
    image = [self.rippleDelegate cardCellRippleDelegateUpdateImage:image];
  }
  [self.selectedImageView setImage:image];
  [self.selectedImageView sizeToFit];
}

- (UIImage *)imageForState:(MDCCardCellState)state {
  UIImage *image = _images[@(state)];
  if (state != MDCCardCellStateNormal && image == nil) {
    image = _images[@(MDCCardCellStateNormal)];
  }
  return image;
}

- (void)setHorizontalImageAlignment:(MDCCardCellHorizontalImageAlignment)horizontalImageAlignment
                           forState:(MDCCardCellState)state {
  _horizontalImageAlignments[@(state)] = @(horizontalImageAlignment);

  [self updateImageAlignment];
}

- (MDCCardCellHorizontalImageAlignment)horizontalImageAlignmentForState:(MDCCardCellState)state {
  NSNumber *horizontalImageAlignment = _horizontalImageAlignments[@(state)];
  if (state != MDCCardCellStateNormal && horizontalImageAlignment == nil) {
    horizontalImageAlignment = _horizontalImageAlignments[@(MDCCardCellStateNormal)];
  }
  if (horizontalImageAlignment != nil) {
    return (MDCCardCellHorizontalImageAlignment)[horizontalImageAlignment integerValue];
  }
  return MDCCardCellHorizontalImageAlignmentRight;
}

- (void)setVerticalImageAlignment:(MDCCardCellVerticalImageAlignment)verticalImageAlignment
                         forState:(MDCCardCellState)state {
  _verticalImageAlignments[@(state)] = @(verticalImageAlignment);

  [self updateImageAlignment];
}

- (MDCCardCellVerticalImageAlignment)verticalImageAlignmentForState:(MDCCardCellState)state {
  NSNumber *verticalImageAlignment = _verticalImageAlignments[@(state)];
  if (state != MDCCardCellStateNormal && verticalImageAlignment == nil) {
    verticalImageAlignment = _verticalImageAlignments[@(MDCCardCellStateNormal)];
  }
  if (verticalImageAlignment != nil) {
    return (MDCCardCellVerticalImageAlignment)[verticalImageAlignment integerValue];
  }
  return MDCCardCellVerticalImageAlignmentTop;
}

- (void)updateImageAlignment {
  MDCCardCellVerticalImageAlignment verticalImageAlignment =
      [self verticalImageAlignmentForState:self.state];
  MDCCardCellHorizontalImageAlignment horizontalImageAlignment =
      [self horizontalImageAlignmentForState:self.state];

  CGFloat yAlignment = 0;
  CGFloat xAlignment = 0;

  switch (verticalImageAlignment) {
    case MDCCardCellVerticalImageAlignmentTop:
      yAlignment =
          MDCCardCellSelectedImagePadding + CGRectGetHeight(self.selectedImageView.frame) / 2;
      break;
    case MDCCardCellVerticalImageAlignmentCenter:
      yAlignment = CGRectGetHeight(self.bounds) / 2;
      break;
    case MDCCardCellVerticalImageAlignmentBottom:
      yAlignment = CGRectGetHeight(self.bounds) - MDCCardCellSelectedImagePadding -
                   CGRectGetHeight(self.selectedImageView.frame) / 2;
      break;
  }

  switch (horizontalImageAlignment) {
    case MDCCardCellHorizontalImageAlignmentLeft:
      xAlignment =
          MDCCardCellSelectedImagePadding + CGRectGetWidth(self.selectedImageView.frame) / 2;
      break;
    case MDCCardCellHorizontalImageAlignmentCenter:
      xAlignment = CGRectGetWidth(self.bounds) / 2;
      break;
    case MDCCardCellHorizontalImageAlignmentRight:
      xAlignment = CGRectGetWidth(self.bounds) - MDCCardCellSelectedImagePadding -
                   CGRectGetWidth(self.selectedImageView.frame) / 2;
      break;
  }

  self.selectedImageView.center = CGPointMake(xAlignment, yAlignment);
}

- (void)setImageTintColor:(UIColor *)imageTintColor forState:(MDCCardCellState)state {
  _imageTintColors[@(state)] = imageTintColor;

  [self updateImageTintColor];
}

- (void)updateImageTintColor {
  UIColor *imageTintColor = [self imageTintColorForState:self.state];
  if (self.rippleDelegate != nil) {
    imageTintColor =
        [self.rippleDelegate cardCellRippleDelegateUpdateImageTintColor:imageTintColor];
  }
  [self.selectedImageView setTintColor:imageTintColor];
}

- (UIColor *)imageTintColorForState:(MDCCardCellState)state {
  UIColor *imageTintColor = _imageTintColors[@(state)];
  if (state != MDCCardCellStateNormal && imageTintColor == nil) {
    imageTintColor = _imageTintColors[@(MDCCardCellStateNormal)];
  }
  return imageTintColor;
}

- (void)tintColorDidChange {
  [super tintColorDidChange];
  [self setImageTintColor:self.tintColor forState:MDCCardCellStateNormal];
}

- (void)setShapeGenerator:(id<MDCShapeGenerating>)shapeGenerator {
  if (shapeGenerator) {
    self.layer.shadowPath = nil;
  } else {
    self.layer.shadowPath = [self boundingPath].CGPath;
  }

  self.layer.shapeGenerator = shapeGenerator;
  self.layer.shadowMaskEnabled = NO;
  [self updateBackgroundColor];
  // Original logic for configuring Ink prior to the Ripple integration.
  if (self.rippleDelegate == nil) {
    [self updateInkForShape];
  }
}

- (id)shapeGenerator {
  return self.layer.shapeGenerator;
}

- (void)updateInkForShape {
  CGRect boundingBox = CGPathGetBoundingBox(self.layer.shapeLayer.path);
  self.inkView.maxRippleRadius =
      (CGFloat)(MDCHypot(CGRectGetHeight(boundingBox), CGRectGetWidth(boundingBox)) / 2 + 10);
  self.inkView.layer.masksToBounds = NO;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
  _backgroundColor = backgroundColor;
  [self updateBackgroundColor];
}

- (UIColor *)backgroundColor {
  return _backgroundColor;
}

- (void)updateBackgroundColor {
  self.layer.shapedBackgroundColor = _backgroundColor;
}

#pragma mark - UIResponder

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
  UIView *result = [super hitTest:point withEvent:event];
  if (!_interactable && (result == self.contentView || result == self)) {
    return nil;
  }
  return result;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [self.rippleDelegate cardCellRippleDelegateTouchesBegan:touches withEvent:event];
  [super touchesBegan:touches withEvent:event];
  if (self.rippleDelegate == nil) {
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInView:self];
    _lastTouch = location;
    if (!self.selected || !self.selectable) {
      [self setState:MDCCardCellStateHighlighted animated:YES];
    }
  }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  // The ripple invocation must come before touchesMoved of the super, otherwise the setHighlighted
  // of the UICollectionViewCell will be triggered before the ripple identifies that the highlighted
  // was trigerred from a long press entering the view and shouldn't invoke a ripple.
  [self.rippleDelegate cardCellRippleDelegateTouchesMoved:touches withEvent:event];
  [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  [self.rippleDelegate cardCellRippleDelegateTouchesEnded:touches withEvent:event];
  [super touchesEnded:touches withEvent:event];
  if (self.rippleDelegate == nil) {
    if (!self.selected || !self.selectable) {
      [self setState:MDCCardCellStateNormal animated:YES];
    }
  }
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [self.rippleDelegate cardCellRippleDelegateTouchesCancelled:touches withEvent:event];
  [super touchesCancelled:touches withEvent:event];
  if (self.rippleDelegate == nil) {
    if (!self.selected || !self.selectable) {
      [self setState:MDCCardCellStateNormal animated:YES];
    }
  }
}

- (void)setEnableBetaBehavior:(BOOL)enableBetaBehavior {
  if (enableBetaBehavior == _enableBetaBehavior) {
    return;
  }
  _enableBetaBehavior = enableBetaBehavior;
  // TODO: Remove this performSelector code once Ripple is no longer in Beta.
  SEL cardCellRippleEnableBetaBehavior = NSSelectorFromString(@"cardCellRippleEnableBetaBehavior:");
  if ([self respondsToSelector:cardCellRippleEnableBetaBehavior]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    NSNumber *enabled = [NSNumber numberWithBool:enableBetaBehavior];
    [self performSelector:cardCellRippleEnableBetaBehavior withObject:enabled];
#pragma clang diagnostic pop
  }
}
@end
