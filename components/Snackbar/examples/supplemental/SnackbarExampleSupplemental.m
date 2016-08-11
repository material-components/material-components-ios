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

#import "SnackbarExampleSupplemental.h"

@implementation SnackbarExample

- (void)setupExampleViews {
  self.view.backgroundColor = [UIColor whiteColor];

  // Set up the button.
  self.snackbarButton = [[MDCRaisedButton alloc] init];
  [self.snackbarButton setTitle:@"Present Snackbar" forState:UIControlStateNormal];
  [self.snackbarButton addTarget:self
                          action:@selector(handleShowSnackbarButtonTapped:)
                forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:self.snackbarButton];

  // Position the button.
  CGRect snackFrame = CGRectMake(0, 100.0f, 200.0f, 40.0f);
  snackFrame.origin.x = CGRectGetMidX(self.view.bounds) - CGRectGetWidth(snackFrame) / 2.0f;
  snackFrame = CGRectIntegral(snackFrame);
  self.snackbarButton.frame = snackFrame;
  self.snackbarButton.autoresizingMask =
      (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);
}

@end

@implementation SnackbarActionExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Snackbar", @"Snackbar Multi-line Action Message" ];
}

@end

@implementation SnackbarBoldExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Snackbar", @"Snackbar Bold Message" ];
}

@end

@implementation SnackbarSimpleExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Snackbar", @"Snackbar" ];
}

+ (NSString *)catalogDescription {
  return @"Snackbars provide brief feedback about an operation through a message at the bottom of"
          " the screen.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

@end

@implementation SnackbarOverlayViewExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Snackbar", @"Snackbar Overlay View" ];
}

@end

@implementation SnackbarSuspensionExample (Layout)

- (void)setupExampleViews {
  self.view.backgroundColor = [UIColor whiteColor];

  self.groupAButton = [[MDCRaisedButton alloc] init];
  [self.groupAButton setTitle:@"Show Category A Message" forState:UIControlStateNormal];
  [self.groupAButton addTarget:self
                        action:@selector(handleShowTapped:)
              forControlEvents:UIControlEventTouchUpInside];
  self.groupAButton.autoresizingMask =
      (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);
  [self.view addSubview:self.groupAButton];

  self.groupBButton = [[MDCRaisedButton alloc] init];
  [self.groupBButton setTitle:@"Show Category B Message" forState:UIControlStateNormal];
  [self.groupBButton addTarget:self
                        action:@selector(handleShowTapped:)
              forControlEvents:UIControlEventTouchUpInside];
  self.groupBButton.autoresizingMask =
      (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);
  [self.view addSubview:self.groupBButton];

  self.allMessagesButton = [[MDCRaisedButton alloc] init];
  [self.allMessagesButton setTitle:@"Show Standard Message" forState:UIControlStateNormal];
  [self.allMessagesButton addTarget:self
                             action:@selector(handleShowTapped:)
                   forControlEvents:UIControlEventTouchUpInside];
  self.allMessagesButton.autoresizingMask =
      (UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin);
  [self.view addSubview:self.allMessagesButton];

  self.groupASwitch = [[MDCSwitch alloc] init];
  self.groupASwitch.on = NO;
  [self.groupASwitch addTarget:self
                        action:@selector(handleSuspendStateChanged:)
              forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:self.groupASwitch];

  self.groupBSwitch = [[MDCSwitch alloc] init];
  self.groupBSwitch.on = NO;
  [self.groupBSwitch addTarget:self
                        action:@selector(handleSuspendStateChanged:)
              forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:self.groupBSwitch];

  self.allMessagesSwitch = [[MDCSwitch alloc] init];
  self.allMessagesSwitch.on = NO;
  [self.allMessagesSwitch addTarget:self
                             action:@selector(handleSuspendStateChanged:)
                   forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:self.allMessagesSwitch];

  self.groupALabel = [[UILabel alloc] init];
  self.groupALabel.text = @"Suspend Catagory A Messages";
  self.groupALabel.font = [MDCTypography captionFont];
  self.groupALabel.alpha = [MDCTypography captionFontOpacity];
  [self.view addSubview:self.groupALabel];

  self.groupBLabel = [[UILabel alloc] init];
  self.groupBLabel.text = @"Suspend Catagory B Messages";
  self.groupBLabel.font = [MDCTypography captionFont];
  self.groupBLabel.alpha = [MDCTypography captionFontOpacity];
  [self.view addSubview:self.groupBLabel];

  self.allLabel = [[UILabel alloc] init];
  self.allLabel.text = @"Suspend All Messages";
  self.allLabel.font = [MDCTypography captionFont];
  self.allLabel.alpha = [MDCTypography captionFontOpacity];
  [self.view addSubview:self.allLabel];
}

- (void)viewWillLayoutSubviews {
  CGFloat labelWidth = 200.0f;
  CGFloat labelHeight = 27.0f;
  CGFloat labelXOffset = 48.0f;

  CGFloat buttonWidth = 250.0f;
  CGFloat buttonHeight = 40.0f;
  CGFloat buttonYOffset = 60.0f;

  CGFloat switchWidth = 100.0f;
  CGFloat switchYOffset = 40.0f;
  if (self.view.frame.size.height > self.view.frame.size.width) {
    buttonYOffset = 80.f;
    switchYOffset = 50.0f;
  }
  CGFloat spacing = self.view.frame.size.height / 3.5f;

  CGRect catAButtonFrame = CGRectMake(0, spacing - buttonYOffset, buttonWidth, buttonHeight);
  catAButtonFrame.origin.x =
      CGRectGetMidX(self.view.bounds) - CGRectGetWidth(catAButtonFrame) / 2.0f;
  catAButtonFrame = CGRectIntegral(catAButtonFrame);
  self.groupAButton.frame = catAButtonFrame;

  CGRect catBButtonFrame = CGRectMake(0, 2.f * spacing - buttonYOffset, buttonWidth, buttonHeight);
  catBButtonFrame.origin.x =
      CGRectGetMidX(self.view.bounds) - CGRectGetWidth(catBButtonFrame) / 2.0f;
  catBButtonFrame = CGRectIntegral(catBButtonFrame);
  self.groupBButton.frame = catBButtonFrame;

  CGRect allMessagesButtonFrame =
      CGRectMake(0, 3.f * spacing - buttonYOffset, buttonWidth, buttonHeight);
  allMessagesButtonFrame.origin.x =
      CGRectGetMidX(self.view.bounds) - CGRectGetWidth(allMessagesButtonFrame) / 2.0f;
  allMessagesButtonFrame = CGRectIntegral(allMessagesButtonFrame);
  self.allMessagesButton.frame = allMessagesButtonFrame;

  self.groupASwitch.frame =
      CGRectMake(self.groupAButton.frame.origin.x, self.groupAButton.frame.origin.y + switchYOffset,
                 switchWidth, labelHeight);
  self.groupBSwitch.frame =
      CGRectMake(self.groupBButton.frame.origin.x, self.groupBButton.frame.origin.y + switchYOffset,
                 switchWidth, labelHeight);
  self.allMessagesSwitch.frame =
      CGRectMake(self.allMessagesButton.frame.origin.x,
                 self.allMessagesButton.frame.origin.y + switchYOffset, switchWidth, labelHeight);
  self.groupALabel.frame =
      CGRectMake(self.groupAButton.frame.origin.x + labelXOffset,
                 self.groupAButton.frame.origin.y + switchYOffset, labelWidth, labelHeight);
  self.groupBLabel.frame =
      CGRectMake(self.groupBButton.frame.origin.x + labelXOffset,
                 self.groupBButton.frame.origin.y + switchYOffset, labelWidth, labelHeight);
  self.allLabel.frame =
      CGRectMake(self.allMessagesButton.frame.origin.x + labelXOffset,
                 self.allMessagesButton.frame.origin.y + switchYOffset, labelWidth, labelHeight);
}

@end

@implementation SnackbarSuspensionExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Snackbar", @"Snackbar Suspension" ];
}

@end
