// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MDCTextControlLabelSupport.h"

/**
 The logic to animate labels is extracted into its own class so that any MDCTextControl can
 make use of it.
 */
@interface MDCTextControlLabelAnimation : NSObject

/**
 This method lays out the label in an animated fashion, often from normal position to the floating
 position, and vice versa.

 This method does not attempt an animation and passes @c NO to the completion block if an animation
 is already in progress. It does the animation and passes @c YES to the completion block if there is
 no animation in progress.
 */
+ (void)animateLabel:(nonnull UILabel *)label
                       state:(MDCTextControlLabelPosition)labelPosition
            normalLabelFrame:(CGRect)normalLabelFrame
          floatingLabelFrame:(CGRect)floatingLabelFrame
                  normalFont:(nonnull UIFont *)normalFont
                floatingFont:(nonnull UIFont *)floatingFont
    labelTruncationIsPresent:(BOOL)labelTruncationIsPresent
           animationDuration:(NSTimeInterval)animationDuration
                  completion:(void (^__nullable)(BOOL))completion;
@end
