#import <UIKit/UIKit.h>

#import "SimpleTextFieldLayoutUtils.h"

@interface SimpleTextField : UITextField

/**
 The default style is .underline
 */
@property (nonatomic, assign) TextFieldStyle textFieldStyle;
@property (nonatomic, assign) BOOL canPlaceholderFloat;
@property (strong, nonatomic, readonly, nonnull) UILabel *leadingUnderlineLabel;
@property (strong, nonatomic, readonly, nonnull) UILabel *trailingUnderlineLabel;
@property (nonatomic, assign) UnderlineLabelDrawPriority underlineLabelDrawPriority;
@property (strong, nonatomic, nullable) UIView *leadingView;
@property (strong, nonatomic, nullable) UIView *trailingView;
@property (nonatomic, assign) UITextFieldViewMode leadingViewMode;
@property (nonatomic, assign) UITextFieldViewMode trailingViewMode;

// 0 means only trailing. .5 means 50/50. 1 means only leading. only used if draw priority is .custom.
@property (nonatomic, assign) CGFloat customUnderlineLabelDrawPriority;



@end
