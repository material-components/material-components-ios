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

#import <MaterialComponents/MaterialButtons.h>
#import "MaterialContainerScheme.h"

#import <Foundation/Foundation.h>

@interface MDCFloatingButton (MaterialTheming)

/**
 Applies the secondary Floating Action Button style to an MDCFloatingButton instance.
 @param scheme A container scheme instance containing any desired customizations to the theming
 system.

 The [Material Guidelines article for Floating Action
 Buttons](https://material.io/design/components/buttons-floating-action-button.html#theming) has
 more details about how Floating Action Buttons can be styled and used.
 */
- (void)applySecondaryThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme;

@end
