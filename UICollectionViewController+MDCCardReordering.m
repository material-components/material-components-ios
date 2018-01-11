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
//  UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc]
//                                                  initWithTarget:self
//                                                  action:@selector(mdc_tapCard:)];
  UILongPressGestureRecognizer *longGestureRecognizer = [[UILongPressGestureRecognizer alloc]
                                                         initWithTarget:self
                                                         action:@selector(mdc_longPressCard:)];
  longGestureRecognizer.delegate = self;
//  tapGestureRecognizer.delegate = self;
//  gestureRecognizer.cancelsTouchesInView = NO;
  [self.collectionView addGestureRecognizer:longGestureRecognizer];
//  [self.collectionView addGestureRecognizer:tapGestureRecognizer];
}

- (BOOL)gestureRecognizer:(__unused UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:
(__unused UIGestureRecognizer *)otherGestureRecognizer {
  return YES;
}

//- (void)mdc_tapCard:(UITapGestureRecognizer *)gesture {
//  if (gesture.state == UIGestureRecognizerStateBegan) {
//    NSLog(@"tapped");
////    NSIndexPath *selected = [self.collectionView indexPathForItemAtPoint:
////                             [gesture locationInView:self.collectionView]];
////    MDCCollectionViewCardCell *cell =
////    (MDCCollectionViewCardCell *)[self.collectionView cellForItemAtIndexPath:selected];
////    [cell isReordering:YES withLocation:CGPointZero];
//  } else if (gesture.state == UIGestureRecognizerStateEnded) {
//    NSLog(@"untapped");
////    for (MDCCollectionViewCardCell *cell in [self.collectionView visibleCells]) {
////      if (cell.longPressActive) {
////        CGPoint loc = [gesture locationInView:cell];
////        [cell isReordering:NO withLocation:loc];
////      }
////    }
//  }
//}

- (void)mdc_longPressCard:(UILongPressGestureRecognizer *)gesture {
  NSLog(@"long");
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
