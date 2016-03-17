#import <UIKit/UIKit.h>

@interface RemoteImageService : NSObject

- (void)fetchImageAndThumbnailFromURL:(NSURL *)url
                           completion:(void (^)(UIImage *, UIImage *))completion;

+ (instancetype)sharedService;

@end
