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

@class MDCStatusBarShifter;

/**
 The MDCStatusBarShifterDelegate protocol allows a delegate to react to changes in the status bar
 shifter's state.
 */
@protocol MDCStatusBarShifterDelegate <NSObject>
@required

/** Informs the receiver that the preferred status bar visibility has changed. */
- (void)statusBarShifterNeedsStatusBarAppearanceUpdate:(MDCStatusBarShifter *)statusBarShifter;

/**
 Informs the receiver that a snapshot view would like to be added to a view hierarchy.

 The receiver is expected to add `view` as a subview. The superview should be shifting off-screen,
 which will cause the snapshot view to shift off-screen as well.
 */
- (void)statusBarShifter:(MDCStatusBarShifter *)statusBarShifter
    wantsSnapshotViewAdded:(UIView *)view;

@end
