// Copyright 2018-present the Material Components for iOS authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MDCContainedInputViewState) {
  MDCContainedInputViewStateNormal,
  MDCContainedInputViewStateFocused,
  MDCContainedInputViewStateActivated,
  MDCContainedInputViewStateErrored,
  MDCContainedInputViewStateDisabled,
};

@protocol MDCContainedInputView <NSObject>
@property (nonatomic, assign, readonly) MDCContainedInputViewState containedInputViewState;
@property (strong, nonatomic, readonly) UILabel *placeholderLabel;
@property (strong, nonatomic, readonly) UILabel *leadingUnderlineLabel;
@property (strong, nonatomic, readonly) UILabel *trailingUnderlineLabel;
@end

@protocol MDCContainedInputViewColorScheming <NSObject>
@property(strong, nonatomic, readonly, nonnull) UIColor *textColor;
@property(strong, nonatomic, readonly, nonnull) UIColor *underlineLabelColor;
@property(strong, nonatomic, readonly, nonnull) UIColor *placeholderLabelColor;
@property(strong, nonatomic, readonly, nonnull) UIColor *clearButtonTintColor;
@property(strong, nonatomic, readonly, nonnull) UIColor *errorColor;
@end

@interface MDCContainedInputViewColorScheme : NSObject <MDCContainedInputViewColorScheming>
@property(strong, nonatomic) UIColor *textColor;
@property(strong, nonatomic) UIColor *underlineLabelColor;
@property(strong, nonatomic) UIColor *placeholderLabelColor;
@property(strong, nonatomic) UIColor *clearButtonTintColor;
@property(strong, nonatomic) UIColor *errorColor;
@end

@protocol MDCContainedInputViewStyle <NSObject>
- (id<MDCContainedInputViewColorScheming>)defaultColorSchemeForState:(MDCContainedInputViewState)state;
- (void)applyStyleToContainedInputView:(id<MDCContainedInputView>)inputView
   withContainedInputViewColorScheming:(id<MDCContainedInputViewColorScheming>)colorScheme;
- (void)removeStyleFrom:(id<MDCContainedInputView>)containedInputView;
@end

@interface MDCContainerStyleBase : NSObject <MDCContainedInputViewStyle>
@end

@protocol MDCContainedInputViewStyleDensityInforming <NSObject>
@optional
- (CGFloat)floatingPlaceholderMinYWithFloatingPlaceholderHeight:(CGFloat)floatingPlaceholderHeight;
- (CGFloat)spaceBetweenFloatingPlaceholderAndTextAreaWithFloatingPlaceholderMinY:(CGFloat)floatingPlaceholderMinY
                                                       floatingPlaceholderHeight:(CGFloat)floatingPlaceholderHeight;
- (CGFloat)topRowBottomRowDividerYWithTopRowSubviewMaxY:(CGFloat)topRowSubviewMaxY
                                   topRowSubviewCenterY:(CGFloat)topRowSubviewCenterY;
@end
