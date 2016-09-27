#import <UIKit/UIKit.h>

#import "MaterialInk.h"

/** Describes the visual style of individual items in an item bar. */
@interface MDCItemBarStyle : NSObject <NSCopying>

/** The default height of the bar. */
@property(nonatomic) CGFloat defaultHeight;

/** Determines if the selection indicator bar should be shown. */
@property(nonatomic) BOOL shouldDisplaySelectionIndicator;

/** Color used for the selection indicator bar which indicates the selected item. */
@property(nonatomic, strong, nullable) UIColor *selectionIndicatorColor;

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

/** Font used for item titles. */
@property(nonatomic, nonnull) UIFont *titleFont;

/** Style of ink animations on item interaction. */
@property(nonatomic) MDCInkStyle inkStyle;

/** Color of ink splashes. Default is 25% white. */
@property(nonatomic, strong, nonnull) UIColor *inkColor;

/** Padding in points between the title and image components, according to the MD spec. */
@property(nonatomic) CGFloat titleImagePadding;

/**
 Indicates if all tab titles should be uppercased for display. If NO, item titles will be
 displayed verbatim.

 Default is YES and is recommended whenever possible.
 */
@property(nonatomic) BOOL displaysUppercaseTitles;

@end
