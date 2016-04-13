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

#import <UIKit/UIKit.h>

@protocol MDCScrollViewDelegateCombining;

/**
 MDCScrollViewDelegateMultiplexer acts as a proxy object for UIScrollViewDelegate events and
 forwards all received events to an ordered list of registered observers.

 When a UIScrollViewDelegate method invocation is received by the multiplexer, the multiplexer
 forwards the invocation to each observer in order of registration.

 If the scroll view method signature has a return value, after all delegate method invocations,
 the return value will be provided by the first observing delegate that responded. If no
 observers implement the method, a default return value will be used.

 However, if a combiner is set and the receiving class conforms to the
 MDCScrollViewDelegateCombining protocol, then the receiving class can designate which result
 value to return via the use of the optional protocol methods.

 Example implementation:

 _multiplexer = [[MDCScrollViewDelegateMultiplexer alloc] init];
 myScrollView.delegate = _multiplexer;
 [_multiplexer addObservingDelegate:myControl];
 [_multiplexer addObservingDelegate:anotherControl];
 */
// clang-format off
__deprecated_msg("This component is now available at https://github.com/google/GOSScrollViewDelegateMultiplexer.")
@interface MDCScrollViewDelegateMultiplexer : NSObject <UIScrollViewDelegate>

/**
 Adds an observing delegate to the end of the array of delegates.

 @param delegate The observing delegate to be added.
 */
- (void)addObservingDelegate : (nonnull id<UIScrollViewDelegate>)delegate;

/**
 Removes an observing delegate from the array of delegates.

 @param delegate The observing delegate to be removed.
 */
- (void)removeObservingDelegate:(nonnull id<UIScrollViewDelegate>)delegate;

/**
 An optional delegate through which the MDCScrollViewDelegateMultiplexer may provide a
 single UIScrollViewDelegate protocol return value from its array of observing delegates.
 */
@property(nonatomic, weak, null_resettable) id<MDCScrollViewDelegateCombining> combiner;

@end

/**
 The MDCScrollViewDelegateCombining protocol defines an internal mechanism through which
 MDCScrollViewDelegateMultiplexer provides an array of responding observing delegates
 and their respective return values.

 Since it is possible that multiple delegates may respond to UIScrollViewDelegate methods that
 provide return values, this protocol allows the receiver to select the specific value to return
 from an array of those responding result values.
 */
__deprecated_msg("This component is now available at https://github.com/google/GOSScrollViewDelegateMultiplexer.")
@protocol MDCScrollViewDelegateCombining<NSObject> @optional

/**
 Allows the receiver to return the preferred UIView result from observer delegates that have
 responded to the UIScrollViewDelegate -viewForZoomingInScrollView method.

 @param multiplexer The scrollView delegate multiplexer.
 @param results A pointer array of UIView instances returned by responding observer delegates.
 NSPointerArray here to allow nil results from -viewForZoomingInScrollView.
 @param respondingObservers An array of observing delegates that responded.

 @return The preferred UIView result for this method.
 */
- (nullable UIView *)scrollViewDelegateMultiplexer:(nonnull MDCScrollViewDelegateMultiplexer *)multiplexer
                         viewForZoomingWithResults:(nonnull NSPointerArray *)results
                           fromRespondingObservers:(nonnull NSArray *)respondingObservers;

/**
 Allows the receiver to return the preferred BOOL result from observer delegates that have
 responded to the UIScrollViewDelegate -scrollViewShouldScrollToTop method.

 @param multiplexer The scrollView delegate multiplexer.
 @param results An array of NSNumber instances returned by responding observer delegates.
 @param respondingObservers An array of observing delegates that responded.

 @return The preferred BOOL result for this method.
 */
- (BOOL)scrollViewDelegateMultiplexer:(nonnull MDCScrollViewDelegateMultiplexer *)multiplexer
         shouldScrollToTopWithResults:(nonnull NSArray *)results
              fromRespondingObservers:(nonnull NSArray *)respondingObservers;

@end
    // clang-format on
