#import <UIKit/UIKit.h>

/** Appearance for content within tab bar items. */
typedef NS_ENUM(NSInteger, MDCTabBarItemAppearance) {
  /** Tabs are shown as titles. */
  MDCTabBarItemAppearanceTitles,

  /** Tabs are shown as images. */
  MDCTabBarItemAppearanceImages,

  /** Tabs are shown as images with titles underneath. */
  MDCTabBarItemAppearanceTitledImages,
};
