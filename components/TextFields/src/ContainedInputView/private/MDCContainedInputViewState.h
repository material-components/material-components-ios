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

static const UIControlState UIControlStateEditing = 1 << 16;

/**
 A set of Contained Input View states outlined in the Material guidelines. These states overlap with
 and extend UIControlState.
 */
typedef NS_OPTIONS(NSInteger, MDCContainedInputViewState) {
  /**
   The default state of the contained input view.
   */
  MDCContainedInputViewStateNormal = 1 << 0,
  /**
   The state the view is in during normal editing.
   */
  MDCContainedInputViewStateFocused = 1 << 1,
  /**
   The disabled state.
   */
  MDCContainedInputViewStateDisabled = 1 << 2,
};

MDCContainedInputViewState MDCContainedInputViewStateWithUIControlState(
    UIControlState controlState);
