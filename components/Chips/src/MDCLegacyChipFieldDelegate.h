// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

// TODO(cl/315839473): Delete MDCLegacyChipFieldDelegate.h after migrating.

@protocol MDCLegacyChipFieldDelegate <NSObject>

@optional

/**
 Asks the delegate if editing should begin in the specified chip field.

 @param chipField The @c MDCLegacyChipField where is about to begin.
 */
- (BOOL)chipFieldShouldBeginEditing:(nonnull MDCLegacyChipField *)chipField;

/**
 Asks the delegate if editing should end in the specified chip field.

 @param chipField The @c MDCLegacyChipField where is about to end.
 */
- (BOOL)chipFieldShouldEndEditing:(nonnull MDCLegacyChipField *)chipField;

/**
 Tells the delegate that editing began in the specified chip field.

 @param chipField The MDCLegacyChipField where editing began.
 */
- (void)chipFieldDidBeginEditing:(nonnull MDCLegacyChipField *)chipField;

/**
 Tells the delegate when editing ends for the specified MDCLegacyChipField.

 @param chipField The MDCLegacyChipField where editing ended.
 */
- (void)chipFieldDidEndEditing:(nonnull MDCLegacyChipField *)chipField;

/**
 Tells the delegate when a chip is added. This delegate method is not called if @c chips
 array is directly set.

 @param chipField The MDCLegacyChipField where a chip was added.
 @param chip The chip that was added.
 */
- (void)chipField:(nonnull MDCLegacyChipField *)chipField didAddChip:(nonnull MDCChipView *)chip;

/**
 Asks the delegate whether the user-entered chip should be added to the chip field. If not
 implemented, YES is assumed.

 @param chipField The MDCLegacyChipField where a chip will be added.
 @param chip The chip to be added.

 @return YES if the chip should be added, NO otherwise.
 */
- (BOOL)chipField:(nonnull MDCLegacyChipField *)chipField shouldAddChip:(nonnull MDCChipView *)chip;

/**
 Tells the delegate when a chip is removed. This delegate method is not called if @c chips
 array is directly set.

 @param chipField The MDCLegacyChipField where a chip was removed.
 @param chip The chip that was removed.
 */
- (void)chipField:(nonnull MDCLegacyChipField *)chipField didRemoveChip:(nonnull MDCChipView *)chip;

/**
 Tells the delegate when the height of the chip field changes.

 @param chipField The MDCLegacyChipField which height changed.
 */
- (void)chipFieldHeightDidChange:(nonnull MDCLegacyChipField *)chipField;

/**
 Tells the delegate when the text in the chip field changes.

 @param chipField The MDCLegacyChipField where text has changed.
 @param input The text entered into the chip field that has not yet been converted to a chip.
 */
- (void)chipField:(nonnull MDCLegacyChipField *)chipField didChangeInput:(nullable NSString *)input;

/**
 Tells the delegate when a chip in the chip field is tapped.

 @param chipField The MDCLegacyChipField which has a chip that was tapped.
 @param chip The chip that was tapped.
 */
- (void)chipField:(nonnull MDCLegacyChipField *)chipField didTapChip:(nonnull MDCChipView *)chip;

/**
 Called when 'return' key is pressed in the text field contained within the chip field. Return
 YES to use default behavior where chip is created. Return NO to override default behavior, no
 chip is created and client must manually create and add a chip.

 @param chipField The MDCLegacyChipField where return was pressed.
 */
- (BOOL)chipFieldShouldReturn:(nonnull MDCLegacyChipField *)chipField;

/**
 Asks the delegate whether the chip field should become first responder when it is tapped. If not
 implemented, YES is assumed.

 @param chipField The MDCLegacyChipField that becomes the first responder.

 @return YES if the chip field should become first responder, NO otherwise.
 */
- (BOOL)chipFieldShouldBecomeFirstResponder:(nonnull MDCLegacyChipField *)chipField;

@end
