// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#ifndef SimpleTextFieldLayoutUtils_h
#define SimpleTextFieldLayoutUtils_h

static const CGFloat kFloatingPlaceholderAnimationDuration = 0.15;

static const CGFloat kLeadingMargin = 12.0;
static const CGFloat kTrailingMargin = 12.0;

static const CGFloat kFilledTextFieldTopCornerRadius = 4.0;
static const CGFloat kOutlinedTextFieldCornerRadius = 4.0;
static const CGFloat kFloatingPlaceholderSideMargin = 5.0;
static const CGFloat kFloatingPlaceholderXOffsetFromTextArea = 3.0;
static const CGFloat kTopMargin = 5.0;

static const CGFloat kClearButtonTouchTargetSideLength = 30.0;
static const CGFloat kTextRectSidePadding = 12.0;

static const CGFloat kUnderlineLabelsTopPadding = 8.0;
static const CGFloat kTopRowSubviewVerticalPadding = 10.0;

static const UIControlState UIControlStateError = 1 << 10;

/**
 TextFieldStyle dictates what type of text field it will be from a cosmetic standpoint. The values
 are derived from the styles outlined in the Material Guidelines for Text Fields.
 */
typedef NS_ENUM(NSUInteger, TextFieldStyle) {
  TextFieldStyleFilled,
  TextFieldStyleOutline,
};

/**
 Dictates the relative importance of the underline labels, and the order in which they are laid out.
 */
typedef NS_ENUM(NSUInteger, UnderlineLabelDrawPriority) {
  /**
   When the priority is @c .leading, the @c leadingUnderlineLabel will be laid out first within the
   horizontal space available for @b both underline labels. Any remaining space will then be given
   for the @c trailingUnderlineLabel.
   */
  UnderlineLabelDrawPriorityLeading,
  /**
   When the priority is @c .trailing, the @c trailingUnderlineLabel will be laid out first within
   the horizontal space available for @b both underline labels. Any remaining space will then be
   given for the @c leadingUnderlineLabel.
   */
  UnderlineLabelDrawPriorityTrailing,
  /**
   When the priority is @c .custom, the @c customUnderlineLabelDrawPriority property will be used to
   divide the space available for the two underline labels.
   */
  UnderlineLabelDrawPriorityCustom,
};

/**
 This enum allows us to differentiate between traditional UITextField placeholders and the
 "floating" style customary in Text Fields outlined in the Material guidelines.
 */
typedef NS_ENUM(NSUInteger, PlaceholderState) {
  PlaceholderStateNone,
  PlaceholderStateFloating,
  PlaceholderStateNormal,
};

/**
 A representation of Text Field state that is compatible with UIControlState as well as an
 interpretation of the states outlined in the Material guidelines for Text Fields.
 */
typedef NS_ENUM(NSUInteger, TextFieldState) {
  TextFieldStateNormal,
  TextFieldStateFocused,
  TextFieldStateActivated,
  TextFieldStateErrored,
  TextFieldStateDisabled,
};

#endif /* SimpleTextFieldLayoutUtils_h */
