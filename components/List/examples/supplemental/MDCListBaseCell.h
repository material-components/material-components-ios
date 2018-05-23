//
//  MDCListBaseCell.h
//  CatalogByConvention
//
//  Created by andrewoverton on 5/22/18.
//

#import <UIKit/UIKit.h>

@interface MDCListBaseCell : UICollectionViewCell

@property (nonatomic) BOOL allowsSwipeLeftGesture;
@property (nonatomic, assign) CGFloat cellWidth; // for reordering

- (void)performAsAtomicUpdateCellUpdate:(void(^)(void))updateBlock;

@end

