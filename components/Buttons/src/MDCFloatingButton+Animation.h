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

#import "MDCFloatingButton.h"

@interface MDCFloatingButton (Animation)

/**
 Causes this button to return to its "normal" size.

 @param animated YES if the size change should be animated.
 @param completion a completion block to call after the size change is complete.
 */
- (void)enter:(BOOL)animated completion:(void (^_Nullable)(void))completion;

/**
 Causes this button to decrease in size until it is very small. Specifically, it sets the button's
 transform to a scale less than 0.001. For example, a 56-point button will become fewer than 0.056
 points in diameter.

 @param animated YES if the size change should be animated.
 @param completion a completion block to call after the size change is complete.
 */
- (void)exit:(BOOL)animated completion:(void (^_Nullable)(void))completion;

@end
