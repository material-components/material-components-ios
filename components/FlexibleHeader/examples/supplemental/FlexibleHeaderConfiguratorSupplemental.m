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

/** IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to use Material Components for iOS.
 */

#import "FlexibleHeaderConfiguratorSupplemental.h"

#import "FlexibleHeaderConfiguratorControlItem.h"
#import "MaterialFlexibleHeader.h"

static const UITableViewStyle kStyle = UITableViewStyleGrouped;

@implementation FlexibleHeaderConfiguratorExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Flexible Header", @"Configurator" ];
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

@end

@implementation FlexibleHeaderConfiguratorExample (Supplemental)

- (instancetype)init {
  return [self initWithStyle:kStyle];
}

- (instancetype)initWithStyle:(UITableViewStyle)style {
  self = [super initWithStyle:kStyle];
  if (self) {
    self.fhvc = [[MDCFlexibleHeaderViewController alloc] initWithNibName:nil bundle:nil];
    [self addChildViewController:self.fhvc];

    self.title = @"Configurator";
  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated {
  [super viewWillAppear:animated];

  [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
  return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.minimumHeaderHeight = self.fhvc.headerView.minimumHeight;

  self.fhvc.headerView.trackingScrollView = self.tableView;

  self.fhvc.view.frame = self.view.bounds;
  [self.view addSubview:self.fhvc.view];
  [self.fhvc didMoveToParentViewController:self];

  UIColor *lightBlue500 = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:1];
  self.fhvc.headerView.backgroundColor = lightBlue500;

  UILabel *titleLabel = [[UILabel alloc] init];
  CGRect frame = self.fhvc.headerView.bounds;
  frame.origin.y += 20;
  frame.size.height -= 20;
  titleLabel.frame = frame;
  titleLabel.text = self.title;
  titleLabel.textColor = [UIColor whiteColor];
  titleLabel.font = [UIFont systemFontOfSize:22];
  titleLabel.textAlignment = NSTextAlignmentCenter;
  titleLabel.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;

  [self.fhvc.headerView addSubview:titleLabel];

  id (^switchItem)(NSString *, FlexibleHeaderConfiguratorField) = ^(
      NSString *title, FlexibleHeaderConfiguratorField field) {
    FlexibleHeaderConfiguratorControlType type = FlexibleHeaderConfiguratorControlTypeSwitch;
    return [FlexibleHeaderConfiguratorControlItem itemWithTitle:title controlType:type field:field];
  };
  id (^sliderItem)(NSString *, FlexibleHeaderConfiguratorField) = ^(
      NSString *title, FlexibleHeaderConfiguratorField field) {
    FlexibleHeaderConfiguratorControlType type = FlexibleHeaderConfiguratorControlTypeSlider;
    return [FlexibleHeaderConfiguratorControlItem itemWithTitle:title controlType:type field:field];
  };
  id (^filler)(void) = ^{
    return [NSNull null];
  };
  NSMutableArray *sections = [NSMutableArray array];
  NSMutableArray *sectionTitles = [NSMutableArray array];
  void (^createSection)(NSString *, NSArray *) = ^(NSString *title, NSArray *items) {
    [sectionTitles addObject:title ?: @""];
    [sections addObject:items ?: @[]];
  };

  createSection(@"Swipe right from left edge to go back", nil);

  createSection(@"Basic behavior", @[
    switchItem(@"Can over-extend", FlexibleHeaderConfiguratorFieldCanOverExtend),
    switchItem(@"In front of infinite content",
               FlexibleHeaderConfiguratorFieldInFrontOfInfiniteContent),
    switchItem(@"Hide status bar", FlexibleHeaderConfiguratorFieldHideStatusBar),
  ]);

  createSection(@"Shift behavior", @[
    switchItem(@"Enabled", FlexibleHeaderConfiguratorFieldShiftBehaviorEnabled),
    switchItem(@"Enabled with status bar",
               FlexibleHeaderConfiguratorFieldShiftBehaviorEnabledWithStatusBar),
    switchItem(@"Header content is important", FlexibleHeaderConfiguratorFieldContentImportance)
  ]);

  createSection(@"Header height", @[
    sliderItem(@"Minimum", FlexibleHeaderConfiguratorFieldMinimumHeight),
    sliderItem(@"Maximum", FlexibleHeaderConfiguratorFieldMaximumHeight)
  ]);

  NSMutableArray *fillerItems = [NSMutableArray array];
  for (NSUInteger ix = 0; ix < 100; ++ix) {
    [fillerItems addObject:filler()];
  }
  createSection(nil, fillerItems);

  self.sections = sections;
  self.sectionTitles = sectionTitles;

  self.view.backgroundColor = [UIColor whiteColor];
}

- (UIControl *)controlForControlType:(FlexibleHeaderConfiguratorControlType)controlType {
  switch (controlType) {
    case FlexibleHeaderConfiguratorControlTypeSwitch:
      return [[UISwitch alloc] init];

    case FlexibleHeaderConfiguratorControlTypeSlider:
      return [[UISlider alloc] init];
  }
}

- (NSNumber *)valueForControl:(UIControl *)control {
  if ([control isKindOfClass:[UISwitch class]]) {
    return @([(UISwitch *)control isOn]);
  } else if ([control isKindOfClass:[UISlider class]]) {
    return @([(UISlider *)control value]);
  }
  return nil;
}

- (void)setValue:(NSNumber *)value onControl:(UIControl *)control animated:(BOOL)animated {
  if ([control isKindOfClass:[UISwitch class]]) {
    [(UISwitch *)control setOn:[value boolValue] animated:animated];
  } else if ([control isKindOfClass:[UISlider class]]) {
    [(UISlider *)control setValue:[value floatValue] animated:animated];
  }
}

- (void)didChangeValueForField:(FlexibleHeaderConfiguratorField)field animated:(BOOL)animated {
  UIControl *control = [self.tableView viewWithTag:field];
  NSNumber *value = [self valueForField:field];
  [self setValue:value onControl:control animated:animated];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return [self.sections[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
  return self.sectionTitles[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                  reuseIdentifier:@"cell"];
  }
  id item = self.sections[indexPath.section][indexPath.row];
  if ([item isKindOfClass:[FlexibleHeaderConfiguratorControlItem class]]) {
    FlexibleHeaderConfiguratorControlItem *fieldItem =
        (FlexibleHeaderConfiguratorControlItem *)item;

    cell.textLabel.font = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption1];

    cell.textLabel.text = fieldItem.title;

    UIControl *control = [self controlForControlType:fieldItem.controlType];
    control.tag = fieldItem.field;
    [control addTarget:self
                  action:@selector(didChangeControl:)
        forControlEvents:UIControlEventValueChanged];
    [self setValue:[self valueForField:fieldItem.field] onControl:control animated:NO];
    cell.accessoryView = control;

  } else {
    cell.textLabel.text = nil;
    cell.accessoryView = nil;
  }

  return cell;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
  return NO;
}

#pragma mark - User actions

- (void)didChangeControl:(UIControl *)sender {
  NSNumber *value = [self valueForControl:sender];
  [self field:(FlexibleHeaderConfiguratorField)sender.tag didChangeValue:value];
}

- (void)didTapBackButton:(id)button {
  [self.navigationController popViewControllerAnimated:YES];
}

@end
