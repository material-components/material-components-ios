/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCShadowElevations.h"


@implementation MDCShadowElevation

- (instancetype)init {
   _value = 0.0f;
   return self;
}

+ (CGFloat)appBar {
   return 4.0;
}

+ (CGFloat)cardPickedUp {
   return 8.0f;
}
+ (CGFloat)cardResting {
   return 2.0f;
}
+ (CGFloat)cardDialog {
   return 24.0f;
}
+ (CGFloat)fabPressed {
   return 12.0f;
}
+ (CGFloat)fabResting {
   return 6.0f;
}
+ (CGFloat)menu {
   return 8.0f;
}
+ (CGFloat)modalBottomSheet {
   return 16.0f;
}
+ (CGFloat)navDrawer {
   return 16.0f;
}
+ (CGFloat)none {
   return 0.0f;
}
+ (CGFloat)picker {
   return 24.0f;
}
+ (CGFloat)quickEntry {
   return 3.0f;
}
+ (CGFloat)quickEntryResting {
   return 2.0f;
}
+ (CGFloat)raisedButtonPressed {
   return 8.0f;
}
+ (CGFloat)raisedButtonResting {
   return 2.0f;
}
+ (CGFloat)refresh {
   return 3.0f;
}
+ (CGFloat)rightDrawer {
   return 16.0f;
}
+ (CGFloat)searchBarResting {
   return 2.0f;
}
+ (CGFloat)searchBarScrolled {
   return 3.0f;
}
+ (CGFloat)snackbar {
   return 6.0f;
}
+ (CGFloat)subMenu {
   return 9.0f;
}
+ (CGFloat)switch {
   return 1.0f;
}

@end
