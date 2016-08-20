/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCCollectionViewCell+Ink.h"

#import <objc/runtime.h>

@implementation MDCCollectionViewCell (Ink)

@dynamic inkView;

- (MDCInkView *)inkView {
  MDCInkView *ink = objc_getAssociatedObject(self, _cmd);
  if (!ink) {
    ink = [[MDCInkView alloc] initWithFrame:self.bounds];
    [self addSubview:ink];
    objc_setAssociatedObject(self, @selector(inkView), ink, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
  } else if ([ink superview] == nil) {
    // add the inkView back in if it was previously removed.
    // See `prepareForReuse` for when this subview could have been removed.
    [self addSubview:ink];
  }
  return ink;
}

- (void)setInkView:(MDCInkView *)inkView {
  if (self.inkView) {
    [self.inkView removeFromSuperview];
  }
  [self addSubview:inkView];
  objc_setAssociatedObject(self, @selector(inkView), inkView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)prepareForReuse {
  [super prepareForReuse];
  if (self.inkView) {
    [self.inkView removeFromSuperview];
  }
}

@end
