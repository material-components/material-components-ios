/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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

#import <UIKit/UIKit.h>

#import "BottomNavigationTypicalUseSupplemental.h"
#import "MaterialBottomNavigation.h"

@implementation BottomNavigationTypicalUseExample

- (id)init {
  self = [super init];
  if (self) {
    self.title = @"Bottom Navigation";
     [self commonBottomNavigationTypicalUseExampleInit];
  }
  return self;
}

- (void)commonBottomNavigationTypicalUseExampleInit {
  self.view.backgroundColor = [UIColor lightGrayColor];

  CGRect frame = CGRectMake(0,
                            self.view.bounds.size.height - 72.f,
                            self.view.bounds.size.width,
                            72.f);
  MDCBottomNavigationView *bottomNavView = [[MDCBottomNavigationView alloc] initWithFrame:frame];
  [self.view addSubview:bottomNavView];
  
  UITabBarItem *tabBarItem1 = [[UITabBarItem alloc] initWithTitle:@"Item 1"
                                                            image:[UIImage imageNamed:@"Search"]
                                                              tag:0];
  bottomNavView.items = @[ tabBarItem1 ];
}

@end
