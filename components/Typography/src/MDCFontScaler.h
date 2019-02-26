#import <UIKit/UIKit.h>

extern NSString * _Nonnull MaterialTextStyleHeadline1;
extern NSString * _Nonnull MaterialTextStyleHeadline2;
extern NSString * _Nonnull MaterialTextStyleHeadline3;
extern NSString * _Nonnull MaterialTextStyleHeadline4;
extern NSString * _Nonnull MaterialTextStyleHeadline5;
extern NSString * _Nonnull MaterialTextStyleHeadline6;
extern NSString * _Nonnull MaterialTextStyleSubtitle1;
extern NSString * _Nonnull MaterialTextStyleSubtitle2;
extern NSString * _Nonnull MaterialTextStyleBody1;
extern NSString * _Nonnull MaterialTextStyleBody2;
extern NSString * _Nonnull MaterialTextStyleButton;
extern NSString * _Nonnull MaterialTextStyleCaption;
extern NSString * _Nonnull MaterialTextStyleOverline;

@interface MDCFontScaler : NSObject

+ (nonnull instancetype)scalerForMaterialTextStyle:(nonnull NSString *)textStyle;
- (nonnull instancetype)initForMaterialTextStyle:(nonnull NSString *)textStyle;

- (nonnull UIFont *)scalableFontWithFont:(nonnull UIFont *)font;

- (CGFloat)scaledValueForValue:(CGFloat)value;

@end
