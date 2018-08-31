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

#import <Foundation/Foundation.h>

#import "MaterialColorScheme.h"
#import "MaterialTextFields.h"

/**
 The Material Design color system's outlined text field themer.
 */
@interface MDCOutlinedTextFieldColorThemer : NSObject

/**
 Applies a color scheme's properties to a text field using the outlined style.

 @param colorScheme The color scheme to apply to the component instance.
 @param textInputController A component instance to which the color scheme should be applied.
 */
+ (void)applySemanticColorScheme:(nonnull id<MDCColorScheming>)colorScheme
           toTextInputController:(nonnull id<MDCTextInputController>)textInputController;

@end
