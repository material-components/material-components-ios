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
                                                     action:@selector(mdc_reorderCells:)];
  gestureRecognizer.delegate = self;
  [self.collectionView addGestureRecognizer:gestureRecognizer];
}

- (BOOL)gestureRecognizer:(__unused UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:
(__unused UIGestureRecognizer *)otherGestureRecognizer {
  return YES;
}

- (void)mdc_reorderCells:(UILongPressGestureRecognizer *)gesture {
  if (gesture.state == UIGestureRecognizerStateBegan) {
    NSIndexPath *selected = [self.collectionView indexPathForItemAtPoint:
                             [gesture locationInView:self.collectionView]];
    MDCCollectionViewCardCell *cell =
    (MDCCollectionViewCardCell *)[self.collectionView cellForItemAtIndexPath:selected];
    [cell isReordering:YES withLocation:CGPointZero];
  } else if (gesture.state == UIGestureRecognizerStateEnded) {
    for (MDCCollectionViewCardCell *cell in [self.collectionView visibleCells]) {
      if (cell.longPressActive) {
        CGPoint loc = [gesture locationInView:cell];
        [cell isReordering:NO withLocation:loc];
      }
    }
  }
}

@end
