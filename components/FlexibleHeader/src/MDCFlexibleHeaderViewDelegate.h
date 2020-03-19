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
 The MDCFlexibleHeaderViewDelegate protocol allows a delegate to respond to changes in the header
 view's state.

 The delegate is typically the UIViewController that owns this flexible header view.
 */
@protocol MDCFlexibleHeaderViewDelegate <NSObject>
@required

/**
 Informs the receiver that the flexible header view's preferred status bar visibility has changed.
 */
- (void)flexibleHeaderViewNeedsStatusBarAppearanceUpdate:
    (nonnull MDCFlexibleHeaderView *)headerView;

/**
 Informs the receiver that the flexible header view's frame has changed.

 The frame may change in response to scroll events of the tracking scroll view. The receiver
 should use the MDCFlexibleHeaderView scrollPhase APIs to determine which phase the header's frame
 is in.
 */
- (void)flexibleHeaderViewFrameDidChange:(nonnull MDCFlexibleHeaderView *)headerView;

@end
