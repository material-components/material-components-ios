/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import <UIKit/UIKit.h>

#import "MaterialIcons.h"

// This file is normally automatically generated by running ./scripts/sync_icons.sh
// It has been temporarily modified manually to support the transition to a new style for this icon.

@interface MDCIcons (ic_arrow_back)

/*
 Returns the path for the ic_arrow_back image contained in
 MaterialIcons_ic_arrow_back.bundle.

 Defaults to the old style.
 */
+ (nonnull NSString *)pathFor_ic_arrow_back;

/*
 Change the style returned by `pathFor_ic_arrow_back`.
 @param useNewStyle Use the new iOS style OR Material style for ic_arrow_back.
 */
+ (void)ic_arrow_backUseNewStyle:(BOOL)useNewStyle;

/*
 Returns the bundle for the ic_arrow_back image contained in
 MaterialIcons_ic_arrow_back.bundle.
 */
+ (nullable UIImage *)imageFor_ic_arrow_back;

@end
