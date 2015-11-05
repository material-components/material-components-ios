#import <Availability.h>
#import <Foundation/Foundation.h>

#if !defined(__IPHONE_6_0) || (__IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0)
#error "This component only supports iOS 6.0 and above."
#endif

#import "GOOFontResource.h"
#import "GOORobotoFontLoader.h"
#import "GOOTypography.h"
#import "GOOTypography+Deprecated.h"
#import "GOOTypography+GoogleAdditions.h"
/**
 * @defgroup Typography
 * @brief Material typography.
 */
