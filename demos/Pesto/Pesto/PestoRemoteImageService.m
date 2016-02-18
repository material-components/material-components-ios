#import "PestoRemoteImageService.h"

@interface PestoRemoteImageService ()

@property(nonatomic) NSCache *cache;

@end

@implementation PestoRemoteImageService

- (instancetype)init {
  self = [super init];
  if (self) {
    _cache = [[NSCache alloc] init];
    _thumbnailCache = [[NSCache alloc] init];
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
      UIImage *thumbnailImage = [self createThumbnailWithImageData:imageData];
      [_thumbnailCache setObject:thumbnailImage forKey:url];
    }
    if (imageData == nil) {
      return;
    }
    completion(imageData);
  });
}

- (UIImage *)createThumbnailWithImageData:(NSData *)imageData {
  UIImage *image = [UIImage imageWithData:imageData];
  CGFloat scaleFactor = 0.2f;
  CGSize scaledSize = CGSizeMake(image.size.width * scaleFactor, image.size.height * scaleFactor);
  UIImage *thumbnailImage = [PestoRemoteImageService imageWithImage:image scaledToSize:scaledSize];
  return thumbnailImage;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
  UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
  [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
  UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return newImage;
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
