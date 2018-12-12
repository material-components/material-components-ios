//
//  SimpleTextFieldLayout.h
//  ComponentsProject
//
//  Created by Andrew Overton on 12/6/18.
//  Copyright © 2018 andrewoverton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "SimpleTextFieldLayoutUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface SimpleTextFieldLayout : NSObject

@property (nonatomic, assign) BOOL leftViewHidden;
@property (nonatomic, assign) BOOL rightViewHidden;
@property (nonatomic, assign) BOOL clearButtonHidden;
@property (nonatomic, assign) BOOL placeholderHidden;

@property (nonatomic, assign) CGRect placeholderFrameFloating;
@property (nonatomic, assign) CGRect placeholderFrameNormal;
@property (nonatomic, assign) CGRect textAreaFrame;
@property (nonatomic, assign) CGRect clearButtonFrame;
@property (nonatomic, assign) CGRect leftViewFrame;
@property (nonatomic, assign) CGRect rightViewFrame;
@property (nonatomic, assign) CGRect leftUnderlineLabelFrame;
@property (nonatomic, assign) CGRect rightUnderlineLabelFrame;

@property (nonatomic, readonly) CGFloat calculatedHeight;
@property (nonatomic, assign) CGFloat topRowBottomRowDividerY;

- (instancetype)initWithTextFieldBounds:(CGRect)textFieldBounds
                         textFieldStyle:(TextFieldStyle)textFieldStyle
                                   text:(NSString *)text
                            placeholder:(NSString *)placeholder
                                   font:(UIFont *)font
                floatingPlaceholderFont:(UIFont *)floatingPlaceholderFont
                    canPlaceholderFloat:(BOOL)canPlaceholderFloat
                               leftView:(UIView *)leftView
                           leftViewMode:(UITextFieldViewMode)leftViewMode
                              rightView:(UIView *)rightView
                          rightViewMode:(UITextFieldViewMode)rightViewMode
                            clearButton:(UIButton *)clearButton
                        clearButtonMode:(UITextFieldViewMode)clearButtonMode
                     leftUnderlineLabel:(UILabel *)leftUnderlineLabel
                    rightUnderlineLabel:(UILabel *)rightUnderlineLabel
             underlineLabelDrawPriority:(UnderlineLabelDrawPriority)underlineLabelDrawPriority
       customUnderlineLabelDrawPriority:(CGFloat)customUnderlineLabelDrawPriority
                                  isRTL:(BOOL)isRTL
                              isEditing:(BOOL)isEditing;


@end

NS_ASSUME_NONNULL_END
