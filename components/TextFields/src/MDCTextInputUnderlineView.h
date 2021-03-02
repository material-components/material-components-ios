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

#import <UIKit/UIKit.h>

/**
 A view that draws the underline effect for an instance of MDCTextInput. The underline has 2
 possible states enabled and disabled. Disabled shows a dotted line instead of solid.
 */
__deprecated_msg(
    "MDCTextField and its associated classes are deprecated. Please use TextControls instead.")
    @interface MDCTextInputUnderlineView : UIView<NSCopying>

@property(nonatomic, strong) UIColor *color;
@property(nonatomic, strong) UIColor *disabledColor;
@property(nonatomic, assign) BOOL enabled;
@property(nonatomic, assign) CGFloat lineHeight;

@end
