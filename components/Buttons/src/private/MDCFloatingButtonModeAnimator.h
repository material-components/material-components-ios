// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCFloatingButton.h"

@protocol MDCFloatingButtonModeAnimatorDelegate;

/**
 Animates an MDCFloatingButton's mode.
 */
__attribute__((objc_subclassing_restricted)) @interface MDCFloatingButtonModeAnimator : NSObject

- (nonnull instancetype)initWithTitleLabel:(nonnull UILabel *)titleLabel
                   titleLabelContainerView:(nonnull UIView *)titleLabelContainerView
    NS_DESIGNATED_INITIALIZER;

/**
 Informs the animator that the floating button mode has changed.

 If the change was animated, then the animator will initiate the necessary animations to create the
 visual effect of the modes animating from one state to the next.
 */
- (void)modeDidChange:(MDCFloatingButtonMode)mode
             animated:(BOOL)animated
     animateAlongside:(nullable void (^)(void))animateAlongside
           completion:(nullable void (^)(BOOL finished))completion;

/**
 The animator uses the delegate to interact with its owning context: the MDCFloatingButton instance.
 */
@property(nonatomic, weak, nullable) id<MDCFloatingButtonModeAnimatorDelegate> delegate;

- (nonnull instancetype)init NS_UNAVAILABLE;

@end
