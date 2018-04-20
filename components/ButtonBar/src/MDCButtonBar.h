/*
 Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at

 http://www.apache.org/licenses/LICENSE-2.0

 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

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

 - enabled
 - title
 - image

 If any of the above properties change, the MDCButtonBar will immediately reflect the change
 in the visible UIButton instance.
 */
IB_DESIGNABLE
@interface MDCButtonBar : UIView

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
 If greater than zero, will ensure that any UIButton with a title is aligned to the provided
 baseline.

 The baseline is expressed in number of points from the top edge of the receiver’s
 bounds.

 Default: 0
 */
@property(nonatomic) CGFloat buttonTitleBaseline;

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
 The inkColor that is used for all buttons in the button bar.

 If set to nil, button bar buttons use default ink color.
 */
@property(nonatomic, strong, nullable) UIColor *inkColor;

/**
 Returns a height adhering to the Material spec for Bars and a width that is able to accommodate
 every item present in the `items` property. The provided size is ignored.
 */
- (CGSize)sizeThatFits:(CGSize)size;

@end

typedef NS_OPTIONS(NSUInteger, MDCBarButtonItemLayoutHints) {
  MDCBarButtonItemLayoutHintsNone = 0,

  /** Whether or not this bar button item is the first button in the list. */
  MDCBarButtonItemLayoutHintsIsFirstButton = 1 << 0,

  /** Whether or not this bar button item is the last button in the list. */
  MDCBarButtonItemLayoutHintsIsLastButton = 1 << 1,
};

/**
 The MDCButtonBarDelegate protocol defines the means by which MDCButtonBar can request that a
 view be created for a bar button item.

 An object that conforms to this protocol must forward UIControlEventTouchUpInside events to the
 button bar's didTapButton:event: method signature in order to pass the correct UIBarButtonItem
 argument to the item's target/action invocation. This method signature is made available by
 importing the MDCAppBarButtonBarBuilder.h header. The MDCAppBarButtonBarBuilder.h header should
 *only* be
 imported in files that implement objects conforming to MDCButtonBarDelegate.

 @seealso MDCBarButtonItemLayoutHints
 */
@protocol MDCButtonBarDelegate <NSObject>
@required

/** Asks the receiver to return a view that represents the given bar button item. */
- (nonnull UIView *)buttonBar:(nonnull MDCButtonBar *)buttonBar
                  viewForItem:(nonnull UIBarButtonItem *)barButtonItem
                  layoutHints:(MDCBarButtonItemLayoutHints)layoutHints;

@end
