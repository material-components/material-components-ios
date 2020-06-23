// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialNavigationDrawer.h"
#import "MaterialContainerScheme.h"

@interface MDCBottomDrawerViewController (MaterialTheming)

/**
 Applies the Material theme to a MDCBottomDrawerViewController instance.

 @param scheme A container scheme instance containing any desired customizations to the theming
 system.
 @note This method does not apply the Material theme to @c trackingScrollView.
 */
- (void)applyThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme;

/**
 Applies the Material theme to a MDCBottomDrawerViewController instance.

 @param scheme A container scheme instance containing any desired customizations to the theming
 system.
 @param applyToTrackingScrollView Whether or not the Material theme should be applied to
 @c trackingScrollView.
 */
- (void)applyThemeWithScheme:(nonnull id<MDCContainerScheming>)scheme
    applyToTrackingScrollView:(BOOL)applyToTrackingScrollView;

@end
