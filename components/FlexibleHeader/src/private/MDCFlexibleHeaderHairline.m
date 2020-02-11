// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCFlexibleHeaderHairline.h"

@protocol MDCFlexibleHeaderHairlineViewDelegate;

__attribute__((objc_subclassing_restricted)) @interface MDCFlexibleHeaderHairlineView : UIView
@property(nonatomic, weak) id<MDCFlexibleHeaderHairlineViewDelegate> delegate;
@end

@protocol MDCFlexibleHeaderHairlineViewDelegate <NSObject>
@required

// Informs the receiver that the hairline view moved to a new window.
- (void)hairlineViewDidMoveToWindow:(MDCFlexibleHeaderHairlineView *)hairlineView;

@end

#pragma mark -

@interface MDCFlexibleHeaderHairline () <MDCFlexibleHeaderHairlineViewDelegate>

// The view that represents the bottom hairline when showsHairline is enabled.
@property(nonatomic, strong) MDCFlexibleHeaderHairlineView *hairlineView;

@end

#pragma mark -

@implementation MDCFlexibleHeaderHairline

- (nonnull instancetype)initWithContainerView:(nonnull UIView *)containerView {
  self = [super init];
  if (self) {
    _containerView = containerView;
    _color = [UIColor blackColor];
    _hidden = YES;
  }
  return self;
}

#pragma mark - Public

- (void)setColor:(UIColor *)color {
  _color = color;

  _hairlineView.backgroundColor = _color;
}

- (void)setHidden:(BOOL)hidden {
  if (_hidden == hidden) {
    return;
  }
  _hidden = hidden;

  if (!_hidden && !_hairlineView) {
    _hairlineView = [[MDCFlexibleHeaderHairlineView alloc] init];
    _hairlineView.delegate = self;
    _hairlineView.backgroundColor = self.color;
    _hairlineView.autoresizingMask =
        (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin);

    [self.containerView addSubview:_hairlineView];
    _hairlineView.frame = [self frame];
  }

  _hairlineView.hidden = _hidden;
}

#pragma mark - MDCFlexibleHeaderHairlineViewDelegate

- (void)hairlineViewDidMoveToWindow:(MDCFlexibleHeaderHairlineView *)hairlineView {
  // When we move to a new window it's possible that the window's screen scale has changed, so we
  // re-calculate the frame of the hairline with the new screen scale in mind.
  _hairlineView.frame = [self frame];
}

#pragma mark - Private

- (CGRect)frame {
  CGRect bounds = self.containerView.bounds;
  CGFloat containerScreenScale = self.containerView.window.screen.scale;
  BOOL hasValidScreenScale = containerScreenScale > 0;
  CGFloat hairlineHeight = hasValidScreenScale ? ((CGFloat)1.0 / containerScreenScale) : 1;
  return CGRectMake(0, CGRectGetHeight(bounds) - hairlineHeight, CGRectGetWidth(bounds),
                    hairlineHeight);
}

@end

#pragma mark -

@implementation MDCFlexibleHeaderHairlineView

- (void)didMoveToWindow {
  [super didMoveToWindow];

  [self.delegate hairlineViewDidMoveToWindow:self];
}

@end
