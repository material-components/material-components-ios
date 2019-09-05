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

#import "MDCBaseTextArea+MaterialTheming.h"

#import <Foundation/Foundation.h>

#import "private/MDCBaseTextArea+MDCContainedInputView.h"
#import "private/MDCContainedInputView.h"
#import "private/MDCContainedInputViewStyleFilled.h"
#import "private/MDCContainedInputViewStyleOutlined.h"

@implementation MDCBaseTextArea (MaterialTheming)

- (void)applyThemeWithScheme:(nonnull id<MDCContainerScheming>)containerScheme {
  [self applyTypographySchemeWith:containerScheme];
  [self applyColorSchemeWith:containerScheme];
}

- (void)applyTypographySchemeWith:(id<MDCContainerScheming>)containerScheme {
  id<MDCTypographyScheming> mdcTypographyScheming = containerScheme.typographyScheme;
  if (!mdcTypographyScheming) {
    mdcTypographyScheming =
        [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201804];
  }
  [self applyMDCTypographyScheming:mdcTypographyScheming];
}

- (void)applyColorSchemeWith:(id<MDCContainerScheming>)containerScheme {
  id<MDCColorScheming> mdcColorScheme = containerScheme.colorScheme;
  if (!mdcColorScheme) {
    mdcColorScheme =
        [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
  }
  [self applyMDCColorScheming:mdcColorScheme];
}

- (void)applyMDCColorScheming:(id<MDCColorScheming>)mdcColorScheming {
}

- (void)applyMDCTypographyScheming:(id<MDCTypographyScheming>)mdcTypographyScheming {
  self.textView.font = mdcTypographyScheming.subtitle1;
  self.leadingAssistiveLabel.font = mdcTypographyScheming.caption;
  self.trailingAssistiveLabel.font = mdcTypographyScheming.caption;
}

- (void)applyOutlinedThemeWithScheme:(nonnull id<MDCContainerScheming>)containerScheme {
  MDCContainedInputViewStyleOutlined *outlinedStyle =
      [[MDCContainedInputViewStyleOutlined alloc] init];
  self.containerStyle = outlinedStyle;
}

- (void)applyFilledThemeWithScheme:(nonnull id<MDCContainerScheming>)containerScheme {
  // TODO: Remove this method
  self.containerStyle = [[MDCContainedInputViewStyleFilled alloc] init];
}

@end
