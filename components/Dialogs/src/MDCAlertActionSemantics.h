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

/**
 Material Design Alert Action Semantic Emphasis.

 Emphasis semantics are available to themers. When assigned to actions, these can enforce
 consistent theming that conforms to Material Design.
 */
typedef NS_ENUM(NSUInteger, MDCAlertActionEmphasis) {
  MDCAlertActionEmphasisNone,
  MDCAlertActionEmphasisLow,
  MDCAlertActionEmphasisMedium,
  MDCAlertActionEmphasisHigh,
};

/**
 Material Design Alert Actions Roles.

 Use these properties to map voice over accessibility gestures to dialog actions:
   Voice Over default gesture is mapped to an MDCAlertActionRoleDefault action.
   Voice Over escape gesture is mapped to an MDCAlertActionRoleCancel action.
      When no MDCAlertActionRoleCancel is defined, and the presentationController's
      dismissOnBackgroundTap is false, the escape will be ignored.

 todo: Additionally, actions set as MDCAlertActionRoleCancel are added as the leading button
 in the order of buttons, regardless of the order the actions were added to an alert.

 The alert action roles are available to themers and may be used in role-based button styling.
 */
typedef NS_ENUM(NSUInteger, MDCAlertActionRole) {
  /** designates no specific role for the action */
  MDCAlertActionRoleNone,
  /** designates the default action that is taken when no specific action is selected.
   Used for indicating a default action to assistive technologies. */
  MDCAlertActionRoleDefault,
  /** designates a dismiss or cancel action */
  MDCAlertActionRoleCancel,
  /** designates an action that might be detrimental or irreversible */
  MDCAlertActionRoleDestructive,
};
