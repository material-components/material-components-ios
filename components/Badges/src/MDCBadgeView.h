// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MDCMinimumOS.h"  // IWYU pragma: keep

/**
 An indication of the actions that might be required in a given context.

 Common uses include showing the number of unread emails in an inbox or the number of unread
 messages in a chat room.

 The background color of the badge can be changed through the backgroundColor property like a
 typical UIView.

 To add a border, customize the view's `.layer.border*` properties.
 */
__attribute__((objc_subclassing_restricted))
@interface MDCBadgeView : UIView

#pragma mark - Displaying a value in the badge

/** The human-readable value, typically numerical, that will be shown for this badge. */
@property(nonatomic, copy, nullable, direct) NSString *text;

#pragma mark - Configuring the badge's visual appearance

/** The color of the text representing the value. */
@property(nonatomic, strong, null_resettable, direct) UIColor *textColor;

/** The font that will be used to display the value. */
@property(nonatomic, strong, null_resettable, direct) UIFont *font;

#pragma mark - Unsupported APIs

// Interface builder is not supported.
- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder NS_UNAVAILABLE;

@end
