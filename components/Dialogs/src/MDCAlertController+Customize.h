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

#import "MaterialDialogs.h"

@interface MDCAlertController (Customize)

/**
 An optional custom icon view above the title of the alert.

 @note This property is intended to be used to provide a custom implementation of the title icon
 view. If the intention is to just display a `UIImage`, use `setTitleIcon:` API instead. If
 'titleIcon' is set, 'titleIconView' is ignored.
 */
@property(nonatomic, strong, nullable) UIView *titleIconView;

@end
