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

/**
 Objects conforming to this protocol provide information to layout objects regarding the horizontal
 positioning of TextControl subviews.
 */
@protocol MDCTextControlHorizontalPositioning

/**
 The amount of horizontal padding between the leftmost subview and the left edge of the screen as
 well as the rightmost view and the right edge of the screen.
*/
@property(nonatomic, assign) CGFloat horizontalEdgePadding;

/**
 The amount of horizontal padding between the various subviews.
*/
@property(nonatomic, assign) CGFloat horizontalInterItemSpacing;

@end
