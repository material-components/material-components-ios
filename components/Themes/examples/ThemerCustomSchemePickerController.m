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
#import "MaterialThemes.h"

@interface ThemerCustomSchemePickerController () <UITextFieldDelegate>

@property(weak, nonatomic) IBOutlet UIView *primaryColorPreView;
@property(weak, nonatomic) IBOutlet UITextField *primaryColorField;
@property(weak, nonatomic) IBOutlet UITextField *secondaryColorField;
@property(weak, nonatomic) IBOutlet UIView *secondaryColorPreView;
@property(weak, nonatomic) IBOutlet MDCRaisedButton *previewButton;

@property(nonatomic, strong) MDCBasicColorScheme *colorScheme;

@end

@implementation ThemerCustomSchemePickerController
static NSString *s_primaryColorString;
static NSString *s_secondaryColorString;

- (void)viewDidLoad {
  [super viewDidLoad];
  self.primaryColorField.delegate = self;
  self.primaryColorField.text = s_primaryColorString;
  self.secondaryColorField.delegate = self;
  self.secondaryColorField.text = s_secondaryColorString;
  [self.previewButton addTarget:self
                         action:@selector(didTapPreviewButton)
               forControlEvents:UIControlEventTouchUpInside];
  self.previewButton.enabled = NO;

  self.primaryColorPreView.layer.borderWidth = 1;
  self.primaryColorPreView.layer.borderColor = [UIColor blackColor].CGColor;
  self.secondaryColorPreView.layer.borderWidth = 1;
  self.secondaryColorPreView.layer.borderColor = [UIColor blackColor].CGColor;

  [self updateSchemeWithPrimaryColorString:s_primaryColorString
                      secondaryColorString:s_secondaryColorString];
}

- (void)didTapPreviewButton {
  ThemerTypicalUseViewController *themerController =
      [[ThemerTypicalUseViewController alloc] initWithColorScheme:self.colorScheme];
  [self.navigationController pushViewController:themerController animated:YES];
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
  [MDCTextFieldColorThemer applyColorSchemeToAllTextInputControllerDefault:colorScheme];

  // Apply color scheme to UIKit components.
  [UISlider appearance].tintColor = colorScheme.primaryColor;
  [UISwitch appearance].tintColor = colorScheme.primaryColor;

  // Send notification that color scheme has changed so existing components can update if necessary.
  NSDictionary *userInfo = @{ @"colorScheme" : colorScheme };
  [[NSNotificationCenter defaultCenter] postNotificationName:@"ColorThemeChangeNotification"
                                                      object:self
                                                    userInfo:userInfo];
}

- (void)updateSchemeWithPrimaryColorString:(NSString *)primaryString
                      secondaryColorString:(NSString *)secondaryString {
  UIColor *primaryColor = self.primaryColorPreView.backgroundColor;
  UIColor *secondaryColor = self.secondaryColorPreView.backgroundColor;

  // Primary color
  if (primaryString.length != 6 && primaryString.length != 3) {
    self.previewButton.enabled = NO;
    return;
  }

  BOOL use3Digit = primaryString.length == 3;
  NSInteger rangeStep = 2;
  NSInteger rangeStart = 0;
  if (use3Digit) {
    rangeStep = 1;
  }
  NSScanner *scanner = [NSScanner
      scannerWithString:[primaryString substringWithRange:NSMakeRange(rangeStart, rangeStep)]];
  rangeStart += rangeStep;
  unsigned int redInt, greenInt, blueInt;
  BOOL success = YES;
  success = success && [scanner scanHexInt:&redInt];
  scanner = [NSScanner
      scannerWithString:[primaryString substringWithRange:NSMakeRange(rangeStart, rangeStep)]];
  rangeStart += rangeStep;
  success = success && [scanner scanHexInt:&greenInt];
  scanner = [NSScanner
      scannerWithString:[primaryString substringWithRange:NSMakeRange(rangeStart, rangeStep)]];
  success = success && [scanner scanHexInt:&blueInt];
  if (!success) {
    NSLog(@"Invalid hex input: %@", primaryString);
    return;
  }

  if (use3Digit) {
    redInt *= 17;
    greenInt *= 17;
    blueInt *= 17;
  }

  primaryColor =
      [UIColor colorWithRed:redInt / 255.0 green:greenInt / 255.0 blue:blueInt / 255.0 alpha:1.0];
  s_primaryColorString = primaryString;
  self.primaryColorPreView.backgroundColor = primaryColor;

  // Secondary color
  if (secondaryString.length != 6 && secondaryString.length != 3) {
    self.previewButton.enabled = NO;
    return;
  }

  use3Digit = secondaryString.length == 3;
  rangeStep = 2;
  rangeStart = 0;
  if (use3Digit) {
    rangeStep = 1;
  }
  scanner = [NSScanner
      scannerWithString:[secondaryString substringWithRange:NSMakeRange(rangeStart, rangeStep)]];
  rangeStart += rangeStep;
  success = YES;
  success = success && [scanner scanHexInt:&redInt];
  scanner = [NSScanner
      scannerWithString:[secondaryString substringWithRange:NSMakeRange(rangeStart, rangeStep)]];
  rangeStart += rangeStep;
  success = success && [scanner scanHexInt:&greenInt];
  scanner = [NSScanner
      scannerWithString:[secondaryString substringWithRange:NSMakeRange(rangeStart, rangeStep)]];
  rangeStart += rangeStep;
  success = success && [scanner scanHexInt:&blueInt];
  if (!success) {
    NSLog(@"Invalid hex input: %@", secondaryString);
    return;
  }

  if (use3Digit) {
    redInt *= 17;
    greenInt *= 17;
    blueInt *= 17;
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

#pragma mark - Catalog By Convention

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Themes", @"Custom Colors" ];
}

+ (NSString *)catalogStoryboardName {
  return @"ThemerCustomSchemePicker";
}
@end
