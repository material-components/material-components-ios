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
  NSTimeInterval overallDuration;
} MDCMaskedTransitionMotionTiming;

typedef struct MDCMaskedTransitionMotionSpec {
  MDCMaskedTransitionMotionTiming expansion;
  MDCMaskedTransitionMotionTiming collapse;
  BOOL shouldSlideWhenCollapsed;
  BOOL isCentered;
} MDCMaskedTransitionMotionSpec;

@interface MDCMaskedTransitionMotionSpecs: NSObject

@property(nonatomic, class, readonly) MDCMaskedTransitionMotionSpec fullscreen;
@property(nonatomic, class, readonly) MDCMaskedTransitionMotionSpec bottomSheet;
@property(nonatomic, class, readonly) MDCMaskedTransitionMotionSpec bottomCard;
@property(nonatomic, class, readonly) MDCMaskedTransitionMotionSpec toolbar;

// This object is not meant to be instantiated.
- (instancetype)init NS_UNAVAILABLE;

@end
