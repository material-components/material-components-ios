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

#import <FBSnapshotTestCase/FBSnapshotTestCase.h>

@interface MDCSnapshotTestCase : FBSnapshotTestCase

/**
 * This will call FBSnapshotVerifyView but first check for supported iOS versions. Additionally,
 * this will use UIGraphicsImageRenderer to render the view correctly (including shadows).
 *
 * Permits no changed pixels.
 *
 * @param view The view to use for snapshot comparison.
 */
- (void)snapshotVerifyView:(UIView *)view;

/**
 * This will call FBSnapshotVerifyView for iOS13. Additionally,
 * this will use UIGraphicsImageRenderer to render the view correctly (including shadows).
 *
 * Permits no changed pixels.
 *
 * @param view The view to use for snapshot comparison.
 */
- (void)snapshotVerifyViewForIOS13:(UIView *)view;

/**
 * This will call FBSnapshotVerifyView but first check for supported iOS versions. Additionally,
 * this will use UIGraphicsImageRenderer to render the view correctly (including shadows).
 * @param view the view to use for snapshot comparison.
 * @param tolerancePercent the percentage (0.0 - 1.0) of pixels that can differ while still passing.
 * @param supportIOS13 if to take the snapshot test on iOS13.
 */
- (void)snapshotVerifyView:(UIView *)view
                 tolerance:(CGFloat)tolerancePercent
              supportIOS13:(BOOL)supportIOS13;

/// Change view to RTL mode.
/// @param view The view to be changed to RTL mode.
- (void)changeViewToRTL:(UIView *)view;

@end
