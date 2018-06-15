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

#import "ManualLayoutListBaseCell2.h"

#import "MaterialInk.h"
#import "MaterialShadowLayer.h"
#import "MaterialMath.h"

static NSString *const MDCListBaseCellInkViewKey = @"MDCListBaseCellInkViewKey";
static NSString *const MDCListBaseCellShadowColorsKey = @"MDCListBaseCellShadowColorsKey";
static NSString *const MDCListBaseCellShadowElevationsKey = @"MDCListBaseCellShadowElevationsKey";

static const CGFloat MDCListBaseCellShadowElevationNormal = 0.f;
static const CGFloat MDCListBaseCellShadowElevationSelected = 0.f;
static const CGFloat MDCListBaseCellShadowElevationHighlighted = 0.f;

@interface ManualLayoutListBaseCell2 ()

@property (nonatomic, assign) CGPoint lastTouch;
@property (strong, nonatomic, nonnull) MDCInkView *inkView;
@property (strong, nonatomic, nonnull) NSMutableDictionary<NSNumber *, NSNumber *> *shadowElevations;
@property (strong, nonatomic, nonnull) NSMutableDictionary<NSNumber *, UIColor *> *shadowColors;

@end

@implementation ManualLayoutListBaseCell2

#pragma mark Object Lifecycle

-(instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self baseManualLayoutListBaseCell2Init];
    return self;
  }
  return nil;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    _shadowElevations = [aDecoder decodeObjectOfClass:[NSMutableDictionary class]
                                               forKey:MDCListBaseCellShadowElevationsKey];
    _shadowColors = [aDecoder decodeObjectOfClass:[NSMutableDictionary class]
                                           forKey:MDCListBaseCellShadowColorsKey];
    _inkView = [aDecoder decodeObjectOfClass:[MDCInkView class]
                                      forKey:MDCListBaseCellInkViewKey];
    [self baseManualLayoutListBaseCell2Init];
    return self;
  }
  return nil;
}

- (void)encodeWithCoder:(NSCoder *)coder {
  [super encodeWithCoder:coder];
  [coder encodeObject:_shadowElevations forKey:MDCListBaseCellShadowElevationsKey];
  [coder encodeObject:_shadowColors forKey:MDCListBaseCellShadowColorsKey];
  [coder encodeObject:_inkView forKey:MDCListBaseCellInkViewKey];
}

-(instancetype)init {
  self = [super init];
  if (self) {
    [self baseManualLayoutListBaseCell2Init];
    return self;
  }
  return nil;
}

#pragma mark Setup

- (void)baseManualLayoutListBaseCell2Init {
  [self setUpInkView];
  [self setUpShadows];
}

- (void)setUpInkView {
  if (!self.inkView) {
    self.inkView = [[MDCInkView alloc] initWithFrame:self.bounds];
  }
  _inkView.usesLegacyInkRipple = NO;
  [self addSubview:_inkView];
}

- (void)setUpShadows {
  if (self.shadowElevations == nil) {
    self.shadowElevations = [NSMutableDictionary dictionary];
    self.shadowElevations[@(MDCListBaseCellStateNormal)] = @(MDCListBaseCellShadowElevationNormal);
    self.shadowElevations[@(MDCListBaseCellStateHighlighted)] = @(MDCListBaseCellShadowElevationHighlighted);
    self.shadowElevations[@(MDCListBaseCellStateSelected)] = @(MDCListBaseCellShadowElevationSelected);
  }

  if (self.shadowColors == nil) {
    self.shadowColors = [NSMutableDictionary dictionary];
    self.shadowColors[@(MDCListBaseCellStateNormal)] = UIColor.blackColor;
    self.shadowColors[@(MDCListBaseCellStateHighlighted)] = UIColor.blackColor;
    self.shadowColors[@(MDCListBaseCellStateSelected)] = UIColor.blackColor;
  }
}

- (MDCListBaseCellState)currentState {
  if (self.selected) {
    return MDCListBaseCellStateSelected;
  } else if (self.highlighted) {
    return MDCListBaseCellStateHighlighted;
  } else {
    return MDCListBaseCellStateNormal;
  }
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  self.lastTouch = location;
}

#pragma mark UIView Overrides

+(Class)layerClass {
  return [MDCShadowLayer class];
}

#pragma mark UICollectionViewCell Overrides

- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];
  [self updateShadowElevation];
  [self updateShadowColor];
  [self performInkAnimation];
 }

-(void)setSelected:(BOOL)selected {
  [super setSelected:selected];
  [self updateShadowElevation];
  [self updateShadowColor];
}

-(void)layoutSubviews {
  [super layoutSubviews];
  [self updateShadowElevation];
  [self updateShadowColor];
}

#pragma mark Ink

- (void)performInkAnimation {
  if (self.highlighted) {
    [self.inkView startTouchBeganAtPoint:_lastTouch
                                animated:YES
                          withCompletion:nil];
  } else {
    [self.inkView startTouchEndAtPoint:_lastTouch
                              animated:YES
                        withCompletion:nil];
  }
}

#pragma mark Shadow

- (UIBezierPath *)boundingPath {
  return [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.layer.cornerRadius];
}

- (void)setShadowElevation:(MDCShadowElevation)shadowElevation forState:(MDCListBaseCellState)state {
  _shadowElevations[@(state)] = @(shadowElevation);
  [self updateShadowElevation];
}

- (MDCShadowElevation)shadowElevationForState:(MDCListBaseCellState)state {
  NSNumber *elevation = _shadowElevations[@(state)];
  if (state != MDCListBaseCellStateNormal && elevation == nil) {
    elevation = _shadowElevations[@(MDCListBaseCellShadowElevationNormal)];
  }
  if (elevation != nil) {
    return (CGFloat)[elevation doubleValue];
  }
  return 0;
}

- (void)updateShadowElevation {
  CGFloat elevation = [self shadowElevationForState:self.currentState];
  self.layer.shadowPath = [self boundingPath].CGPath;
  [(MDCShadowLayer *)self.layer setElevation:elevation];
}

- (void)setShadowColor:(UIColor *)shadowColor forState:(MDCListBaseCellState)state {
  _shadowColors[@(state)] = shadowColor;
  [self updateShadowColor];
}

- (UIColor *)shadowColorForState:(MDCListBaseCellState)state {
  UIColor *shadowColor = _shadowColors[@(state)];
  if (state != MDCListBaseCellStateNormal && shadowColor == nil) {
    shadowColor = _shadowColors[@(MDCListBaseCellStateNormal)];
  }
  if (shadowColor != nil) {
    return shadowColor;
  }
  return [UIColor blackColor];
}

- (void)updateShadowColor {
  CGColorRef shadowColor = [self shadowColorForState:self.currentState].CGColor;
  self.layer.shadowColor = shadowColor;
}

@end
