#import <UIKit/UIKit.h>

@interface PestoRemoteImageService : NSObject

@property(nonatomic) NSCache *thumbnailCache;

- (void)fetchImageDataFromURL:(NSURL *)url completion:(void (^)(NSData *))completion;

- (void)fetchImageDataFromURL:(NSURL *)url priority:(dispatch_queue_priority_t)priority
                   completion:(void (^)(NSData *))completion;

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;

+ (instancetype)sharedService;

@end
