/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCFloatingButton+Animation.h"

static const CGFloat kMDCFloatingButtonAnimationDuration = 0.18F;

@implementation MDCFloatingButton (Animation)

- (void)grow:(BOOL)animated completion:(void (^_Nullable)(void))completion {
  void (^growActions)() = ^{
    self.transform = CGAffineTransformIdentity;
  };
  if (animated) {
    [UIView animateWithDuration:kMDCFloatingButtonAnimationDuration
                     animations:^{
                       growActions();
                     }
                     completion:^(BOOL finished) {
                       if (completion) {
                         completion();
                       }
                     }];
  } else {
    growActions();
    if (completion) {
      completion();
    }
  }
}

- (void)shrink:(BOOL)animated completion:(void (^_Nullable)(void))completion {
  void (^shrinkActions)() = ^{
    self.transform = CGAffineTransformMakeScale(0.0001F, 0.0001F);
  };
  if (animated) {
    [UIView animateWithDuration:kMDCFloatingButtonAnimationDuration
                     animations:^{
                       shrinkActions();
                     }
                     completion:^(BOOL finished) {
                       if (completion) {
                         completion();
                       }
                     }];
  } else {
    shrinkActions();
    if (completion) {
      completion();
    }
  }
}

#pragma mark - UIView overrides to handle non-identity transforms

- (CGRect)frame {
  CGRect frame = [super frame];
  if (CGAffineTransformEqualToTransform(self.transform, CGAffineTransformIdentity)) {
    return frame;
  }
  CGFloat width = CGRectGetWidth(self.bounds);
  CGFloat height = CGRectGetHeight(self.bounds);
  return CGRectMake(self.center.x - (width / 2.F), self.center.y - (height / 2.F),
                    CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));
}

- (void)setFrame:(CGRect)frame {
  if (CGAffineTransformEqualToTransform(self.transform, CGAffineTransformIdentity)) {
    [super setFrame:frame];
  } else {
    CGPoint center = CGPointMake(CGRectGetMidX(frame), CGRectGetMidY(frame));
    CGSize boundsSize = CGSizeMake(CGRectGetWidth(frame), CGRectGetHeight(frame));
    self.center = center;
    self.bounds = CGRectMake(CGRectGetMinX(self.bounds), CGRectGetMinY(self.bounds),
                             boundsSize.width, boundsSize.height);
  }
}

@end
