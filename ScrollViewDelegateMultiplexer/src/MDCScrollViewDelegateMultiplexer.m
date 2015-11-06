/*
 Copyright 2015-present Google Inc. All Rights Reserved.

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

#import "MDCScrollViewDelegateMultiplexer.h"

#import <objc/runtime.h>

@implementation MDCScrollViewDelegateMultiplexer {
  NSPointerArray *_observingDelegates;
}

- (instancetype)init {
  self = [super init];
  if (self) {
    NSPointerFunctionsOptions options =
        (NSPointerFunctionsWeakMemory | NSPointerFunctionsObjectPointerPersonality);
    _observingDelegates = [NSPointerArray pointerArrayWithOptions:options];
  }
  return self;
}

- (void)addObservingDelegate:(id<UIScrollViewDelegate>)delegate {
  [_observingDelegates addPointer:(__bridge void *)(delegate)];
}

- (void)removeObservingDelegate:(id<UIScrollViewDelegate>)delegate {
  for (NSUInteger i = 0; i < _observingDelegates.count; i++) {
    if ([_observingDelegates pointerAtIndex:i] == (__bridge void *)(delegate)) {
      [_observingDelegates removePointerAtIndex:i];
    }
  }
}

- (void)setCombiner:(id<MDCScrollViewDelegateCombining>)combiner {
  _combiner = combiner;
}

#pragma mark - NSObject

- (BOOL)shouldForwardSelector:(SEL)selector {
  // Check optional methods.
  struct objc_method_description description =
      protocol_getMethodDescription(@protocol(UIScrollViewDelegate), selector, NO, YES);
  return (description.name != NULL && description.types != NULL);
}

- (BOOL)respondsToSelector:(SEL)aSelector {
  if ([super respondsToSelector:aSelector]) {
    return YES;
  } else if ([self shouldForwardSelector:aSelector]) {
    for (id delegate in _observingDelegates) {
      if ([delegate respondsToSelector:aSelector]) {
        return YES;
      }
    }
  }
  return NO;
}

#pragma mark - UIScrollViewDelegate Forwarding

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  for (id<UIScrollViewDelegate> delegate in _observingDelegates) {
    if ([delegate respondsToSelector:_cmd]) {
      [delegate scrollViewDidScroll:scrollView];
    }
  }
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
  for (id<UIScrollViewDelegate> delegate in _observingDelegates) {
    if ([delegate respondsToSelector:_cmd]) {
      [delegate scrollViewDidZoom:scrollView];
    }
  }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
  for (id<UIScrollViewDelegate> delegate in _observingDelegates) {
    if ([delegate respondsToSelector:_cmd]) {
      [delegate scrollViewWillBeginDragging:scrollView];
    }
  }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset {
  for (id<UIScrollViewDelegate> delegate in _observingDelegates) {
    if ([delegate respondsToSelector:_cmd]) {
      [delegate scrollViewWillEndDragging:scrollView
                             withVelocity:velocity
                      targetContentOffset:targetContentOffset];
    }
  }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
  for (id<UIScrollViewDelegate> delegate in _observingDelegates) {
    if ([delegate respondsToSelector:_cmd]) {
      [delegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
    }
  }
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
  for (id<UIScrollViewDelegate> delegate in _observingDelegates) {
    if ([delegate respondsToSelector:_cmd]) {
      [delegate scrollViewWillBeginDecelerating:scrollView];
    }
  }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  for (id<UIScrollViewDelegate> delegate in _observingDelegates) {
    if ([delegate respondsToSelector:_cmd]) {
      [delegate scrollViewDidEndDecelerating:scrollView];
    }
  }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
  for (id<UIScrollViewDelegate> delegate in _observingDelegates) {
    if ([delegate respondsToSelector:_cmd]) {
      [delegate scrollViewDidEndScrollingAnimation:scrollView];
    }
  }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
  // NSPointerArray here to allow nil results from -viewForZoomingInScrollView.
  NSPointerArray *results =
      [NSPointerArray pointerArrayWithOptions:(NSPointerFunctionsStrongMemory |
                                               NSPointerFunctionsObjectPointerPersonality)];
  NSMutableArray *respondingObservers = [NSMutableArray array];

  // Execute this method for every responding observer.
  for (id<UIScrollViewDelegate> delegate in _observingDelegates) {
    if ([delegate respondsToSelector:_cmd]) {
      UIView *result = [delegate viewForZoomingInScrollView:scrollView];
      [results addPointer:(__bridge void *)(result)];
      [respondingObservers addObject:delegate];
    }
  }

  if ([_combiner respondsToSelector:@selector(scrollViewDelegateMultiplexer:
                                              viewForZoomingWithResults:
                                              fromRespondingObservers:)]) {
    return [_combiner scrollViewDelegateMultiplexer:(id)self
                          viewForZoomingWithResults:results
                            fromRespondingObservers:respondingObservers];
  } else if (results.count > 0) {

#if DEBUG
    NSHashTable *hash = [NSHashTable weakObjectsHashTable];
    for (UIView *view in results) {
      [hash addObject:view ? view : [NSNull null]];
    }
    NSAssert(hash.count == 1,
             @"-viewForZoomingInScrollView returns different results from multiple observers."
             " Use the combiner protocol MDCScrollViewDelegateCombining to select the appropriate"
             " observer return value for this method.");
#endif

    return [results pointerAtIndex:0];
  }

  return nil;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView
                          withView:(UIView *)view {
  for (id<UIScrollViewDelegate> delegate in _observingDelegates) {
    if ([delegate respondsToSelector:_cmd]) {
      [delegate scrollViewWillBeginZooming:scrollView withView:view];
    }
  }
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView
                       withView:(UIView *)view
                        atScale:(CGFloat)scale {
  for (id<UIScrollViewDelegate> delegate in _observingDelegates) {
    if ([delegate respondsToSelector:_cmd]) {
      [delegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
    }
  }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView {
  NSMutableArray *results = [NSMutableArray array];
  NSMutableArray *respondingObservers = [NSMutableArray array];

  // Execute this method for every responding observer.
  for (id<UIScrollViewDelegate> delegate in _observingDelegates) {
    if ([delegate respondsToSelector:_cmd]) {
      [results addObject:@([delegate scrollViewShouldScrollToTop:scrollView])];
      [respondingObservers addObject:delegate];
    }
  }

  if ([_combiner respondsToSelector:@selector(scrollViewDelegateMultiplexer:
                                              shouldScrollToTopWithResults:
                                              fromRespondingObservers:)]) {
    return [_combiner scrollViewDelegateMultiplexer:(id)self
                       shouldScrollToTopWithResults:results
                            fromRespondingObservers:respondingObservers];
  } else if (results.count > 0) {

#if DEBUG
    NSSet *set = [NSSet setWithArray:results];
    NSAssert(set.count == 1,
             @"-scrollViewShouldScrollToTop returns different results from multiple observers."
             " Use the combiner protocol MDCScrollViewDelegateCombining to select the appropriate"
             " observer return value for this method.");
#endif

    return [results[0] boolValue];
  }

  return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
  for (id<UIScrollViewDelegate> delegate in _observingDelegates) {
    if ([delegate respondsToSelector:_cmd]) {
      [delegate scrollViewDidScrollToTop:scrollView];
    }
  }
}

@end
