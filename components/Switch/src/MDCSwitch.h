/*
 Copyright 2015-present Google Inc. All Rights Reserved.

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

// TODO(iangordon): Switch to class method?
/** Returns the size of a @c MDCSwitch. */
CG_EXTERN CGSize MDCSwitchSizeThatFits(CGSize size);

/**
 * A material design on/off switch UIControl.
 *
 * It has an interface similar to UISwitch. Note that MDCSwitch objects have an intrinsic size
 * and are not resizable.
 *
 */
NS_CLASS_AVAILABLE_IOS(7_0)
IB_DESIGNABLE
@interface MDCSwitch : UIControl <NSCoding>

// TODO(iangordon): Unify our Color handling over all of our components
/** The color of the thumb and track in the on position. */
@property(null_resettable, nonatomic, strong) UIColor *onTintColor UI_APPEARANCE_SELECTOR;

/** The color of the thumb in the off position. */
@property(null_resettable, nonatomic, strong) UIColor *offThumbColor UI_APPEARANCE_SELECTOR;

/** The color of the track in the off position. */
@property(null_resettable, nonatomic, strong) UIColor *offTrackColor UI_APPEARANCE_SELECTOR;

/** The color of the thumb when disabled. */
@property(null_resettable, nonatomic, strong) UIColor *disabledThumbColor UI_APPEARANCE_SELECTOR;

/** The color of the track when disabled. */
@property(null_resettable, nonatomic, strong) UIColor *disabledTrackColor UI_APPEARANCE_SELECTOR;

/**
 * Boolean value that determines the off/on state of the switch.
 *
 * This property allows you to retrieve and set (without animation) a value determining whether the
 * MDCSwitch object is on or off.
 */
@property(nonatomic, getter=isOn) IBInspectable BOOL on;

/**
 * Returns an initialized switch object.
 *
 * @param frame A rectangle defining the frame of the MDCSwitch object. The size components of this
 * rectangle are ignored.
 *
 * @return An initialized MDCSwitch object.
 */
- (nonnull instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;

/**
 * Returns a switch object initialized from data in a given unarchiver.
 *
 * @return An initialized MDCSwitch object or nil if the object could not be initialized.
 */
- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder NS_DESIGNATED_INITIALIZER;

/**
 * Set the state of the switch, optionally with animation.
 *
 * @param on State to set the switch to.
 * @param animated Whether to animate the transition.
 *
 * Calling this method does not result in an action message being sent.
 */
- (void)setOn:(BOOL)on animated:(BOOL)animated;

@end
