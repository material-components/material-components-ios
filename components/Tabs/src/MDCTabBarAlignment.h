#import <Foundation/Foundation.h>

/** Alignment styles for items in a tab bar. */
typedef NS_ENUM(NSInteger, MDCTabBarAlignment) {
  /** Items are aligned on the leading edge and sized to fit their content. */
  MDCTabBarAlignmentLeading,

  /**
   Items are justified to equal size across the width of the screen. Overscrolling is disabled
   for this alignment.
   */
  MDCTabBarAlignmentJustified,

  /**
   Items are sized to fit their content and center-aligned as a group. If they do not fit in view,
   they will be leading-aligned instead.
   */
  MDCTabBarAlignmentCenter,

  /** Tabs are center-aligned on the selected item. */
  MDCTabBarAlignmentCenterSelected,
};
