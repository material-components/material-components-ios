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

#import "MDCBaseCollectionViewCell.h"

#import "MaterialInk.h"
#import "MaterialShadowLayer.h"
#import "MaterialMath.h"

static NSString *const MDCListBaseCellInkViewKey = @"MDCListBaseCellInkViewKey";

@interface MDCBaseCollectionViewCell ()

@property (nonatomic, assign) CGPoint lastTouch;
@property (strong, nonatomic, nonnull) MDCInkView *inkView;

@end

@implementation MDCBaseCollectionViewCell

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
    _inkView = [aDecoder decodeObjectOfClass:[MDCInkView class]
                                      forKey:MDCListBaseCellInkViewKey];
    [self baseManualLayoutListBaseCell2Init];
    return self;
  }
  return nil;
}

- (void)encodeWithCoder:(NSCoder *)coder {
  [super encodeWithCoder:coder];
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
}

- (void)setUpInkView {
  if (!self.inkView) {
    self.inkView = [[MDCInkView alloc] initWithFrame:self.bounds];
  }
  _inkView.usesLegacyInkRipple = NO;
  [self addSubview:_inkView];
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
  if (highlighted) {
    [self.inkView startTouchBeganAtPoint:_lastTouch
                                animated:YES
                          withCompletion:nil];
  } else {
    [self.inkView startTouchEndAtPoint:_lastTouch
                              animated:YES
                        withCompletion:nil];
  }
}

-(void)layoutSubviews {
  [super layoutSubviews];
  [self updateShadowElevation];
  self.inkView.frame = self.bounds;
}

#pragma mark Accessors

-(void)setElevation:(MDCShadowElevation)elevation {
  if (elevation == _elevation) {
    return;
  }
  _elevation = elevation;
  [self updateShadowElevation];
}

#pragma mark Shadow

- (UIBezierPath *)boundingPath {
  return [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:self.layer.cornerRadius];
}

- (void)updateShadowElevation {
  self.layer.shadowPath = [self boundingPath].CGPath;
  [(MDCShadowLayer *)self.layer setElevation:self.elevation];
}

@end
