// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCOverlayAnimationObserver.h"

@interface MDCOverlayAnimationObserver () {
 @public
  /** Whether or not the observer has been primed and should report a runloop end event. */
  BOOL _primed;  // Raw ivar to allow direct access from the runloop observer callback.
}

/**
 The runloop observer being used on the current runloop.
 */
@property(nonatomic, strong) __attribute__((NSObject)) CFRunLoopObserverRef observer;

/**
 Called by the runloop observer C function.
 */
- (void)handleObserverFired;

@end

#pragma mark - Runloop Observer

static void runloopObserverCallback(__unused CFRunLoopObserverRef observer,
                                    __unused CFRunLoopActivity activity,
                                    void *info) {
  MDCOverlayAnimationObserver *animationObserver = (__bridge MDCOverlayAnimationObserver *)info;
  if (animationObserver != NULL && animationObserver->_primed) {
    [animationObserver handleObserverFired];
  }
}

@implementation MDCOverlayAnimationObserver

- (instancetype)init {
  self = [super init];
  if (self != nil) {
    [self installRunloopObserver];
  }
  return self;
}

- (void)dealloc {
  [self uninstallRunloopObserver];
}

- (void)messageDelegateOnNextRunloop {
  _primed = YES;
}

#pragma mark - Runloop Observer

- (void)installRunloopObserver {
  if (self.observer != NULL) {
    return;
  }

  CFRunLoopRef runloop = CFRunLoopGetMain();
  CFRunLoopObserverContext context = {0, (__bridge void *)(self), NULL, NULL, NULL};

  CFRunLoopObserverRef observer =
      CFRunLoopObserverCreate(kCFAllocatorDefault, kCFRunLoopBeforeWaiting,
                              YES,  // Repeats
                              0,    // Order. Lower == earlier.
                              &runloopObserverCallback, &context);

  if (observer != NULL) {
    // Schedule the observer and hold on to it.
    self.observer = observer;
    CFRunLoopAddObserver(runloop, observer, kCFRunLoopCommonModes);

    // Clean up.
    CFRelease(observer);
  }
}

- (void)uninstallRunloopObserver {
  if (self.observer == NULL) {
    return;
  }

  CFRunLoopRef runloop = CFRunLoopGetMain();
  CFRunLoopRemoveObserver(runloop, self.observer, kCFRunLoopCommonModes);
  self.observer = nil;
}

- (void)handleObserverFired {
  [self.delegate animationObserverDidEndRunloop:self];
  _primed = NO;
}

@end
