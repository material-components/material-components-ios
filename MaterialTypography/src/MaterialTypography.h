#import <Availability.h>
#import <Foundation/Foundation.h>

#if !defined(__IPHONE_6_0) || (__IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0)
#error "This component only supports iOS 6.0 and above."
#endif

#import "MDCFontResource.h"
#import "MDCRobotoFontLoader.h"
#import "MDCTypography.h"

/**
 * @defgroup Typography
 * @brief Material typography.
 */
