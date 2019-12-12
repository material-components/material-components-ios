// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import "supplemental/CollectionCellsLayoutExample.h"
#import "MaterialTypography.h"

@interface SimpleModel : NSObject
@property(nonatomic, strong, nullable) NSString *text;
@property(nonatomic, strong, nullable) NSString *detailText;
@property(nonatomic) NSInteger textLines;
@property(nonatomic) NSInteger detailTextLines;
@property(nonatomic) BOOL checkMark;
@property(nonatomic) BOOL circle;
+ (instancetype)modelWithTextArray:(NSArray *)textArray
                     textLineArray:(NSArray *)textLineArray
                         checkMark:(BOOL)checkmark
                            circle:(BOOL)circle;
@end

@implementation SimpleModel
- (instancetype)initWithTextArray:(NSArray *)textArray
                    textLineArray:(NSArray *)textLineArray
                        checkMark:(BOOL)checkmark
                           circle:(BOOL)circle {
  self = [super init];
  if (self) {
    _text = textArray[0];
    _detailText = textArray[1];
    _textLines = [textLineArray[0] integerValue];
    _detailTextLines = [textLineArray[1] integerValue];
    _checkMark = checkmark;
    _circle = circle;
  }
  return self;
}

+ (instancetype)modelWithTextArray:(NSArray *)textArray
                     textLineArray:(NSArray *)textLineArray
                         checkMark:(BOOL)checkmark
                            circle:(BOOL)circle {
  return [[self alloc] initWithTextArray:textArray
                           textLineArray:textLineArray
                               checkMark:checkmark
                                  circle:circle];
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
  [UIColor colorWithRed:(r) / (CGFloat)255 green:(g) / (CGFloat)255 blue:(b) / (CGFloat)255 alpha:1]
#define HEXCOLOR(hex) RGBCOLOR((((hex) >> 16) & 0xFF), (((hex) >> 8) & 0xFF), ((hex)&0xFF))

@implementation CollectionCellsLayoutExample {
  NSMutableArray *_content;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  // Register cell class.
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forCellWithReuseIdentifier:kReusableIdentifierItem];

  // Populate content.
  _content = [NSMutableArray array];
  [_content addObject:[SimpleModel modelWithTextArray:@[ @"Show in Editing Mode", @"" ]
                                        textLineArray:@[ @(1), @(0) ]
                                            checkMark:NO
                                               circle:NO]];
  [_content addObject:[SimpleModel modelWithTextArray:@[ @"Single line text", @"" ]
                                        textLineArray:@[ @(1), @(0) ]
                                            checkMark:NO
                                               circle:NO]];
  [_content addObject:[SimpleModel modelWithTextArray:@[ kExampleText, @"" ]
                                        textLineArray:@[ @(2), @(0) ]
                                            checkMark:YES
                                               circle:NO]];
  [_content addObject:[SimpleModel modelWithTextArray:@[ kExampleText, @"" ]
                                        textLineArray:@[ @(3), @(0) ]
                                            checkMark:NO
                                               circle:NO]];
  [_content addObject:[SimpleModel modelWithTextArray:@[ @"", @"Detail text" ]
                                        textLineArray:@[ @(0), @(1) ]
                                            checkMark:NO
                                               circle:NO]];
  [_content addObject:[SimpleModel modelWithTextArray:@[ kExampleText, kExampleDetailText ]
                                        textLineArray:@[ @(1), @(1) ]
                                            checkMark:NO
                                               circle:YES]];
  [_content addObject:[SimpleModel modelWithTextArray:@[ kExampleText, kExampleDetailText ]
                                        textLineArray:@[ @(1), @(2) ]
                                            checkMark:NO
                                               circle:YES]];
  [_content addObject:[SimpleModel modelWithTextArray:@[ kExampleText, @"Detail text" ]
                                        textLineArray:@[ @(2), @(1) ]
                                            checkMark:NO
                                               circle:NO]];

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
    UISwitch *editingSwitch = [[UISwitch alloc] initWithFrame:CGRectZero];
    editingSwitch.on = self.editor.isEditing;
    [editingSwitch addTarget:self
                      action:@selector(didSwitch:)
            forControlEvents:UIControlEventValueChanged];
    cell.accessoryView = editingSwitch;
  }

  if (model.checkMark) {
    cell.accessoryType = MDCCollectionViewCellAccessoryCheckmark;
  }
  if (model.circle) {
    cell.imageView.image = [self imageWithSize:CGSizeMake(40, 40)
                                         color:HEXCOLOR(0x80CBC4)
                                  cornerRadius:20];
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

- (void)collectionView:(UICollectionView *)collectionView
    willMoveItemAtIndexPath:(nonnull NSIndexPath *)indexPath
                toIndexPath:(nonnull NSIndexPath *)newIndexPath {
  // Update Model
  SimpleModel *model = _content[indexPath.item];
  [_content removeObjectAtIndex:indexPath.item];
  [_content insertObject:model atIndex:newIndexPath.item];
}

#pragma mark UIControlEvents

- (void)didSwitch:(id)sender {
  UISwitch *switchControl = sender;
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

#pragma mark - CatalogByConvention

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Collection Cells", @"Cell Layout Example" ],
    @"primaryDemo" : @NO,
    @"presentable" : @NO,
  };
}

@end
