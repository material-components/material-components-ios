/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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
 The frame to use when actually laying out a view in its superview.

 A view is conceptually positioned within its superview in terms of leading/trailing. When it's time
 to actually lay out (i.e. setting frames), leading/trailing needs to be converted to left/right,
 based on the layout direction. Use this method to compute the international frame to use at layout
 time.

 @note Example: placing a view 50pts wide at 10pts from the leading edge of its parent 100pts wide.
   CGRect frame = MDCRectFlippedForRTL(CGRectMake(10, originY, 50, height), 100, layoutDirection);

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

 @param leftToRightRect The frame to convert.
 @param boundingWidth The superview's bounds's width.
 @param layoutDirection The layout direction to consider to compute the layout origin.
 @return The frame ready for layout, already internationalized based on the layout direction.
 */
CGRect MDCRectFlippedForRTL(CGRect leftToRightRect,
                            CGFloat boundingWidth,
                            UIUserInterfaceLayoutDirection layoutDirection);

/**
 Creates an UIEdgeInsets instance from the parameters while obeying layoutDirection.

 If layoutDirection is UIUserInterfaceLayoutDirectionLeftToRight, then the left inset is leading and
 the right inset is trailing, otherwise they are reversed.

 @param top The top inset.
 @param leading The leading inset.
 @param bottom The bottom inset.
 @param trailing The trailing inset.
 @return Insets in terms of left/right, already internationalized based on the layout direction.
 */
UIEdgeInsets MDCInsetsMakeWithLayoutDirection(CGFloat top,
                                              CGFloat leading,
                                              CGFloat bottom,
                                              CGFloat trailing,
                                              UIUserInterfaceLayoutDirection layoutDirection);
