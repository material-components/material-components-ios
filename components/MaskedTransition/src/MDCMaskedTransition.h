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

#import <UIKit/UIKit.h>

#import <MotionTransitioning/MotionTransitioning.h>

/**
 A masked transition will animate between two view controllers using an expanding mask effect.

 It is presently assumed that the mask will be a circular mask and that the source view is a view
 with equal width and height and a corner radius equal to half the view's width.
 */
@interface MDCMaskedTransition: NSObject <MDMTransition>

/**
 Initializes the transition with the view from which the mask should emanate.

 @param sourceView The view from which the mask should emanate. The view is assumed to be in the
                   presenting view controller's view hierarchy.
 */
- (nonnull instancetype)initWithSourceView:(nonnull UIView *)sourceView
    NS_DESIGNATED_INITIALIZER;

/**
 An optional block that may be used to calculate the frame of the presented view controller's view.

 If provided, the block will be invoked immediately before the transition is initiated and the
 returned rect will be assigned to the presented view controller's frame.
 */
@property(nonatomic, copy, nullable) CGRect (^calculateFrameOfPresentedView)(UIPresentationController * _Nonnull);

- (nonnull instancetype)init NS_UNAVAILABLE;

@end
