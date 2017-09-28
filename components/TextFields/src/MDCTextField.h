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

/** When text is manually set via .text or setText:, this notification fires. */
extern NSString *_Nonnull const MDCTextFieldTextDidSetTextNotification;

/**
  Material Design compliant single-line text input.
  https://www.google.com/design/spec/components/text-fields.html#text-fields-single-line-text-field
 */
@interface MDCTextField : UITextField <MDCTextInput>

/** MDCTextField does not implement borders that conform to UITextBorderStyle. */
@property(nonatomic, assign) UITextBorderStyle borderStyle NS_UNAVAILABLE;

/**
 An overlay view on the leading side.

 Note: if RTL is engaged, this will return the .rightView and if LTR, it will return the .leftView.
 */
@property(nonatomic, nullable, strong) UIView *leadingView;

/**
 Controls when the leading view will display.
 */
@property(nonatomic, assign) UITextFieldViewMode leadingViewMode;

@end
