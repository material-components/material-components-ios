#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/** Used to store the scaling curve and initial size of the @c imageView of a @c M3CButton. */
@interface M3CIconAttributes : NSObject

@property(nonatomic, copy, readonly) UIFontTextStyle textStyle;
@property(nonatomic, assign, readonly) CGFloat pointSize;

- (instancetype)initWithTextStyle:(UIFontTextStyle)textStyle pointSize:(CGFloat)pointSize;

@end

NS_ASSUME_NONNULL_END
