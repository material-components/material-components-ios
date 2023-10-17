#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class MDCShadow;

__attribute__((objc_subclassing_restricted))
@interface M3CButton : UIButton

/**
 A color used as the button's @c backgroundColor.

 If left unset or reset to nil for a given state, then a default blue color is used.

 @param color The background color.
 @param state The state.
*/
- (void)setBackgroundColor:(nullable UIColor *)color forState:(UIControlState)state;

/**
 A color used as the button's @c tintColor.

 If left unset or reset to nil for a given state, then a default blue color is used.

 @param color The tint color.
 @param state The state.
*/
- (void)setTintColor:(nullable UIColor *)color forState:(UIControlState)state;

/**
 Sets the border color for a particular control state. Sets the @c borderColor of the layer.

 @param borderColor The border color to set.
 @param state The state to set.
*/
- (void)setBorderColor:(nullable UIColor *)borderColor forState:(UIControlState)state;

/**
 Sets the shadow for a particular control state. Sets the @c shadow of the
 layer.

 @param shadow The shadow to set.
 @param state The state to set.
*/
- (void)setShadow:(nullable MDCShadow *)shadow forState:(UIControlState)state;

/**
 The preferred imageEdgeInsets for a button with an image and title.
*/
@property(nonatomic) UIEdgeInsets imageEdgeInsetsWithImageAndTitle;

/**
 The preferred contentEdgeInsets for a button with an image and title.
*/
@property(nonatomic) UIEdgeInsets edgeInsetsWithImageAndTitle;

/**
 The preferred contentEdgeInsets for a button with an image only.
*/
@property(nonatomic) UIEdgeInsets edgeInsetsWithImageOnly;

/**
 The preferred contentEdgeInsets for a button with a title only.
*/
@property(nonatomic) UIEdgeInsets edgeInsetsWithTitleOnly;

/**
 The minimum height of the button.
*/
@property(nonatomic) CGFloat minimumHeight;

/**
 The minimum width of the button.
*/
@property(nonatomic) CGFloat minimumWidth;

/**
 Is the button a capsule shape.
*/
@property(nonatomic) BOOL isCapsuleShape;

/**
 The time interval used to animate the transintion between button states.
*/
@property(nonatomic) NSTimeInterval animationDuration;

/**
 Should the button's label be rendered on multiple lines. If you set this
 property to YES, make sure that your button has either its
 @c titleLabel.preferredMaxLayoutWidth property set, or that the button's frame
 width is set as desired.
 Otherwise, the button will not be able to calculate a multiline layout.

 @note If using @c isCapsuleShape enabled with this API be sure to consider accessibility needs as
 the label may extend outside the cut corner.
 */
@property(nonatomic) BOOL textCanWrap;

@end

NS_ASSUME_NONNULL_END
