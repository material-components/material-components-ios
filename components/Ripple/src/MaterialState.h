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
 Enumerates all Material States.

 The integert value used for each State matches the UIControlState value so both states
 maybe used interchangeably. For example:

 [rippleView setRippleColor:UIColor.redColor forState:(MaterialState)UIControlStateHighlighted];

 @note Additional Material states that do not have a corresponding UIControlState value are
      within UIControlState's range that is reserved for application use.
 */
typedef NS_OPTIONS(NSInteger, MaterialState) {

  /** Used as Material Enabled or Resting state. Matches UIControlStateNormal value. */
  MaterialStateNormal = 0,
  /** Used as Material Pressed state. Matches UIControlStateHighlighted value. */
  MaterialStateHighlighted = 1 << 0,
  /** Used as Material Disabled state. Matches UIControlStateDisabled value. */
  MaterialStateDisabled = 1 << 1,
  /** Used as Material Selected state. Matches UIControlStateSelected value. */
  MaterialStateSelected = 1 << 2,

  /** Used as Material Active state. Matches UIControlState's reserved range for applications. */
  MaterialStateActive = 1 << 20,
  /** Used as Material Dragged state. Matches UIControlState's reserved range for applications. */
  MaterialStateDragged = 1 << 21,
  /** Used as Material Error state. Matches UIControlState's reserved range for applications. */
  MaterialStateError = 1 << 22,
};
