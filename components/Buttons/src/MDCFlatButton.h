// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCButton.h"

API_DEPRECATED_BEGIN("🤖👀 Use branded M3CButton instead. "
                     "See go/material-ios-buttons/gm2-migration for more details. "
                     "This has go/material-ios-migrations#scriptable-potential 🤖👀.",
                     ios(12, 12))

/**
 A "flat" MDCButton.

 Flat buttons should be considered the default button. They do not have their own background color,
 do not raise when touched, and have uppercased text to indicate to the user that they are buttons.
 Flat buttons should be used in most situations requiring a button. For layouts with many UI
 elements in which a flat button might get visually lost, consider using a MDCRaisedButton instead.

 @warning This class will be deprecated soon. Consider using @c MDCTextButtonThemer with an
 @c MDCButton instead.

 @see https://material.io/go/design-buttons#buttons-flat-buttons
 */
@interface MDCFlatButton : MDCButton

@end

@interface MDCFlatButton (ToBeDeprecated)

/**
 Use an opaque background color (default is NO).

 Flat buttons normally have a transparent background and blend seamlessly with their underlying
 color, but occasionally a flat button with an opaque background will be required. Consider using
 a raised button instead if possible.
 */
@property(nonatomic) BOOL hasOpaqueBackground;

@end

API_DEPRECATED_END
