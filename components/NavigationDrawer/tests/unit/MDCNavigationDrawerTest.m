// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialNavigationDrawer.h"

#import "MDCNavigationDrawerFakes.h"

@interface MDCNavigationDrawerTest : XCTestCase
@property(nonatomic, strong) MDCBottomDrawerViewController *navigationDrawer;
@end

@implementation MDCNavigationDrawerTest

- (void)setUp {
  [super setUp];

  MDCNavigationDrawerFakeTableViewController *fakeTableViewController =
      [[MDCNavigationDrawerFakeTableViewController alloc] init];
  MDCNavigationDrawerFakeHeaderViewController *fakeHeader =
      [[MDCNavigationDrawerFakeHeaderViewController alloc] init];
  self.navigationDrawer = [[MDCBottomDrawerViewController alloc] init];
  self.navigationDrawer.headerViewController = fakeHeader;
  self.navigationDrawer.contentViewController = fakeTableViewController;
  self.navigationDrawer.trackingScrollView = fakeTableViewController.tableView;
}

- (void)tearDown {
  self.navigationDrawer = nil;

  [super tearDown];
}



@end
