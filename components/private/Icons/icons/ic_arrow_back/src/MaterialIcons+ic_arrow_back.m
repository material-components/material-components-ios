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

// This file is normally automatically generated by running ./scripts/sync_icons.sh
// It has been temporarily modified manually to support the transition to a new style for this icon.

#import "MaterialIcons+ic_arrow_back.h"

#import "MDCIcons+BundleLoader.h"

static NSString *const kBundleName = @"MaterialIcons_ic_arrow_back";
static NSString *const kIconName = @"ic_arrow_back";
NSString *const kNewIconName = @"ic_arrow_back_ios";

static NSString *__icArrowBackIconName = @"ic_arrow_back_ios";

// Export a nonsense symbol to suppress a libtool warning when this is linked alone in a static lib.
__attribute__((visibility("default"))) char MDCIconsExportToSuppressLibToolWarning_ic_arrow_back =
    0;

@implementation MDCIcons (ic_arrow_back)

+ (nonnull NSString *)pathFor_ic_arrow_back {
  return [self pathForIconName:__icArrowBackIconName withBundleName:kBundleName];
}

// TODO(samnm): Remove this method and __icArrowBackIconName after transitioning all clients to the
// new icon style.
+ (void)ic_arrow_backUseNewStyle:(BOOL)useNewStyle {
  if (useNewStyle) {
    __icArrowBackIconName = kNewIconName;
  } else {
    __icArrowBackIconName = kIconName;
  }
}

@end
