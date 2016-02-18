#import "PestoData.h"

NSString *const PestoDataBaseURL =
    @"https://www.gstatic.com/angular/material-adaptive/pesto/";

@interface PestoData ()

@end

@implementation PestoData

- (instancetype)init {
  self = [super init];
  if (self) {
    [self setupData];
  }
  return self;
}

- (void)setupData {
  _imageFileNames = @[ @"image2-01.png",
                       @"blue-potato.jpg",
                       @"image1-01.png",
                       @"sausage.jpg",
                       @"white-rice.jpg",
                       @"IMG_5447.jpg",
                       @"IMG_0575.jpg",
                       @"IMG_5438.jpg",
                       @"IMG_5332.jpg",
                       @"bok-choy.jpg",
                       @"pasta.png",
                       @"fish-steaks.jpg",
                       @"image2-01.png",
                       @"blue-potato.jpg",
                       @"image1-01.png",
                       @"sausage.jpg",
                       @"white-rice.jpg",
                       @"IMG_5447.jpg" ];

  _titles = @[ @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Apple pie",
               @"Belgian waffles",
               @"Chicken Kiev",
               @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Apple pie",
               @"Belgian waffles",
               @"Chicken Kiev",
               @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Pesto Bruchetta",
               @"Chocolate cookies",
               @"Apple pie",
               @"Belgian waffles",
               @"Chicken Kiev",
               @"Pesto Bruchetta" ];

  _authors = @[ @"Alice Jones",
                @"Bob Smith",
                @"Carol Clark",
                @"Dave Johnson",
                @"Mallory Masters",
                @"Alice Jones",
                @"Bob Smith",
                @"Carol Clark",
                @"Dave Johnson",
                @"Mallory Masters",
                @"Alice Jones",
                @"Bob Smith",
                @"Mallory Masters",
                @"Alice Jones",
                @"Bob Smith",
                @"Dave Johnson",
                @"Mallory Masters",
                @"Alice Jones" ];

  _iconNames = @[ @"Fish",
                  @"Healthy",
                  @"Main",
                  @"Meat",
                  @"Spicy",
                  @"Veggie",
                  @"Fish",
                  @"Healthy",
                  @"Main",
                  @"Meat",
                  @"Spicy",
                  @"Veggie",
                  @"Meat",
                  @"Spicy",
                  @"Veggie",
                  @"Meat",
                  @"Spicy",
                  @"Veggie" ];
}

@end
