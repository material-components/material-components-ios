//
//  MDCButtonBarButton.h
//  MaterialComponents
//
//  Created by Ian Gordon on 1/17/18.
//

#import "MaterialButtons.h"

@interface MDCButtonBarButton : MDCFlatButton

// Content padding for the button.
@property(nonatomic) UIEdgeInsets contentPadding UI_APPEARANCE_SELECTOR;

/**
 The font used by the button's @c title.

 If left unset or reset to nil for a given state, then a default font is used.

 @param font The font.
 @param state The state.
 */
- (void)setTitleFont:(nullable UIFont *)font forState:(UIControlState)state
    UI_APPEARANCE_SELECTOR;

@end
