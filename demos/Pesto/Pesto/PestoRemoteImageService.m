#import "PestoRemoteImageService.h"

@interface PestoRemoteImageService ()

@property(nonatomic) NSCache *dataCache;
@property(nonatomic) NSCache *imageCache;
@property(nonatomic) NSCache *thumbnailImageCache;
@property(nonatomic) NSMutableDictionary *networkImageRequested;

@end

@implementation PestoRemoteImageService

- (instancetype)init {
  self = [super init];
  if (self) {
    self.dataCache = [[NSCache alloc] init];
    self.imageCache = [[NSCache alloc] init];
    self.thumbnailImageCache = [[NSCache alloc] init];
    self.networkImageRequested = [NSMutableDictionary dictionary];
  }
  return self;
}

- (UIImage *)fetchImageFromURL:(NSURL *)url {
  UIImage *image = [_imageCache objectForKey:url];
  if (image) {
    return image;
  }

  // Prevent the same image from being requested again if a network request is in progress.
  if ([_networkImageRequested objectForKey:url.absoluteString] != nil) {
    return nil;
  }
  [_networkImageRequested setValue:url forKey:url.absoluteString];
  NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
  if (!imageData) {
    return nil;
  }
  if (imageData) {
    [_dataCache setObject:imageData forKey:url];
  } else {
    return nil;
  }
  image = [UIImage imageWithData:imageData];
  [_imageCache setObject:image forKey:url];
  return image;
}

- (UIImage *)fetchThumbnailImageFromURL:(NSURL *)url {
  UIImage *thumbnailImage = [_thumbnailImageCache objectForKey:url];
  if (thumbnailImage == nil) {
    UIImage *image = [self fetchImageFromURL:url];
    if (!image) {
      return nil;
    }
    thumbnailImage = [self createThumbnailWithImage:image];
    [_thumbnailImageCache setObject:thumbnailImage forKey:url];
  }
  return thumbnailImage;
}

- (void)fetchImageAndThumbnailFromURL:(NSURL *)url
                           completion:(void (^)(UIImage *, UIImage *))completion {
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
    UIImage *image = [self fetchImageFromURL:url];
    UIImage *thumbnailImage = [self fetchThumbnailImageFromURL:url];
    completion(image, thumbnailImage);
  });
}

- (UIImage *)createThumbnailWithImage:(UIImage *)image {
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
