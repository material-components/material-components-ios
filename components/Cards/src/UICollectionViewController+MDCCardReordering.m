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

#import "UICollectionViewController+MDCCardReordering.h"

#import "MaterialInk.h"
#import "MDCCardCollectionCell.h"

@implementation UICollectionViewController (MDCCardReordering)


- (void)mdc_setupCardReordering {
  UILongPressGestureRecognizer *longGestureRecognizer =
      [[UILongPressGestureRecognizer alloc] initWithTarget:self action:nil];

  longGestureRecognizer.delegate = self;
  longGestureRecognizer.cancelsTouchesInView = NO;
  [self.collectionView addGestureRecognizer:longGestureRecognizer];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(UITouch *)touch {
  for (UIGestureRecognizer *gesture in self.collectionView.gestureRecognizers) {
    if ([gesture isKindOfClass:[UILongPressGestureRecognizer class]]) {
      gesture.cancelsTouchesInView = NO;
    }
  }
  return YES;
}

@end
