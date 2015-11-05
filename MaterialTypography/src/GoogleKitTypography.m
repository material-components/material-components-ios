#import <Availability.h>

#if !defined(__IPHONE_6_0) || (__IPHONE_OS_VERSION_MIN_REQUIRED < __IPHONE_6_0)
#error "This component only supports iOS 6.0 and above."
#endif

#import "googlemac/iPhone/Shared/GoogleKit/Typography/GOOFontResource.m"
#import "googlemac/iPhone/Shared/GoogleKit/Typography/GOORobotoFontLoader.m"
#import "googlemac/iPhone/Shared/GoogleKit/Typography/GOOTypography.m"
#import "googlemac/iPhone/Shared/GoogleKit/Typography/GOOTypography+Deprecated.m"
#import "googlemac/iPhone/Shared/GoogleKit/Typography/GOOTypography+GoogleAdditions.m"
#import "googlemac/iPhone/Shared/GoogleKit/Typography/Private/GOOTypography+Constants.m"
#import "googlemac/iPhone/Shared/GoogleKit/Typography/Private/GOOTypographyFontLoader.m"
