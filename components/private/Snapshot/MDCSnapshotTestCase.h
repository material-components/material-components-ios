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

@property(nonatomic, strong) UIView *testView;

/**
 * This method will take a view and add it to as a subview to a new view with a size slightly
 * larger than the argument view.
 */
- (UIView *)addBackgroundViewToView:(UIView *)view;

/**
 * This will call FBSnapshotVerifyView but first check for supported iOS versions. Additionally,
 * this will use UIGraphicsImageRenderer to render the view correctly (including shadows).
 */
- (void)snapshotVerifyView:(UIView *)view;

@end
