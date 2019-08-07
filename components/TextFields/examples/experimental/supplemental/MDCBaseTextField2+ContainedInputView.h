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

#import <UIKit/UIKit.h>
#import "MDCBaseTextField2.h"
#import "MDCContainedInputView.h"

/**
 A UITextField subclass that attempts to do the following:

 - Earnestly interpret and actualize the Material guidelines for text fields, which can be found
 here: https://material.io/design/components/text-fields.html#outlined-text-field

 - Feel intuitive for someone used to the conventions of iOS development and UIKit controls.

 - Enable easy set up and reliable and predictable behavior.

 */
@interface MDCBaseTextField2 (Private) <MDCContainedInputView>
@end
