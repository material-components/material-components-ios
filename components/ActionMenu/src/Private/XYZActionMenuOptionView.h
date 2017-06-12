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

extern const NSTimeInterval kXYZActionMenuFastAnimationDuration;
extern const NSTimeInterval kXYZActionMenuSuperFastAnimationDuration;

/**
 * The action menu view.
 */
@interface XYZActionMenuOptionView : UIView <XYZInkTouchControllerDelegate>

/**
 * Expansion style set on the XYZActionMenuViewController.
 */
@property(nonatomic) XYZActionMenuStyle style;

/**
 * Position for the label set on the XYZActionMenuViewController.
 */
@property(nonatomic) XYZActionMenuLabelPosition labelPosition;

/**
 * Index for the item.
 */
@property(nonatomic) NSUInteger index;

/**
 * Option displayed by this view.
 */
@property(nonatomic) XYZActionMenuOption *option;

/**
 * Floating action button displayed by the item.
 */
@property(nonatomic, readonly) XYZButton *floatingActionButton;

/**
 * Set and update the activated state of the cell.
 *
 * @param activated Whether the cell should be activated.
 * @param animated  Whether the cell should animate any changes.
 * @param delay     The duration in seconds by which the animation should be delayed.
 */
- (void)setActivatedState:(BOOL)activated
                 animated:(BOOL)animated
         withStaggerDelay:(NSTimeInterval)delay;

@end
