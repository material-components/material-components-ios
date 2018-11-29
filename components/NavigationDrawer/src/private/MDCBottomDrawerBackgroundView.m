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
static NSString *const kPreferredContentSizeKeyPath = @"preferredContentSize";

@implementation MDCBottomDrawerBackgroundView

- (void)dealloc {
  [self removeObservers];
}

- (void)setTrackedViewController:(UIViewController *)trackedViewController {
  if (trackedViewController) {
    [self addObservers];
  } else {
    [self removeObservers];
  }
  _trackedViewController = trackedViewController;
}

- (void)addObservers {
  [self.trackedViewController.view addObserver:self forKeyPath:kBackgroundColorKeyPath
                        options:NSKeyValueObservingOptionNew context:nil];
  [self.trackedViewController addObserver:self forKeyPath:kPreferredContentSizeKeyPath
                                  options:NSKeyValueObservingOptionNew context:nil];
}

- (void)removeObservers {
  @try {
    [self.trackedViewController.view removeObserver:self forKeyPath:kBackgroundColorKeyPath];
    [self.trackedViewController removeObserver:self forKeyPath:kPreferredContentSizeKeyPath];
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
  } else if ([keyPath isEqualToString:kPreferredContentSizeKeyPath]) {
    CGSize newSize = [change[NSKeyValueChangeNewKey] CGSizeValue];
    CGRect newFrame = CGRectStandardize(self.frame);
    newFrame.size = newSize;
    self.frame = newFrame;
  }
}

@end
