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

#import "MDCBottomNavigationItem.h"

#import "private/MDCBottomNavigationCell.h"

@interface MDCBottomNavigationItem ()

@property(nonatomic, strong) MDCBottomNavigationCell *bottomNavCell;

@end

@implementation MDCBottomNavigationItem

- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
                    badgeText:(NSString *)badgeText {
  self = [super initWithTitle:title image:image tag:0];
  if (self) {
    _badgeText = badgeText;
  }
  return self;
}

- (void)setBadgeText:(NSString *)badgeText {
  _badgeText = badgeText;
}

@end
