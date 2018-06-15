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

#import "AutoLayoutListBaseCell1.h"

#import <MDFInternationalization/MDFInternationalization.h>

#import "MaterialInk.h"
#import "MaterialTypography.h"

@interface AutoLayoutListBaseCell1 ()

@property (nonatomic, assign) CGPoint lastTouch;
@property (strong, nonatomic) MDCInkView *inkView;
@property (strong, nonatomic) NSLayoutConstraint *cellWidthConstraint;
@property (strong, nonatomic) NSLayoutConstraint *cellHeightConstraint;

@end

@implementation AutoLayoutListBaseCell1

#pragma mark Object Lifecycle

- (instancetype)init {
  self = [super init];
  if (self) {
    [self baseCommonInit];
    return self;
  }
  return nil;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self baseCommonInit];
    return self;
  }
  return nil;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self baseCommonInit];
    return self;
  }
  return nil;

}

#pragma mark Setup

- (void)baseCommonInit {
  self.contentView.translatesAutoresizingMaskIntoConstraints = NO;
  [self initializeInkView];
  [self setUpContentViewConstraints];
}

- (void)initializeInkView {
  self.inkView = [[MDCInkView alloc] initWithFrame:self.bounds];
  _inkView.usesLegacyInkRipple = NO;
  [self addSubview:_inkView];
}

- (void)setUpContentViewConstraints {
  self.cellWidthConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                          attribute:NSLayoutAttributeWidth
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:nil
                                                          attribute:NSLayoutAttributeNotAnAttribute
                                                         multiplier:1
                                                           constant:0];

  NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                          attribute:NSLayoutAttributeBottom
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeBottom
                                                         multiplier:1
                                                         constant:0];
  bottomConstraint.active = YES;
  bottomConstraint.priority = UILayoutPriorityDefaultHigh;
  NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                                                          attribute:NSLayoutAttributeTop
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self
                                                          attribute:NSLayoutAttributeTop
                                                         multiplier:1
                                                           constant:0];
  topConstraint.active = YES;
  topConstraint.priority = UILayoutPriorityDefaultHigh;
  NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:self.contentView
                               attribute:NSLayoutAttributeLeading
                               relatedBy:NSLayoutRelationEqual
                                  toItem:self
                               attribute:NSLayoutAttributeLeading
                              multiplier:1
                                constant:0];
  leadingConstraint.active = YES;
  leadingConstraint.priority = UILayoutPriorityDefaultHigh;
}

#pragma mark UICollectionViewCell

- (void)setHighlighted:(BOOL)highlighted {
  [super setHighlighted:highlighted];
  if (highlighted) {
    [_inkView startTouchBeganAnimationAtPoint:_lastTouch completion:nil];
  } else {
    [_inkView startTouchEndedAnimationAtPoint:_lastTouch completion:nil];
  }
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  [super touchesBegan:touches withEvent:event];

  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  self.lastTouch = location;
}

#pragma mark - Accessors

-(void)setCellWidth:(CGFloat)cellWidth {
  if (_cellWidth == cellWidth) {
    return;
  }
  _cellWidth = cellWidth;
  _cellWidthConstraint.constant = _cellWidth;
  _cellWidthConstraint.active = YES;
}

@end
