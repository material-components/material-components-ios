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

#import <UIKit/UIKit.h>

/**
 Allows elevation changes to propagate down the view hierarchy and allows objects
 conforming to @c MDCElevation to react to those changes accordingly.
 */
@interface UIView (MaterialElevationResponding)

/**
 Should be invoked when the view has an elevation change, and passes on the message to
 all the @c subviews, by recursively calling itself.

 If one of the views, or their repsective view controllers conform to @c MDCElevation,
 then @c mdc_elevationDidChangeBlock: is called.
 */
- (void)mdc_elevationDidChange;

/**
 Returns the sum of all @c superviews in the view hierarchy that conform to @c MDCElevation @c mdc_currentElevation.
 */
- (CGFloat)mdc_baseElevation;

@end

