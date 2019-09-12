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

#import <MaterialComponents/MaterialButtonBar.h>
#import <MaterialComponents/MaterialContainerScheme.h>

// This category applies Material themes that are defined in the Material Guidelines:
// https://material.io/design/components/app-bars-top.html
__deprecated_msg("ButtonBar is not intended to be themed as a standalone component."
                 " Please theme it via the AppBar component's Theming extension instead.")
    @interface MDCButtonBar(MaterialTheming)

/**
 Apply the primary theme to this instance.

 @param scheme A container scheme instance containing any desired customizations to the theming
 system.
 */
- (void)applyPrimaryThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme
    __deprecated_msg("ButtonBar is not intended to be themed as a standalone component."
                     " Please theme it via the AppBar component's Theming extension instead.");

@end
