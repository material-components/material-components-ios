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

#import "MDCCollectionViewStyler.h"

#import "MDCCollectionViewStylingDelegate.h"
#import "MaterialCollectionLayoutAttributes.h"
#import "MaterialPalettes.h"

#include <tgmath.h>

typedef NS_OPTIONS(NSUInteger, BackgroundCacheKey) {
  BackgroundCacheKeyFlat = 0,
  BackgroundCacheKeyTop = 1 << 0,
  BackgroundCacheKeyBottom = 1 << 1,
  BackgroundCacheKeyCard = 1 << 2,
  BackgroundCacheKeyGrouped = 1 << 3,
  BackgroundCacheKeyHighlighted = 1 << 4,
  BackgroundCacheKeyMax = 1 << 5,
};

const CGFloat MDCCollectionViewCellStyleCardSectionInset = 8.0f;

/** Cell content view insets for card-style cells */
static const CGFloat kFourThirds = 4.0f / 3.0f;
static const UIEdgeInsets kCollectionViewCellContentInsetsRetina3x = {kFourThirds, kFourThirds,
                                                                      kFourThirds, kFourThirds};
static const UIEdgeInsets kCollectionViewCellContentInsetsRetina = {1.5, 1.5, 1.5, 1.5};
static const UIEdgeInsets kCollectionViewCellContentInsets = {1, 2, 1, 2};

/** Default cell separator style settings */
static const CGFloat kCollectionViewCellSeparatorDefaultHeightInPixels = 1.0f;

/** Grid layout defaults */
static const NSInteger kCollectionViewGridDefaultColumnCount = 2;
static const CGFloat kCollectionViewGridDefaultPadding = 4.0f;

/** The drawn cell background */
static const CGSize kCellImageSize = {44, 44};
static const CGFloat kCollectionViewCellDefaultBorderWidth = 1.0f;
static const CGFloat kCollectionViewCellDefaultBorderRadius = 1.5f;
static inline UIColor *kCollectionViewCellDefaultBorderColor() {
  return [UIColor colorWithWhite:0 alpha:0.05f];
}

/** Cell shadowing */
static const CGFloat kCollectionViewCellDefaultShadowWidth = 1.0f;
static inline CGSize kCollectionViewCellDefaultShadowOffset() {
  return CGSizeMake(0, 1);
}
static inline UIColor *kCollectionViewCellDefaultShadowColor() {
  return [UIColor colorWithWhite:0 alpha:0.1f];
}

/** Animate cell on appearance settings */
static const CGFloat kCollectionViewAnimatedAppearancePadding = 20.0f;
static const NSTimeInterval kCollectionViewAnimatedAppearanceDelay = 0.1;
static const NSTimeInterval kCollectionViewAnimatedAppearanceDuration = 0.3;

/** Modifies only the right and bottom edges of a CGRect. */
NS_INLINE CGRect RectContract(CGRect rect, CGFloat dx, CGFloat dy) {
  return CGRectMake(rect.origin.x, rect.origin.y, rect.size.width - dx, rect.size.height - dy);
}

/** Modifies only the top and left edges of a CGRect. */
NS_INLINE CGRect RectShift(CGRect rect, CGFloat dx, CGFloat dy) {
  return CGRectOffset(RectContract(rect, dx, dy), dx, dy);
}

@interface MDCCollectionViewStyler ()

/**
 A dictionary of NSPointerArray caches, keyed by UIColor, for cached cell background images
 using that background color. Index into the NSPointerArray using the results of
 backgroundCacheKeyForCardStyle:isGroupedStyle:isTop:isBottom:isHighlighted:
 */
@property(nonatomic, readonly) NSMutableDictionary *cellBackgroundCaches;

/** An set of index paths for items that are inlaid. */
@property(nonatomic, strong) NSMutableSet *inlaidIndexPathSet;

@end

@implementation MDCCollectionViewStyler

@synthesize collectionView = _collectionView;
@synthesize delegate = _delegate;
@synthesize shouldInvalidateLayout = _shouldInvalidateLayout;
@synthesize cellBackgroundColor = _cellBackgroundColor;
@synthesize cellLayoutType = _cellLayoutType;
@synthesize gridColumnCount = _gridColumnCount;
@synthesize gridPadding = _gridPadding;
@synthesize cellStyle = _cellStyle;
@synthesize separatorColor = _separatorColor;
@synthesize separatorInset = _separatorInset;
@synthesize separatorLineHeight = _separatorLineHeight;
@synthesize shouldHideSeparators = _shouldHideSeparators;
@synthesize allowsItemInlay = _allowsItemInlay;
@synthesize allowsMultipleItemInlays = _allowsMultipleItemInlays;
@synthesize shouldAnimateCellsOnAppearance = _shouldAnimateCellsOnAppearance;
@synthesize willAnimateCellsOnAppearance = _willAnimateCellsOnAppearance;
@synthesize animateCellsOnAppearancePadding = _animateCellsOnAppearancePadding;
@synthesize animateCellsOnAppearanceDuration = _animateCellsOnAppearanceDuration;

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView {
  self = [super init];
  if (self) {
    _collectionView = collectionView;

    // Cell default style properties.
    _cellBackgroundColor = [UIColor whiteColor];
    _cellStyle = MDCCollectionViewCellStyleDefault;
    // Background color is 0xEEEEEE
    _collectionView.backgroundColor = MDCPalette.greyPalette.tint200;
    _inlaidIndexPathSet = [NSMutableSet set];

    // Cell separator defaults.
    _separatorColor = MDCPalette.greyPalette.tint300;
    _separatorInset = UIEdgeInsetsZero;
    _separatorLineHeight =
        kCollectionViewCellSeparatorDefaultHeightInPixels / [[UIScreen mainScreen] scale];
    _shouldHideSeparators = NO;

    // Grid defaults.
    _cellLayoutType = MDCCollectionViewCellLayoutTypeList;
    _gridColumnCount = kCollectionViewGridDefaultColumnCount;
    _gridPadding = kCollectionViewGridDefaultPadding;

    // Animate cell on appearance settings.
    _animateCellsOnAppearancePadding = kCollectionViewAnimatedAppearancePadding;
    _animateCellsOnAppearanceDuration = kCollectionViewAnimatedAppearanceDuration;

    // Caching.
    _cellBackgroundCaches = [NSMutableDictionary dictionary];
  }
  return self;
}

- (BOOL)isEqual:(id)object {
  // If shouldInvalidateLayout property is NO, prevent a collection view layout caused when
  // layout attributes check here if they are equal.
  return (self == object) && ![self shouldInvalidateLayoutForStyleChange];
}

#pragma mark - Cell Appearance Animation

- (void)setShouldAnimateCellsOnAppearance:(BOOL)shouldAnimateCellsOnAppearance {
  _shouldAnimateCellsOnAppearance = shouldAnimateCellsOnAppearance;
  _willAnimateCellsOnAppearance = shouldAnimateCellsOnAppearance;
}

- (void)beginCellAppearanceAnimation {
  if (_shouldAnimateCellsOnAppearance) {
    _willAnimateCellsOnAppearance = NO;
    [UIView animateWithDuration:_animateCellsOnAppearanceDuration
        delay:kCollectionViewAnimatedAppearanceDelay
        options:UIViewAnimationOptionCurveEaseInOut
        animations:^{
          [self updateLayoutAnimated:YES];
        }
        completion:^(__unused BOOL finished) {
          [self setShouldAnimateCellsOnAppearance:NO];
        }];
  }
}

#pragma mark - Caching

- (BackgroundCacheKey)backgroundCacheKeyForCardStyle:(BOOL)isCardStyle
                                      isGroupedStyle:(BOOL)isGroupedStyle
                                               isTop:(BOOL)isTop
                                            isBottom:(BOOL)isBottom
                                       isHighlighted:(BOOL)isHighlighted {
  if (!isCardStyle && !isGroupedStyle) {
    return BackgroundCacheKeyFlat;
  }
  BackgroundCacheKey options = isTop ? BackgroundCacheKeyTop : 0;
  options |= isBottom ? BackgroundCacheKeyBottom : 0;
  options |= isCardStyle ? BackgroundCacheKeyCard : 0;
  options |= isGroupedStyle ? BackgroundCacheKeyGrouped : 0;
  options |= isHighlighted ? BackgroundCacheKeyHighlighted : 0;
  NSAssert(isCardStyle != isGroupedStyle, @"Cannot be both card and grouped style");
  return options;
}

- (NSPointerArray *)cellBackgroundCache {
  NSPointerArray *cache = [NSPointerArray strongObjectsPointerArray];
  cache.count = BackgroundCacheKeyMax;
  return cache;
}

#pragma mark - Separators

- (void)setSeparatorColor:(UIColor *)separatorColor {
  if (_separatorColor == separatorColor) {
    return;
  }
  [self invalidateLayoutForStyleChange];
  _separatorColor = separatorColor;
}

- (void)setSeparatorInset:(UIEdgeInsets)separatorInset {
  if (UIEdgeInsetsEqualToEdgeInsets(_separatorInset, separatorInset)) {
    return;
  }
  [self invalidateLayoutForStyleChange];
  _separatorInset = separatorInset;
}

- (void)setSeparatorLineHeight:(CGFloat)separatorLineHeight {
  if (_separatorLineHeight == separatorLineHeight) {
    return;
  }
  [self invalidateLayoutForStyleChange];
  _separatorLineHeight = separatorLineHeight;
}

- (void)setShouldHideSeparators:(BOOL)shouldHideSeparators {
  if (_shouldHideSeparators == shouldHideSeparators) {
    return;
  }
  [self invalidateLayoutForStyleChange];
  _shouldHideSeparators = shouldHideSeparators;
}

- (void)setCellStyle:(MDCCollectionViewCellStyle)cellStyle {
  if (_cellStyle == cellStyle) {
    return;
  }
  [_cellBackgroundCaches removeAllObjects];
  [self invalidateLayoutForStyleChange];
  _cellStyle = cellStyle;
}

- (BOOL)shouldHideSeparatorForCellLayoutAttributes:(MDCCollectionViewLayoutAttributes *)attr {
  BOOL shouldHideSeparator = self.shouldHideSeparators;
  if (!self.delegate) {
    return shouldHideSeparator;
  }

  NSIndexPath *indexPath = attr.indexPath;
  BOOL isCell = attr.representedElementCategory == UICollectionElementCategoryCell;
  BOOL isSectionHeader =
      [attr.representedElementKind isEqualToString:UICollectionElementKindSectionHeader];
  BOOL isSectionFooter =
      [attr.representedElementKind isEqualToString:UICollectionElementKindSectionFooter];
  if (isCell) {
    if ([self.delegate
            respondsToSelector:@selector(collectionView:shouldHideItemSeparatorAtIndexPath:)]) {
      shouldHideSeparator = [self.delegate collectionView:_collectionView
                       shouldHideItemSeparatorAtIndexPath:indexPath];
    }
  } else if (isSectionHeader) {
    if ([self.delegate
            respondsToSelector:@selector(collectionView:shouldHideHeaderSeparatorForSection:)]) {
      shouldHideSeparator = [self.delegate collectionView:_collectionView
                      shouldHideHeaderSeparatorForSection:indexPath.section];
    }
  } else if (isSectionFooter) {
    if ([self.delegate
            respondsToSelector:@selector(collectionView:shouldHideFooterSeparatorForSection:)]) {
      shouldHideSeparator = [self.delegate collectionView:_collectionView
                      shouldHideFooterSeparatorForSection:indexPath.section];
    }
  }
  return shouldHideSeparator;
}

#pragma mark - Public

- (UIEdgeInsets)backgroundImageViewOutsetsForCellWithAttribute:
        (MDCCollectionViewLayoutAttributes *)attr {
  // Inset contentView to allow for shadowed borders in cards.
  UIEdgeInsets insets = UIEdgeInsetsZero;

  MDCCollectionViewCellStyle cellStyle = [self cellStyleAtSectionIndex:attr.indexPath.section];
  BOOL isCardStyle = cellStyle == MDCCollectionViewCellStyleCard;
  BOOL isGroupedStyle = cellStyle == MDCCollectionViewCellStyleGrouped;
  BOOL isHighlighted = NO;

  MDCCollectionViewOrdinalPosition position = attr.sectionOrdinalPosition;

  if ([self drawShadowForCellWithIsCardStye:isCardStyle
                               isGroupStyle:isGroupedStyle
                              isHighlighted:isHighlighted]) {
    CGFloat mainScreenScale = [[UIScreen mainScreen] scale];
    if (mainScreenScale > (CGFloat)2.1) {
      insets = kCollectionViewCellContentInsetsRetina3x;
    } else if (mainScreenScale > (CGFloat)1.1) {
      insets = kCollectionViewCellContentInsetsRetina;
    } else {
      insets = kCollectionViewCellContentInsets;
    }

    if (!isCardStyle) {
      insets = UIEdgeInsetsMake(insets.top, 0, insets.bottom, 0);
    }

    switch (position) {
      case MDCCollectionViewOrdinalPositionVerticalTop:
        insets = UIEdgeInsetsMake(insets.top, insets.left, 0, insets.right);
        break;
      case MDCCollectionViewOrdinalPositionVerticalBottom:
        insets = UIEdgeInsetsMake(0, insets.left, insets.bottom, insets.right);
        break;
      case MDCCollectionViewOrdinalPositionVerticalCenter:
        insets = UIEdgeInsetsMake(0, insets.left, 0, insets.right);
        break;
      default:
        break;
    }
  }

  return insets;
}

- (void)setCellStyle:(MDCCollectionViewCellStyle)cellStyle animated:(BOOL)animated {
  _cellStyle = cellStyle;
  [self updateLayoutAnimated:animated];
}

- (MDCCollectionViewCellStyle)cellStyleAtSectionIndex:(NSInteger)section {
  MDCCollectionViewCellStyle cellStyle = self.cellStyle;
  if (self.delegate &&
      [self.delegate respondsToSelector:@selector(collectionView:cellStyleForSection:)]) {
    cellStyle = [self.delegate collectionView:_collectionView cellStyleForSection:section];
  }
  return cellStyle;
}

- (NSArray *)indexPathsForInlaidItems {
  return [_inlaidIndexPathSet allObjects];
}

- (BOOL)isItemInlaidAtIndexPath:(NSIndexPath *)indexPath {
  return [_inlaidIndexPathSet containsObject:indexPath];
}

- (void)applyInlayToItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
  if (_allowsItemInlay) {
    // If necessary, remove any previously inlaid items.
    if (!_allowsMultipleItemInlays) {
      for (NSIndexPath *inlaidIndexPath in [self indexPathsForInlaidItems]) {
        [self removeInlayFromItemAtIndexPath:inlaidIndexPath animated:animated];
      }
    }

    void (^completionBlock)(BOOL finished) = ^(__unused BOOL finished) {
      if ([self.delegate
              respondsToSelector:@selector(collectionView:didApplyInlayToItemAtIndexPaths:)]) {
        [self.delegate collectionView:self.collectionView
            didApplyInlayToItemAtIndexPaths:@[ indexPath ]];
      }
    };

    // Inlay this item.
    [_inlaidIndexPathSet addObject:indexPath];
    [self updateLayoutAnimated:animated completion:completionBlock];
  }
}

- (void)removeInlayFromItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated {
  [_inlaidIndexPathSet removeObject:indexPath];

  void (^completionBlock)(BOOL finished) = ^(__unused BOOL finished) {
    if ([self.delegate
            respondsToSelector:@selector(collectionView:didRemoveInlayFromItemAtIndexPaths:)]) {
      [self.delegate collectionView:self.collectionView
          didRemoveInlayFromItemAtIndexPaths:@[ indexPath ]];
    }
  };

  [self updateLayoutAnimated:animated completion:completionBlock];
}

- (void)applyInlayToAllItemsAnimated:(BOOL)animated {
  if (_allowsItemInlay && _allowsMultipleItemInlays) {
    // Store all index paths.
    [_inlaidIndexPathSet removeAllObjects];
    NSInteger sections = [_collectionView numberOfSections];
    for (NSInteger section = 0; section < sections; section++) {
      for (NSInteger item = 0; item < [_collectionView numberOfItemsInSection:section]; item++) {
        [_inlaidIndexPathSet addObject:[NSIndexPath indexPathForItem:item inSection:section]];
      }
    }

    void (^completionBlock)(BOOL finished) = ^(__unused BOOL finished) {
      if ([self.delegate
              respondsToSelector:@selector(collectionView:didApplyInlayToItemAtIndexPaths:)]) {
        [self.delegate collectionView:self.collectionView
            didApplyInlayToItemAtIndexPaths:[self.inlaidIndexPathSet allObjects]];
      }
    };

    // Inlay all items.
    [self updateLayoutAnimated:animated completion:completionBlock];
  }
}

- (void)removeInlayFromAllItemsAnimated:(BOOL)animated {
  NSArray *indexPaths = [_inlaidIndexPathSet allObjects];
  [_inlaidIndexPathSet removeAllObjects];

  void (^completionBlock)(BOOL finished) = ^(__unused BOOL finished) {
    if ([self.delegate
            respondsToSelector:@selector(collectionView:didRemoveInlayFromItemAtIndexPaths:)]) {
      [self.delegate collectionView:self.collectionView didRemoveInlayFromItemAtIndexPaths:indexPaths];
    }
  };

  [self updateLayoutAnimated:animated completion:completionBlock];
}

- (void)resetIndexPathsForInlaidItems {
  [_inlaidIndexPathSet removeAllObjects];
  [self applyInlayToAllItemsAnimated:NO];
}

- (void)updateLayoutAnimated:(BOOL)animated {
  [self updateLayoutAnimated:animated completion:nil];
}

#pragma mark - Private

- (void)updateLayoutAnimated:(BOOL)animated completion:(void (^)(BOOL finished))completion {
  if (animated) {
    // Invalidate current layout while allowing animation to new layout.
    [UIView animateWithDuration:0
        animations:^{
          [self.collectionView.collectionViewLayout invalidateLayout];
        }
        completion:^(BOOL finished) {
          if (completion) {
            completion(finished);
          }
        }];
  } else {
    _shouldInvalidateLayout = YES;

    // Create new layout with existing layout properties.
    NSData *data =
        [NSKeyedArchiver archivedDataWithRootObject:_collectionView.collectionViewLayout];
    UICollectionViewFlowLayout *newLayout = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    [_collectionView setCollectionViewLayout:newLayout
                                    animated:animated
                                  completion:^(BOOL finished) {
                                    if (completion) {
                                      completion(finished);
                                    }
                                  }];
  }
}

- (void)invalidateLayoutForStyleChange {
  _shouldInvalidateLayout = YES;
}

- (BOOL)shouldInvalidateLayoutForStyleChange {
  // Whether the collection view layout should be invalidated due to a style property that has
  // changed value.
  return _shouldInvalidateLayout;
}

#pragma mark - Cell Image Background

- (BOOL)drawShadowForCellWithIsCardStye:(BOOL)isCardStyle
                           isGroupStyle:(BOOL)isGroupStyle
                          isHighlighted:(BOOL)isHighlighted {
  return (isCardStyle || isGroupStyle) && kCollectionViewCellDefaultShadowWidth > 0 &&
         !isHighlighted;
}

- (UIImage *)backgroundImageForCellLayoutAttributes:(MDCCollectionViewLayoutAttributes *)attr {
  BOOL isSectionHeader =
      [attr.representedElementKind isEqualToString:UICollectionElementKindSectionHeader];
  BOOL isSectionFooter =
      [attr.representedElementKind isEqualToString:UICollectionElementKindSectionFooter];
  BOOL isDecorationView =
      attr.representedElementCategory == UICollectionElementCategoryDecorationView;
  BOOL isTop = attr.sectionOrdinalPosition & MDCCollectionViewOrdinalPositionVerticalTop;
  BOOL isBottom = attr.sectionOrdinalPosition & MDCCollectionViewOrdinalPositionVerticalBottom;

  MDCCollectionViewCellStyle cellStyle = [self cellStyleAtSectionIndex:attr.indexPath.section];
  BOOL isCardStyle = cellStyle == MDCCollectionViewCellStyleCard;
  BOOL isGroupedStyle = cellStyle == MDCCollectionViewCellStyleGrouped;
  BOOL isGridLayout = (_cellLayoutType == MDCCollectionViewCellLayoutTypeGrid);
  if (!isCardStyle && !isGroupedStyle) {
    // If not card or grouped style, revert @c isBottom to allow drawing separator at bottom.
    isBottom = NO;
  }
  CGFloat borderRadius = (isCardStyle) ? kCollectionViewCellDefaultBorderRadius : 0.0f;

  // Allowance for grid decoration view.
  if (isGridLayout) {
    if (!isDecorationView && attr.shouldShowGridBackground) {
      return nil;
    } else {
      isTop = isBottom = YES;
    }
  }

  // If no-background section header, return nil image.
  BOOL hidesHeaderBackground = NO;
  if ([_delegate
          respondsToSelector:@selector(collectionView:shouldHideHeaderBackgroundForSection:)]) {
    hidesHeaderBackground = [_delegate collectionView:_collectionView
                 shouldHideHeaderBackgroundForSection:attr.indexPath.section];
  }
  if (hidesHeaderBackground && isSectionHeader) {
    return nil;
  }

  // If no-background section footer, return nil image.
  BOOL hidesFooterBackground = NO;
  if ([_delegate
          respondsToSelector:@selector(collectionView:shouldHideFooterBackgroundForSection:)]) {
    hidesFooterBackground = [_delegate collectionView:_collectionView
                 shouldHideFooterBackgroundForSection:attr.indexPath.section];
  }
  if (hidesFooterBackground && isSectionFooter) {
    return nil;
  }

  // If no-background section item, return nil image.
  BOOL hidesBackground = NO;
  if ([_delegate
          respondsToSelector:@selector(collectionView:shouldHideItemBackgroundAtIndexPath:)]) {
    hidesBackground = [_delegate collectionView:_collectionView
            shouldHideItemBackgroundAtIndexPath:attr.indexPath];
  }
  if (hidesBackground && !(isDecorationView || isSectionFooter || isSectionHeader)) {
    return nil;
  }

  BOOL isHighlighted = NO;

  BackgroundCacheKey backgroundCacheKey = [self backgroundCacheKeyForCardStyle:isCardStyle
                                                                isGroupedStyle:isGroupedStyle
                                                                         isTop:isTop
                                                                      isBottom:isBottom
                                                                 isHighlighted:isHighlighted];

  if (backgroundCacheKey > BackgroundCacheKeyMax) {
    NSAssert(NO, @"Invalid styler cell background cache key");
    return nil;
  }

  // Get cell color.
  UIColor *backgroundColor = _cellBackgroundColor;
  if ([_delegate respondsToSelector:@selector(collectionView:cellBackgroundColorAtIndexPath:)]) {
    UIColor *customBackgroundColor =
        [_delegate collectionView:_collectionView cellBackgroundColorAtIndexPath:attr.indexPath];
    if (customBackgroundColor) {
      backgroundColor = customBackgroundColor;
    }
  }

  NSPointerArray *cellBackgroundCache = _cellBackgroundCaches[backgroundColor];
  if (!cellBackgroundCache) {
    cellBackgroundCache = [self cellBackgroundCache];
    _cellBackgroundCaches[backgroundColor] = cellBackgroundCache;
  } else if ([cellBackgroundCache pointerAtIndex:backgroundCacheKey]) {
    return (__bridge UIImage *)[cellBackgroundCache pointerAtIndex:backgroundCacheKey];
  }

  CGRect imageRect = CGRectMake(0, 0, kCellImageSize.width, kCellImageSize.height);
  UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, 0);

  CGContextRef cx = UIGraphicsGetCurrentContext();

  // Create a transparent background.
  CGContextClearRect(cx, imageRect);

  // Inner background color
  CGContextSetFillColorWithColor(cx, backgroundColor.CGColor);

  CGRect contentFrame = imageRect;

  // Draw the shadow.
  if ([self drawShadowForCellWithIsCardStye:isCardStyle
                               isGroupStyle:isGroupedStyle
                              isHighlighted:isHighlighted]) {
    if (isCardStyle) {
      contentFrame = CGRectInset(imageRect, kCollectionViewCellDefaultShadowWidth, 0);
    }
    if (isTop) {
      contentFrame = RectShift(contentFrame, 0, kCollectionViewCellDefaultShadowWidth);
    }
    if (isBottom) {
      contentFrame = RectContract(contentFrame, 0, kCollectionViewCellDefaultShadowWidth);
    }

    CGContextSaveGState(cx);
    CGRect shadowFrame = contentFrame;

    // We want the shadow to clip to the top and bottom edges of the image so that when two cells
    // are next to each other their shadows line up perfectly.
    if (!isTop) {
      shadowFrame = RectShift(shadowFrame, 0, -kCollectionViewCellDefaultShadowWidth);
    }
    if (!isBottom) {
      shadowFrame = RectContract(shadowFrame, 0, -kCollectionViewCellDefaultShadowWidth);
    }

    [self applyBackgroundPathToContext:cx
                                  rect:shadowFrame
                                 isTop:isTop
                              isBottom:isBottom
                                isCard:(isCardStyle || isGroupedStyle)
                          borderRadius:borderRadius];
    CGContextSetShadowWithColor(cx, kCollectionViewCellDefaultShadowOffset(),
                                kCollectionViewCellDefaultShadowWidth,
                                kCollectionViewCellDefaultShadowColor().CGColor);
    CGContextDrawPath(cx, kCGPathFill);
    CGContextRestoreGState(cx);
  } else {
    // Draw a flat cell background.
    CGContextSaveGState(cx);
    [self applyBackgroundPathToContext:cx
                                  rect:contentFrame
                                 isTop:isTop
                              isBottom:isBottom
                                isCard:(isCardStyle || isGroupedStyle)
                          borderRadius:borderRadius];
    CGContextFillPath(cx);
    CGContextRestoreGState(cx);
  }
  // Draw border paths for cells. We want the cell border to overlap the shadow and the content.
  if ((isCardStyle || isGroupedStyle) && !isHighlighted) {
    CGFloat minPixelOffset = [self minPixelOffset];
    CGRect borderFrame = CGRectInset(contentFrame, -minPixelOffset, -minPixelOffset);
    CGContextSaveGState(cx);
    CGContextSetLineWidth(cx, kCollectionViewCellDefaultBorderWidth);
    CGContextSetStrokeColorWithColor(cx, kCollectionViewCellDefaultBorderColor().CGColor);
    [self applyBorderPathToContext:cx
                              rect:borderFrame
                             isTop:isTop
                          isBottom:isBottom
                            isCard:isCardStyle
                      borderRadius:borderRadius];
    CGContextStrokePath(cx);
    CGContextRestoreGState(cx);
  }

  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  UIImage *resizableImage = [self resizableImage:image];
  [cellBackgroundCache replacePointerAtIndex:backgroundCacheKey
                                 withPointer:(__bridge void *)(resizableImage)];
  return resizableImage;
}

#pragma mark - Private Context Paths

// We want to draw the borders and shadows on single retina-pixel boundaries if possible, but
// we need to avoid doing this on non-retina devices because it'll look blurry.
- (CGFloat)minPixelOffset {
  return 1.0f / [[UIScreen mainScreen] scale];
}

- (UIImage *)resizableImage:(UIImage *)image {
  // Returns a resizable version of this image with cap insets equal to center point.
  CGFloat capWidth = (CGFloat)floor(image.size.width / 2);
  CGFloat capHeight = (CGFloat)floor(image.size.height / 2);
  UIEdgeInsets capInsets = UIEdgeInsetsMake(capHeight, capWidth, capHeight, capWidth);
  return [image resizableImageWithCapInsets:capInsets];
}

- (void)applyBackgroundPathToContext:(CGContextRef)c
                                rect:(CGRect)rect
                               isTop:(BOOL)isTop
                            isBottom:(BOOL)isBottom
                              isCard:(BOOL)isCard
                        borderRadius:(CGFloat)borderRadius {
  // Draw background paths for cell.
  CGFloat minPixelOffset = (isCard) ? [self minPixelOffset] : 0.0f;
  CGFloat minX = CGRectGetMinX(rect) + minPixelOffset;
  CGFloat midX = CGRectGetMidX(rect) + minPixelOffset;
  CGFloat maxX = CGRectGetMaxX(rect) - minPixelOffset;
  CGFloat minY = CGRectGetMinY(rect) - minPixelOffset;
  CGFloat midY = CGRectGetMidY(rect) - minPixelOffset;
  CGFloat maxY = CGRectGetMaxY(rect) + minPixelOffset;

  CGContextBeginPath(c);

  CGContextMoveToPoint(c, minX, midY);
  if (isTop && isCard) {
    CGContextAddArcToPoint(c, minX, minY + 1, midX, minY + 1, borderRadius);
    CGContextAddArcToPoint(c, maxX, minY + 1, maxX, midY, borderRadius);
  } else {
    CGContextAddLineToPoint(c, minX, minY);
    CGContextAddLineToPoint(c, maxX, minY);
  }

  CGContextAddLineToPoint(c, maxX, midY);

  if (isBottom & isCard) {
    CGContextAddArcToPoint(c, maxX, maxY - 1, midX, maxY - 1, borderRadius);
    CGContextAddArcToPoint(c, minX, maxY - 1, minX, midY, borderRadius);
  } else {
    CGContextAddLineToPoint(c, maxX, maxY);
    CGContextAddLineToPoint(c, minX, maxY);
  }
  CGContextAddLineToPoint(c, minX, midY);

  CGContextClosePath(c);
}

- (void)applyBorderPathToContext:(CGContextRef)c
                            rect:(CGRect)rect
                           isTop:(BOOL)isTop
                        isBottom:(BOOL)isBottom
                          isCard:(BOOL)isCard
                    borderRadius:(CGFloat)borderRadius {
  // Draw border paths for cell.
  CGFloat minPixelOffset = (isCard) ? [self minPixelOffset] : 0.0f;
  CGFloat minX = CGRectGetMinX(rect) + minPixelOffset;
  CGFloat midX = CGRectGetMidX(rect) + minPixelOffset;
  CGFloat maxX = CGRectGetMaxX(rect) - minPixelOffset;
  CGFloat minY = CGRectGetMinY(rect) - minPixelOffset;
  CGFloat midY = CGRectGetMidY(rect) - minPixelOffset;
  CGFloat maxY = CGRectGetMaxY(rect) + minPixelOffset;

  CGContextBeginPath(c);

  if (isTop && isBottom) {
    CGContextMoveToPoint(c, minX, midY);
    CGContextAddArcToPoint(c, minX, minY + 1, midX, minY + 1, borderRadius);
    CGContextAddArcToPoint(c, maxX, minY + 1, maxX, midY, borderRadius);
    CGContextAddLineToPoint(c, maxX, midY);
    CGContextAddArcToPoint(c, maxX, maxY - 1, midX, maxY - 1, borderRadius);
    CGContextAddArcToPoint(c, minX, maxY - 1, minX, midY, borderRadius);
    CGContextAddLineToPoint(c, minX, midY);
  } else if (isTop) {
    CGContextMoveToPoint(c, minX, maxY);
    CGContextAddLineToPoint(c, minX, midY);
    CGContextAddArcToPoint(c, minX, minY + 1, midX, minY + 1, borderRadius);
    CGContextAddArcToPoint(c, maxX, minY + 1, maxX, midY, borderRadius);
    CGContextAddLineToPoint(c, maxX, maxY);
  } else if (isBottom) {
    CGContextMoveToPoint(c, maxX, minY);
    CGContextAddLineToPoint(c, maxX, midY);
    CGContextAddArcToPoint(c, maxX, maxY - 1, midX, maxY - 1, borderRadius);
    CGContextAddArcToPoint(c, minX, maxY - 1, minX, midY, borderRadius);
    CGContextAddLineToPoint(c, minX, minY);
  } else {
    CGContextMoveToPoint(c, minX, minY);
    CGContextAddLineToPoint(c, minX, maxY);
    CGContextMoveToPoint(c, maxX, minY);
    CGContextAddLineToPoint(c, maxX, maxY);
  }

  CGContextClosePath(c);
}

@end
