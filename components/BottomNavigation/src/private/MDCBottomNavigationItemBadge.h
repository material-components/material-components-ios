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

/**
 An indication of the actions that might be required in a given context.

 Common uses include showing the number of unread emails in an inbox or the number of unread
 messages in a chat room.
 */
__attribute__((objc_subclassing_restricted))
@interface MDCBottomNavigationItemBadge : UIView

/** The human-readable value, typically numerical, that will be shown for this badge. */
@property(nonatomic, copy, nullable) NSString *badgeValue;

/** The background color of the badge. */
// TODO(featherless): Delete this in favor of just setting the background color.
@property(nonatomic, strong, nonnull) UIColor *badgeColor;

/** The label that shows the badge value. */
// TODO(featherless): Delete this and expose needed APIs instead.
@property(nonatomic, strong, nonnull, readonly) UILabel *badgeValueLabel;

// Interface builder is not supported.
- (nullable instancetype)initWithCoder:(nonnull NSCoder *)aDecoder NS_UNAVAILABLE;

@end
