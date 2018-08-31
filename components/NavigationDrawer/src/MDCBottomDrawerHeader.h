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

#import <UIKit/UIKit.h>

/**
 A protocol view controllers should conform to for enabling the view controller to be
 used as a drawer header view controller.
 */
@protocol MDCBottomDrawerHeader

@optional
/**
 The drawer header transition to top ratio: zero represents the drawer being
 fully displayed as part of the content, one represents the drawer being fully
 displayed as a top header.

 @param transitionToTopRatio moves between 0 to 1 as the transition of the header view
 transforms from being above the content to becoming sticky on the top. It is 0 when the drawer
 is above the content and starts changing as the header view expands to cover the status bar and
 safe area based on the completion rate. It is 1 once the header finishes its transition to become
 sticky on the top and it's height is at the size of its preferredContentSize + the safe area.
 */
- (void)updateDrawerHeaderTransitionRatio:(CGFloat)transitionToTopRatio;

@end
