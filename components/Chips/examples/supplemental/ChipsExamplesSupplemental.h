// Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.
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

#import <UIKit/UIKit.h>
#import "MaterialColorScheme.h"
#import "MaterialShapeScheme.h"
#import "MaterialTypographyScheme.h"

@class MDCChipView;
@class ChipModel;

@interface ExampleChipCollectionViewController : UICollectionViewController
@end

@interface ChipsChoiceExampleViewController
    : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic, strong) NSArray<NSString *> *titles;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCShapeScheme *shapeScheme;
@end

@interface ChipsActionExampleViewController
    : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic, strong) NSArray<NSString *> *titles;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCShapeScheme *shapeScheme;
@end

@interface ChipsCollectionExampleViewController
    : ExampleChipCollectionViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic, strong) NSArray<NSString *> *titles;
@end

@interface ChipsCustomizedExampleViewController
    : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic, strong) NSArray<NSString *> *titles;
@end

@interface ChipsCustomizedExampleViewController (Supplemental)
- (UIImage *)doneImage;
@end

@interface ChipsFilterExampleViewController
    : UIViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@property(nonatomic, strong) NSArray<NSString *> *titles;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCShapeScheme *shapeScheme;
@end

@interface ChipsFilterAnimatedExampleViewController
    : ChipsFilterExampleViewController <UICollectionViewDelegate, UICollectionViewDataSource>
@end

@interface ChipsFilterExampleViewController (Supplemental)
- (UIImage *)doneImage;
@end

@interface ChipsInputExampleViewController : UIViewController
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;
@property(nonatomic, strong) MDCSemanticColorScheme *colorScheme;
@property(nonatomic, strong) MDCShapeScheme *shapeScheme;
@end

@interface ChipsSizingExampleViewController : UIViewController
@end

@interface ChipsSizingExampleViewController (Supplemental)
- (UIImage *)faceImage;
- (UIButton *)deleteButton;
@end

@interface ChipsTypicalUseViewController
    : ExampleChipCollectionViewController <UICollectionViewDelegate,
                                           UICollectionViewDataSource,
                                           UICollectionViewDelegateFlowLayout>
@property(nonatomic, strong) NSArray<ChipModel *> *model;
@property(nonatomic, strong) MDCShapeScheme *shapeScheme;
@property(nonatomic, strong) MDCTypographyScheme *typographyScheme;
@end

@interface ChipsTypicalUseViewController (Supplemental)
- (UIImage *)doneImage;
@end

@interface ChipsShapingExampleViewController : UIViewController
@end

@interface ChipsShapingExampleViewController (Supplemental)
- (UIImage *)faceImage;
- (UIButton *)deleteButton;
@end

@interface ChipModel : NSObject
@property(nonatomic, strong) NSString *title;
@property(nonatomic, assign) BOOL showProfilePic;
@property(nonatomic, assign) BOOL showDoneImage;
@property(nonatomic, assign) BOOL showDeleteButton;
- (void)apply:(MDCChipView *)cell;
@end

static inline ChipModel *MakeModel(NSString *title,
                                   BOOL showProfilePic,
                                   BOOL showDoneImage,
                                   BOOL showDeleteButton) {
  ChipModel *chip = [[ChipModel alloc] init];
  chip.title = title;
  chip.showProfilePic = showProfilePic;
  chip.showDoneImage = showDoneImage;
  chip.showDeleteButton = showDeleteButton;
  return chip;
};
