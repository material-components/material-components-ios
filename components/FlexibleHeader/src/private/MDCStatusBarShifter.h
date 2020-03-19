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

// TODO(b/151929968): Delete import of delegate headers when client code has been migrated to no
// longer import delegates as transitive dependencies.
#import "MDCStatusBarShifterDelegate.h"

@protocol MDCStatusBarShifterDelegate;

/**
 The status bar shifter is responsible for the management of the status bar's offset as a header
 view is shifting off-screen.

 This class is not intended to be subclassed.
 */
@interface MDCStatusBarShifter : NSObject

#pragma mark Shifting the status bar

/**
 Provides the status bar shifter with the current desired y offset of the status bar.

 A value of 0 means the status bar is unshifted. Values > 0 shift the status bar by that amount
 off-screen. Negative values are treated as zero.
 */
- (void)setOffset:(CGFloat)offset;

#pragma mark Configuring behavior

/**
 Whether or not the status bar shifter is enabled.

 If the status bar shifter is disabled midway through shifting the status bar then the shifter
 will move the status bar to a reasonable location.
 */
@property(nonatomic, getter=isEnabled) BOOL enabled;

/**
 A Boolean value indicating whether this class should use snapshotting when rendering the status
 bar shift.

 Defaults to YES.
 */
@property(nonatomic, getter=isSnapshottingEnabled) BOOL snapshottingEnabled;

#pragma mark Responding to state changes

@property(nonatomic, weak) id<MDCStatusBarShifterDelegate> delegate;

#pragma mark Introspection

/**
 A Boolean value indicating whether the receiver is able to shift the status bar.

 There are certain scenarios where the status bar shifter won't try to adjust the frame of the
 status bar. For example, if the status bar is showing the tap-to-return-to-call effect. In these
 cases this method returns NO.
 */
- (BOOL)canUpdateStatusBarFrame;

#pragma mark UIViewController events

/**
 A Boolean value indicating whether the true status bar should be hidden.

 The implementor of MDCStatusBarShifterDelegate should use this to inform UIKit of the expected
 status bar visibility via UIViewController::prefersStatusBarHidden.
 */
- (BOOL)prefersStatusBarHidden;

/** Must be called when the owning UIViewController's interface orientation is about to change. */
- (void)interfaceOrientationWillChange;

/** Must be called when the owning UIViewController's interface orientation has changed. */
- (void)interfaceOrientationDidChange;

/** Must be called when the owning UIViewController's view moves to a window. */
- (void)didMoveToWindow;

@end
