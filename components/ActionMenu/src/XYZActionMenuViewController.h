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

@class XYZActionMenuOption;

/**
 * Floating action button size expansion style for the Action Menu.
 */
typedef NS_ENUM(NSInteger, XYZActionMenuStyle) {
  /**
   * Menu expands from default sized primary button to default sized options.
   */
  kXYZActionMenuStyleDefaultToDefault,
  /**
   * Menu expands from default sized primary button to mini sized options.
   */
  kXYZActionMenuStyleDefaultToMini,
  /**
   * Menu expands from mini sized primary button to mini sized options.
   */
  kXYZActionMenuStyleMiniToMini,
  /**
   * Menu expands into sheet style.
   * Note: The floating action button will take the colorGroup the first XYZActionMenuOption.
   */
  kXYZActionMenuStyleSheet
};

/**
 * Position for the Action Menu option label.
 */
typedef NS_ENUM(NSInteger, XYZActionMenuLabelPosition) {
  /**
   * Label displays to the left of the floating action button.
   */
  kXYZActionMenuLabelPositionLeft,
  /**
   * Label displays to the right of the floating action button.
   */
  kXYZActionMenuLabelPositionRight
};

/**
 * A view controller that when a user touches the floating action button, activates, animates and
 * displays the Action Menu with all of its options.
 *
 * To use the XYZActionMenuViewController, simply create the controller and add the options. Add
 * the controller as a child view controller to the parent in which you want to display this
 * component, add the controller's view to the view you want to display it in, setting a frame and
 * autoresize mask.
 *
 * The display of the options, animation, rotation, etc. are taken care of internally. If there is
 * only one option, the action on the option is performed immediately instead of displaying a menu.
 *
 * @ingroup GoogleKitActionMenu
 */
@interface XYZActionMenuViewController : UIViewController

/**
 * Expansion style for Action Menu.
 */
@property(nonatomic, readonly) XYZActionMenuStyle style;

/**
 * Position for the label. Default is kXYZActionMenuLabelPositionLeft.
 */
@property(nonatomic) XYZActionMenuLabelPosition labelPosition;

/**
 * Elevation in points set on the floating action buttons. Default is MDCShadowElevationFABResting.
 */
@property(nonatomic) CGFloat elevation;

/**
 * Whether to automatically dismiss an activated menu on option selection. Default is YES.
 */
@property(nonatomic) BOOL autoDismissOnSelection;

/**
 * Whether the Action Menu is currently activated.
 */
@property(nonatomic, readonly, getter=isActivated) BOOL activated;

/**
 * Accessibility label for the primary floating action button. If there is only one option in the
 * menu, the option's accessibility label is used if present.
 */
@property(nonatomic, copy) NSString *accessibilityLabel;

/**
 * Background color for the dimming view displayed behind all options when activated. Default is
 * clear.
 */
@property(nonatomic, strong) UIColor *backgroundColor;

/**
 * Designated initializer for the XYZActionMenuViewController.
 *
 * @param style         Expansion style for the menu.
 * @param image         Image for the primary floating action button prior to activation.
 *
 * @return A fully configured XYZActionMenuViewController.
 */
- (instancetype)initWithStyle:(XYZActionMenuStyle)style
                        image:(UIImage *)image NS_DESIGNATED_INITIALIZER;

/**
 * @deprecated Please use initWithStyle:image:primaryOption:.
 */
- (instancetype)init NS_UNAVAILABLE;

/**
 * @deprecated Please use initWithStyle:image:primaryOption:.
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

/**
 * @deprecated Please use initWithStyle:image:primaryOption:.
 */
- (instancetype)initWithNibName:(NSString *)nibNameOrNil
                         bundle:(NSBundle *)nibBundleOrNil NS_UNAVAILABLE;

/**
 * Add an option to the menu.
 */
- (void)addOption:(XYZActionMenuOption *)option;

/**
 * Clear the action menu options.
 */
- (void)clearOptions;

/**
 * Refresh the action menu options in the current activated state.
 */
- (void)refreshOptions;

/**
 * Programmatically activate the action menu (if it has multiple options).
 *
 * @param animated    Whether the activation should be animated.
 * @param completion  A block to invoke once the activation is finished, or has failed. May be nil. 
 *                    The block will be called asynchronously on the main queue. The block takes a
 *                    single BOOL didActivate parameter, which will be YES if this method call
 *                    causes the menu to activate.
 */
- (void)activateAnimated:(BOOL)animated withCompletion:(void (^)(BOOL didActivate))completion;

/**
 * Programmatically dismiss the action menu if it is activated.
 *
 * @param animated    Whether the dismissal should be animated.
 * @param completion  A block to invoke once the dismissal is finished. May be nil. The block will
 *                    be called asynchronously on the main queue.
 */
- (void)dismissAnimated:(BOOL)animated withCompletion:(void (^)(void))completion;

/**
 * Forwards to dismissAnimated:withCompletion: with animated:YES and completion:nil.
 * -deprecated Use dismissAnimated:withCompletion: instead.
 */
- (void)dismiss;

/**
 * Forwards to dismissAnimated:withCompletion: with animated:YES.
 * -deprecated Use dismissAnimated:withCompletion: instead.
 */
- (void)dismissWithCompletion:(void (^)(void))completion;

@end
