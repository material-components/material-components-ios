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

/**
 Themable Material States

MDCControlState represents all Material states.
 UIControlState names are preferred when UIKit names are different than Material names.

 * Eight distinctive states are enumerated.
 * Additional "interactive" state is added to allow collective-theming of interactive states
   (interactive states include all states except for normal, disabled and error).
 */
typedef NS_OPTIONS(NSUInteger, MDCControlState) {
  MDCControlStateNormal = 0,            // Material: Enabled
  MDCControlStateHighlighted = 1 << 0,  // Material: Pressed
  MDCControlStateSelected = 1 << 1,     // Material: Selected
  MDCControlStateActive = 1 << 2,       // Material: Active
  MDCControlStateFocused = 1 << 3,      // Material: Focused
  MDCControlStateDragged = 1 << 4,      // Material: Dragged
  MDCControlStateDisabled = 1 << 5,     // Material: Disabled
  MDCControlStateError = 1 << 6,        // Material: Error

  MDCControlStateInteractive = 1 << 7  // Pressed or Selected or Active or Focused or Dragged
  //  TODO: Change interactive value to a mask:
  //  MDCControlStateInteractive =  MDCControlStateHighlighted | MDCControlStateSelected |
  //                                MDCControlStateActive | MDCControlStateFocused |
  //                                MDCControlStateDragged;
};
