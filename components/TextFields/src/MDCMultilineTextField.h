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

#import <UIKit/UIKit.h>

// TODO(b/151929968): Delete import of delegate headers when client code has been migrated to no
// longer import delegates as transitive dependencies.
#import "MaterialElevation.h"
#import "MDCMultilineTextInputLayoutDelegate.h"
#import "MDCTextInput.h"

@class MDCIntrinsicHeightTextView;

@protocol MDCMultilineTextInputDelegate;
@protocol MDCMultilineTextInputLayoutDelegate;

/**
  Material Design themed mutiline text field (multiline text input).
  https://www.google.com/design/spec/components/text-fields.html#text-fields-multi-line-text-field
 */
@interface MDCMultilineTextField
    : UIView <MDCTextInput, MDCMultilineTextInput, MDCElevatable, MDCElevationOverriding>

/** A mirror of the same property that already exists on UITextField, UITextView, and UILabel. */
@property(nonatomic, assign) BOOL adjustsFontForContentSizeCategory;

/**
 Should the text field grow vertically as new lines are added.

 Default is YES.

 Note: Inherited from MDCMultilineTextInput protocol. Added here to declare Interface Builder
 support (IBInspectable).
 */
@property(nonatomic, assign) IBInspectable BOOL expandsOnOverflow;

/**
 The delegate for changes to preferred content size.

 If using auto layout, it is not necessary to have a layout delegate.
 */
@property(nonatomic, nullable, weak) IBOutlet id<MDCMultilineTextInputLayoutDelegate>
    layoutDelegate;

/** An optional delegate for useful methods not included in UITextViewDelegate.*/
@property(nonatomic, nullable, weak) IBOutlet id<MDCMultilineTextInputDelegate> multilineDelegate;

/**
 The text string of the placeholder label.
 Bringing convenience API found in UITextField to all MDCTextInputs. Maps to the .text of the
 placeholder label.

 Note: Inherited from MDCTextInput protocol. Added here to declare Interface Builder support
 (IBInspectable).
 Note: The [Design guidance](https://material.io/components/text-fields/#anatomy) changed and treats
 placeholder as distinct from `label text`. The placeholder-related properties of this class most
 closely align with the "label text" as described in the guidance.
 */
@property(nonatomic, nullable, copy) IBInspectable NSString *placeholder;

/** Insets used to calculate the spacing of subviews. */
@property(nonatomic, assign, readonly) UIEdgeInsets textInsets;

/**
 Embedded textView. Can be set from storyboard or will be auto-created during initialization.
 */
@property(nonatomic, nullable, strong) IBOutlet MDCIntrinsicHeightTextView *textView;

/**
 * Whether or not the multiline text field should use its contraints to calculate its intrinsic
 * content size. Default is NO, in which case the multiline text field gives an approximate
 * intrinsic content size using its subviews.
 */
@property(nonatomic) BOOL useConstraintsForIntrinsicContentSize;

/**
 A block that is invoked when the @c MDCMultilineTextField receives a call to @c
 traitCollectionDidChange:. The block is called after the call to the superclass.
 */
@property(nonatomic, copy, nullable) void (^traitCollectionDidChangeBlock)(
    MDCMultilineTextField *_Nonnull textField, UITraitCollection *_Nullable previousTraitCollection)
    ;

@end
