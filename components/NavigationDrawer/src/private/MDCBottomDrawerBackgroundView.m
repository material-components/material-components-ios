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

#import "MDCBottomDrawerBackgroundView.h"

static NSString *const kBackgroundColorKeyPath = @"backgroundColor";
static NSString *const kFrameKeyPath = @"frame";

@implementation MDCBottomDrawerBackgroundView

- (void)dealloc {
  [self removeObservers];
}

- (void)setTrackedView:(UIView *)trackedView {
  if (trackedView) {
    [self addObservers];
  } else {
    [self removeObservers];
  }
  _trackedView = trackedView;
}

- (void)addObservers {
  [self.trackedView addObserver:self forKeyPath:kBackgroundColorKeyPath
                        options:NSKeyValueObservingOptionNew context:nil];
  [self.trackedView addObserver:self forKeyPath:kFrameKeyPath options:NSKeyValueObservingOptionNew
                        context:nil];
}

- (void)removeObservers {
  @try {
    [self.trackedView removeObserver:self forKeyPath:kBackgroundColorKeyPath];
    [self.trackedView removeObserver:self forKeyPath:kFrameKeyPath];
  }
  @catch (NSException *exception) {
    if (exception) {
      // No need to do anything if there are no observers.
    }
  }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary<NSKeyValueChangeKey,id> *)change
                       context:(void *)context {
  if ([keyPath isEqualToString:kBackgroundColorKeyPath]) {
    self.backgroundColor = change[NSKeyValueChangeNewKey];
  } else if ([keyPath isEqualToString:kFrameKeyPath]) {
    self.frame = [change[NSKeyValueChangeNewKey] CGRectValue];
  }
}

@end
