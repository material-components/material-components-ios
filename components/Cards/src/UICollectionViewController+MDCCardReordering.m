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
                                                         action:@selector(mdc_longPressCard:)];

  longGestureRecognizer.delegate = self;
  longGestureRecognizer.cancelsTouchesInView = NO;
  [self.collectionView addGestureRecognizer:longGestureRecognizer];
}

- (BOOL)gestureRecognizer:(__unused UIGestureRecognizer *)gestureRecognizer
shouldRecognizeSimultaneouslyWithGestureRecognizer:
(__unused UIGestureRecognizer *)otherGestureRecognizer {
  return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
  for (UIGestureRecognizer *gesture in self.collectionView.gestureRecognizers) {
    if ([gesture isKindOfClass:[UILongPressGestureRecognizer class]]) {
      gesture.cancelsTouchesInView = NO;
    }
  }
  return YES;
}

- (void)mdc_longPressCard:(UILongPressGestureRecognizer *)gesture {
  switch(gesture.state) {
    case UIGestureRecognizerStateBegan: {
      NSIndexPath *selected = [self.collectionView indexPathForItemAtPoint:
                               [gesture locationInView:self.collectionView]];
      MDCCollectionViewCardCell *cell =
      (MDCCollectionViewCardCell *)[self.collectionView cellForItemAtIndexPath:selected];
      [cell setLongPressActive:YES];
      break;
    }
    case UIGestureRecognizerStateEnded:
    case UIGestureRecognizerStateCancelled:
    case UIGestureRecognizerStateFailed: {
      for (MDCCollectionViewCardCell *cell in [self.collectionView visibleCells]) {
        if (cell.longPressActive) {
          CGPoint loc = [gesture locationInView:cell];
          [cell setLongPressActive:NO withLocation:loc];
        }
      }
      break;
    }
    default:
      break;
  }
}

@end
