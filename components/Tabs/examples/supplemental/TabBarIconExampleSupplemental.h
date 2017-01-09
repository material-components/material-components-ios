/*Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */
/* IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to use Material Components for iOS.
 */

@import UIKit;

@class MDCAppBar;
@class MDCRaisedButton;
@class MDCTabBar;

@protocol MDCTabBarDelegate;

@interface TabBarIconExample : UIViewController <MDCTabBarDelegate>

@property MDCTabBar *_Nullable tabBar;
@property MDCRaisedButton *_Nullable alignmentButton;
@property MDCAppBar *_Nullable appBar;
@property UIScrollView *_Nullable scrollView;
@property UIView *_Nullable starPage;

@end

@interface TabBarIconExample (Supplemental)

- (void)setupExampleViews;
- (void)addStarCentered:(BOOL)centered;

@end
