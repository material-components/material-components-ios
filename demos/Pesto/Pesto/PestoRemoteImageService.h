#import <UIKit/UIKit.h>

@interface PestoRemoteImageService : NSObject

- (void)fetchImageAndThumbnailFromURL:(NSURL *)url
                           completion:(void (^)(UIImage *, UIImage *))completion;

+ (instancetype)sharedService;

@end
