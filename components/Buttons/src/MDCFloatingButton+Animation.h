// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCFloatingButton.h"

API_DEPRECATED_BEGIN("🤖👀 Use branded M3CButton instead. "
                     "See go/material-ios-buttons/gm2-migration for more details. "
                     "This has go/material-ios-migrations#scriptable-potential 🤖👀.",
                     ios(12, 12))

/**
 This category is used to animate @c MDCFloatingButton instances, to expand or
 collapse.
 */
@interface MDCFloatingButton (Animation)

/**
 Expand this button to its unscaled (normal) size.

 @param animated YES if the size change should be animated.
 @param completion a completion block to call after the size change is complete.

 @note This method will modify the transform property of the button. Apple's documentation about
       UIView frames and transforms states that whenever the transform is not the identity
       transform, the frame is undefined and should be ignored.
       https://developer.apple.com/documentation/uikit/uiview/1622621-frame
 */
- (void)expand:(BOOL)animated completion:(void (^_Nullable)(void))completion;

/**
 Collapses this button so that it becomes smaller than 0.1% of its normal size.

 @param animated YES if the size change should be animated.
 @param completion a completion block to call after the size change is complete.

 @note This method will modify the transform property of the button. Apple's documentation about
       UIView frames and transforms states that whenever the transform is not the identity
       transform, the frame is undefined and should be ignored.
       https://developer.apple.com/documentation/uikit/uiview/1622621-frame
 */
- (void)collapse:(BOOL)animated completion:(void (^_Nullable)(void))completion;

@end

API_DEPRECATED_END
