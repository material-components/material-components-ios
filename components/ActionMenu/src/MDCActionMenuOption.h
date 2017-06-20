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

#import "MaterialPalettes.h"

/**
 * A menu option displayed in a MDCActionMenuViewController.
 */
@interface MDCActionMenuOption : NSObject

/**
 * Label displayed adjoining the floating action button.
 *
 * Default accessibility label used in lieu of |accessibilityLabel|.
 */
@property(nonatomic, copy) NSString *label;

/**
 * Accessibility label that takes precedence over the |label|.
 */
@property(nonatomic, copy) NSString *accessibilityLabel;

/**
 * Accessibility identifier for unique identification.
 */
@property(nonatomic, copy) NSString *accessibilityIdentifier;

/**
 * Color palette for the floating action button.
 */
@property(nonatomic, readonly) MDCPalette *palette;

/**
 * Image for the floating action button.
 */
@property(nonatomic) UIImage *image;

/**
 * Whether to inset the image or allow it to take the full size of the floating action button.
 * Default is YES.
 */
@property(nonatomic) BOOL insetImage;

/**
 * Target upon which to call the |action| if this item is selected.
 */
@property(nonatomic, readonly, weak) id target;

/**
 * Action to call on the |target| if this item is selected.
 */
@property(nonatomic, readonly) SEL action;

/**
 * Designated initializer for creating a MDCActionMenuOption.
 *
 * @param palette Color palette for the floating action button.
 * @param image   Image for the floating action button.
 * @param target  Target for the action to be performed on if the option is selected.
 * @param action  Action for the target to be performed on if the option is selected.
 *
 * @return A MDCActionMenuOption to display in a MDCActionMenuViewController.
 */
- (instancetype)initWithPalette:(MDCPalette *)palette
                             image:(UIImage *)image
                            target:(id)target
                            action:(SEL)action NS_DESIGNATED_INITIALIZER;

/**
 * @deprecated Please use initWithColorGroup:image:target:action:.
 */
- (instancetype)init NS_UNAVAILABLE;

@end
