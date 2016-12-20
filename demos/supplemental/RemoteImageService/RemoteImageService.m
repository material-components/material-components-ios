/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

#import "RemoteImageService.h"

@interface RemoteImageService ()

@property(nonatomic) NSCache *dataCache;
@property(nonatomic) NSCache *imageCache;
@property(nonatomic) NSCache *thumbnailImageCache;
@property(nonatomic) NSCache *networkImageRequested;

@end

@implementation RemoteImageService

- (instancetype)init {
  self = [super init];
  if (self) {
    _dataCache = [[NSCache alloc] init];
    _imageCache = [[NSCache alloc] init];
    _thumbnailImageCache = [[NSCache alloc] init];
    _networkImageRequested = [[NSCache alloc] init];
  }
  return self;
}

- (UIImage *)fetchImageFromURL:(NSURL *)url {
  UIImage *image = [self.imageCache objectForKey:url];
  if (image) {
    return image;
  } else {
    // Prevent the same image from being requested again if a network request is in progress.
    if ([self.networkImageRequested objectForKey:url.absoluteString] != nil) {
      return nil;
    } else {
      [self.networkImageRequested setObject:url forKey:url.absoluteString];
    }
  }

  NSData *imageData = [[NSData alloc] initWithContentsOfURL:url];
  if (!imageData) {
    return nil;
  }
  if (imageData) {
    [self.dataCache setObject:imageData forKey:url];
  } else {
    return nil;
  }
  image = [[UIImage alloc] initWithData:imageData];
  [self.imageCache setObject:image forKey:url];
  return image;
}

- (UIImage *)fetchThumbnailImageFromURL:(NSURL *)url {
  UIImage *thumbnailImage = [self.thumbnailImageCache objectForKey:url];
  if (thumbnailImage == nil) {
    UIImage *image = [self fetchImageFromURL:url];
    if (!image) {
      return nil;
    }
    thumbnailImage = [self createThumbnailWithImage:image];
    [self.thumbnailImageCache setObject:thumbnailImage forKey:url];
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
  UIImage *thumbnailImage = [RemoteImageService imageWithImage:image scaledToSize:scaledSize];
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
  static RemoteImageService *instance = nil;
  static dispatch_once_t onceToken = 0;
  dispatch_once(&onceToken, ^{
    instance = [[RemoteImageService alloc] init];
  });

  return instance;
}

@end
