/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import <UIKit/UIKit.h>

/**
 A label with in-frame padding.

 @note This label was created for use with auto layout. If you are using manual layout, test it
 first. You may need to adjust code around sizeThatFits: etc.
 */
@interface MDCPaddedLabel : UILabel

/**
 The padding to be applied.

 The padding is applied the same on each side (left and right both get the value of
 .horizontalPadding added to them. This will result in a label that's 2 * .horizontalPadding wider
 than a plain UILabel.
 */
@property(nonatomic, assign) CGFloat horizontalPadding;

@end
