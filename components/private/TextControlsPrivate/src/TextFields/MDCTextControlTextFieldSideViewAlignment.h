// Copyright 2020-present the Material Components for iOS authors. All Rights
// Reserved.
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

#import "Foundation/Foundation.h"

API_DEPRECATED_BEGIN(
    "🕘 Schedule time to migrate. "
    "Use branded UITextField or UITextView instead: go/material-ios-text-fields/gm2-migration. "
    "This is go/material-ios-migrations#not-scriptable 🕘",
    ios(12, 12))

NS_ASSUME_NONNULL_BEGIN

/**
 This enum describes different approaches to vertically positioning side views (@c leadingView, @c
 trailingView, and the clear button) in a text field. MDCBaseTextFieldLayout uses this to help it
 determine where to put side views on MDCBaseTextField and its subclasses.
 */
typedef NS_ENUM(NSUInteger, MDCTextControlTextFieldSideViewAlignment) {
  /**
   This case will result in the side views being vertically centered in the text field's container.
   */
  MDCTextControlTextFieldSideViewAlignmentCenteredInContainer,
  /**
   This case will result in the side views sharing the same mid Y as the text rect.
   */
  MDCTextControlTextFieldSideViewAlignmentAlignedWithText,
};

NS_ASSUME_NONNULL_END

API_DEPRECATED_END
