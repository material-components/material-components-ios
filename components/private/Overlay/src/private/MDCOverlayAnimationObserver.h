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

#import <Foundation/Foundation.h>

@protocol MDCOverlayAnimationObserverDelegate;

/**
 Utility class which will call its delegate at the end of the current runloop cycle.

 Called before CoreAnimation has had a chance to commit any pending implicit @c CATransactions.
 */
@interface MDCOverlayAnimationObserver : NSObject

/**
 Called to tell the observer that it should call the @c delegate at the end of the next runloop.

 Without calling this method, the observer will not call the delegate.
 */
- (void)messageDelegateOnNextRunloop;

/**
 The delegate to notify when the end of the runloop has occurred.
 */
@property(nonatomic, weak) id<MDCOverlayAnimationObserverDelegate> delegate;

@end

/**
 Delegate protocol for @c MDCOverlayAnimationObserver.
 */
@protocol MDCOverlayAnimationObserverDelegate <NSObject>

/**
 Called at the end of the current runloop, before CoreAnimation commits any implicit transactions.
 */
- (void)animationObserverDidEndRunloop:(MDCOverlayAnimationObserver *)observer;

@end
