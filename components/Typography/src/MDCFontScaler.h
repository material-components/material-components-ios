#import <UIKit/UIKit.h>

// Material's text styles, which are similar, but not quite equivalent to Apple's UIFontTextStyle.
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


/**
 MDCFontScaler is used to attach a scaling curve to a UIFont via an associated object on that
 font instance.

 This interface is similar to UIFontMetrics, but the font returned from MDCFontScaler do *not*
 automatically adjust when the device's text size / content size category is changed.
 */
@interface MDCFontScaler : NSObject


/**
 Initializes a font scaler object for the specified text style.

 @param textStyle The style that will be used to determine the scaling curver associated with the
   returned font.  For example, MaterialTextStyleBody1.
 @return An initialized font scaler object.
 */
- (nonnull instancetype)initForMaterialTextStyle:(nonnull NSString *)textStyle;

/**
 Creates and returns a font scaler object for the specified text style.

 @param textStyle The style that will be used to determine the scaling curver associated with the
 returned font.  For example, MaterialTextStyleBody1.
 @return An initialized font scaler object.
 */
+ (nonnull instancetype)scalerForMaterialTextStyle:(nonnull NSString *)textStyle;

- (nonnull instancetype)init NS_UNAVAILABLE;


/**
 Returns an instance of the specified font with an associated scaling curve.

 @param font The base font to use when applying the scaling curve.
 @return An instance of the specified font with an associated scaling curve, and scaled to the
   current Dynamic Type setting.
 */
- (nonnull UIFont *)scalableFontWithFont:(nonnull UIFont *)font;


@end
