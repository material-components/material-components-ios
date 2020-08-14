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

#import "MaterialButtons.h"

/**
 The MDCButtonBarButton class is used by MDCButtonBar.
 */
@interface MDCButtonBarButton : MDCFlatButton

/**
 The font used by the button's @c title.

 If left unset or reset to nil for a given state, then a default font is used.

 @param font The font.
 @param state The state.
 */
- (void)setTitleFont:(nullable UIFont *)font forState:(UIControlState)state UI_APPEARANCE_SELECTOR;

#pragma mark - UILargeContentViewerItem

/**
 The title to display in the large content viewer. If set to nil, this property will return
 @c title.
 */
@property(nonatomic, copy, nullable) NSString *largeContentTitle NS_AVAILABLE_IOS(13_0);

/**
 The image to display in the large content viwer.  If set to nil, the property will return
 @c image . If set to nil (or not set) @c scalesLargeContentImage will return YES otherwise NO.
 */
@property(nonatomic, nullable) UIImage *largeContentImage NS_AVAILABLE_IOS(13_0);

@end
