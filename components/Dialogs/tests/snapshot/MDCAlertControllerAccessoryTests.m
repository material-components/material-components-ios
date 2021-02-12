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

#import <UIKit/UIKit.h>

#import "MaterialButtons.h"
#import "MaterialSnapshot.h"

#import "MaterialButtons+Theming.h"
#import "MaterialDialogs.h"
#import "MDCAlertController+Testing.h"
#import "MaterialDialogs+Theming.h"
#import "MaterialTextFields.h"
#import "MaterialColorScheme.h"
#import "MaterialContainerScheme.h"
#import "MaterialTypographyScheme.h"

static NSString *const kCellId = @"cellId";

@interface TestView : UIView
@property(nonatomic, strong) MDCButton *button;
@property(nonatomic, strong) UILabel *label;
@end

@interface MDCAlertControllerAccessoryTests : MDCSnapshotTestCase <UICollectionViewDataSource>
@property(nonatomic, strong) MDCAlertController *alert;
@property(nonatomic, strong) MDCContainerScheme *containerScheme;
@end

@implementation MDCAlertControllerAccessoryTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.alert = [MDCAlertController alertControllerWithTitle:@"Title" message:nil];
  [self addOutlinedActionWithTitle:@"OK"];

  self.containerScheme = [[MDCContainerScheme alloc] init];
  self.containerScheme.colorScheme =
      [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201907];
  self.containerScheme.typographyScheme =
      [[MDCTypographyScheme alloc] initWithDefaults:MDCTypographySchemeDefaultsMaterial201902];
}

- (void)tearDown {
  self.alert = nil;
  self.containerScheme = nil;

  [super tearDown];
}

#pragma mark - Helpers

- (void)addOutlinedActionWithTitle:(NSString *)actionTitle {
  [self.alert addAction:[MDCAlertAction actionWithTitle:actionTitle
                                               emphasis:MDCActionEmphasisMedium
                                                handler:nil]];
}

- (void)generateSizedSnapshotAndVerifyForAlert:(MDCAlertController *)alert {
  [alert sizeToFitAutoLayoutContentInBounds:CGSizeMake(300.0f, 300.0f)];
  [alert highlightAlertPanels];
  [self generateSnapshotAndVerifyForView:alert.view];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  [view layoutIfNeeded];

  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

- (void)changeToRTL:(MDCAlertController *)alert {
  [self changeViewToRTL:alert.view];
}

#pragma mark - Tests

- (void)testAlertHasTextFieldAccessory {
  // Given
  MDCTextField *textField = [[MDCTextField alloc] init];
  textField.placeholder = @"A TextField with a placeholder.";
  [self.alert applyThemeWithScheme:self.containerScheme];

  // When
  self.alert.accessoryView = textField;

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alert];
}

/**
 Accesory Views that use autolayout to layout their subviews must set the accessoryView's
 translatesAutoresizingMaskIntoConstraints to YES, to allow the alert to calcualte the accessory
 view's size correctly (Material Alerts use manual layout). In more complicated autolayout cases,
 in which the snapshot size becomes very wide or otherwise caluclated incorrectly, implementing
 `systemLayoutSizeFittingSize:` and/or
 `systemLayoutSizeFittingSize:withHorizontalFittingPriority:verticalFittingPriority` may be
 necessary in order to provide the alert with an accurate size of the accessory view.
*/
- (void)testAlertWithMessageAndButtonAccessoryWithAutoLayoutNoSubclassing {
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 250.0f, 250.0f)];
  view.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.2f];

  UILabel *label = [[UILabel alloc] init];
  label.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.";
  label.numberOfLines = 0;
  label.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3f];

  MDCButton *button = [[MDCButton alloc] init];
  [button setTitle:@"Learn More" forState:UIControlStateNormal];
  [button applyOutlinedThemeWithScheme:self.containerScheme];

  label.translatesAutoresizingMaskIntoConstraints = NO;
  button.translatesAutoresizingMaskIntoConstraints = NO;
  // Material Alerts expect this flag to be true when autolayout is used.
  view.translatesAutoresizingMaskIntoConstraints = YES;
  [view addSubview:label];
  [view addSubview:button];

  [label.leadingAnchor constraintEqualToAnchor:view.leadingAnchor].active = YES;
  [label.trailingAnchor constraintEqualToAnchor:view.trailingAnchor].active = YES;
  [label.topAnchor constraintEqualToAnchor:view.topAnchor].active = YES;
  [label.bottomAnchor constraintEqualToAnchor:button.topAnchor].active = YES;

  [button.leadingAnchor constraintEqualToAnchor:view.leadingAnchor].active = YES;
  [button.trailingAnchor constraintLessThanOrEqualToAnchor:view.trailingAnchor].active = YES;
  [button.bottomAnchor constraintEqualToAnchor:view.bottomAnchor].active = YES;

  MDCAlertControllerView *alertView = (MDCAlertControllerView *)self.alert.view;
  alertView.contentInsets = UIEdgeInsetsMake(24.0f, 24.0f, 10.0f, 24.0f);

  // When
  self.alert.accessoryView = view;
  [self.alert applyThemeWithScheme:self.containerScheme];

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alert];
}

- (void)testSubclassedAccessoryViewWithAutoLayout {
  TestView *view = [[TestView alloc] initWithFrame:CGRectZero];
  view.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.2f];
  view.label.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3f];
  // Material Alerts expect this flag to be true when autolayout is used.
  view.translatesAutoresizingMaskIntoConstraints = YES;

  MDCAlertControllerView *alertView = (MDCAlertControllerView *)self.alert.view;
  alertView.contentInsets = UIEdgeInsetsMake(24.0f, 24.0f, 10.0f, 24.0f);

  // When
  self.alert.accessoryView = view;
  [self.alert applyThemeWithScheme:self.containerScheme];
  [view.button applyOutlinedThemeWithScheme:self.containerScheme];

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alert];
}

- (void)testAlertHasMessageAndButtonAccessoryWithManualLayout {
  MDCButton *button = [[MDCButton alloc] init];
  [button setTitle:@"Learn More" forState:UIControlStateNormal];
  [button applyOutlinedThemeWithScheme:self.containerScheme];
  [button sizeToFit];

  CGSize size = button.bounds.size;
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, size.width, size.height)];
  view.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.2f];

  [view addSubview:button];

  MDCAlertControllerView *alertView = (MDCAlertControllerView *)self.alert.view;
  alertView.accessoryViewVerticalInset = 0.0f;
  alertView.contentInsets = UIEdgeInsetsMake(24.0f, 24.0f, 10.0f, 24.0f);

  // When
  self.alert.message = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.";
  self.alert.accessoryView = view;
  [self.alert applyThemeWithScheme:self.containerScheme];

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alert];
}

- (void)testAlertHasCollectionViewAccessory {
  // Given
  UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
  CGRect frame = CGRectMake(0.0f, 0.0f, 320.0f, 160.0f);
  layout.itemSize = CGSizeMake(frame.size.width, frame.size.height / 4.0f);
  layout.minimumLineSpacing = 0.0f;
  UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame
                                                        collectionViewLayout:layout];
  collectionView.dataSource = self;
  [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kCellId];
  collectionView.backgroundColor = [UIColor whiteColor];
  [self.alert applyThemeWithScheme:self.containerScheme];
  [collectionView reloadData];

  // When
  self.alert.accessoryView = collectionView;

  // Then
  [self generateSizedSnapshotAndVerifyForAlert:self.alert];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellId
                                                                         forIndexPath:indexPath];
  [cell setBackgroundColor:[[UIColor purpleColor]
                               colorWithAlphaComponent:0.1f * (indexPath.item + 1)]];
  return cell;
}

@end

@implementation TestView

- (instancetype)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.label = [[UILabel alloc] init];
    self.label.text = @"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.";
    self.label.numberOfLines = 0;

    self.button = [[MDCButton alloc] init];
    [self.button setTitle:@"Learn More" forState:UIControlStateNormal];

    self.label.translatesAutoresizingMaskIntoConstraints = NO;
    self.button.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.label];
    [self addSubview:self.button];

    [self.label.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [self.label.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    [self.label.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [self.label.bottomAnchor constraintEqualToAnchor:self.button.topAnchor].active = YES;

    [self.button.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [self.button.trailingAnchor constraintLessThanOrEqualToAnchor:self.trailingAnchor].active = YES;
    [self.button.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
  }
  return self;
}

@end
