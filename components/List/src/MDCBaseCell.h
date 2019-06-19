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

#import <UIKit/UIKit.h>

#import "MaterialShadowElevations.h"

@interface MDCBaseCell : UICollectionViewCell

/**
 The current elevation of the cell.
 */
@property(nonatomic, assign) MDCShadowElevation elevation;

/**
 By setting this property to @c YES, the Ripple component will be used instead of Ink
 to display visual feedback to the user.

 @note This property will eventually be enabled by default, deprecated, and then deleted as part
 of our migration to Ripple. Learn more at
 https://github.com/material-components/material-components-ios/tree/develop/components/Ink#migration-guide-ink-to-ripple

 Defaults to NO.
 */
@property(nonatomic, assign) BOOL enableRippleBehavior;

/**
 The color of the cell’s underlying Ripple.
 */
@property(nonatomic, strong, nullable) UIColor *rippleColor;

@end

@interface MDCBaseCell (ToBeDeprecated)

/**
 The color of the cell’s underlying Ripple.
 @warning This method will eventually be deprecated. Opt-in to Ripple by setting
 enableRippleBehavior to YES, and then use rippleColor instead. Learn more at
 https://github.com/material-components/material-components-ios/tree/develop/components/Ink#migration-guide-ink-to-ripple
 */
@property(nonatomic, strong, nonnull) UIColor *inkColor;

@end
