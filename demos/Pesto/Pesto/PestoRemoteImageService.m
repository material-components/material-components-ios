#import "PestoRemoteImageService.h"

@interface PestoRemoteImageService ()

@property(nonatomic) NSCache *cache;

@end

@implementation PestoRemoteImageService

- (instancetype)init {
  self = [super init];
  if (self) {
    _cache = [[NSCache alloc] init];
  }
  return self;
}

- (void)fetchImageDataFromURL:(NSURL *)url completion:(void (^)(NSData *))completion {
  [self fetchImageDataFromURL:url priority:DISPATCH_QUEUE_PRIORITY_DEFAULT completion:completion];
}

- (void)fetchImageDataFromURL:(NSURL *)url priority:(dispatch_queue_priority_t)priority
                   completion:(void (^)(NSData *))completion {
  dispatch_async(dispatch_get_global_queue(priority, 0), ^{
    NSData *imageData = [_cache objectForKey:url];
    if (!imageData) {
      imageData = [[NSData alloc] initWithContentsOfURL:url];
      [_cache setObject:imageData forKey:url];
    }
    completion(imageData);
  });
}

+ (instancetype)sharedService {
  static PestoRemoteImageService *instance = nil;
  static dispatch_once_t onceToken = 0;
  dispatch_once(&onceToken, ^{
    instance = [[PestoRemoteImageService alloc] init];
  });

  return instance;
}

@end
