// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import <UIKit/UIKit.h>

#import "MaterialInk.h"  // IWYU pragma: keep
#import "MaterialRipple.h"  // IWYU pragma: keep

/** The available cell accessory view types. Based on UITableViewCellAccessoryType. */
typedef NS_ENUM(NSUInteger, MDCCollectionViewCellAccessoryType) {
  /** Default value. No accessory view shown. */
  MDCCollectionViewCellAccessoryNone,

  /** A chevron accessory view. */
  MDCCollectionViewCellAccessoryDisclosureIndicator,

  /** A checkmark accessory view. */
  MDCCollectionViewCellAccessoryCheckmark,

  /** An info button accessory view. */
  MDCCollectionViewCellAccessoryDetailButton
};

// String key for accessibility hint of selected cells.
FOUNDATION_EXPORT NSString *_Nonnull const kSelectedCellAccessibilityHintKey;

// String key for accessibility hint of deselected cells.
FOUNDATION_EXPORT NSString *_Nonnull const kDeselectedCellAccessibilityHintKey;

/**
 The MDCCollectionViewCell class provides an implementation of UICollectionViewCell that
 supports Material Design layout and styling.
 */
@interface MDCCollectionViewCell : UICollectionViewCell

/** The accessory type for this cell. Default is MDCCollectionViewCellAccessoryNone. */
@property(nonatomic) MDCCollectionViewCellAccessoryType accessoryType;

/** If set, use custom view and ignore accessoryType. Defaults to nil. */
@property(nonatomic, strong, nullable) UIView *accessoryView;

/**
 The accessory inset for this cell. Only left/right insets are valid as top/bottom insets will
 be ignored. These insets are used for both accessories and editing mask controls.
 Defaults to {0, 16, 0, 16}.
 */
@property(nonatomic) UIEdgeInsets accessoryInset;

/**
 Whether to hide the separator for this cell. If not set, the @c shouldHideSeparators property of
 the collection view styler will be used. Defaults to NO.
 */
@property(nonatomic) BOOL shouldHideSeparator;

/**
 The separator inset for this cell. Only left/right insets are valid as top/bottom insets will be
 ignored. If this property is not changed, the @c separatorInset property of the collection view
 styler will be used instead. Defaults to UIEdgeInsetsZero.
 */
@property(nonatomic) UIEdgeInsets separatorInset;

/**
 A boolean value indicating whether a cell permits interactions with subviews of its content while
 the cell is in editing mode. If NO, then tapping anywhere in the cell will select it instead of
 permitting the tapped subview to receive the touch. Defaults to NO.
 */
@property(nonatomic) BOOL allowsCellInteractionsWhileEditing;

/**
 A boolean value indicating whether the a cell is being edited. Setting is not animated.

 When set, the cell will shows/hide editing controls with/without animation.
 */
@property(nonatomic, getter=isEditing) BOOL editing;

/**
 The color for the editing selector when the cell is selected.

 The default is a red color.
 */
@property(nonatomic, strong, null_resettable) UIColor *editingSelectorColor UI_APPEARANCE_SELECTOR;

/**
 Set the editing state with optional animations.

 When set, the cell will shows/hide editing controls with/without animation.

 @param editing YES if editing; otherwise, NO.
 @param animated YES the transition will be animated; otherwise, NO.
 */
- (void)setEditing:(BOOL)editing animated:(BOOL)animated;

/** View containing the ink effect. */
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
@property(nonatomic, strong, nullable) MDCInkView *inkView;
#pragma clang diagnostic pop

/**
 This property determines if an @c MDCCollectionViewCell should use the @c MDCInkView behavior or
 not.

 By setting this property to @c YES, @c MDCRippleView is used to provide the user visual
 touch feedback, instead of the legacy @c MDCInkView.

 @note Defaults to @c NO.
 */
@property(nonatomic, assign) BOOL enableRippleBehavior;

/**
The rippleView for the cell that is initiated on tap. The ripple view is the successor of ink
view, and can be used by setting `enableRippleBehavior` to YES.
*/
@property(nonatomic, strong, nullable) MDCRippleView *rippleView;

@end
