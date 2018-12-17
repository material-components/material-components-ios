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

#import "supplemental/CollectionsEditingManyCellsExampleSupplemental.h"

static const NSInteger kSectionCount = 25;
static const NSInteger kSectionItemCount = 50;

@implementation CollectionsEditingManyCellsExample

- (void)viewDidLoad {
  [super viewDidLoad];

  // Add button to toggle edit mode.
  [self updatedRightBarButtonItem:NO];

  // Register cell class.
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forCellWithReuseIdentifier:kCollectionsEditingManyCellsCellIdentifierItem];
  // Optional
  // Register section header class
  [self.collectionView registerClass:[MDCCollectionViewTextCell class]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:kCollectionsEditingManyCellsHeaderReuseIdentifier];

  // Populate content.
  self.content = [NSMutableArray array];
  for (NSInteger i = 0; i < kSectionCount; i++) {
    NSMutableArray *items = [NSMutableArray array];
    for (NSInteger j = 0; j < kSectionItemCount; j++) {
      NSString *itemString =
          [NSString stringWithFormat:@"Section-%02ld Item-%02ld", (long)i, (long)j];
      [items addObject:itemString];
    }
    [self.content addObject:items];
  }

  // Customize collection view settings.
  self.styler.cellStyle = MDCCollectionViewCellStyleCard;
}

- (void)updatedRightBarButtonItem:(BOOL)isEditing {
  self.navigationItem.rightBarButtonItem =
      [[UIBarButtonItem alloc] initWithTitle:isEditing ? @"Cancel" : @"Edit"
                                       style:UIBarButtonItemStyleDone
                                      target:self
                                      action:@selector(toggleEditMode:)];
}

- (void)toggleEditMode:(id)sender {
  BOOL isEditing = self.editor.isEditing;
  [self updatedRightBarButtonItem:!isEditing];
  [self.editor setEditing:!isEditing animated:YES];
}

@end
