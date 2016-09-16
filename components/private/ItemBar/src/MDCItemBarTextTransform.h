#import <Foundation/Foundation.h>

/** Text transforms available for text in the tab bar. */
typedef NS_ENUM(NSInteger, MDCItemBarTextTransform) {
  /** Text is always displayed verbatim. */
  MDCItemBarTextTransformNone,

  /** Text is always uppercased for display. */
  MDCItemBarTextTransformUppercase,

  /** Text is always lowercased for display. */
  MDCItemBarTextTransformLowercase,

  /** Text is always title-cased for display. */
  MDCItemBarTextTransformCapitalize,
};
