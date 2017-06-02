/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

#import "ProductCollectionViewCell.h"
#import "Product.h"

#import "MaterialButtons.h"

@interface ProductCollectionViewCell ()

@property(nonatomic) IBOutlet UIImageView *imageView;
@property(nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation ProductCollectionViewCell

- (void)awakeFromNib {
  [super awakeFromNib];
  self.favoriteButton.contentEdgeInsets = UIEdgeInsetsZero;
  UIImage *image = [[self.favoriteButton imageForState:UIControlStateNormal] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [self.favoriteButton setImage:image forState:UIControlStateNormal];

  image = [[self.favoriteButton imageForState:UIControlStateSelected] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  [self.favoriteButton setImage:image forState:UIControlStateSelected];
}

- (void)setProduct:(Product *)product {
  if (![_product isEqual:product]) {
    _product = product;

    self.imageView.image = [UIImage imageWithContentsOfFile:product.imagePath];
    self.priceLabel.text = product.price;
    self.favoriteButton.selected = product.isFavorite;
  }
}

@end
