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

#import "MaterialDialogs.h"

/** Dialogs testing utitlies */
@interface MDCAlertController (Testing)

/**
 Use this method in snapshot or unit tests to determine the size of the alert view based on the
 given bounds.

 @example [alert sizeToFitContentInBounds:CGSizeMake(300.0f, 300.0f)];

 This method calls @c `calculatePreferredContentSizeForBounds:` to determine a size that fits its
 content within the given bounds.  This resulting size is a close approximation of the actual size
 that would be used if the alert was presented on a device or a simulator.

 @note For best results, call this method after completing all alert set up, and before testing or
       grabbing a snapshot.
 */
- (void)sizeToFitContentInBounds:(CGSize)bounds;

/**
 A convenience method that allows highlighting different areas of the alert (using background
 colors) in snapshot tests.
 */
- (void)highlightAlertPanels;

@end
