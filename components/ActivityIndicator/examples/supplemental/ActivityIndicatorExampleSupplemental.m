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

/* IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to use Material Components for iOS.
 */

#import <Foundation/Foundation.h>

#import "ActivityIndicatorExampleSupplemental.h"
#import "MaterialTypography.h"

#import "CatalogStyle.h"

static NSString * const kCell = @"Cell";


@implementation ActivityIndicatorExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Activity Indicator", @"Activity Indicator" ];
}

+ (NSString *)catalogDescription {
  return @"Activity Indicator is a visual indication of an app loading content. It can display how "
         @"long an operation will take or visualize an unspecified wait time.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

@end

@implementation ActivityIndicatorExample (Supplemental)

- (void)setupExampleViews {

  [self.collectionView registerClass:[MDCCollectionViewTextCell class] forCellWithReuseIdentifier:kCell];

  // Set up container view of three activity indicators.
  UIView *indicators = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 160)];
  indicators.backgroundColor = [CatalogStyle greyColor];

  [indicators addSubview:self.activityIndicator1];
  [indicators addSubview:self.activityIndicator2];
  [indicators addSubview:self.activityIndicator3];

  self.activityIndicator1.center =
      CGPointMake(indicators.bounds.size.width / 3, indicators.bounds.size.height / 2);
  self.activityIndicator2.center =
      CGPointMake(indicators.bounds.size.width / 2, indicators.bounds.size.height / 2);
  self.activityIndicator3.center =
      CGPointMake(2 * indicators.bounds.size.width / 3, indicators.bounds.size.height / 2);

  self.indicators = indicators;


  self.onSwitch = [[UISwitch alloc] init];
  self.onSwitch.onTintColor = [CatalogStyle primaryColor];
  [self.onSwitch setOn:YES];
  [self.onSwitch addTarget:self
                    action:@selector(didChangeOnSwitch:)
          forControlEvents:UIControlEventValueChanged];

  CGRect sliderFrame = CGRectMake(0, 0, 160, 27);
  self.slider = [[UISlider alloc] initWithFrame:sliderFrame];
  self.slider.tintColor = [CatalogStyle primaryColor];
  self.slider.value = kActivityInitialProgress;
  [self.slider addTarget:self
                  action:@selector(didChangeSliderValue:)
        forControlEvents:UIControlEventValueChanged];
}

- (void)didChangeOnSwitch:(UISwitch *)onSwitch {
  if (onSwitch.on) {
    [self.activityIndicator1 startAnimating];
    [self.activityIndicator2 startAnimating];
    [self.activityIndicator3 startAnimating];
  } else {
    [self.activityIndicator1 stopAnimating];
    [self.activityIndicator2 stopAnimating];
    [self.activityIndicator3 stopAnimating];
  }
}

- (void)didChangeSliderValue:(UISlider *)slider {
  self.activityIndicator1.progress = slider.value;
  MDCCollectionViewTextCell *cell =
      (MDCCollectionViewTextCell *)[self.collectionView cellForItemAtIndexPath:
                                        [NSIndexPath indexPathForRow:1 inSection:0]];
  cell.textLabel.text = [NSString stringWithFormat:@"%.00f%%", slider.value * 100];
  [cell setNeedsDisplay];
}

#pragma mark - 


- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
  return 3;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView
    cellHeightAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == 0) return 160;
  return 56;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
  MDCCollectionViewTextCell *cell =
      [collectionView dequeueReusableCellWithReuseIdentifier:kCell forIndexPath:indexPath];
  cell.textLabel.text = @"";
  switch (indexPath.row) {
    case 0:
      cell.accessoryView = nil;
      cell.textLabel.text = nil;
      [cell addSubview:self.indicators];
      break;
    case 1:
      cell.accessoryView = self.slider;
      cell.textLabel.text = @"Progress";
      break;
    case 2:
      cell.accessoryView = self.onSwitch;
      cell.textLabel.text = @"Show Indicator";
      break;
    default:
      break;
  }
  return cell;
}


@end
