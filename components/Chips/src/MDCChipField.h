// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKit.h>

#import "MDCChipView.h"
#import "MaterialTextFields.h"

/**
 Note: There is a UIKit bug affecting iOS 8.0-8.2 where UITextFields do not properly call the
 public |deleteBackward| method when the user presses backspace, which means that users can't
 delete chips with the backspace key. Apple fixed the underlying bug in iOS 8.3, so clients
 targeting a minimum iOS version of >= 8.3 are not affected by this bug.

 As a workaround, this class can OPTIONALLY USE THE PRIVATE |keyboardInputShouldDelete| method to
 detect when backspace is pressed and forward the event to |deleteBackward|. There is anecdotal
 evidence that this private usage is currently acceptable by Apple, see
 http://stackoverflow.com/a/25862878/23624.

 To enable the workaround, define MDC_CHIPFIELD_PRIVATE_API_BUG_FIX to be 1 when building
 MDCChipField. MDC itself will never define this macro, it's entirely a client decision.

 If you target iOS versions < 8.3 and you decide not to define MDC_CHIPFIELD_PRIVATE_API_BUG_FIX,
 your iOS 8.0-8.2 users will *not be able to delete chips using the backspace key*. Please
 consider adding a delete button to each chip's accessoryView.

 An alternative approach (using an empty character to detect backspace) makes MDCChipField unusable
 by VoiceOver users on all versions of iOS.
 */

/** The minimum text field width of the text field contained within the MDCChipField. */
extern const CGFloat MDCChipFieldDefaultMinTextFieldWidth;

/** The default content edge insets for the MDCChipField. */
extern const UIEdgeInsets MDCChipFieldDefaultContentEdgeInsets;

@protocol MDCChipFieldDelegate;

/** Defines when text field input is changed into a chip. */
typedef NS_OPTIONS(NSUInteger, MDCChipFieldDelimiter) {
  MDCChipFieldDelimiterNone = 0,
  MDCChipFieldDelimiterReturn = 1 << 0,
  MDCChipFieldDelimiterSpace = 1 << 1,
  MDCChipFieldDelimiterDidEndEditing = 1 << 2,
  MDCChipFieldDelimiterDefault = (MDCChipFieldDelimiterReturn | MDCChipFieldDelimiterDidEndEditing),
  MDCChipFieldDelimiterAll = 0xFFFFFFFF
};

@interface MDCChipField : UIView

/**
 The text field used to enter new chips.

 Do not set the delegate or positioningDelegate.

 If you set a custom font, make sure to also set the custom font on textField.placeholderLabel and
 on your MDCChipView instances.
 */
@property(nonatomic, nonnull, readonly) MDCTextField *textField;

/**
 The fixed height of all chip views.

 Default is 32dp.
 */
@property(nonatomic, assign) CGFloat chipHeight;

/**
 Attribute to determine whether to show the placeholder text (if it exists) when chips are
 present.

 Default is YES.
 */
@property(nonatomic, assign) BOOL showPlaceholderWithChips;

/**
 Enabling this property allows chips to be deleted by tapping on them.

 @note This does not support the 48x48 touch targets that Google recommends. We recommend if this
 behavior is enabled that a snackbar or dialog are used as well to allow the user to confirm if they
 want to delete the chip.
 */
@property(nonatomic) BOOL showChipsDeleteButton;

/**
 The delimiter used to create chips in the text field. Uses default value
 MDCChipFieldDelimiterDefault if no delimiter is set.
 */
@property(nonatomic, assign) MDCChipFieldDelimiter delimiter;

/**
 The minimum width of the text field.

 Default is |kMDCChipFieldDefaultMinTextFieldWidth|.
 */
@property(nonatomic, assign) CGFloat minTextFieldWidth;

/**
 The chips that are visible in the input area.
 */
@property(nonatomic, nonnull, copy) NSArray<MDCChipView *> *chips;

/**
 Delegate to receive updates to the chip field view. Implement
 |chipFieldHeightDidChange| to receive updates when the height of the chip field changes.
 */
@property(nonatomic, nullable, weak) id<MDCChipFieldDelegate> delegate;

/**
 The inset or outset margins for the rectangle surrounding all of the chip field's content.
 Default is |kMDCChipFieldDefaultContentEdgeInsets|.
 */
@property(nonatomic, assign) UIEdgeInsets contentEdgeInsets;

/**
 Adds a chip to the chip field.

 @param chip The chip to add to the field.

 Note: Implementing |chipField:shouldAddChip| only affects whether user interface input entered into
 the text field is changed into chips and will not affect use of this method.
 */
- (void)addChip:(nonnull MDCChipView *)chip;

/**
 Removes a chip from the chip field.

 @param chip The chip to remove from the field.
 */
- (void)removeChip:(nonnull MDCChipView *)chip;

/** Removes all selected chips from the chip field. */
- (void)removeSelectedChips;

/** Removes all text from the chip field text input area. */
- (void)clearTextInput;

/** Selects a chip in a chip field. */
- (void)selectChip:(nonnull MDCChipView *)chip;

/** Deselects all chips in a chip field. */
- (void)deselectAllChips;

/** Sets the VoiceOver focus on the text field. */
- (void)focusTextFieldForAccessibility;

@end

@protocol MDCChipFieldDelegate <NSObject>

@optional

/**
 Asks the delegate if editing should begin in the specified chip field.

 @param chipField The @c MDCChipField where is about to begin.
 */
- (BOOL)chipFieldShouldBeginEditing:(nonnull MDCChipField *)chipField;

/**
 Tells the delegate that editing began in the specified chip field.

 @param chipField The MDCChipField where editing began.
 */
- (void)chipFieldDidBeginEditing:(nonnull MDCChipField *)chipField;

/**
 Tells the delegate when editing ends for the specified MDCChipField.

 @param chipField The MDCChipField where editing ended.
 */
- (void)chipFieldDidEndEditing:(nonnull MDCChipField *)chipField;

/**
 Tells the delegate when a chip is added. This delegate method is not called if @c chips
 array is directly set.

 @param chipField The MDCChipField where a chip was added.
 @param chip The chip that was added.
 */
- (void)chipField:(nonnull MDCChipField *)chipField didAddChip:(nonnull MDCChipView *)chip;

/**
 Asks the delegate whether the user-entered chip should be added to the chip field. If not
 implemented, YES is assumed.

 @param chipField The MDCChipField where a chip will be added.
 @param chip The chip to be added.

 @return YES if the chip should be added, NO otherwise.
 */
- (BOOL)chipField:(nonnull MDCChipField *)chipField shouldAddChip:(nonnull MDCChipView *)chip;

/**
 Tells the delegate when a chip is removed. This delegate method is not called if @c chips
 array is directly set.

 @param chipField The MDCChipField where a chip was removed.
 @param chip The chip that was removed.
 */
- (void)chipField:(nonnull MDCChipField *)chipField didRemoveChip:(nonnull MDCChipView *)chip;

/**
 Tells the delegate when the height of the chip field changes.

 @param chipField The MDCChipField which height changed.
 */
- (void)chipFieldHeightDidChange:(nonnull MDCChipField *)chipField;

/**
 Tells the delegate when the text in the chip field changes.

 @param chipField The MDCChipField where text has changed.
 @param input The text entered into the chip field that has not yet been converted to a chip.
 */
- (void)chipField:(nonnull MDCChipField *)chipField didChangeInput:(nullable NSString *)input;

/**
 Tells the delegate when a chip in the chip field is tapped.

 @param chipField The MDCChipField which has a chip that was tapped.
 @param chip The chip that was tapped.
 */
- (void)chipField:(nonnull MDCChipField *)chipField didTapChip:(nonnull MDCChipView *)chip;

/**
 Called when 'return' key is pressed in the text field contained within the chip field. Return
 YES to use default behavior where chip is created. Return NO to override default behavior, no
 chip is created and client must manually create and add a chip.

 @param chipField The MDCChipField where return was pressed.
 */
- (BOOL)chipFieldShouldReturn:(nonnull MDCChipField *)chipField;

/**
 Asks the delegate whether the chip field should become first responder when it is tapped. If not
 implemented, YES is assumed.

 @param chipField The MDCChipField that becomes the first responder.

 @return YES if the chip field should become first responder, NO otherwise.
 */
- (BOOL)chipFieldShouldBecomeFirstResponder:(nonnull MDCChipField *)chipField;

@end
