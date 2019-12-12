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

#import <XCTest/XCTest.h>
#import "MaterialCollections.h"

@interface FakeUICollectionViewUpdateItem : UICollectionViewUpdateItem {
  NSIndexPath *_indexPathBeforeUpdate;
  NSIndexPath *_indexPathAfterUpdate;
  UICollectionUpdateAction _updateAction;
}
@end

@implementation FakeUICollectionViewUpdateItem

- (void)setIndexPathBeforeUpdate:(NSIndexPath *)indexPath {
  _indexPathBeforeUpdate = indexPath;
}

- (NSIndexPath *)indexPathBeforeUpdate {
  return _indexPathBeforeUpdate;
}

- (void)setIndexPathAfterUpdate:(NSIndexPath *)indexPath {
  _indexPathAfterUpdate = indexPath;
}

- (NSIndexPath *)indexPathAfterUpdate {
  return _indexPathAfterUpdate;
}

- (void)setUpdateAction:(UICollectionUpdateAction)updateAction {
  _updateAction = updateAction;
}

- (UICollectionUpdateAction)updateAction {
  return _updateAction;
}

@end

@interface MDCCollectionViewFlowLayoutTests : XCTestCase <UICollectionViewDataSource>

@end

@implementation MDCCollectionViewFlowLayoutTests

- (void)testPrepareForCollectionViewUpdatesInsertSection {
  // Given
  MDCCollectionViewFlowLayout *layout = [[MDCCollectionViewFlowLayout alloc] init];

  UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                        collectionViewLayout:layout];
  collectionView.dataSource = self;
  NSMutableArray<UICollectionViewUpdateItem *> *updates = [NSMutableArray array];
  FakeUICollectionViewUpdateItem *section1Update = [[FakeUICollectionViewUpdateItem alloc] init];
  [section1Update setIndexPathBeforeUpdate:nil];
  [section1Update setIndexPathAfterUpdate:[NSIndexPath indexPathForItem:NSNotFound inSection:1]];
  section1Update.updateAction = UICollectionUpdateActionInsert;
  [updates addObject:section1Update];

  // When
  [layout prepareForCollectionViewUpdates:[updates copy]];

  // Then
  UICollectionViewLayoutAttributes *section1Attributes = [layout
      initialLayoutAttributesForAppearingItemAtIndexPath:[NSIndexPath indexPathForItem:NSNotFound
                                                                             inSection:1]];
  XCTAssertNotNil(section1Attributes,
                  @"Section 1 has an insert so the attributes should be non-nil.");
  XCTAssertEqual(0, section1Attributes.alpha);
  XCTAssertTrue(CGRectEqualToRect(CGRectZero, section1Attributes.bounds),
                @"The bounds should be the zero rect.\nReceived: %@",
                NSStringFromCGRect(section1Attributes.bounds));
  XCTAssertTrue(
      CGAffineTransformEqualToTransform(CGAffineTransformIdentity, section1Attributes.transform),
      @"The transform should be the transform because the attributes have zero-height "
      @"bounds.\nIdentity: %@\nReceived: %@",
      NSStringFromCGAffineTransform(CGAffineTransformIdentity),
      NSStringFromCGAffineTransform(section1Attributes.transform));

  UICollectionViewLayoutAttributes *section0Attributes = [layout
      initialLayoutAttributesForAppearingItemAtIndexPath:[NSIndexPath indexPathForItem:NSNotFound
                                                                             inSection:0]];
  XCTAssertNil(section0Attributes, @"Section 0 has no inserts so the attributes should be nil.");
  section1Attributes = [layout
      finalLayoutAttributesForDisappearingItemAtIndexPath:[NSIndexPath indexPathForItem:NSNotFound
                                                                              inSection:1]];
  XCTAssertNil(section1Attributes);
  section0Attributes = [layout
      finalLayoutAttributesForDisappearingItemAtIndexPath:[NSIndexPath indexPathForItem:NSNotFound
                                                                              inSection:0]];
  XCTAssertNil(section0Attributes);
}

- (void)testPrepareForCollectionViewUpdatesInsertItem {
  // Given
  MDCCollectionViewFlowLayout *layout = [[MDCCollectionViewFlowLayout alloc] init];

  UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                        collectionViewLayout:layout];
  collectionView.dataSource = self;
  NSMutableArray<UICollectionViewUpdateItem *> *updates = [NSMutableArray array];
  FakeUICollectionViewUpdateItem *section0Update = [[FakeUICollectionViewUpdateItem alloc] init];
  [section0Update setIndexPathBeforeUpdate:nil];
  [section0Update setIndexPathAfterUpdate:[NSIndexPath indexPathForItem:0 inSection:0]];
  section0Update.updateAction = UICollectionUpdateActionInsert;
  [updates addObject:section0Update];

  // When
  [layout prepareForCollectionViewUpdates:[updates copy]];

  // Then
  UICollectionViewLayoutAttributes *section1Attributes =
      [layout initialLayoutAttributesForAppearingItemAtIndexPath:[NSIndexPath indexPathForItem:1
                                                                                     inSection:1]];
  XCTAssertNotNil(section1Attributes,
                  @"Section 1 has an insert so the attributes should be non-nil.");
  XCTAssertEqual(1, section1Attributes.alpha);
  XCTAssertTrue(CGRectEqualToRect(CGRectZero, section1Attributes.bounds),
                @"The bounds should be the zero rect.\nReceived: %@",
                NSStringFromCGRect(section1Attributes.bounds));
  XCTAssertTrue(
      CGAffineTransformEqualToTransform(CGAffineTransformIdentity, section1Attributes.transform),
      @"The transform should be the transform because the attributes have zero-height "
      @"bounds.\nIdentity: %@\nReceived: %@",
      NSStringFromCGAffineTransform(CGAffineTransformIdentity),
      NSStringFromCGAffineTransform(section1Attributes.transform));

  UICollectionViewLayoutAttributes *section0Attributes =
      [layout initialLayoutAttributesForAppearingItemAtIndexPath:[NSIndexPath indexPathForItem:0
                                                                                     inSection:0]];
  XCTAssertNotNil(section0Attributes,
                  @"Section 0 has an insert so the attributes should be non-nil.");
  XCTAssertEqual(0, section0Attributes.alpha);
  XCTAssertTrue(CGRectEqualToRect(CGRectZero, section0Attributes.bounds),
                @"The bounds should be the zero rect.\nReceived: %@",
                NSStringFromCGRect(section0Attributes.bounds));
  XCTAssertTrue(
      CGAffineTransformEqualToTransform(CGAffineTransformIdentity, section0Attributes.transform),
      @"The transform should be the transform because the attributes have zero-height "
      @"bounds.\nIdentity: %@\nReceived: %@",
      NSStringFromCGAffineTransform(CGAffineTransformIdentity),
      NSStringFromCGAffineTransform(section0Attributes.transform));

  section1Attributes =
      [layout finalLayoutAttributesForDisappearingItemAtIndexPath:[NSIndexPath indexPathForItem:0
                                                                                      inSection:1]];
  XCTAssertNil(section1Attributes);
  section0Attributes =
      [layout finalLayoutAttributesForDisappearingItemAtIndexPath:[NSIndexPath indexPathForItem:0
                                                                                      inSection:0]];
  XCTAssertNil(section0Attributes);
}

- (void)testPrepareForCollectionViewUpdatesDeleteSection {
  // Given
  MDCCollectionViewFlowLayout *layout = [[MDCCollectionViewFlowLayout alloc] init];
  UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                        collectionViewLayout:layout];
  collectionView.dataSource = self;
  NSMutableArray<UICollectionViewUpdateItem *> *updates = [NSMutableArray array];
  FakeUICollectionViewUpdateItem *section1Update = [[FakeUICollectionViewUpdateItem alloc] init];
  [section1Update setIndexPathBeforeUpdate:[NSIndexPath indexPathForItem:NSNotFound inSection:1]];
  [section1Update setIndexPathAfterUpdate:nil];
  section1Update.updateAction = UICollectionUpdateActionDelete;
  [updates addObject:section1Update];

  // When
  [layout prepareForCollectionViewUpdates:[updates copy]];

  // Then
  UICollectionViewLayoutAttributes *section1Attributes = [layout
      initialLayoutAttributesForAppearingItemAtIndexPath:[NSIndexPath indexPathForItem:NSNotFound
                                                                             inSection:1]];
  XCTAssertNil(section1Attributes, @"Section 1 has no inserts so the attributes should be nil.");
  UICollectionViewLayoutAttributes *section0Attributes = [layout
      initialLayoutAttributesForAppearingItemAtIndexPath:[NSIndexPath indexPathForItem:NSNotFound
                                                                             inSection:0]];
  XCTAssertNil(section0Attributes, @"Section 0 has no inserts so the attributes should be nil.");
  section1Attributes = [layout
      finalLayoutAttributesForDisappearingItemAtIndexPath:[NSIndexPath indexPathForItem:NSNotFound
                                                                              inSection:1]];
  XCTAssertNil(section1Attributes);
  section0Attributes = [layout
      finalLayoutAttributesForDisappearingItemAtIndexPath:[NSIndexPath indexPathForItem:NSNotFound
                                                                              inSection:0]];
  XCTAssertNil(section0Attributes);
}

- (void)testPrepareForCollectionViewUpdatesDeleteItem {
  // Given
  MDCCollectionViewFlowLayout *layout = [[MDCCollectionViewFlowLayout alloc] init];
  UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                                        collectionViewLayout:layout];
  collectionView.dataSource = self;
  NSMutableArray<UICollectionViewUpdateItem *> *updates = [NSMutableArray array];
  FakeUICollectionViewUpdateItem *section1Update = [[FakeUICollectionViewUpdateItem alloc] init];
  [section1Update setIndexPathBeforeUpdate:[NSIndexPath indexPathForItem:1 inSection:1]];
  [section1Update setIndexPathAfterUpdate:nil];
  section1Update.updateAction = UICollectionUpdateActionDelete;
  [updates addObject:section1Update];

  // When
  [layout prepareForCollectionViewUpdates:[updates copy]];

  // Then
  UICollectionViewLayoutAttributes *section1Attributes =
      [layout initialLayoutAttributesForAppearingItemAtIndexPath:[NSIndexPath indexPathForItem:1
                                                                                     inSection:1]];
  XCTAssertNotNil(section1Attributes,
                  @"Section 1 has a delete so the attributes should be non-nil.");
  XCTAssertEqual(1, section1Attributes.alpha);
  XCTAssertTrue(CGRectEqualToRect(CGRectZero, section1Attributes.bounds),
                @"The bounds should be the zero rect.\nReceived: %@",
                NSStringFromCGRect(section1Attributes.bounds));
  XCTAssertTrue(
      CGAffineTransformEqualToTransform(CGAffineTransformIdentity, section1Attributes.transform),
      @"The transform should be the transform because the attributes have zero-height "
      @"bounds.\nIdentity: %@\nReceived: %@",
      NSStringFromCGAffineTransform(CGAffineTransformIdentity),
      NSStringFromCGAffineTransform(section1Attributes.transform));
  UICollectionViewLayoutAttributes *section0Attributes =
      [layout initialLayoutAttributesForAppearingItemAtIndexPath:[NSIndexPath indexPathForItem:1
                                                                                     inSection:0]];
  XCTAssertNotNil(section0Attributes,
                  @"Section 0 has a delete so the attributes should be non-nil.");
  XCTAssertEqual(1, section0Attributes.alpha);
  XCTAssertTrue(CGRectEqualToRect(CGRectZero, section0Attributes.bounds),
                @"The bounds should be the zero rect.\nReceived: %@",
                NSStringFromCGRect(section0Attributes.bounds));
  XCTAssertTrue(
      CGAffineTransformEqualToTransform(CGAffineTransformIdentity, section0Attributes.transform),
      @"The transform should be the transform because the attributes have zero-height "
      @"bounds.\nIdentity: %@\nReceived: %@",
      NSStringFromCGAffineTransform(CGAffineTransformIdentity),
      NSStringFromCGAffineTransform(section0Attributes.transform));
  section1Attributes =
      [layout finalLayoutAttributesForDisappearingItemAtIndexPath:[NSIndexPath indexPathForItem:1
                                                                                      inSection:1]];
  XCTAssertNil(section1Attributes);
  section0Attributes =
      [layout finalLayoutAttributesForDisappearingItemAtIndexPath:[NSIndexPath indexPathForItem:1
                                                                                      inSection:0]];
  XCTAssertNil(section0Attributes);
}

#pragma mark - <UICollectionViewDataSource>

// Never called in these tests
- (UICollectionViewCell *)collectionView:(UICollectionView *)cv
                  cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
  return nil;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 2;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 2;
}

@end
