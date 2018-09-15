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

#import <UIKit/UIKit.h>

/**
 Class responsible for reporting changes to overlays on a given screen.
 */
@interface MDCOverlayObserver : NSObject

/**
 Returns the overlay observer for the given screen.

 If @c screen is nil, the main screen is used.
 */
+ (instancetype)observerForScreen:(UIScreen *)screen;

/**
 Adds a target/action pair to listen for changes to overlays.

 If an overlay is already showing when this method is called, then a call to the target/action will
 be made immediately with an unanimated transition.

 @param target The object which will be the target of @c action
 @param action The method to invoke on @c target. This method should take a single argument, an
               object that conforms to @c MDCOverlayTransitioning.
 */
- (void)addTarget:(id)target action:(SEL)action;

/**
 Prevents the given target/action pair from being notified of overlay changes.

 @param target The target to stop notifying of changes. If multiple @c actions have been
               registered, then @c target may still receive notifications via other selectors.
 @param action The method which will no longer be called when overlay changes occur.
 */
- (void)removeTarget:(id)target action:(SEL)action;

/**
 Prevents the given target from being notified of any overlay changes.

 @param target The target to stop notifying of changes. This will remove any and all target-action
               pairs registered via @c addTarget:action:.
 */
- (void)removeTarget:(id)target;

@end
