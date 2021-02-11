// Copyright 2020-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import "MaterialCards.h"
#import "MaterialShapeLibrary.h"
#import "MaterialShapes.h"

@interface MDCShapeWithBorderExample : UIViewController
@property(strong, nonatomic) MDCCard *card;
@end

@implementation MDCShapeWithBorderExample

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = UIColor.whiteColor;
  self.card = [[MDCCard alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
  self.card.center = self.view.center;
  self.card.backgroundColor = UIColor.blueColor;

  MDCRectangleShapeGenerator *rectangleShape = [[MDCRectangleShapeGenerator alloc] init];
  [rectangleShape setCorners:[MDCCornerTreatment cornerWithRadius:8]];
  self.card.shapeGenerator = rectangleShape;
  [self.card setBorderColor:UIColor.blackColor forState:UIControlStateNormal];
  [self.card setBorderColor:UIColor.blackColor forState:UIControlStateHighlighted];
  [self.card setBorderWidth:1 forState:UIControlStateNormal];
  [self.card setBorderWidth:4 forState:UIControlStateHighlighted];

  [self.view addSubview:self.card];
}

@end

#pragma mark - Catalog by convention
@implementation MDCShapeWithBorderExample (CatlogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Shape", @"Card with Border example" ],
    @"primaryDemo" : @NO,
    @"presentable" : @YES,
  };
}

@end

@implementation MDCShapeWithBorderExample (SnapshotTestingByConvention)

- (void)testTappingMultipleTimesOnCard {
  // When
  self.card.highlighted = YES;
  self.card.highlighted = YES;
  self.card.highlighted = YES;
  self.card.highlighted = YES;
  self.card.highlighted = YES;
  self.card.highlighted = YES;
  self.card.highlighted = YES;
}

@end
