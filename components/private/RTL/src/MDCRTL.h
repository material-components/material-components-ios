/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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
 Leading autoresizing mask based on layoutDirection. 'Leading' is 'Left' in
 UIUserInterfaceLayoutDirectionLeftToRight, 'Right' otherwise.

 @param layoutDirection The layout direction to consider to compute the autoresizing mask.

 @return The leading margin part of an autoresizing mask.
 */
UIViewAutoresizing MDCAutoresizingFlexibleLeadingMargin(
    UIUserInterfaceLayoutDirection layoutDirection);

/**
 Trailing autoresizing masks based on layoutDirection. 'Trailing' is 'Right' in
 UIUserInterfaceLayoutDirectionLeftToRight, 'Left' otherwise.

 @param layoutDirection The layout direction to consider to compute the autoresizing mask.

 @return The trailing margin part of an autoresizing mask.
 */
UIViewAutoresizing MDCAutoresizingFlexibleTrailingMargin(
    UIUserInterfaceLayoutDirection layoutDirection);

/**
 The origin to use when actually laying out a view in its superview.

 A view is conceptually positioned within its superview in terms of leading/trailing. When it's time
 to actually lay out (ie setting frames), leading/trailing needs to be converted to left/right,
 based on the layout direction. Use this method to compute the internationalized origin to use at
 layout time.

 Example: placing a view 50pts wide at 10pts from the leading edge of its parent 100pts wide.
   CGFloat originX = MDCOriginForLeadingInset(10, 50, 100, layoutDirection);
   CGRect frame = CGRectMake(originX, originY, 50, height);

 In LTR, frame is { { 10, originY }, { 50, height } }.
  +----------------------------------------100----------------------------------------+
  |                                                                                   |
  | 10 +--------------------50--------------------+                                   |
  |    |                                          |                                   |
  |    +------------------------------------------+                                   |
  |                                                                                   |
  +----------------------------------------100----------------------------------------+

 In RTL, frame is { { 40, originY }, { 50, height } }.
  +----------------------------------------100----------------------------------------+
  |                                                                                   |
  |                                40 +--------------------50--------------------+    |
  |                                   |                                          |    |
  |                                   +------------------------------------------+    |
  |                                                                                   |
  +----------------------------------------100----------------------------------------+

 @param leadingInset The leading inset between the view and its superview.
 @param width The width of the view to lay out.
 @param boundingWidth The width of the superview in witch to lay out.
 @param layoutDirection The layout direction to consider to compute the layout origin.

 @return The origin in terms of left/right, already internationalized based on the layout direction.
 */
CGFloat MDCOriginForLeadingInset(CGFloat leadingInset,
                                 CGFloat width,
                                 CGFloat boundingWidth,
                                 UIUserInterfaceLayoutDirection layoutDirection);

/**
 Creates an UIEdgeInsets instance from the parameters while obeying layoutDirection.

 If layoutDirection is UIUserInterfaceLayoutDirectionLeftToRight, then the left inset is leading and
 the right inset is trailing, otherwise they are reversed.

 @param top The top inset.
 @param top The leading inset.
 @param top The bottom inset.
 @param top The trailing inset.

 @return Insets in terms of left/right, already internationalized based on the layout direction.
 */
UIEdgeInsets MDCInsetsMakeWithLayoutDirection(CGFloat top,
                                              CGFloat leading,
                                              CGFloat bottom,
                                              CGFloat trailing,
                                              UIUserInterfaceLayoutDirection layoutDirection);
