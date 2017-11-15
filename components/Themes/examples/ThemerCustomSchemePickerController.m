/*
 Copyright 2017-present the Material Components for iOS authors. All Rights Reserved.

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
#import "ThemerTypicalUseSupplemental.h"

#import "MDCActivityIndicatorColorThemer.h"
#import "MDCAlertColorThemer.h"
#import "MDCButtonBarColorThemer.h"
#import "MDCButtonColorThemer.h"
#import "MDCFeatureHighlightColorThemer.h"
#import "MDCFlexibleHeaderColorThemer.h"
#import "MDCHeaderStackViewColorThemer.h"
#import "MDCNavigationBarColorThemer.h"
#import "MDCPageControlColorThemer.h"
#import "MDCProgressViewColorThemer.h"
#import "MDCSliderColorThemer.h"
#import "MDCTabBarColorThemer.h"
#import "MDCTextFieldColorThemer.h"
#import "MaterialTextFields.h"
#import "MaterialThemes.h"

@interface ThemerCustomSchemePickerController () <UITextFieldDelegate>

@property(weak, nonatomic) IBOutlet UIView *primaryColorPreView;
@property(weak, nonatomic) IBOutlet MDCTextField *primaryColorField;
@property(weak, nonatomic) IBOutlet MDCTextField *secondaryColorField;
@property(weak, nonatomic) IBOutlet UIView *secondaryColorPreView;
@property(weak, nonatomic) IBOutlet MDCRaisedButton *previewButton;

@property(nonatomic, strong) MDCBasicColorScheme *colorScheme;

@property(nonatomic, strong) MDCTextInputControllerLegacyDefault *primaryInputController;
@property(nonatomic, strong) MDCTextInputControllerLegacyDefault *secondaryInputController;

@end

@implementation ThemerCustomSchemePickerController
static NSString *s_primaryColorString;
static NSString *s_secondaryColorString;

+ (BOOL)integersFromColorHexString:(NSString *)string
                            redInt:(unsigned int *)redInt
                          greenInt:(unsigned int *)greenInt
                           blueInt:(unsigned int *)blueInt {
  if (!string || (string.length != 3 && string.length != 6)) {
    return NO;
  }

  BOOL use3Digit = string.length == 3;
  NSInteger rangeStep = 2;
  NSInteger rangeStart = 0;
  if (use3Digit) {
    rangeStep = 1;
  }

  unsigned int tempRed, tempGreen, tempBlue;
  NSScanner *scanner =
      [NSScanner scannerWithString:[string substringWithRange:NSMakeRange(rangeStart, rangeStep)]];
  rangeStart += rangeStep;

  BOOL success = YES;
  success = success && [scanner scanHexInt:&tempRed];
  scanner =
      [NSScanner scannerWithString:[string substringWithRange:NSMakeRange(rangeStart, rangeStep)]];
  rangeStart += rangeStep;
  success = success && [scanner scanHexInt:&tempGreen];
  scanner =
      [NSScanner scannerWithString:[string substringWithRange:NSMakeRange(rangeStart, rangeStep)]];
  success = success && [scanner scanHexInt:&tempBlue];
  if (!success) {
    NSLog(@"Invalid hex input: %@", string);
    return NO;
  }

  if (use3Digit) {
    tempRed *= 17;
    tempGreen *= 17;
    tempBlue *= 17;
  }

  *redInt = tempRed;
  *greenInt = tempGreen;
  *blueInt = tempBlue;

  return YES;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Try to restore in-memory state
  self.primaryColorField.delegate = self;
  self.primaryColorField.text = s_primaryColorString;
  self.secondaryColorField.delegate = self;
  self.secondaryColorField.text = s_secondaryColorString;
  [self.previewButton addTarget:self
                         action:@selector(didTapPreviewButton)
               forControlEvents:UIControlEventTouchUpInside];
  self.previewButton.enabled = NO;

  // Preview views
  self.primaryColorPreView.layer.borderWidth = 1;
  self.primaryColorPreView.layer.borderColor = [UIColor blackColor].CGColor;
  self.secondaryColorPreView.layer.borderWidth = 1;
  self.secondaryColorPreView.layer.borderColor = [UIColor blackColor].CGColor;

  // Text Fields
  self.primaryInputController =
      [[MDCTextInputControllerLegacyDefault alloc] initWithTextInput:self.primaryColorField];
  self.primaryInputController.floatingEnabled = NO;
  self.primaryInputController.helperText = @"1A2B3C";
  self.secondaryInputController =
      [[MDCTextInputControllerLegacyDefault alloc] initWithTextInput:self.secondaryColorField];
  self.secondaryInputController.floatingEnabled = NO;
  self.secondaryInputController.helperText = @"9F7";

  UITapGestureRecognizer *dismissKeyboardRecognizer =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(userTappedOutsideFields)];
  [self.view addGestureRecognizer:dismissKeyboardRecognizer];

  [self updateSchemeWithPrimaryColorString:s_primaryColorString
                      secondaryColorString:s_secondaryColorString];
}

- (void)updateSchemeWithPrimaryColorString:(NSString *)primaryString
                      secondaryColorString:(NSString *)secondaryString {
  UIColor *primaryColor = self.primaryColorPreView.backgroundColor;
  UIColor *secondaryColor = self.secondaryColorPreView.backgroundColor;

  // Primary color
  unsigned int redInt, greenInt, blueInt;

  BOOL success = [ThemerCustomSchemePickerController integersFromColorHexString:primaryString
                                                                         redInt:&redInt
                                                                       greenInt:&greenInt
                                                                        blueInt:&blueInt];
  if (!success) {
    self.previewButton.enabled = NO;
    return;
  }

  primaryColor =
      [UIColor colorWithRed:redInt / 255.0 green:greenInt / 255.0 blue:blueInt / 255.0 alpha:1.0];
  s_primaryColorString = primaryString;
  self.primaryColorPreView.backgroundColor = primaryColor;

  // Secondary color
  success = [ThemerCustomSchemePickerController integersFromColorHexString:secondaryString
                                                                    redInt:&redInt
                                                                  greenInt:&greenInt
                                                                   blueInt:&blueInt];
  if (!success) {
    self.previewButton.enabled = NO;
    return;
  }

  secondaryColor =
      [UIColor colorWithRed:redInt / 255.0 green:greenInt / 255.0 blue:blueInt / 255.0 alpha:1.0];
  s_secondaryColorString = secondaryString;
  self.secondaryColorPreView.backgroundColor = secondaryColor;

  self.colorScheme =
      [[MDCBasicColorScheme alloc] initWithPrimaryColor:primaryColor secondaryColor:secondaryColor];
  [self applyColorScheme:self.colorScheme];
  self.previewButton.enabled = YES;
}

- (void)applyColorScheme:(NSObject<MDCColorScheme> *)colorScheme {
  // Apply color scheme to material design components using component themers.
  [MDCActivityIndicatorColorThemer applyColorScheme:colorScheme
                                toActivityIndicator:[MDCActivityIndicator appearance]];
  [MDCAlertColorThemer applyColorScheme:colorScheme];
  [MDCButtonBarColorThemer applyColorScheme:colorScheme toButtonBar:[MDCButtonBar appearance]];
  [MDCButtonColorThemer applyColorScheme:colorScheme toButton:self.previewButton];
  [MDCButtonColorThemer applyColorScheme:colorScheme toButton:[MDCButton appearance]];
  [MDCFeatureHighlightColorThemer applyColorScheme:colorScheme
                            toFeatureHighlightView:[MDCFeatureHighlightView appearance]];
  [MDCFlexibleHeaderColorThemer applyColorScheme:colorScheme
                            toFlexibleHeaderView:[MDCFlexibleHeaderView appearance]];
  [MDCHeaderStackViewColorThemer applyColorScheme:colorScheme
                                toHeaderStackView:[MDCHeaderStackView appearance]];
  [MDCNavigationBarColorThemer applyColorScheme:colorScheme
                                toNavigationBar:[MDCNavigationBar appearance]];
  [MDCPageControlColorThemer applyColorScheme:colorScheme
                                toPageControl:[MDCPageControl appearance]];
  [MDCProgressViewColorThemer applyColorScheme:colorScheme
                                toProgressView:[MDCProgressView appearance]];
  [MDCSliderColorThemer applyColorScheme:colorScheme toSlider:[MDCSlider appearance]];
  [MDCTabBarColorThemer applyColorScheme:colorScheme toTabBar:[MDCTabBar appearance]];
  [MDCTextFieldColorThemer applyColorScheme:colorScheme
           toAllTextInputControllersOfClass:[MDCTextInputControllerDefault class]];
  [MDCTextFieldColorThemer applyColorScheme:colorScheme
           toAllTextInputControllersOfClass:[MDCTextInputControllerLegacyDefault class]];
  [MDCTextFieldColorThemer applyColorScheme:colorScheme
           toAllTextInputControllersOfClass:[MDCTextInputControllerFilled class]];
  [MDCTextFieldColorThemer applyColorScheme:colorScheme
           toAllTextInputControllersOfClass:[MDCTextInputControllerOutlined class]];
  [MDCTextFieldColorThemer applyColorScheme:colorScheme
           toAllTextInputControllersOfClass:[MDCTextInputControllerOutlinedTextArea class]];

  // Apply color scheme to UIKit components.
  [UISlider appearance].tintColor = colorScheme.primaryColor;
  [UISwitch appearance].onTintColor = colorScheme.primaryColor;

  // Send notification that color scheme has changed so existing components can update if necessary.
  NSDictionary *userInfo = @{ @"colorScheme" : colorScheme };
  [[NSNotificationCenter defaultCenter] postNotificationName:@"ColorThemeChangeNotification"
                                                      object:self
                                                    userInfo:userInfo];
}

#pragma mark - Actions

- (void)userTappedOutsideFields {
  [self.primaryColorField resignFirstResponder];
  [self.secondaryColorField resignFirstResponder];
}

- (void)didTapPreviewButton {
  ThemerTypicalUseViewController *themerController =
      [[ThemerTypicalUseViewController alloc] initWithColorScheme:self.colorScheme];
  [self.navigationController pushViewController:themerController animated:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  NSString *finishedString =
      [textField.text stringByReplacingCharactersInRange:range withString:string];
  NSString *primaryColorString = self.primaryColorField.text;
  NSString *secondaryColorString = self.secondaryColorField.text;

  if (textField == self.primaryColorField) {
    primaryColorString = finishedString;
  } else if (textField == self.secondaryColorField) {
    secondaryColorString = finishedString;
  }

  [self updateSchemeWithPrimaryColorString:primaryColorString
                      secondaryColorString:secondaryColorString];
  return YES;
}

#pragma mark - CatalogByConvention

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Themes", @"Custom Colors" ];
}

+ (NSString *)catalogStoryboardName {
  return @"ThemerCustomSchemePicker";
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

@end
