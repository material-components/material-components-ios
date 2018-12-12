#import <UIKit/UIKit.h>

#import "SimpleTextFieldLayoutUtils.h"

#import "MaterialColorScheme.h"



/**
 A UITextField that attempts to do the following:
 
 - Earnestly interpret and actualize the Material guidelines for text fields, which can be found here:
 https://material.io/design/components/text-fields.html#outlined-text-field

 - Feel intuitive for someone used to the conventions of iOS development and UIKit controls.
 
 - Enable easy set up and reliable and predictable behavior.
 
 */
@interface SimpleTextField : UITextField

/**
  property acts as a complement of @c UIControl's state system
 as well as an interpretation of the state soutlined in the Material guidelines for Text Fields,
 which can be found here:
 https://material.io/design/components/text-fields.html#outlined-text-field
 */
@property (nonatomic, assign) TextFieldStyle textFieldStyle;

/**
 This class-specific @c TextFieldState property acts as a complement of @c UIControl's state system
 as well as an interpretation of the state soutlined in the Material guidelines for Text Fields,
 which can be found here:
 https://material.io/design/components/text-fields.html#outlined-text-field
 */
@property (nonatomic, assign, readonly) TextFieldState textFieldState;

@property (nonatomic, assign) BOOL canPlaceholderFloat;

@property (strong, nonatomic, readonly, nonnull) UILabel *leadingUnderlineLabel;
@property (strong, nonatomic, readonly, nonnull) UILabel *trailingUnderlineLabel;
@property (nonatomic, assign) UnderlineLabelDrawPriority underlineLabelDrawPriority;

@property (strong, nonatomic, nullable) UIView *leadingView;
@property (strong, nonatomic, nullable) UIView *trailingView;
@property (nonatomic, assign) UITextFieldViewMode leadingViewMode;
@property (nonatomic, assign) UITextFieldViewMode trailingViewMode;



/**
 This property toggles a state (similar to @c isHighlighted, @c isEnabled, @c isSelected, etc.) that
 is part of a general interpretation of the states outlined in the Material guidelines for Text
 Fields, which can be found here:
 https://material.io/design/components/text-fields.html#outlined-text-field
 */
@property (nonatomic, assign) BOOL isErrored;

/**
 This property toggles a state (similar to @c isHighlighted, @c isEnabled, @c isSelected, etc.) that
 is part of a general interpretation of the states outlined in the Material guidelines for Text
 Fields, which can be found here:
 https://material.io/design/components/text-fields.html#outlined-text-field
 */
@property (nonatomic, assign) BOOL isActivated;

/**
 When @c underlineLabelDrawPriority is set to @c .custom the value of this property helps determine
 what percentage of the available width each underline label gets. It can be thought of as a
 divider. A value of @c 0 would result in the trailing underline label getting all the available
 width. A value of @c 1 would result in the leading underline label getting all the available width.
 A value of @c .5 would result in each underline label getting 50% of the available width.
 */
@property (nonatomic, assign) CGFloat customUnderlineLabelDrawPriority;


- (void)setColorScheme:(MDCSemanticColorScheme *)colorScheme
              forState:(TextFieldState)textFieldState;

- (MDCSemanticColorScheme *)colorSchemeForState:(TextFieldState)textFieldState;

- (void)applyColorScheme:(MDCSemanticColorScheme *)colorScheme;

+ (MDCSemanticColorScheme *)defaultColorSchemeForState:(TextFieldState)textFieldState;

@end
