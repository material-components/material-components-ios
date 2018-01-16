//
//  UICollectionViewController+MDCCardReordering.m
//  MaterialComponents
//
//  Created by Yarden Eitan on 1/11/18.
//

#import "UICollectionViewController+MDCCardReordering.h"
#import "MDCCollectionViewCardCell.h"
#import "MaterialInk.h"

@implementation UICollectionViewController (MDCCardReordering)


- (void)mdc_setupCardReordering {
  UILongPressGestureRecognizer *longGestureRecognizer = [[UILongPressGestureRecognizer alloc]
                                                         initWithTarget:self
                                                         action:nil];

  longGestureRecognizer.delegate = self;
  longGestureRecognizer.cancelsTouchesInView = NO;
  [self.collectionView addGestureRecognizer:longGestureRecognizer];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
  for (UIGestureRecognizer *gesture in self.collectionView.gestureRecognizers) {
    if ([gesture isKindOfClass:[UILongPressGestureRecognizer class]]) {
      gesture.cancelsTouchesInView = NO;
    }
  }
  return YES;
}

@end
