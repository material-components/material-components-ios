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

@class MDCAppBarViewController;

/**
 A delegate that can be implemented in order to respond to events specific to
 MDCAppBarViewController.
 */
@protocol MDCAppBarViewControllerAccessibilityPerformEscapeDelegate <NSObject>
@required

/**
 Informs the receiver that the app bar view controller received an accessibilityPerformEscape event.

 The receiver should return @c YES if the modal view is successfully dismissed; otherwise,
 return @c NO. The value returned by this method is in turn returned to the
 @c accessibilityPerformEscape event.
 */
- (BOOL)appBarViewControllerAccessibilityPerformEscape:
    (nonnull MDCAppBarViewController *)appBarViewController;

@end
