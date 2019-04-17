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

#import <MaterialComponents/MaterialContainerScheme.h>
#import <MaterialComponents/MaterialTextFields.h>

/**
 This category is used to style MDCTextInputControllerOutlined instances to a specific Material
 style which can be found within the [Material
 Guidelines](https://material.io/design/components/text-fields.html).
 */
@interface MDCTextInputControllerOutlined (MaterialTheming)

/**
 Applies the Material theme to this instance.

 @param scheme A container scheme instance containing any desired customizations to the theming
 system.
 */
- (void)applyThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme;

@end
