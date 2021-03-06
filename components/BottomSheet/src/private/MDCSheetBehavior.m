// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCSheetBehavior.h"

/**
 These values were arrived at empirically (through trial and error) to either emphasize or diminish
 the bounce effect that UIKit dynamics provides.
 */
static const CGFloat kSimulateScrollViewBounceFrequency = 3.5f;
static const CGFloat kSimulateScrollViewBounceDamping = 0.4f;
static const CGFloat kDisableScrollViewBounceFrequency = 5.5f;
static const CGFloat kDisableScrollViewBounceDamping = 1.0f;

@interface MDCSheetBehavior ()
@property(nonatomic) UIAttachmentBehavior *attachmentBehavior;
@property(nonatomic) UIDynamicItemBehavior *itemBehavior;
@property(nonatomic) id<UIDynamicItem> item;
@end

@implementation MDCSheetBehavior

- (instancetype)initWithItem:(id<UIDynamicItem>)item
    simulateScrollViewBounce:(BOOL)simulateScrollViewBounce {
  self = [super init];
  if (self) {
    _item = item;
    _attachmentBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.item
                                                    attachedToAnchor:CGPointZero];
    if (simulateScrollViewBounce) {
      _attachmentBehavior.frequency = kSimulateScrollViewBounceFrequency;
      _attachmentBehavior.damping = kSimulateScrollViewBounceDamping;
    } else {
      _attachmentBehavior.frequency = kDisableScrollViewBounceFrequency;
      _attachmentBehavior.damping = kDisableScrollViewBounceDamping;
    }
    _attachmentBehavior.length = 0;

    // Anchor movement along the y-axis.
    __weak MDCSheetBehavior *weakSelf = self;
    _attachmentBehavior.action = ^{
      MDCSheetBehavior *strongSelf = weakSelf;
      CGPoint center = item.center;
      center.x = strongSelf->_targetPoint.x;
      item.center = center;
    };
    [self addChildBehavior:_attachmentBehavior];

    _itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[ self.item ]];
    _itemBehavior.density = 100;
    _itemBehavior.resistance = 10;
    [self addChildBehavior:_itemBehavior];
  }
  return self;
}

- (void)setTargetPoint:(CGPoint)targetPoint {
  _targetPoint = targetPoint;
  self.attachmentBehavior.anchorPoint = targetPoint;
}

- (void)setVelocity:(CGPoint)velocity {
  _velocity = velocity;
  CGPoint currentVelocity = [self.itemBehavior linearVelocityForItem:self.item];
  CGPoint velocityDelta =
      CGPointMake(velocity.x - currentVelocity.x, velocity.y - currentVelocity.y);
  [self.itemBehavior addLinearVelocity:velocityDelta forItem:self.item];
}

@end
