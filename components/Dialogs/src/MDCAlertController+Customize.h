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

/**
 The Customize extensions privde APIs that extend the default Material Dialog. Make sure to adjust
 your custom theming when using these APIs, if you are concerned with conforming to the Material
 spec (material.io).
*/
@interface MDCAlertController (Customize)

/**
 An optional custom icon view that's displayed above the title of the alert, enabling custom
 implementations of the view above the title.

 @note Use `titleIcon` to display icons or images.  Use `titleIconView` for custom views
 implementations. If both `titleIcon` are `titleIconView` are set, 'titleIconView' is ignored.
 */
@property(nonatomic, strong, nullable) UIView *titleIconView;

@end
