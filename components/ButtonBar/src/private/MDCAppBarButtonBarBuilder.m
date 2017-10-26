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

#import "MDCAppBarButtonBarBuilder.h"

#import "MDCButtonBar+Private.h"
#import "MDFInternationalization.h"
#import "MaterialButtons.h"

#import <objc/runtime.h>

static const CGFloat kMinimumItemWidth = 36.f;

// The padding around button contents.
static const CGFloat kButtonPaddingHorizontal = 12.f;

// Additional insets for the left-most or right-most items, primarily for image buttons.
static const CGFloat kEdgeButtonAdditionalMarginPhone = 4.f;
static const CGFloat kEdgeButtonAdditionalMarginPad = 12.f;

// The default MDCButton's alpha for display state is 0.1f which in the context of bar buttons
// makes it practically invisible. Setting button to a higher opacity is closer to what the
// button should look like when it is disabled.
static const CGFloat kDisabledButtonAlpha = 0.45f;

// Content insets for text-only buttons.
static const UIEdgeInsets kTextOnlyButtonInset = {0, 24.f, 0, 24.f};

// Content insets for image-only buttons.
static const UIEdgeInsets kImageOnlyButtonInset = {0, 12.0f, 0, 12.0f};

// Indiana Jones style placeholder view for UINavigationBar. Ownership of UIBarButtonItem.customView
// and UINavigationItem.titleView are normally transferred to UINavigationController but we plan to
// steal them away. In order to avoid crashing during KVO updates, we steal the view away and
// replace it with a sandbag view.
@interface MDCButtonBarSandbagView : UIView
@end

@interface MDCButtonBarButton : MDCFlatButton

// Content padding for the button.
@property(nonatomic) UIEdgeInsets contentPadding;

@end

@interface UIBarButtonItem (MDCHeaderInternal)

// Internal version of the standard -customView property. When an item is pushed onto a
// UINavigationController stack, any -customView object is moved over to this property. This
// prevents UINavigationController from adding the customView to its own view hierarchy.
@property(nonatomic, strong, setter=mdc_setCustomView:) UIView *mdc_customView;

@end

@implementation MDCAppBarButtonBarBuilder

#pragma mark - MDCBarButtonItemBuilding

- (UIView *)buttonBar:(MDCButtonBar *)buttonBar
          viewForItem:(UIBarButtonItem *)buttonItem
          layoutHints:(MDCBarButtonItemLayoutHints)layoutHints {
  if (buttonItem == nil) {
    return nil;
  }

  // Transfer custom view ownership if necessary.
  [self transferCustomViewOwnershipForBarButtonItem:buttonItem];

  // Take the real custom view if it exists instead of sandbag view.
  UIView *customView =
      buttonItem.mdc_customView ? buttonItem.mdc_customView : buttonItem.customView;
  if (customView) {
    return customView;
  }

// NOTE: This assertion does not occur in release builds because it is accessing a private api.
#if DEBUG
  NSAssert(![[buttonItem valueForKey:@"isSystemItem"] boolValue],
           @"Instances of %@ must not be initialized with %@ when working with %@."
           @" This is because we cannot extract the system item type from the item.",
           NSStringFromClass([buttonItem class]),
           NSStringFromSelector(@selector(initWithBarButtonSystemItem:target:action:)),
           NSStringFromClass([MDCButtonBar class]));
#endif

  MDCButtonBarButton *button = [[MDCButtonBarButton alloc] init];
  [button setBackgroundColor:[UIColor clearColor] forState:UIControlStateNormal];
  button.disabledAlpha = kDisabledButtonAlpha;

  button.exclusiveTouch = YES;

  [MDCAppBarButtonBarBuilder configureButton:button fromButtonItem:buttonItem];

  [button setTitleColor:self.buttonTitleColor forState:UIControlStateNormal];
  [button setUnderlyingColorHint:self.buttonUnderlyingColor];

  [self updateButton:button withItem:buttonItem barMetrics:UIBarMetricsDefault];

  // Contrary to intuition, UIKit provides the UIBarButtonItem as the action's first argument when
  // bar buttons are tapped, NOT the button itself. Simply adding the item's target/action to the
  // button does not allow us to pass the expected argument to the target.
  //
  // MDCButtonBar provides didTapButton:event: to which we can pass button events
  // so that the correct argument is ultimately passed along.
  [button addTarget:buttonBar
                action:@selector(didTapButton:event:)
      forControlEvents:UIControlEventTouchUpInside];

  UIEdgeInsets contentInsets = [MDCAppBarButtonBarBuilder
      contentInsetsForButton:button
                 layoutHints:layoutHints
             layoutDirection:[buttonBar mdf_effectiveUserInterfaceLayoutDirection]
                                userInterfaceIdiom:[self usePadInsetsForButtonBar:buttonBar] ?
                                UIUserInterfaceIdiomPad : UIUserInterfaceIdiomPhone];

  // Only add padding to the first item of the button bar.
  if (layoutHints == MDCBarButtonItemLayoutHintsIsFirstButton) {
    switch (buttonBar.layoutPosition) {
      case MDCButtonBarLayoutPositionLeading:
        button.contentPadding =
            UIEdgeInsetsMake(0, contentInsets.left - kButtonPaddingHorizontal, 0, 0);
        break;
      case MDCButtonBarLayoutPositionTrailing:
        button.contentPadding =
            UIEdgeInsetsMake(0, 0, 0, contentInsets.right - kButtonPaddingHorizontal);
      default:
        break;
    }
  }

  button.contentEdgeInsets = contentInsets;
  button.enabled = buttonItem.enabled;
  button.accessibilityLabel = buttonItem.accessibilityLabel;
  button.accessibilityHint = buttonItem.accessibilityHint;
  button.accessibilityValue = buttonItem.accessibilityValue;
  button.accessibilityIdentifier = buttonItem.accessibilityIdentifier;

  return button;
}

#pragma mark - Private

// Used to determine whether or not to apply insets relevant for iPad or use smaller iPhone size
// Because only widths are affected, we use horizontal size class
- (BOOL)usePadInsetsForButtonBar:(MDCButtonBar *)buttonBar {
  const BOOL isPad = [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
  if (isPad && buttonBar.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) {
    return YES;
  }
  return NO;
}

+ (UIEdgeInsets)contentInsetsForButton:(MDCButton *)button
                           layoutHints:(MDCBarButtonItemLayoutHints)layoutHints
                       layoutDirection:(UIUserInterfaceLayoutDirection)layoutDirection
                    userInterfaceIdiom:(UIUserInterfaceIdiom)userInterfaceIdiom {
  UIEdgeInsets contentInsets = UIEdgeInsetsZero;

  UIEdgeInsets (^addInsets)(UIEdgeInsets, UIEdgeInsets) = ^(UIEdgeInsets i1, UIEdgeInsets i2) {
    UIEdgeInsets sum = i1;
    sum.left += i2.left;
    sum.top += i2.top;
    sum.right += i2.right;
    sum.bottom += i2.bottom;
    return sum;
  };

  BOOL isPad = userInterfaceIdiom == UIUserInterfaceIdiomPad;

  if ([[button currentTitle] length]) {  // Text-only buttons.
    contentInsets = addInsets(contentInsets, kTextOnlyButtonInset);

  } else if ([button currentImage]) {  // Image-only buttons.
    contentInsets = addInsets(contentInsets, kImageOnlyButtonInset);

    if ((layoutHints & MDCBarButtonItemLayoutHintsIsFirstButton) ==
        MDCBarButtonItemLayoutHintsIsFirstButton) {
      CGFloat additionalInset =
          (isPad ? kEdgeButtonAdditionalMarginPad : kEdgeButtonAdditionalMarginPhone);

      if (layoutDirection == UIUserInterfaceLayoutDirectionLeftToRight) {
        contentInsets.left += additionalInset;
      } else {
        contentInsets.right += additionalInset;
      }
    }

    if ((layoutHints & MDCBarButtonItemLayoutHintsIsLastButton) ==
        MDCBarButtonItemLayoutHintsIsLastButton) {
      CGFloat additionalInset =
          (isPad ? kEdgeButtonAdditionalMarginPad : kEdgeButtonAdditionalMarginPhone);

      if (layoutDirection == UIUserInterfaceLayoutDirectionLeftToRight) {
        contentInsets.right += additionalInset;
      } else {
        contentInsets.left += additionalInset;
      }
    }

  } else {
    NSAssert(0, @"No button title or image");
  }

  return contentInsets;
}

+ (void)configureButton:(MDCButton *)destinationButton
         fromButtonItem:(UIBarButtonItem *)sourceButtonItem {
  if (sourceButtonItem == nil || destinationButton == nil) {
    return;
  }

  if (sourceButtonItem.title != nil) {
    [destinationButton setTitle:sourceButtonItem.title forState:UIControlStateNormal];
  }
  if (sourceButtonItem.image != nil) {
    [destinationButton setImage:sourceButtonItem.image forState:UIControlStateNormal];
  }
  if (sourceButtonItem.tintColor != nil) {
    destinationButton.tintColor = sourceButtonItem.tintColor;
  }

  if (sourceButtonItem.title) {
    destinationButton.inkStyle = MDCInkStyleBounded;
  } else {
    destinationButton.inkStyle = MDCInkStyleUnbounded;
  }

  destinationButton.tag = sourceButtonItem.tag;
}

- (void)updateButton:(UIButton *)button
            withItem:(UIBarButtonItem *)item
          barMetrics:(UIBarMetrics)barMetrics {
  [self updateButton:button withItem:item forState:UIControlStateNormal barMetrics:barMetrics];
  [self updateButton:button withItem:item forState:UIControlStateHighlighted barMetrics:barMetrics];
  [self updateButton:button withItem:item forState:UIControlStateDisabled barMetrics:barMetrics];
}

- (void)updateButton:(UIButton *)button
            withItem:(UIBarButtonItem *)item
            forState:(UIControlState)state
          barMetrics:(UIBarMetrics)barMetrics {
  NSString *title = item.title ? item.title : @"";
  if ([UIButton instancesRespondToSelector:@selector(setAttributedTitle:forState:)]) {
    NSMutableDictionary<NSString *, id> *attributes = [NSMutableDictionary dictionary];

    // UIBarButtonItem's appearance proxy values don't appear to come "for free" like they do with
    // typical UIView instances, so we're attempting to recreate the behavior here.
    NSArray *appearanceProxies = @[ [item.class appearance] ];
    for (UIBarButtonItem *appearance in appearanceProxies) {
      [attributes addEntriesFromDictionary:[appearance titleTextAttributesForState:state]];
    }
    [attributes addEntriesFromDictionary:[item titleTextAttributesForState:state]];
    if ([attributes count] > 0) {
      [button
          setAttributedTitle:[[NSAttributedString alloc] initWithString:title attributes:attributes]
                    forState:state];
    }
  } else {
    [button setTitle:title forState:state];
  }

  UIImage *backgroundImage = [item backgroundImageForState:state barMetrics:barMetrics];
  if (backgroundImage) {
    [button setBackgroundImage:backgroundImage forState:state];
  }
}

- (void)transferCustomViewOwnershipForBarButtonItem:(UIBarButtonItem *)barButtonItem {
  UIView *customView = barButtonItem.customView;
  if (customView && ![customView isKindOfClass:[MDCButtonBarSandbagView class]]) {
    // Transfer ownership of any UIBarButtonItem.customView to the internal property
    // so that UINavigationController won't steal the view from us.
    barButtonItem.mdc_customView = customView;
    barButtonItem.customView = [[MDCButtonBarSandbagView alloc] init];
  }
}

@end

@implementation MDCButtonBarSandbagView
@end

@implementation MDCButtonBarButton

- (CGSize)sizeThatFits:(CGSize)size {
  CGSize fitSize = [super sizeThatFits:size];
  fitSize.height =
      self.contentPadding.top + MAX(kMinimumItemWidth, fitSize.height) + self.contentPadding.bottom;
  fitSize.width =
      self.contentPadding.left + MAX(kMinimumItemWidth, fitSize.width) + self.contentPadding.right;

  return fitSize;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  // TODO(featherless): Remove this conditional and always set the max ripple radius once
  // https://github.com/material-components/material-components-ios/issues/329 lands.
  if (self.inkStyle == MDCInkStyleUnbounded) {
    self.inkMaxRippleRadius = MIN(self.bounds.size.width, self.bounds.size.height) / 2;
  } else {
    self.inkMaxRippleRadius = 0;
  }
}

@end

@implementation UIBarButtonItem (MDCHeaderInternal)

@dynamic mdc_customView;

- (UIView *)mdc_customView {
  return objc_getAssociatedObject(self, _cmd);
}

- (void)mdc_setCustomView:(UIView *)customView {
  objc_setAssociatedObject(self, @selector(mdc_customView), customView,
                           OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
