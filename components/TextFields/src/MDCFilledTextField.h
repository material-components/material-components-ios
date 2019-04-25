// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCInputTextField.h"

/**
 An implementation of a Material filled text field.
 */
@interface MDCFilledTextField : MDCInputTextField

/**
 The filled background color when the text field is enabled and not editing.
 */
@property(strong, nonatomic, nonnull) UIColor *filledBackgroundColor;

/**
 The underline color when the text field is enabled and not editing.
 */
@property(strong, nonatomic, nonnull) UIColor *underlineColorNormal;

/**
 The underline color when the text field is enabled and editing.
 */
@property(strong, nonatomic, nonnull) UIColor *underlineColorEditing;

/**
 The underline color when the text field is disabled.
 */
@property(strong, nonatomic, nonnull) UIColor *underlineColorDisabled;

@end
