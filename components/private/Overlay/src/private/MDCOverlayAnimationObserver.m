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

static void runloopObserverCallback(CFRunLoopObserverRef observer,
                                    CFRunLoopActivity activity,
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
