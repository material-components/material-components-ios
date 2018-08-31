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

#import "MDCBaseCell.h"

#import "MaterialInk.h"
#import "MaterialShadowLayer.h"

static NSString *const MDCListBaseCellInkViewKey = @"MDCListBaseCellInkViewKey";
static NSString *const MDCListBaseCellCurrentInkColorKey = @"MDCListBaseCellCurrentInkColorKey";
static NSString *const MDCListBaseCellCurrentElevationKey = @"MDCListBaseCellCurrentElevationKey";

@interface MDCBaseCell ()

@property (nonatomic, assign) CGPoint lastTouch;
@property (strong, nonatomic, nonnull) MDCInkView *inkView;

@end

@implementation MDCBaseCell

#pragma mark Object Lifecycle

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCBaseCellInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    MDCInkView *decodedInkView = [aDecoder decodeObjectOfClass:[MDCInkView class]
                                                        forKey:MDCListBaseCellInkViewKey];
    if (decodedInkView) {
      self.inkView = decodedInkView;
    }
    UIColor *decodedColor = [aDecoder decodeObjectOfClass:[UIColor class]
                                                   forKey:MDCListBaseCellCurrentInkColorKey];
    if (decodedColor) {
      self.inkView.inkColor = decodedColor;
    }
    NSNumber *decodedElevation = [aDecoder decodeObjectOfClass:[NSNumber class]
                                                        forKey:MDCListBaseCellCurrentElevationKey];
    if (decodedElevation) {
      self.elevation = (CGFloat)[decodedElevation doubleValue];
    }
    [self commonMDCBaseCellInit];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
  [super encodeWithCoder:coder];
  [coder encodeObject:_inkView forKey:MDCListBaseCellInkViewKey];
  [coder encodeObject:_inkView.inkColor forKey:MDCListBaseCellCurrentInkColorKey];
  [coder encodeObject:[NSNumber numberWithDouble:(double)_elevation]
               forKey:MDCListBaseCellCurrentInkColorKey];
}

#pragma mark Setup

- (void)commonMDCBaseCellInit {
  if (!self.inkView) {
    self.inkView = [[MDCInkView alloc] initWithFrame:self.bounds];
  }
  _inkView.usesLegacyInkRipple = NO;
  [self addSubview:_inkView];
}

#pragma mark Ink

- (void)startInk {
  [self.inkView startTouchBeganAtPoint:_lastTouch
                              animated:YES
                        withCompletion:nil];
}

- (void)endInk {
  [self.inkView startTouchEndAtPoint:_lastTouch
                            animated:YES
                      withCompletion:nil];
}

#pragma mark Shadow

- (UIBezierPath *)boundingPath {
  return [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.layer.cornerRadius];
}

- (void)updateShadowElevation {
  self.layer.shadowPath = [self boundingPath].CGPath;
  [self.shadowLayer setElevation:self.elevation];
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  self.lastTouch = location;
  [self startInk];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
  [super touchesEnded:touches withEvent:event];
  [self endInk];
}

#pragma mark UIView Overrides

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

- (void)layoutSubviews {
  [super layoutSubviews];
  [self updateShadowElevation];
  self.inkView.frame = self.bounds;
}

#pragma mark UICollectionViewCell Overrides

- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];
  if (!highlighted) {
    [self endInk];
  }
}

- (void)prepareForReuse {
  [super prepareForReuse];
  self.elevation = 0;
  [self.inkView cancelAllAnimationsAnimated:NO];
}

#pragma mark Accessors

- (void)setElevation:(MDCShadowElevation)elevation {
  if (elevation == _elevation) {
    return;
  }
  _elevation = elevation;
  [self updateShadowElevation];
}

- (void)setInkColor:(UIColor *)inkColor {
  if ([self.inkColor isEqual:inkColor]) {
    return;
  }
  self.inkView.inkColor = inkColor;
}

- (UIColor *)inkColor {
  return self.inkView.inkColor;
}

- (MDCShadowLayer *)shadowLayer {
  if ([self.layer isMemberOfClass:[MDCShadowLayer class]]) {
    return (MDCShadowLayer *)self.layer;
  }
  return nil;
}

@end
