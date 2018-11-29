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

/* IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to use Material Components for iOS.
 */

#import "ActivityIndicatorExampleViewControllerSupplemental.h"

#import "MaterialTypography.h"

#define MDC_CATALOG_GREEN [UIColor colorWithRed:0 green:0xe6 / 255.0f blue:0x76 / 255.0f alpha:1]

static NSString *const kCell = @"Cell";

@implementation ActivityIndicatorExampleViewController (CatalogByConvention)

+ (NSDictionary *)catalogMetadata {
  return @{
    @"breadcrumbs" : @[ @"Activity Indicator", @"Activity Indicator" ],
    @"description" :
        @"Activity Indicator is a visual indication of an app loading content. "
        @"It can display how long an operation will take or visualize an unspecified wait time.",
    @"primaryDemo" : @YES,
    @"presentable" : @YES
  };
}

@end

@implementation ActivityIndicatorExampleViewController (Supplemental)

- (void)setupExampleViews {
  [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kCell];

  // Set up container view of three activity indicators.
  UIView *indicators =
      [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 160)];
  indicators.autoresizingMask = UIViewAutoresizingFlexibleWidth;

  [indicators addSubview:self.activityIndicator1];
  [indicators addSubview:self.activityIndicator2];
  [indicators addSubview:self.activityIndicator3];

  self.activityIndicator1.center =
      CGPointMake(indicators.bounds.size.width / 3, indicators.bounds.size.height / 2);
  self.activityIndicator1.autoresizingMask =
      (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);
  self.activityIndicator2.center =
      CGPointMake(indicators.bounds.size.width / 2, indicators.bounds.size.height / 2);
  self.activityIndicator2.autoresizingMask =
      (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);
  self.activityIndicator3.center =
      CGPointMake(2 * indicators.bounds.size.width / 3, indicators.bounds.size.height / 2);
  self.activityIndicator3.autoresizingMask =
      (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);

  self.indicators = indicators;

  self.onSwitch = [[UISwitch alloc] init];
  [self.onSwitch setOn:YES];
  [self.onSwitch addTarget:self
                    action:@selector(didChangeOnSwitch:)
          forControlEvents:UIControlEventValueChanged];

  self.modeSwitch = [[UISwitch alloc] init];
  [self.modeSwitch setOn:YES];
  [self.modeSwitch addTarget:self
                      action:@selector(didChangeModeSwitch:)
            forControlEvents:UIControlEventValueChanged];

  CGRect sliderFrame = CGRectMake(0, 0, 160, 27);
  self.slider = [[UISlider alloc] initWithFrame:sliderFrame];
  self.slider.value = (float)kActivityInitialProgress;
  [self.slider addTarget:self
                  action:@selector(didChangeSliderValue:)
        forControlEvents:UIControlEventValueChanged];

  self.activityIndicator1.progress = self.slider.value;
  self.activityIndicator2.progress = self.slider.value;
  self.activityIndicator3.progress = self.slider.value;

  [self.activityIndicator1 startAnimating];
  [self.activityIndicator2 startAnimating];
  [self.activityIndicator3 startAnimating];

  self.tableView.layoutMargins = UIEdgeInsetsZero;
  self.tableView.separatorInset = UIEdgeInsetsZero;
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

- (void)didChangeModeSwitch:(UISwitch *)switchControl {
  if (switchControl.on) {
    self.activityIndicator2.indicatorMode = MDCActivityIndicatorModeDeterminate;
    self.activityIndicator3.indicatorMode = MDCActivityIndicatorModeDeterminate;
  } else {
    self.activityIndicator2.indicatorMode = MDCActivityIndicatorModeIndeterminate;
    self.activityIndicator3.indicatorMode = MDCActivityIndicatorModeIndeterminate;
  }
}

- (void)didChangeSliderValue:(UISlider *)slider {
  self.activityIndicator1.progress = slider.value;
  self.activityIndicator2.progress = slider.value;
  self.activityIndicator3.progress = slider.value;
  UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1
                                                                                   inSection:0]];
  cell.textLabel.text = [NSString stringWithFormat:@"%.00f%%", slider.value * 100];
  [cell setNeedsDisplay];
}

#pragma mark -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  if (indexPath.row == 0) {
    return 160;
  }

  return 56;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCell
                                                          forIndexPath:indexPath];
  cell.textLabel.text = @"";
  cell.selectionStyle = UITableViewCellSelectionStyleNone;
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
    case 3:
      cell.accessoryView = self.modeSwitch;
      cell.textLabel.text = @"Show Determinate";
      break;
    default:
      break;
  }
  return cell;
}

@end
