//
//  UICollectionViewController+MDCCardReordering.m
//  MaterialComponents
//
//  Created by Yarden Eitan on 1/11/18.
//

#import "UICollectionViewController+MDCCardReordering.h"
#import "MDCCollectionViewCardCell.h"

@implementation UICollectionViewController (MDCCardReordering)


- (void)mdc_setupCardReordering {
  UILongPressGestureRecognizer *gestureRecognizer = [[UILongPressGestureRecognizer alloc]
                                                     initWithTarget:self
                                                     action:@selector(reorderCells:)];
  gestureRecognizer.delegate = self;
  [self.collectionView addGestureRecognizer:gestureRecognizer];
}

- (BOOL)gestureRecognizer:(__unused UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:
(__unused UIGestureRecognizer *)otherGestureRecognizer {
  return YES;
}

- (void)reorderCells:(UILongPressGestureRecognizer *)gesture {
  if (gesture.state == UIGestureRecognizerStateEnded) {
    for (MDCCollectionViewCardCell *cell in [self.collectionView visibleCells]) {
      if (cell.pressed) {
        CGPoint loc = [gesture locationInView:cell];
        [cell isReordering:NO withLocation:loc];
      }
    }
  }
}

@end
