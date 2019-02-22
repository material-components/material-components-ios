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

#import "MDCRippleView.h"

/**
 Provides the current state of the ripple. The ripple is either in its normal state, or in the
 selected state where the ripple remains spread on the view.

 - MDCRippleStateNormal: The ripple isn't currently presented.
 - MDCRippleStateHighlighted: The ripple is activated and shown.
 - MDCRippleStateSelected: The ripple is in the selected state.
 - MDCRippleStateDragged: The ripple is in the dragged state.
 */
typedef NS_OPTIONS(NSInteger, MDCRippleState) {
  MDCRippleStateNormal = 0,
  MDCRippleStateHighlighted = 1 << 0,
  MDCRippleStateSelected = 1 << 1,
  MDCRippleStateDragged = 1 << 2,
};

/**
 This class subclasses MDCRippleView which provides the Ripple functionality, and adds
 to it support for states. By providing states, you can set the overlay color for each state, and
 change the state of the RippleView by using its highlighted/selected/dragged API.

 This class, as opposed to MDCRippleView is less passive in its approach and listens to touches to
 be able to record the last touch and initiate the Ripple from there, as opposed to receiving
 the touch as input. It also is able to identify when a tap goes off/on the view, and fades in/out
 the ripple accordingly.

 Lastly, the implementation for states follows Material Guidelines closely and is built to work
 well with UICollectionViewCells, UITableViewCells, and UIControls. Therefore MDCStatefulRippleView
 should be used when one wants to leverage the Material state system and should ideally be
 configured/set alongside the UIKit APIs (i.e. UIControlState or cell's setSelected/setHighlighted).
 */
__attribute__((objc_subclassing_restricted)) @interface MDCStatefulRippleView : MDCRippleView

/**
 This BOOL is set to YES if the ripple is currently selected, or NO otherwise.
 It only has significance if allowsSelection is set to YES.

 Defaults to NO.
 */
@property(nonatomic, getter=isSelected) BOOL selected;

/**
 This BOOL is set to YES if the ripple is currently highlighted, or NO otherwise.

 Note: The reason for not calling this property `highlighted` is due to UIKit's internal logic of
 crawling and setting all subviews of a UICollectionViewCell to highlighted when a cell goes
 into the selected state. Because we want the ripple view to imitate the state of the cell itself
 when inserted into a cell, and not become the state of the cell's subviews, we have named the
 property `rippleHighlighted` to make sure the state isn't altered by UIKit.

 Defaults to NO.
 */
@property(nonatomic, getter=isRippleHighlighted) BOOL rippleHighlighted;

/**
 This BOOL is set to YES if the ripple is currently dragged, or NO otherwise.
 This state is only triggered manually by setting this property to YES.

 Defaults to NO.
 */
@property(nonatomic, getter=isDragged) BOOL dragged;

/**
 This BOOL is set to YES if the ripple allows selection, or NO otherwise.

 Note: If allowsSelection is set to NO, it will also set selected to NO if selected was YES prior.

 Defaults to NO.
 */
@property(nonatomic) BOOL allowsSelection;

/**
 Sets the color of the ripple for state.

 @param rippleColor The ripple color to set the ripple to.
 @param state The state of the ripple in which to set the ripple color.
 */
- (void)setRippleColor:(nullable UIColor *)rippleColor forState:(MDCRippleState)state;

/**
 Gets the ripple color for the given state.

 @param state The ripple's state.
 @return the color of the ripple for state.
 */
- (nullable UIColor *)rippleColorForState:(MDCRippleState)state;

/**
 The next three methods are important to get the correct behavior and functionality
 for the stateful ripple.
 The methods need to be invoked in the corresponding `touchesBegan`, `touchesMoved`,
 `touchesEnded`, and `touchesCancelled` in the superview of this view.
 More detailed information can be found for each method below.
 */
#pragma mark - Superview Touch Handling

/**
 The stateful ripple view should receive the initial touch so it knows where to initiate the
 ripple effect from. It also lets the ripple view's `setHighlighted` know if it has been triggered
 due to a touch.

 @param touches The touches, as provided by the superview's `touchesBegan:withEvent:`.
 @param event The event, as provided by the superview's `touchesBegan:withEvent:`.
 */
- (void)touchesBegan:(nullable NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;

/**
 The stateful ripple view should fade in an out as a held touch goes in and out of the view.
 To identify that a touch is held and then moved we need to have the superview pass the touch to
 the ripple so it can react appropriately.

 This class needs to be invoked in the `touchesMoved:withEvent:` of its superview before super is
 called. This is because otherwise `setHighlighted` will be triggered prior to knowing if the
 touch is outside the bounds or not and won't be able to act accordingly.

 @param touches The touches, as provided by the superview's `touchesMoved:withEvent:`.
 @param event The event, as provided by the superview's `touchesMoved:withEvent:`.
 */
- (void)touchesMoved:(nullable NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;

/**
 The stateful ripple view needs to identify an end of a touch for two reasons:
 1. To know the touch has ended so if `setHighlighted` isn't triggered by a touch, it shouldn't
    animate the ripple.
 2. To dissolve the existing ripple if the touch is let go outside the hit target of the superview.

 This class needs to be invoked in the `touchesEnded:withEvent:` of its superview before super is
 called.

 @param touches The touches, as provided by the superview's `touchesEnded:withEvent:`.
 @param event The event, as provided by the superview's `touchesEnded:withEvent:`.
 */
- (void)touchesEnded:(nullable NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;

/**
 The stateful ripple view needs to identify a cancellation of a touch for two reason:
 1. To know the touch has ended so if `setHighlighted` isn't triggered by a touch, it shouldn't
    animate the ripple.
 2. To dissolve the existing ripple if the touch gets cancelled.

 This class needs to be invoked in the `touchesCancelled:withEvent:` of its superview before super
 is called.

 @param touches The touches, as provided by the superview's `touchesCancelled:withEvent:`.
 @param event The event, as provided by the superview's `touchesCancelled:withEvent:`.
 */
- (void)touchesCancelled:(nullable NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event;

@end
