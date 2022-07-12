// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCChipView.h"

API_DEPRECATED_BEGIN("Use a branded UIButton instead (go/material-ios-buttons)", ios(12, 12))

@interface MDCChipView (Private)

- (void)startTouchBeganAnimationAtPoint:(CGPoint)point;
- (void)startTouchEndedAnimationAtPoint:(CGPoint)point;
- (BOOL)willChangeSizeWithSelectedValue:(BOOL)selected;

@end

@interface MDCChipView ()

/**
 A collection of MDCShadow instances each assigned an elevation (in dp).

 To create your own MDCShadowsCollection, please use the provided MDCShadowsCollectionBuilder and
 populate it with MDCShadow instances using the provided MDCShadowBuilder.

 Defaults to MDCShadowsCollectionDefault().
 */
@property(nonatomic, strong, null_resettable) MDCShadowsCollection *shadowsCollection;

@end

API_DEPRECATED_END
