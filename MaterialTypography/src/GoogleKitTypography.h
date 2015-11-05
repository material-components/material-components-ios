#import <Availability.h>
#import <Foundation/Foundation.h>

#if !defined(__IPHONE_6_0) || (__IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0)
#error "This component only supports iOS 6.0 and above."
#endif

#import "googlemac/iPhone/Shared/GoogleKit/Typography/GOOFontResource.h"
#import "googlemac/iPhone/Shared/GoogleKit/Typography/GOORobotoFontLoader.h"
#import "googlemac/iPhone/Shared/GoogleKit/Typography/GOOTypography.h"
#import "googlemac/iPhone/Shared/GoogleKit/Typography/GOOTypography+Deprecated.h"
#import "googlemac/iPhone/Shared/GoogleKit/Typography/GOOTypography+GoogleAdditions.h"
#import "googlemac/iPhone/Shared/GoogleKit/Typography/GOOTypographyConfig.h"

/**
 * @defgroup Typography
 * @brief Material typography.
 */
