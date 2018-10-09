// Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
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

@interface MDCThumbView : UIView

/** A boolean value indicating whether the thumb view has a shadow. */
@property(nonatomic, assign) BOOL hasShadow __deprecated_msg("Use `elevation` instead.");

/**
 The elevation of the thumb view.

 Default is MDCShadowElevationNone (no shadow).
 */
@property(nonatomic, assign) MDCShadowElevation elevation;

/** The border width of the thumbview layer. */
@property(nonatomic, assign) CGFloat borderWidth;

/** The corner radius of the thumbview layer. */
@property(nonatomic, assign) CGFloat cornerRadius;

/** Set the @c icon shown on the thumb. */
- (void)setIcon:(nullable UIImage *)icon;

@end
