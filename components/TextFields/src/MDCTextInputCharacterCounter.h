#import <UIKit/UIKit.h>

@protocol MDCTextInput;

/** Character counter protocol for a text field view conforming to the MDCTextInput protocol. */
@protocol MDCTextInputCharacterCounter <NSObject>

/**
 Returns the count of characters for the text field.

 @param textField the text field.

 @return count of characters.
 */
- (NSUInteger)characterCountForTextField:(UIView<MDCTextInput> *)textField;

@end
