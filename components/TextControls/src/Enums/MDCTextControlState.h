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

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 A set of mutually exclusive readonly states that text controls can inhabit. The value of a text
 control's MDCTextControlState is internally determined by whether or it it's editing and whether or
 not it's enabled.
 */
typedef NS_ENUM(NSInteger, MDCTextControlState) {
  /**
   The default state of the contained input view, when it is resting and not editing.
   */
  MDCTextControlStateNormal,
  /**
   The state the view is in during normal editing.
   */
  MDCTextControlStateEditing,
  /**
   The disabled state.
   */
  MDCTextControlStateDisabled,
};

MDCTextControlState MDCTextControlStateWith(BOOL isEnabled, BOOL isEditing);
