// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
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

@class MDCFlexibleHeaderView;

/**
 An object may conform to this protocol in order to receive animation events caused by a
 MDCFlexibleHeaderView.
 */
@protocol MDCFlexibleHeaderViewAnimationDelegate <NSObject>
@optional

/**
 Informs the receiver that the flexible header view's tracking scroll view has changed.

 @param animated If YES, then this method is being invoked from within an animation block. Changes
 made to the flexible header as a result of this invocation will be animated alongside the header's
 animation.
 */
- (void)flexibleHeaderView:(nonnull MDCFlexibleHeaderView *)flexibleHeaderView
    didChangeTrackingScrollViewAnimated:(BOOL)animated;

/**
 Informs the receiver that the flexible header view's animation changing to a new tracking scroll
 view has completed.

 Only invoked if an animation occurred when the tracking scroll view was changed.
 */
- (void)flexibleHeaderViewChangeTrackingScrollViewAnimationDidComplete:
    (nonnull MDCFlexibleHeaderView *)flexibleHeaderView;

@end
