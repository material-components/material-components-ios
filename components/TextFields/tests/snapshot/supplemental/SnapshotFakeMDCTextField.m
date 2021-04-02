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
#import <UIKit/UIKit.h>

#import "SnapshotFakeMDCTextField.h"
#import <MDFInternationalization/MDFInternationalization.h>

@implementation SnapshotFakeMDCTextField {
  BOOL _isEditing;
  BOOL _isEditingOverridden;
  UIUserInterfaceLayoutDirection _effectiveUserInterfaceLayoutDirection;
  BOOL _isEffectiveUserInterfaceLayoutDirectionOverridden;
}

- (BOOL)isEditing {
  if (_isEditingOverridden) {
    return _isEditing;
  }
  return [super isEditing];
}

- (void)MDCtest_setIsEditing:(BOOL)isEditing {
  _isEditingOverridden = YES;
  if (_isEditing == isEditing) {
    return;
  }
  _isEditing = isEditing;

  // MDCTextInputControllers use the UITextField notifications to allow clients to be the text field
  // delegate. As a result, we need to post the relevant notifications when we programmatically
  // change the value of `isEditing` in tests.
  if (_isEditing) {
    [NSNotificationCenter.defaultCenter
        postNotificationName:UITextFieldTextDidBeginEditingNotification
                      object:self];
  } else {
    [NSNotificationCenter.defaultCenter
        postNotificationName:UITextFieldTextDidEndEditingNotification
                      object:self];
  }
}

- (UIUserInterfaceLayoutDirection)effectiveUserInterfaceLayoutDirection {
  if (_isEffectiveUserInterfaceLayoutDirectionOverridden) {
    return _effectiveUserInterfaceLayoutDirection;
  }

  return [super effectiveUserInterfaceLayoutDirection];
}

- (void)MDCtest_setEffectiveUserInterfaceLayoutDirection:(UIUserInterfaceLayoutDirection)direction {
  _isEffectiveUserInterfaceLayoutDirectionOverridden = YES;
  _effectiveUserInterfaceLayoutDirection = direction;
}

@end
