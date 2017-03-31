/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCTextInput.h"

@protocol MDCTextFieldPositioningDelegate;

/**
  Material Design themed single line text input.
  https://www.google.com/design/spec/components/text-fields.html#text-fields-single-line-text-field
 */
@interface MDCTextField : UITextField <MDCTextInput>

/** MDCTextField does not implement borders that conform to UITextBorderStyle. */
@property(nonatomic) UITextBorderStyle borderStyle NS_UNAVAILABLE;

/**
  Color for the "clear the text" button image.

  Color changes are not animated.

  Default is black with 38% opacity.
 */
@property(nonatomic, nullable, strong) UIColor *clearButtonColor UI_APPEARANCE_SELECTOR;

/**
 An optional delegate that can be queried for important layout information like the editing rect,
 text rect, etc.
 */
@property(nonatomic, nullable, weak) id<MDCTextFieldPositioningDelegate> positioningDelegate;

/** A convenience initializer for inputs that have left views. */
- (_Nonnull instancetype)initWithLeftView:(nullable UIView *)leftView;

@end
