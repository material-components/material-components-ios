/*
 Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.

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

@interface MDCFlexibleHeaderView ()

/*
 The view controller from which the top safe area insets should be extracted.

 This is typically the root parent of the view controller that owns the flexible header view
 controller.
 */
@property(nonatomic, weak, nullable) UIViewController *topSafeAreaSourceViewController;

/*
 A behavioral flag affecting whether the flexible header view should extract top safe area insets
 from topSafeAreaSourceViewController or not.
 */
@property(nonatomic) BOOL inferTopSafeAreaInsetFromViewController;

/*
 Forces an extraction of the top safe area inset. Intended to be called any time the top safe area
 inset is known to have changed.
 */
- (void)extractTopSafeAreaInset;

@end
