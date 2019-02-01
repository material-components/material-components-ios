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

@interface MDCStatefulRippleView : MDCRippleView

/**
 This BOOL is set to YES if the ripple is currently selected, or NO otherwise.
 It only has significance if selectionMode is activated.
 Defaults to NO.
 */
@property(nonatomic, getter=isSelected) BOOL selected;

/**
 This BOOL is set to YES if the ripple is currently highlighted, or NO otherwise.
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
 Defaults to NO.
 */
@property(nonatomic) BOOL allowsSelection;

/**
 The current state of the ripple.
 */
@property(nonatomic, readonly) MDCRippleState state;

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

@end
