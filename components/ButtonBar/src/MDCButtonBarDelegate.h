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

@class MDCButtonBar;

/**
 The MDCButtonBarDelegate protocol defines the means by which MDCButtonBar can request that a
 view be created for a bar button item.

 An object that conforms to this protocol must forward UIControlEventTouchUpInside events to the
 button bar's didTapButton:event: method signature in order to pass the correct UIBarButtonItem
 argument to the item's target/action invocation. This method signature is made available by
 importing the MDCAppBarButtonBarBuilder.h header. The MDCAppBarButtonBarBuilder.h header should
 *only* be
 imported in files that implement objects conforming to MDCButtonBarDelegate.

 @seealso MDCBarButtonItemLayoutHints
 */
@protocol MDCButtonBarDelegate <NSObject>
@optional

/**
 Informs the receiver that the button bar requires a layout pass.

 The receiver is expected to call propagate this setNeedsLayout call to the view responsible for
 setting the frame of the button bar so that the button bar can expand or contract as necessary.

 This method is typically called as a result of a UIBarButtonItem property changing or as a result
 of the items property being changed.
 */
- (void)buttonBarDidInvalidateIntrinsicContentSize:(nonnull MDCButtonBar *)buttonBar;

/** Asks the receiver to return a view that represents the given bar button item. */
- (nonnull UIView *)buttonBar:(nonnull MDCButtonBar *)buttonBar
                  viewForItem:(nonnull UIBarButtonItem *)barButtonItem
                  layoutHints:(MDCBarButtonItemLayoutHints)layoutHints
    __deprecated_msg("There will be no replacement for this API.");

@end
