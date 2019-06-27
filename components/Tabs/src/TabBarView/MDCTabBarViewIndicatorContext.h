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

/** Information about the context in which a tab bar indicator will be displayed. */
@protocol MDCTabBarViewIndicatorContext <NSObject>

/** The tab bar item for the indicated tab. */
@property(nonatomic, readonly, nonnull) UITabBarItem *item;

/**
 The full bounds of the tab's view.

 Any paths should be created relative to this coordinate space.
 */
@property(nonatomic, readonly) CGRect bounds;

/**
 The frame for the tab's primary content in its coordinate space.

 For title-only tabs, this is the frame of the title text.
 For image-only tabs, this is the frame of the primary image.
 For title-and-image tabs, it is the union of the title and primary image's frames.
 */
@property(nonatomic, readonly) CGRect contentFrame;

@end
