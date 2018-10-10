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
 Material Design Alert Action Semantic.

 These semantics are available to themers. When assigned to actions, these can enforce
 consistent theming that conforms to Material Design.
 */
typedef NS_ENUM(NSUInteger, MDCAlertActionSemantic) {
  MDCAlertActionSemanticLow,
  MDCAlertActionSemanticMedium,
  MDCAlertActionSemanticHigh,
};

/**
 Material Design Alert Actions Roles.

 Use these properties to map voice over accessibility gestures to dialog actions:
   Voice Over default gesture is mapped to an MDCAlertActionRoleDefault action.
   Voice Over escape gesture is mapped to an MDCAlertActionRoleCancel action.

 Additionally, actions set as MDCAlertActionRoleCancel are added as the leading button
 in the order of buttons, regardless of the order the actions were added to an alert.

 The alert action roles are available to themers and can afect styling of buttons.
 */
typedef NS_ENUM(NSUInteger, MDCAlertActionRole) {
  MDCAlertActionRoleNormal,   // designates no specific role for the action
  MDCAlertActionRoleDefault,  // designates the action to take when no specific action is requested
  MDCAlertActionRoleCancel,   // designates a dismiss or cancel action
  MDCAlertActionRoleDestructive,  // designates an action that might be harmful or irreversible
};
