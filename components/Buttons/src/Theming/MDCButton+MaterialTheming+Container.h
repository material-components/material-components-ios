// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialButtons.h"
#import "MaterialContainerScheme.h"

@interface MDCButton (MaterialThemingWithContainer)

#pragma mark - Today

- (void)applyContainedThemeWithScheme:(nonnull id<MDCContainerScheming>)containerScheme;
- (void)applyTextThemeWithScheme:(nonnull id<MDCContainerScheming>)containerScheme;

#pragma mark - With a new subsystem

// No public API changes.

#pragma mark - When a subsystem mapping is implemented

// Is a breaking behavioral change if clients were already passing the now-mapped scheme.

@end
