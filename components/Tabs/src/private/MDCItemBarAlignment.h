#import <Foundation/Foundation.h>

/** Alignment styles for items in a tab bar. */
typedef NS_ENUM(NSInteger, MDCItemBarAlignment) {
  /** Items are aligned on the leading edge and sized to fit their content. */
  MDCItemBarAlignmentLeading,

  /** Items are justified to equal size across the width of the screen. */
  MDCItemBarAlignmentJustified,

  /**
   * Items are sized to fit their content and center-aligned as a group. If they do not fit in view,
   * they will be leading-aligned instead.
   */
  MDCItemBarAlignmentCenter,

  /** Items are center-aligned on the selected item. */
  MDCItemBarAlignmentCenterSelected,
};
