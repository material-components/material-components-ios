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

#import <Foundation/Foundation.h>
#import <MotionInterchange/MotionInterchange.h>

typedef struct MDCMaskedTransitionMotionTiming {
  MDMMotionTiming iconFade;
  MDMMotionTiming contentFade;
  MDMMotionTiming floodBackgroundColor;
  MDMMotionTiming maskTransformation;
  MDMMotionTiming horizontalMovement;
  MDMMotionTiming verticalMovement;
  MDMMotionTiming scrimFade;
} MDCMaskedTransitionMotionTiming;

typedef struct MDCMaskedTransitionMotionSpecContext {
  MDCMaskedTransitionMotionTiming expansion;
  MDCMaskedTransitionMotionTiming collapse;
  BOOL shouldSlideWhenCollapsed;
  BOOL isCentered;
} MDCMaskedTransitionMotionSpecContext;

@interface MDCMaskedTransitionMotionSpec: NSObject

@property(nonatomic, class, readonly) MDCMaskedTransitionMotionSpecContext fullscreen;
@property(nonatomic, class, readonly) MDCMaskedTransitionMotionSpecContext bottomSheet;
@property(nonatomic, class, readonly) MDCMaskedTransitionMotionSpecContext bottomCard;
@property(nonatomic, class, readonly) MDCMaskedTransitionMotionSpecContext toolbar;

// This object is not meant to be instantiated.
- (instancetype)init NS_UNAVAILABLE;

@end
