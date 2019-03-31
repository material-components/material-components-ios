// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialInk.h"

@protocol MDCTabBarIndicatorTemplate;

/** Describes the visual style of individual items in an item bar. */
@interface MDCItemBarStyle : NSObject <NSCopying>

/** The default height of the bar. */
@property(nonatomic) CGFloat defaultHeight;

/** Determines if the selection indicator bar should be shown. */
@property(nonatomic) BOOL shouldDisplaySelectionIndicator;

/** Color used for the selection indicator bar which indicates the selected item. */
@property(nonatomic, strong, nullable) UIColor *selectionIndicatorColor;

/** Template defining the selection indicator's appearance. */
@property(nonatomic, nonnull) id<MDCTabBarIndicatorTemplate> selectionIndicatorTemplate;

/** The maximum width for individual items within the bar. If zero, items have no maximum width. */
@property(nonatomic) CGFloat maximumItemWidth;

#pragma mark - Item Style

/** Indicates if the title should be displayed. */
@property(nonatomic) BOOL shouldDisplayTitle;

/** Indicates if the image should be displayed. */
@property(nonatomic) BOOL shouldDisplayImage;

/** Indicates if a badge may be shown. */
@property(nonatomic) BOOL shouldDisplayBadge;

/** Indicates if the cell's components should grow slightly when selected. (Bottom navigation) */
@property(nonatomic) BOOL shouldGrowOnSelection;

/** Color of title text when not selected. Default is opaque white. */
@property(nonatomic, strong, nonnull) UIColor *titleColor;

/** Color of title text when selected. Default is opaque white. */
@property(nonatomic, strong, nonnull) UIColor *selectedTitleColor;

/** Tint color of image when not selected. Default is opaque white. */
@property(nonatomic, strong, nonnull) UIColor *imageTintColor;

/** Tint color of image when selected. Default is opaque white. */
@property(nonatomic, strong, nonnull) UIColor *selectedImageTintColor;

/** Font used for selected item titles. */
@property(nonatomic, strong, nonnull) UIFont *selectedTitleFont;

/** Font used for unselected item titles. */
@property(nonatomic, strong, nonnull) UIFont *unselectedTitleFont;

/** Color of the item bar badge. */
@property(nonatomic, copy, nonnull) UIColor *badgeColor;

/** Style of ink animations on item interaction. */
@property(nonatomic) MDCInkStyle inkStyle;

/** Color of ink splashes. Default is 25% white. */
@property(nonatomic, strong, nonnull) UIColor *inkColor;

/** Padding in points between the title and image components, according to the MD spec. */
@property(nonatomic) CGFloat titleImagePadding;

/**
 The number of lines used for each item's title label. Material Design guidelines specifies 2 lines
 for text-only tabs at the top of the view. All other Tabs styles should use a single line of text.

 Default is 1.
 */
@property(nonatomic, assign) NSInteger textOnlyNumberOfLines;

/**
 Indicates if all tab titles should be uppercased for display. If NO, item titles will be
 displayed verbatim.

 Default is YES and is recommended whenever possible.
 */
@property(nonatomic) BOOL displaysUppercaseTitles;

@end
