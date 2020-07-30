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

#import <UIKit/UIKit.h>

@class MDCBaseTextField;

/**
This delegate protocol for @c MDCBaseTextField and its subclasses provides updates not already
covered by @c UITextFieldDelegate.
 */
@protocol MDCBaseTextFieldDelegate <NSObject>

@optional

/**
 This method is called at the end of @c MDCBaseTextField's implementation of @c -deleteBackward.

 @param textField The MDCBaseTextField calling @c -deleteBackward.
 */
- (void)baseTextFieldDidDeleteBackward:(MDCBaseTextField *)textField;
;

@end
