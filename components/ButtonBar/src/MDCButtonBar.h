// Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.
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

#import <UIKit/UIKit.h>

/**
 The position of the button bar, typically aligned with the leading or trailing edge of the screen.

 Default: MDCBarButtonLayoutPositionNone
 */
typedef NS_OPTIONS(NSUInteger, MDCButtonBarLayoutPosition) {
  MDCButtonBarLayoutPositionNone = 0,

  /** The button bar is on the leading side of the screen. */
  MDCButtonBarLayoutPositionLeading = 1 << 0,
  MDCButtonBarLayoutPositionLeft = MDCButtonBarLayoutPositionLeading,

  /** The button bar is on the trailing side of the screen. */
  MDCButtonBarLayoutPositionTrailing = 1 << 1,
  MDCButtonBarLayoutPositionRight = MDCButtonBarLayoutPositionTrailing,
};

@protocol MDCButtonBarDelegate;

/**
 The MDCButtonBar class provides a view comprised of a horizontal list of buttons.

 This view will register KVO listeners on the provided button items for the following properties:

 - accessibilityHint
 - accessibilityIdentifier
 - accessibilityLabel
 - accessibilityValue
 - enabled
 - image
 - tag
 - tintColor
 - title

 If any of the above properties change, the MDCButtonBar will immediately reflect the change
 in the visible UIButton instance.
 */
IB_DESIGNABLE
@interface MDCButtonBar : UIView
#ifdef __IPHONE_13_4
                          <UIPointerInteractionDelegate>
#endif

#pragma mark Delegating

/**
 The delegate will be informed of events related to the layout of the button bar.
 */
@property(nonatomic, weak, nullable) id<MDCButtonBarDelegate> delegate;

#pragma mark Button Items

/**
 An array of UIBarButtonItem objects that will be used to populate the button views in this bar.

 Setting a new array of items will result in immediate recreation of the button views.

 Once set, changes made to the UIBarButtonItem properties will be observed and applied to the
 created button views.

 ### Item target/action method signature

 The complete action method signature is:

 - (void)didTap:(UIBarButtonItem *)item event:(UIEvent *)event button:(UIButton *)button;

 Each argument can be optionally-specified. E.g. @selector(didTap) is an acceptable action.

 ### iPad popover support

 MDCButtonBar is not able to associate UIBarButtonItem instances with their corresponding UIButton
 instance, so certain UIKit methods that accept a UIBarButtonItem cannot be used. This includes,
 but may not be limited to:

 - UIPopoverController::presentPopoverFromBarButtonItem:permittedArrowDirections:animated:
 - UIPrinterPickerController::presentFromBarButtonItem:animated:completionHandler:
 - UIPrintInteractionController::presentFromBarButtonItem:animated:completionHandler:
 - UIDocumentInteractionController::presentOptionsMenuFromBarButtonItem:animated:
 - UIDocumentInteractionController::presentOpenInMenuFromBarButtonItem:animated:

 Instead, you must use the related -FromRect: variant which requires a CGRect and view. You can
 use the provided UIButton by implementing the complete action method signature:

 - (void)didTap:(UIBarButtonItem *)item event:(UIEvent *)event button:(UIButton *)button;
 */
@property(nonatomic, copy, nullable) NSArray<UIBarButtonItem *> *items;

/**
 Returns the rect of the item's view within the given @c coordinateSpace.

 If the provided item is not contained in @c items, then the behavior is undefined.

 @param item The item within @c items whose rect should be computed.
 @param coordinateSpace The coordinate space the returned rect should be in relation to.
 */
- (CGRect)rectForItem:(nonnull UIBarButtonItem *)item
    inCoordinateSpace:(nonnull id<UICoordinateSpace>)coordinateSpace;

/**
 If greater than zero, will ensure that any UIButton with a title is aligned to the provided
 baseline.

 The baseline is expressed in number of points from the top edge of the receiver’s
 bounds.

 Default: 0
 */
@property(nonatomic) CGFloat buttonTitleBaseline;

/**
 If true, all button titles will be converted to uppercase.

 Changing this property to NO will update the current title string for all buttons.

 Default is YES.
 */
@property(nonatomic) BOOL uppercasesButtonTitles;

/**
 Sets the title font for the given state for all buttons.

 @param font The font that should be displayed on text buttons for the given state.
 @param state The state for which the font should be displayed.
 */
- (void)setButtonsTitleFont:(nullable UIFont *)font forState:(UIControlState)state;

/**
 Returns the font set for @c state that was set by setButtonsTitleFont:forState:.

 If no font has been set for a given state, the returned value will fall back to the value
 set for UIControlStateNormal.

 @param state The state for which the font should be returned.
 @return The font associated with the given state.
 */
- (nullable UIFont *)buttonsTitleFontForState:(UIControlState)state;

/**
 Sets the title label color for the given state for all buttons.

 @param color The color that should be used on text buttons labels for the given state.
 @param state The state for which the color should be used.
 */
- (void)setButtonsTitleColor:(nullable UIColor *)color forState:(UIControlState)state;

/**
 Returns the color set for @c state that was set by setButtonsTitleColor:forState:.

 If no value has been set for a given state, the returned value will fall back to the value
 set for UIControlStateNormal.

 @param state The state for which the color should be returned.
 @return The color associated with the given state.
 */
- (nullable UIColor *)buttonsTitleColorForState:(UIControlState)state;

/**
 The position of the button bar, usually positioned on the leading or trailing edge of the screen.

 Default: MDCBarButtonLayoutPositionNone
 */
@property(nonatomic) MDCButtonBarLayoutPosition layoutPosition;

/**
 The rippleColor that is used for all buttons in the button bar.

 If set to nil, button bar buttons use default ripple color.
 */
@property(nonatomic, strong, nullable) UIColor *rippleColor;

/**
 By setting this property to @c YES, the Ripple component will be used instead of Ink
 to display visual feedback to the user.

 @note This property will eventually be enabled by default, deprecated, and then deleted as part
 of our migration to Ripple. Learn more at
 https://github.com/material-components/material-components-ios/tree/develop/components/Ink#migration-guide-ink-to-ripple

 Defaults to NO.
 */
@property(nonatomic, assign) BOOL enableRippleBehavior;

/**
 Returns a height adhering to the Material spec for Bars and a width that is able to accommodate
 every item present in the `items` property. The provided size is ignored.
 */
- (CGSize)sizeThatFits:(CGSize)size;

/**
 A block that is invoked when the @c MDCButtonBar receives a call to @c
 traitCollectionDidChange:. The block is called after the call to the superclass.
 */
@property(nonatomic, copy, nullable) void (^traitCollectionDidChangeBlock)
    (MDCButtonBar *_Nonnull buttonBar, UITraitCollection *_Nullable previousTraitCollection);

@end

@interface MDCButtonBar (ToBeDeprecated)

/**
 The inkColor that is used for all buttons in the button bar.

 If set to nil, button bar buttons use default ink color.
 @warning This method will eventually be deprecated. Opt-in to Ripple by setting
 enableRippleBehavior to YES, and then use rippleColor instead. Learn more at
 https://github.com/material-components/material-components-ios/tree/develop/components/Ink#migration-guide-ink-to-ripple
 */
@property(nonatomic, strong, nullable) UIColor *inkColor;

@end

typedef NS_OPTIONS(NSUInteger, MDCBarButtonItemLayoutHints) {
  MDCBarButtonItemLayoutHintsNone = 0,

  /** Whether or not this bar button item is the first button in the list. */
  MDCBarButtonItemLayoutHintsIsFirstButton = 1 << 0,

  /** Whether or not this bar button item is the last button in the list. */
  MDCBarButtonItemLayoutHintsIsLastButton = 1 << 1,
};
