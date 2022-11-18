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

#import "MDCButton.h"

API_DEPRECATED_BEGIN("🤖👀 Use branded M3CButton instead. "
                     "See go/material-ios-buttons/gm2-migration for more details. "
                     "This has go/material-ios-migrations#scriptable-potential 🤖👀.",
                     ios(12, 12))

/**
 A "raised" MDCButton.

 Raised buttons have their own background color, float above their parent slightly, and raise
 briefly when touched. Raised buttons should be used when flat buttons would get lost among other
 UI elements on the screen.

 @warning This class will be deprecated soon. Consider using @c MDCContainedButtonThemer with an
 @c MDCButton instead.

 @see https://material.io/go/design-buttons#buttons-raised-buttons
 */
@interface MDCRaisedButton : MDCButton
@end

API_DEPRECATED_END
