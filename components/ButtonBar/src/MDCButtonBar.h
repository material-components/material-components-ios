/*
 Copyright 2016-present Google Inc. All Rights Reserved.

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
@interface MDCButtonBar : UIView

#pragma mark Button Items

/**
 The UIBarButtonItem objects that will be used to populate the button views in this bar.

 Setting a new array of button items will immediately recreate all visible buttons by
 calling @c reloadButtonsViews.

 Once set, the receiver will watch changes to the UIBarButtonItem properties and apply
 them to the created button views.

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
@property(nonatomic, copy) NSArray *buttonItems;

/** The delegate creates button views from UIBarButtonItem instances. */
@property(nonatomic, weak) id<MDCButtonBarDelegate> delegate;

/** Tells the receiver to rebuild its button views. */
- (void)reloadButtonViews;

#pragma mark Configuring Layout

/**
 The direction in which the button views should be laid out.

 Default: UIUserInterfaceLayoutDirectionLeftToRight
 */
@property(nonatomic) UIUserInterfaceLayoutDirection layoutDirection;

/**
 If greater than zero, will ensure that any UIButton with a title is aligned to the provided
 baseline.

 The baseline is expressed in number of points from the top edge of the receiver’s
 bounds.

 Default: 0
 */
@property(nonatomic) CGFloat buttonTitleBaseline;

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
 importing the MDCButtonBar+Builder.h header. The MDCButtonBar+Builder.h header should *only* be
 imported in files that implement objects conforming to MDCButtonBarDelegate.

 @seealso MDCBarButtonItemLayoutHints
 */
@protocol MDCButtonBarDelegate <NSObject>
@required

/** Asks the receiver to return a view that represents the given bar button item. */
- (UIView *)buttonBar:(MDCButtonBar *)buttonBar
          viewForItem:(UIBarButtonItem *)barButtonItem
          layoutHints:(MDCBarButtonItemLayoutHints)layoutHints;

@end

/**
 Target selector for buttons created from UIBarButtonItems.

 See the MDCButtonBarDelegate documentation for more details on how this method
 should be used.
 */
@interface MDCButtonBar (Builder)

/**
 Finds the corresponding UIBarButtonItem and calls its target/action with the item as the first
 parameter.
 */
- (void)didTapButton:(UIButton *)button event:(UIEvent *)event;

@end
