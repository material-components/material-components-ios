#import <UIKit/UIKit.h>

#import "SimpleTextFieldLayoutUtils.h"

@interface SimpleTextField : UITextField

@property (nonatomic, assign) TextFieldStyle textFieldStyle;
@property (nonatomic, assign) BOOL canPlaceholderFloat;
@property (strong, nonatomic, readonly, nonnull) UILabel *leadingUnderlineLabel;
@property (strong, nonatomic, readonly, nonnull) UILabel *trailingUnderlineLabel;
@property (nonatomic, assign) UnderlineLabelDrawPriority underlineLabelDrawPriority;
@property (strong, nonatomic, nullable) UIView *leadingView;
@property (strong, nonatomic, nullable) UIView *trailingView;
@property (nonatomic, assign) UITextFieldViewMode leadingViewMode;
@property (nonatomic, assign) UITextFieldViewMode trailingViewMode;

/**
 When @c underlineLabelDrawPriority is set to @c .custom the value of this property helps determine
 what percentage of the available width each underline label gets. It can be thought of as a
 divider. A value of @c 0 would result in the trailing underline label getting all the available
 width. A value of @c 1 would result in the leading underline label getting all the available width.
 A value of @c .5 would result in each underline label getting 50% of the available width.
 */
@property (nonatomic, assign) CGFloat customUnderlineLabelDrawPriority;


@end
