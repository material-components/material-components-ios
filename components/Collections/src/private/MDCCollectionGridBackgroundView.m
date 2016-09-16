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

#import "MDCCollectionGridBackgroundView.h"

#import "MaterialCollectionLayoutAttributes.h"

@implementation MDCCollectionGridBackgroundView {
  UIImageView *_backgroundImageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonMDCCollectionGridBackgroundViewInit];
  }
  return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonMDCCollectionGridBackgroundViewInit];
  }
  return self;
}

- (void)commonMDCCollectionGridBackgroundViewInit {
  _backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
  _backgroundImageView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
  [self addSubview:_backgroundImageView];
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
  [super applyLayoutAttributes:layoutAttributes];
  NSAssert([layoutAttributes isKindOfClass:[MDCCollectionViewLayoutAttributes class]],
           @"LayoutAttributes must be a subclass of MDCCollectionViewLayoutAttributes.");
  MDCCollectionViewLayoutAttributes *attr = (MDCCollectionViewLayoutAttributes *)layoutAttributes;
  _backgroundImageView.image = attr.backgroundImage;
}

@end
