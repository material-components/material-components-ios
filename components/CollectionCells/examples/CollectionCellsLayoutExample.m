/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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

#import "CollectionCellsLayoutExample.h"

#import "MaterialSwitch.h"
#import "MaterialTypography.h"

@interface SimpleModel : NSObject
@property(nonatomic, strong, nullable) NSString *text;
@property(nonatomic, strong, nullable) NSString *detailText;
@property(nonatomic) NSInteger textLines;
@property(nonatomic) NSInteger detailTextLines;
+ (instancetype)modelWithTextArray:(NSArray *)textArray textLineArray:(NSArray *)textLineArray;
@end

@implementation SimpleModel
- (instancetype)initWithTextArray:(NSArray *)textArray textLineArray:(NSArray *)textLineArray {
  self = [super init];
  if (self) {
    _text = textArray[0];
    _detailText = textArray[1];
    _textLines = [textLineArray[0] integerValue];
    _detailTextLines = [textLineArray[1] integerValue];
  }
  return self;
}

+ (instancetype)modelWithTextArray:(NSArray *)textArray textLineArray:(NSArray *)textLineArray {
  return [[self alloc] initWithTextArray:textArray textLineArray:textLineArray];
}

@end

static NSString *const kReusableIdentifierItem = @"itemCellIdentifier";
static NSString *const kExampleText =
    @"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Mauris tempus, enim non tincidunt "
     "rhoncus, lacus sapien sagittis mi, id gravida risus turpis ut libero. ";
static NSString *const kExampleDetailText =
    @"Pellentesque non quam ornare, porta urna sed, malesuada felis. Praesent at gravida felis, "
     "non facilisis enim. Proin dapibus laoreet lorem, in viverra leo dapibus a.";

#define RGBCOLOR(r, g, b) \
  [UIColor colorWithRed:(r) / 255.0f green:(g) / 255.0f blue:(b) / 255.0f alpha:1]
#define HEXCOLOR(hex) RGBCOLOR((((hex) >> 16) & 0xFF), (((hex) >> 8) & 0xFF), ((hex)&0xFF))

@implementation CollectionCellsLayoutExample {
  NSMutableArray *_content;
}

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Collection Cells", @"Cell Layout Example" ];
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Register cell class.
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forCellWithReuseIdentifier:kReusableIdentifierItem];

  // Populate content.
  _content = [NSMutableArray array];
  [_content addObject:[SimpleModel modelWithTextArray:@[ @"Show in Editing Mode", @"" ]
                                        textLineArray:@[ @(1), @(0) ]]];
  [_content addObject:[SimpleModel modelWithTextArray:@[ @"Single line text", @"" ]
                                        textLineArray:@[ @(1), @(0) ]]];
  [_content addObject:[SimpleModel modelWithTextArray:@[ kExampleText, @"" ]
                                        textLineArray:@[ @(2), @(0) ]]];
  [_content addObject:[SimpleModel modelWithTextArray:@[ kExampleText, @"" ]
                                        textLineArray:@[ @(3), @(0) ]]];
  [_content addObject:[SimpleModel modelWithTextArray:@[ @"", @"Detail text" ]
                                        textLineArray:@[ @(0), @(1) ]]];
  [_content addObject:[SimpleModel modelWithTextArray:@[ kExampleText, kExampleDetailText ]
                                        textLineArray:@[ @(1), @(1) ]]];
  [_content addObject:[SimpleModel modelWithTextArray:@[ kExampleText, kExampleDetailText ]
                                        textLineArray:@[ @(1), @(2) ]]];
  [_content addObject:[SimpleModel modelWithTextArray:@[ kExampleText, @"Detail text" ]
                                        textLineArray:@[ @(2), @(1) ]]];

  // Customize collection view settings.
  self.styler.cellStyle = MDCCollectionViewCellStyleCard;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return [_content count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kReusableIdentifierItem
                                                forIndexPath:indexPath];
  SimpleModel *model = _content[indexPath.item];
  cell.textLabel.text = model.text;
  cell.textLabel.numberOfLines = model.textLines;
  cell.detailTextLabel.text = model.detailText;
  cell.detailTextLabel.numberOfLines = model.detailTextLines;

  // Add accessory views.
  if (indexPath.item == 0) {
    // Add switch as accessory view.
    MDCSwitch *editingSwitch = [[MDCSwitch alloc] initWithFrame:CGRectZero];
    editingSwitch.on = self.editor.isEditing;
    [editingSwitch addTarget:self
                      action:@selector(didSwitch:)
            forControlEvents:UIControlEventValueChanged];
    cell.accessoryView = editingSwitch;
  }

  if (indexPath.item == 2) {
    cell.accessoryType = MDCCollectionViewCellAccessoryCheckmark;
  } else if (indexPath.item == 5 || indexPath.item == 6) {
    cell.imageView.image =
        [self imageWithSize:CGSizeMake(40, 40) color:HEXCOLOR(0x80CBC4) cornerRadius:20];
  }

  return cell;
}

#pragma mark - <MDCCollectionViewStylingDelegate>

- (CGFloat)collectionView:(UICollectionView *)collectionView
    cellHeightAtIndexPath:(NSIndexPath *)indexPath {
  SimpleModel *model = _content[indexPath.item];
  NSInteger numberOfLines = model.textLines + model.detailTextLines;
  if (numberOfLines == 1) {
    return MDCCellDefaultOneLineHeight;
  } else if (numberOfLines == 2) {
    return MDCCellDefaultTwoLineHeight;
  } else if (numberOfLines == 3) {
    return MDCCellDefaultThreeLineHeight;
  }
  return MDCCellDefaultOneLineHeight;
}

#pragma mark - <MDCCollectionViewEditingDelegate>

- (BOOL)collectionViewAllowsEditing:(UICollectionView *)collectionView {
  return YES;
}

- (BOOL)collectionViewAllowsReordering:(UICollectionView *)collectionView {
  return YES;
}

- (BOOL)collectionView:(UICollectionView *)collectionView
    canEditItemAtIndexPath:(NSIndexPath *)indexPath {
  return (indexPath.item != 0);
}

- (BOOL)collectionView:(UICollectionView *)collectionView
    canMoveItemAtIndexPath:(NSIndexPath *)indexPath {
  return (indexPath.item != 0);
}

#pragma mark UIControlEvents

- (void)didSwitch:(id)sender {
  MDCSwitch *switchControl = sender;
  [self.editor setEditing:switchControl.isOn animated:YES];
}

#pragma mark - Private helper methods

- (UIImage *)imageWithSize:(CGSize)size color:(UIColor *)color cornerRadius:(CGFloat)cornerRadius {
  // Create a colored image.
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
  view.backgroundColor = color;
  view.layer.cornerRadius = cornerRadius;
  UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), NO, 0);
  [view.layer renderInContext:UIGraphicsGetCurrentContext()];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  return image;
}

@end
