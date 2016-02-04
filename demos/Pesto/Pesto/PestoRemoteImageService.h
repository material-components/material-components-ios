#import <UIKit/UIKit.h>

@interface PestoRemoteImageService : NSObject

- (void)fetchImageDataFromURL:(NSURL *)url completion:(void (^)(NSData *))completion;

- (void)fetchImageDataFromURL:(NSURL *)url priority:(dispatch_queue_priority_t)priority
                   completion:(void (^)(NSData *))completion;

+ (instancetype)sharedService;

@end
