/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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

#import "MDCCollectionViewEditor.h"

#import "MDCCollectionViewEditingDelegate.h"
#import "MaterialShadowLayer.h"

#include <tgmath.h>

// Distance from center before we start fading the item.
static const CGFloat kDismissalDistanceBeforeFading = 50.0f;

// Minimum alpha for an item being dismissed.
static const CGFloat kDismissalMinimumAlpha = 0.5f;

// Simple linear friction applied to swipe velocity.
static const CGFloat kDismissalSwipeFriction = 0.05f;

// Animation duration for dismissal / restore.
static const NSTimeInterval kDismissalAnimationDuration = 0.3;
static const NSTimeInterval kRestoreAnimationDuration = 0.2;

// Distance from collection view bounds that reorder panning should trigger autoscroll.
static const CGFloat kMDCAutoscrollPanningBuffer = 60.0f;

// Distance collection view should offset during autoscroll.
static const CGFloat kMDCAutoscrollPanningOffset = 10.0f;

/** Autoscroll panning direction. */
typedef NS_ENUM(NSInteger, MDCAutoscrollPanningDirection) {
  kMDCAutoscrollPanningDirectionNone,
  kMDCAutoscrollPanningDirectionUp,
  kMDCAutoscrollPanningDirectionDown
};

/** A view that uses an MDCShadowLayer as its sublayer. */
@interface ShadowedSnapshotView : UIView
@end

@implementation ShadowedSnapshotView
+ (Class)layerClass {
  return [MDCShadowLayer class];
}
@end

@interface MDCCollectionViewEditor () <UIGestureRecognizerDelegate>
@end

#if defined(__IPHONE_10_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0)
@interface MDCCollectionViewEditor () <CAAnimationDelegate>
@end
#endif

@implementation MDCCollectionViewEditor {
  UILongPressGestureRecognizer *_longPressGestureRecognizer;
  UIPanGestureRecognizer *_panGestureRecognizer;
  CGPoint _selectedCellLocation;
  CGPoint _initialCellLocation;
  ShadowedSnapshotView *_cellSnapshot;
  CADisplayLink *_autoscrollTimer;
  MDCAutoscrollPanningDirection _autoscrollPanningDirection;
}

@synthesize collectionView = _collectionView;
@synthesize delegate = _delegate;
@synthesize reorderingCellIndexPath = _reorderingCellIndexPath;
@synthesize dismissingCellIndexPath = _dismissingCellIndexPath;
@synthesize dismissingSection = _dismissingSection;
@synthesize editing = _editing;

#pragma mark - Public

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView {
  self = [super init];
  if (self) {
    _collectionView = collectionView;
    _dismissingSection = NSNotFound;

    // Setup gestures to handle collectionView editing.

    SEL longPressSelector = @selector(handleLongPressGesture:);
    _longPressGestureRecognizer =
        [[UILongPressGestureRecognizer alloc] initWithTarget:self action:longPressSelector];
    _longPressGestureRecognizer.delegate = self;
    [_collectionView addGestureRecognizer:_longPressGestureRecognizer];

    SEL panSelector = @selector(handlePanGesture:);
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:panSelector];
    _panGestureRecognizer.delegate = self;
    _panGestureRecognizer.maximumNumberOfTouches = 1;
    [_collectionView addGestureRecognizer:_panGestureRecognizer];
  }
  return self;
}

- (void)dealloc {
  _longPressGestureRecognizer.delegate = nil;
  _panGestureRecognizer.delegate = nil;

  // Remove gesture recognizers to prevent duplicates when re-initializing this controller.
  [_collectionView removeGestureRecognizer:_longPressGestureRecognizer];
  [_collectionView removeGestureRecognizer:_panGestureRecognizer];
}

- (void)setEditing:(BOOL)editing {
  [self setEditing:editing animated:NO];
}

- (void)setEditing:(BOOL)editing animated:(__unused BOOL)animated {
  _editing = editing;
  _collectionView.allowsMultipleSelection = editing;

  // Clear any selected indexPaths.
  for (NSIndexPath *indexPath in [_collectionView indexPathsForSelectedItems]) {
    [_collectionView deselectItemAtIndexPath:indexPath animated:NO];
  }

  [CATransaction begin];
  if (editing) {
    // Notify delegate will begin editing.
    if ([_delegate respondsToSelector:@selector(collectionViewWillBeginEditing:)]) {
      [_delegate collectionViewWillBeginEditing:_collectionView];
    }

    [CATransaction setCompletionBlock:^{
      // Notify delegate did begin editing.
      if ([self.delegate respondsToSelector:@selector(collectionViewDidBeginEditing:)]) {
        [self.delegate collectionViewDidBeginEditing:self.collectionView];
      }
    }];

  } else {
    // Notify delegate will end editing.
    if ([_delegate respondsToSelector:@selector(collectionViewWillEndEditing:)]) {
      [_delegate collectionViewWillEndEditing:_collectionView];
    }

    [CATransaction setCompletionBlock:^{
      // Notify delegate did end editing.
      if ([self.delegate respondsToSelector:@selector(collectionViewDidEndEditing:)]) {
        [self.delegate collectionViewDidEndEditing:self.collectionView];
      }
    }];
  }
  [CATransaction commit];
}

#pragma mark - Private

- (NSArray *)attributesAtSection:(NSInteger)section {
  UICollectionViewLayout *layout = _collectionView.collectionViewLayout;
  NSIndexPath *indexPath;
  NSMutableArray *sectionAttributes = [NSMutableArray array];

  // Get all item attributes at section.
  NSInteger numberOfItemsInSection = [_collectionView numberOfItemsInSection:section];

  for (NSInteger i = 0; i < numberOfItemsInSection; ++i) {
    indexPath = [NSIndexPath indexPathForItem:i inSection:section];
    UICollectionViewLayoutAttributes *attribute =
        [layout layoutAttributesForItemAtIndexPath:indexPath];
    [sectionAttributes addObject:attribute];
  }

  // Headers/footers require section but ignore item of index path, so set to zero.
  indexPath = [NSIndexPath indexPathForItem:0 inSection:section];

  // Get header attributes at section.
  UICollectionViewLayoutAttributes *headerAttribute =
      [layout layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                             atIndexPath:indexPath];
  [sectionAttributes addObject:headerAttribute];

  // Get footer attributes at section.
  UICollectionViewLayoutAttributes *footerAttribute =
      [layout layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                             atIndexPath:indexPath];
  [sectionAttributes addObject:footerAttribute];

  return sectionAttributes;
}

- (NSInteger)swipedSectionAtLocation:(CGPoint)location {
  // Returns section index being swiped for dismissal, or NSNotFound for an invalid swipes
  // where location does not return an item or section header/footer.
  CGRect contentFrame = _collectionView.frame;
  contentFrame.size = _collectionView.contentSize;
  NSArray *visibleAttributes =
      [_collectionView.collectionViewLayout layoutAttributesForElementsInRect:contentFrame];
  for (UICollectionViewLayoutAttributes *attribute in visibleAttributes) {
    if (!CGRectIsNull(attribute.frame) && CGRectContainsPoint(attribute.frame, location)) {
      return attribute.indexPath.section;
    }
  }
  return NSNotFound;
}

#pragma mark - Snapshotting

- (UIView *)snapshotWithIndexPath:(NSIndexPath *)indexPath {
  // Here we will take a snapshot of the collectionView item.
  if (_cellSnapshot) {
    [_cellSnapshot removeFromSuperview];
    _cellSnapshot = nil;
  }

  // Create snapshot.
  UICollectionViewLayoutAttributes *attributes =
      [_collectionView.collectionViewLayout layoutAttributesForItemAtIndexPath:indexPath];
  _cellSnapshot = [[ShadowedSnapshotView alloc] initWithFrame:attributes.frame];
  UICollectionViewCell *cell = [_collectionView cellForItemAtIndexPath:indexPath];
  [_cellSnapshot addSubview:[cell snapshotViewAfterScreenUpdates:NO]];

  // Invalidate layout here to force attributes to now be hidden.
  [_collectionView.collectionViewLayout invalidateLayout];
  return _cellSnapshot;
}

- (UIView *)snapshotWithSection:(NSInteger)section {
  // Here we will take a snapshot of the collectionView section items, header, and footer.
  if (_cellSnapshot) {
    [_cellSnapshot removeFromSuperview];
    _cellSnapshot = nil;
  }

  // The snapshot frame encompasses all of the section items, header, and footer attribute frames.
  NSArray *sectionAttributes = [self attributesAtSection:section];
  CGRect snapshotFrame = CGRectNull;
  for (UICollectionViewLayoutAttributes *attribute in sectionAttributes) {
    if (!CGRectIsNull(attribute.frame) && !CGRectIsInfinite(attribute.frame)) {
      snapshotFrame = CGRectUnion(snapshotFrame, attribute.frame);
    }
  }

  // Create snapshot.
  _cellSnapshot = [[ShadowedSnapshotView alloc] initWithFrame:snapshotFrame];
  UIImageView *snapshotView =
      [[UIImageView alloc] initWithImage:[self snapshotWithRect:snapshotFrame]];
  [_cellSnapshot addSubview:snapshotView];

  // Invalidate layout here to force attributes to now be hidden.
  [_collectionView.collectionViewLayout invalidateLayout];
  return _cellSnapshot;
}

- (UIImage *)snapshotWithRect:(CGRect)rect {
  // Here we will take a snapshot of a rect within the collectionView.
  UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0);
  CGContextRef cx = UIGraphicsGetCurrentContext();
  CGContextTranslateCTM(cx, -rect.origin.x, -rect.origin.y);

  // Save original collection view properties.
  id<UICollectionViewDelegate> savedDelegate = _collectionView.delegate;
  _collectionView.delegate = nil;
  CGPoint savedContentOffset = _collectionView.contentOffset;
  BOOL savedClipsToBounds = _collectionView.clipsToBounds;
  _collectionView.clipsToBounds = NO;

  // Hide any scroll indicators.
  BOOL showsHorizontalScrollIndicator = _collectionView.showsHorizontalScrollIndicator;
  BOOL showsVerticalScrollIndicator = _collectionView.showsVerticalScrollIndicator;
  _collectionView.showsHorizontalScrollIndicator = NO;
  _collectionView.showsVerticalScrollIndicator = NO;

  // Render snapshot.
  [_collectionView.layer renderInContext:cx];
  _collectionView.layer.rasterizationScale = [UIScreen mainScreen].scale;
  _collectionView.layer.shouldRasterize = YES;
  UIImage *screenshotImage = UIGraphicsGetImageFromCurrentImageContext();

  // Reset collection view.
  _collectionView.contentOffset = savedContentOffset;
  _collectionView.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator;
  _collectionView.showsVerticalScrollIndicator = showsVerticalScrollIndicator;
  _collectionView.delegate = savedDelegate;
  _collectionView.clipsToBounds = savedClipsToBounds;
  _collectionView.layer.shouldRasterize = NO;

  UIGraphicsEndImageContext();
  return screenshotImage;
}

- (void)applyLayerShadowing:(__unused CALayer *)layer {
  MDCShadowLayer *shadowLayer = (MDCShadowLayer *)_cellSnapshot.layer;
  shadowLayer.shadowMaskEnabled = NO;
  shadowLayer.elevation = 3;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
  if ([gestureRecognizer isEqual:_longPressGestureRecognizer]) {
    // Only allow longpress if collectionView is editing.
    return self.isEditing;

  } else if ([gestureRecognizer isEqual:_panGestureRecognizer]) {
    // Only allow panning if collectionView is editing or dismissing item/section.
    BOOL allowsSwipeToDismissItem = NO;
    if ([_delegate respondsToSelector:@selector(collectionViewAllowsSwipeToDismissItem:)]) {
      allowsSwipeToDismissItem = [_delegate collectionViewAllowsSwipeToDismissItem:_collectionView];
    }

    BOOL allowsSwipeToDismissSection = NO;
    if ([_delegate respondsToSelector:@selector(collectionViewAllowsSwipeToDismissSection:)]) {
      allowsSwipeToDismissSection =
          [_delegate collectionViewAllowsSwipeToDismissSection:_collectionView];
    }
    return (self.isEditing || allowsSwipeToDismissItem || allowsSwipeToDismissSection);
  }
  return YES;
}

- (BOOL)gestureRecognizer:(__unused UIGestureRecognizer *)gestureRecognizer
    shouldRecognizeSimultaneouslyWithGestureRecognizer:
        (__unused UIGestureRecognizer *)otherGestureRecognizer {
  return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
    shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
  // Prevent panning to dismiss when scrolling.
  return ([gestureRecognizer isEqual:_panGestureRecognizer] &&
          [otherGestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]);
}

- (BOOL)gestureRecognizer:(__unused UIGestureRecognizer *)gestureRecognizer
       shouldReceiveTouch:(__unused UITouch *)touch {
  BOOL allowsSwipeToDismissItem = NO;
  if ([_delegate respondsToSelector:@selector(collectionViewAllowsSwipeToDismissItem:)]) {
    allowsSwipeToDismissItem = [_delegate collectionViewAllowsSwipeToDismissItem:_collectionView];
  }

  BOOL allowsSwipeToDismissSection = NO;
  if ([_delegate respondsToSelector:@selector(collectionViewAllowsSwipeToDismissSection:)]) {
    allowsSwipeToDismissSection =
        [_delegate collectionViewAllowsSwipeToDismissSection:_collectionView];
  }

  return (self.isEditing || allowsSwipeToDismissItem || allowsSwipeToDismissSection);
}

#pragma mark - LongPress Gesture Handling

- (void)handleLongPressGesture:(UILongPressGestureRecognizer *)recognizer {
  switch (recognizer.state) {
    case UIGestureRecognizerStateBegan: {
      _initialCellLocation = [recognizer locationInView:_collectionView];
      _selectedCellLocation = [recognizer locationInView:_collectionView];
      _reorderingCellIndexPath = [_collectionView indexPathForItemAtPoint:_selectedCellLocation];

      if ([_delegate respondsToSelector:@selector(collectionView:canMoveItemAtIndexPath:)] &&
          ![_delegate collectionView:_collectionView
              canMoveItemAtIndexPath:_reorderingCellIndexPath]) {
        _reorderingCellIndexPath = nil;
        return;
      }

      // Notify delegate dragging has began.
      if ([_delegate
              respondsToSelector:@selector(collectionView:willBeginDraggingItemAtIndexPath:)]) {
        [_delegate collectionView:_collectionView
            willBeginDraggingItemAtIndexPath:_reorderingCellIndexPath];
      }

      // Create cell snapshot with shadowing.
      [_collectionView addSubview:[self snapshotWithIndexPath:_reorderingCellIndexPath]];
      [self applyLayerShadowing:_cellSnapshot.layer];

      // Disable scrolling.
      [_collectionView setScrollEnabled:NO];
      break;
    }
    case UIGestureRecognizerStateCancelled:
    case UIGestureRecognizerStateEnded: {
      // Stop autoscroll.
      [self stopAutoscroll];
      NSIndexPath *currentIndexPath = _reorderingCellIndexPath;
      if (currentIndexPath) {
        UICollectionViewLayoutAttributes *attributes = [_collectionView.collectionViewLayout
            layoutAttributesForItemAtIndexPath:currentIndexPath];

        void (^completionBlock)(BOOL finished) = ^(__unused BOOL finished) {
          // Notify delegate dragging has finished.
          if ([self.delegate
                  respondsToSelector:@selector(collectionView:didEndDraggingItemAtIndexPath:)]) {
            [self.delegate collectionView:self.collectionView
                didEndDraggingItemAtIndexPath:self->_reorderingCellIndexPath];
          }
          [self restoreEditingItem];

          // Re-enable scrolling.
          [self.collectionView setScrollEnabled:YES];
        };

        [UIView animateWithDuration:kDismissalAnimationDuration
                              delay:0
                            options:UIViewAnimationOptionBeginFromCurrentState
                         animations:^{
                           self->_cellSnapshot.frame = attributes.frame;
                         }
                         completion:completionBlock];
      }
      break;
    }
    default:
      break;
  }
}

#pragma mark - Pan Gesture Handling

- (void)handlePanGesture:(UIPanGestureRecognizer *)recognizer {
  if (_reorderingCellIndexPath) {
    [self panToReorderWithRecognizer:recognizer];
  } else {
    [self panToDismissWithRecognizer:recognizer];
  }
}

- (void)panToReorderWithRecognizer:(UIPanGestureRecognizer *)recognizer {
  if (recognizer.state == UIGestureRecognizerStateChanged) {
    // Transform snapshot position when panning.
    _selectedCellLocation = [recognizer locationInView:_collectionView];
    CGFloat change = _selectedCellLocation.y - _initialCellLocation.y;
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, change);
    _cellSnapshot.layer.transform = CATransform3DMakeAffineTransform(transform);

    // Determine moved index paths.
    NSIndexPath *newIndexPath = [_collectionView indexPathForItemAtPoint:_selectedCellLocation];
    NSIndexPath *previousIndexPath = _reorderingCellIndexPath;
    if ((newIndexPath == nil) || [newIndexPath isEqual:previousIndexPath]) {
      return;
    }

    // Autoscroll if the cell is dragged out of the collectionView's bounds.
    CGFloat buffer = kMDCAutoscrollPanningBuffer;
    if (_selectedCellLocation.y < CGRectGetMinY(self.collectionView.bounds) + buffer) {
      [self startAutoscroll];
      _autoscrollPanningDirection = kMDCAutoscrollPanningDirectionUp;
    } else if (_selectedCellLocation.y > (CGRectGetMaxY(self.collectionView.bounds) - buffer)) {
      [self startAutoscroll];
      _autoscrollPanningDirection = kMDCAutoscrollPanningDirectionDown;
    } else {
      [self stopAutoscroll];
    }

    // Check delegate for permission to move item.
    if ([_delegate
            respondsToSelector:@selector(collectionView:canMoveItemAtIndexPath:toIndexPath:)]) {
      if ([_delegate collectionView:_collectionView
              canMoveItemAtIndexPath:previousIndexPath
                         toIndexPath:newIndexPath]) {
        _reorderingCellIndexPath = newIndexPath;

        // Notify delegate that item will move.
        if ([_delegate respondsToSelector:@selector
                       (collectionView:willMoveItemAtIndexPath:toIndexPath:)]) {
          [_delegate collectionView:_collectionView
              willMoveItemAtIndexPath:previousIndexPath
                          toIndexPath:newIndexPath];
        }

        // Notify delegate item did move.
        if ([_delegate
                respondsToSelector:@selector(collectionView:didMoveItemAtIndexPath:toIndexPath:)]) {
          [_delegate collectionView:_collectionView
              didMoveItemAtIndexPath:previousIndexPath
                         toIndexPath:newIndexPath];
        }
      } else {
        // Exit if delegate will not allow this indexPath to move.
        return;
      }
    }
  }
}

- (void)panToDismissWithRecognizer:(UIPanGestureRecognizer *)recognizer {
  CGPoint translation = [recognizer translationInView:_collectionView];
  CGPoint velocity = [recognizer velocityInView:_collectionView];
  CGPoint location = [recognizer locationInView:_collectionView];

  switch (recognizer.state) {
    case UIGestureRecognizerStateBegan: {
      if (fabs(velocity.y) > fabs(velocity.x)) {
        // Exit if panning vertically.
        return [self exitPanToDismissWithRecognizer:recognizer];
      }

      BOOL allowsSwipeToDismissSection = NO;
      if ([_delegate respondsToSelector:@selector(collectionViewAllowsSwipeToDismissSection:)]) {
        allowsSwipeToDismissSection =
            [_delegate collectionViewAllowsSwipeToDismissSection:_collectionView];
      }

      BOOL allowsSwipeToDismissItem = NO;
      if ([_delegate respondsToSelector:@selector(collectionViewAllowsSwipeToDismissItem:)]) {
        allowsSwipeToDismissItem =
            [_delegate collectionViewAllowsSwipeToDismissItem:_collectionView];
      }

      if (allowsSwipeToDismissSection && !self.isEditing) {
        // Determine panned section to dismiss.
        _dismissingSection = [self swipedSectionAtLocation:location];
        if (_dismissingSection == NSNotFound) {
          return [self exitPanToDismissWithRecognizer:recognizer];
        }

        // Check delegate for permission to swipe section.
        if ([_delegate respondsToSelector:@selector(collectionView:canSwipeToDismissSection:)]) {
          if ([_delegate collectionView:_collectionView
                  canSwipeToDismissSection:_dismissingSection]) {
            // Notify delegate.
            if ([_delegate
                    respondsToSelector:@selector(collectionView:willBeginSwipeToDismissSection:)]) {
              [_delegate collectionView:_collectionView
                  willBeginSwipeToDismissSection:_dismissingSection];
            }
          } else {
            // Cannot swipe so exit.
            return [self exitPanToDismissWithRecognizer:recognizer];
          }
        }

        // Create section snapshot.
        [_collectionView insertSubview:[self snapshotWithSection:_dismissingSection] atIndex:0];
        break;

      } else if (allowsSwipeToDismissItem) {
        // Determine panned index path to dismiss.
        _dismissingCellIndexPath = [_collectionView indexPathForItemAtPoint:location];
        if (!_dismissingCellIndexPath) {
          return [self exitPanToDismissWithRecognizer:recognizer];
        }

        // Check delegate for permission to swipe item.
        if ([_delegate
                respondsToSelector:@selector(collectionView:canSwipeToDismissItemAtIndexPath:)]) {
          if ([_delegate collectionView:_collectionView
                  canSwipeToDismissItemAtIndexPath:_dismissingCellIndexPath]) {
            // Notify delegate.
            if ([_delegate respondsToSelector:@selector
                           (collectionView:willBeginSwipeToDismissItemAtIndexPath:)]) {
              [_delegate collectionView:_collectionView
                  willBeginSwipeToDismissItemAtIndexPath:_dismissingCellIndexPath];
            }
          } else {
            // Cannot swipe so exit.
            return [self exitPanToDismissWithRecognizer:recognizer];
          }
        }

        // Create item snapshot.
        [_collectionView insertSubview:[self snapshotWithIndexPath:_dismissingCellIndexPath]
                               atIndex:0];
        break;
      }
    }

    case UIGestureRecognizerStateChanged: {
      // Update the tracked item's position and alpha.
      CGAffineTransform transform;
      CGFloat alpha;
      // The item is fully opaque until it pans at least @c kDismissalDistanceBeforeFading points.
      CGFloat panDistance = (CGFloat)fabs(translation.x) - kDismissalDistanceBeforeFading;
      if (panDistance > 0) {
        transform = [self transformItemDismissalToTranslationX:translation.x];
        alpha = [self dismissalAlphaForTranslationX:translation.x];
      } else {
        // Pan the item.
        transform = CGAffineTransformMakeTranslation(translation.x, 0);
        alpha = 1;
      }
      _cellSnapshot.layer.transform = CATransform3DMakeAffineTransform(transform);
      _cellSnapshot.alpha = alpha;
      break;
    }

    case UIGestureRecognizerStateEnded: {
      // Check the final translation, including the final velocity, to determine
      // if the item should be dismissed.
      CGFloat momentumX = velocity.x * kDismissalSwipeFriction;
      CGFloat translationX = translation.x + momentumX;

      if (fabs(translationX) > [self distanceThresholdForDismissal]) {
        // @c translationX is only guaranteed to be over the dismissal threshold;
        // make sure the view animates all the way off the screen.
        translationX = (CGFloat)copysign(
            MAX(fabs(translationX), CGRectGetWidth(_collectionView.bounds)), translationX);
        [self animateFinalItemDismissalToTranslationX:translationX];
      } else {
        [self restorePanningItemIfNecessaryWithMomentumX:momentumX];
      }
      break;
    }
    default: {
      [self restorePanningItemIfNecessaryWithMomentumX:0];
      break;
    }
  }
}

- (void)exitPanToDismissWithRecognizer:(UIPanGestureRecognizer *)recognizer {
  // To exit, disable the recognizer immediately which forces it to drop out of the current
  // loop and prevent any state updates. Then re-enable to allow future panning.
  recognizer.enabled = NO;
  recognizer.enabled = YES;
}

#pragma mark - Dismissal animation.

- (CGAffineTransform)transformItemDismissalToTranslationX:(CGFloat)translationX {
  // Returns a transform that can be applied to the snapshot during dismissal. The
  // translation will pan along the direction of the swipe.
  CGFloat finalXTranslation = translationX;
  if (finalXTranslation > 0) {
    finalXTranslation = MAX(kDismissalDistanceBeforeFading, finalXTranslation);
  } else {
    finalXTranslation = MIN(-kDismissalDistanceBeforeFading, finalXTranslation);
  }

  return CGAffineTransformMakeTranslation(finalXTranslation, 0);
}

- (void)animateFinalItemDismissalToTranslationX:(CGFloat)translationX {
  // Called at the end of a pan gesture that results in the item being dismissed.
  // Animation that moves the dismissed item to the final location and fades it out.
  CGAffineTransform transform = [self transformItemDismissalToTranslationX:translationX];

  // Notify delegate of dismissed section.
  if (_dismissingSection != NSNotFound) {
    if ([_delegate respondsToSelector:@selector(collectionView:didEndSwipeToDismissSection:)]) {
      [_delegate collectionView:_collectionView didEndSwipeToDismissSection:_dismissingSection];
    }
  }

  // Notify delegate of dismissed item.
  if (_dismissingCellIndexPath) {
    if ([_delegate
            respondsToSelector:@selector(collectionView:didEndSwipeToDismissItemAtIndexPath:)]) {
      [_delegate collectionView:_collectionView
          didEndSwipeToDismissItemAtIndexPath:_dismissingCellIndexPath];
    }
  }

  [UIView animateWithDuration:kDismissalAnimationDuration
      delay:0
      options:UIViewAnimationOptionCurveEaseOut
      animations:^{
        self->_cellSnapshot.layer.transform = CATransform3DMakeAffineTransform(transform);
        self->_cellSnapshot.alpha = 0;
      }
      completion:^(__unused BOOL finished) {
        [self restoreEditingItem];
      }];
}

- (void)restorePanningItemIfNecessaryWithMomentumX:(CGFloat)momentumX {
  // If we never had a snapshot, or the snapshot never moved, then skip straight to cleanup.
  if (_cellSnapshot == nil) {
    [self cleanupDismissingInformation];
    return;
  }
  if (CGAffineTransformIsIdentity(_cellSnapshot.transform)) {
    [self restoreEditingItem];
    return;
  }

  CAAnimationGroup *allAnimations = [CAAnimationGroup animation];
  allAnimations.duration = kRestoreAnimationDuration;

  CATransform3D startTransform = CATransform3DMakeAffineTransform(_cellSnapshot.transform);
  CATransform3D midTransform = CATransform3DTranslate(startTransform, momentumX, 0, 0);
  CATransform3D endTransform = CATransform3DIdentity;

  CAKeyframeAnimation *transformAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
  transformAnimation.values = @[
    [NSValue valueWithCATransform3D:startTransform], [NSValue valueWithCATransform3D:midTransform],
    [NSValue valueWithCATransform3D:endTransform]
  ];
  transformAnimation.calculationMode = kCAAnimationCubicPaced;

  CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
  opacityAnimation.fromValue = @(_cellSnapshot.alpha);
  opacityAnimation.toValue = @1;

  allAnimations.animations = @[ transformAnimation, opacityAnimation ];
  allAnimations.delegate = self;
  allAnimations.fillMode = kCAFillModeBackwards;
  _cellSnapshot.layer.transform = CATransform3DIdentity;
  _cellSnapshot.alpha = 1;
  [_cellSnapshot.layer addAnimation:allAnimations forKey:nil];
}

- (void)animationDidStop:(__unused CAAnimation *)animation finished:(__unused BOOL)didFinish {
  [self cancelPanningItem];
}

- (void)cancelPanningItem {
  // Notify delegate of panned section cancellation.
  if (_dismissingSection != NSNotFound) {
    if ([_delegate respondsToSelector:@selector(collectionView:didCancelSwipeToDismissSection:)]) {
      [_delegate collectionView:_collectionView didCancelSwipeToDismissSection:_dismissingSection];
    }
  }

  // Notify delegate of panned index path cancellation.
  if (_dismissingCellIndexPath) {
    if ([_delegate
            respondsToSelector:@selector(collectionView:didCancelSwipeToDismissItemAtIndexPath:)]) {
      [_delegate collectionView:_collectionView
          didCancelSwipeToDismissItemAtIndexPath:_dismissingCellIndexPath];
    }
  }

  [self restoreEditingItem];
}

- (void)restoreEditingItem {
  [self cleanupDismissingInformation];
  [_collectionView.collectionViewLayout invalidateLayout];
}

- (void)cleanupDismissingInformation {
  // Remove snapshot and reset item.
  [_cellSnapshot removeFromSuperview];
  _cellSnapshot = nil;
  _dismissingSection = NSNotFound;
  _dismissingCellIndexPath = nil;
  _reorderingCellIndexPath = nil;
}

// The distance an item must be panned before it is dismissed. Currently half of the bounds width.
- (CGFloat)distanceThresholdForDismissal {
  if (_cellSnapshot) {
    return CGRectGetWidth(_cellSnapshot.bounds) / 2;
  } else {
    return CGRectGetWidth(_collectionView.bounds) / 2;
  }
}

- (CGFloat)dismissalAlphaForTranslationX:(CGFloat)translationX {
  translationX = (CGFloat)fabs(translationX) - kDismissalDistanceBeforeFading;
  CGFloat adjustedThreshold = [self distanceThresholdForDismissal] - kDismissalDistanceBeforeFading;
  CGFloat dismissalPercentage = (CGFloat)MIN(1, fabs(translationX) / adjustedThreshold);
  return kDismissalMinimumAlpha + (1 - kDismissalMinimumAlpha) * (1 - dismissalPercentage);
}

#pragma mark - Reordering Autoscroll

- (void)startAutoscroll {
  if (_autoscrollTimer) {
    [self stopAutoscroll];
  }
  _autoscrollTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(autoscroll:)];
  [_autoscrollTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

- (void)stopAutoscroll {
  if (_autoscrollTimer) {
    [_autoscrollTimer invalidate];
    _autoscrollTimer = nil;
    _autoscrollPanningDirection = kMDCAutoscrollPanningDirectionNone;
  }
}

- (void)autoscroll:(__unused CADisplayLink *)sender {
  // Scrolls at each tick of CADisplayLink by setting scroll contentOffset. Animation is performed
  // within UIView animation block rather than directly calling -setContentOffset:animated: method
  // in order to prevent jerkiness in scrolling.
  BOOL isPanningDown = _autoscrollPanningDirection == kMDCAutoscrollPanningDirectionDown;
  CGFloat yOffset = kMDCAutoscrollPanningOffset * (isPanningDown ? 1 : -1);
  CGFloat contentYOffset = self.collectionView.contentOffset.y;

  // Quit early if scrolling past collection view bounds.
  if ((!isPanningDown && contentYOffset <= 0) ||
      (isPanningDown && contentYOffset >= self.collectionView.contentSize.height -
                                              CGRectGetHeight(self.collectionView.bounds))) {
    [self stopAutoscroll];
    return;
  }

  // When autoscrolling, keep cell snapshot transform to longpress position.
  CGAffineTransform snapshotTransform =
      CATransform3DGetAffineTransform(_cellSnapshot.layer.transform);
  snapshotTransform.ty += yOffset;

  [UIView animateWithDuration:0.3
                        delay:0
                      options:UIViewAnimationOptionBeginFromCurrentState
                   animations:^{
                     self.collectionView.contentOffset =
                         CGPointMake(0, MAX(0, contentYOffset + yOffset));

                     // Transform snapshot position when panning.
                     self->_cellSnapshot.layer.transform =
                         CATransform3DMakeAffineTransform(snapshotTransform);
                   }
                   completion:nil];
}

@end
