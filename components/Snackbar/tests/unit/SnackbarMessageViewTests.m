/*
 Copyright 2015-present the Material Components for iOS authors. All Rights Reserved.
 
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

#import <XCTest/XCTest.h>

#import "MDCSnackbarMessage.h"
#import "MDCSnackbarMessageView.h"
// TODO(seanoshea): Re-add 'private/' to the path below once our Podspec specfically defines our
// header search paths instead of flattening our header files into a single directory.
#import "MDCSnackbarMessageViewInternal.h"

@interface SnackbarMessageViewTests : XCTestCase

@property (nonatomic) MDCSnackbarMessage *message;
@property (nonatomic) UIColor *defaultBackgroundColor;
@property (nonatomic) UIColor *defaultShadowColor;
@property (nonatomic) UIColor *defaultTextColor;
@property (nonatomic) MDCSnackbarMessageView *view;

- (void)checkThatComponentsAreEqual:(CGFloat *)components expectedComponents:(CGFloat *)expectedComponents;

@end

@implementation SnackbarMessageViewTests

- (void)setUp {
  [super setUp];
  self.message = [[MDCSnackbarMessage alloc] init];
  self.message.attributedText = [[NSAttributedString alloc] initWithString:@"This is a simple message" attributes:nil];
  
  self.defaultBackgroundColor = [UIColor colorWithRed:0x32/255.0f green:0x32/255.0f blue:0x32/255.0f alpha:1.0f];
  self.defaultShadowColor = [UIColor colorWithRed:0x00/255.0f green:0x00/255.0f blue:0x00/255.0f alpha:1.0f];
  self.defaultTextColor = [UIColor colorWithRed:0xFF/255.0f green:0xFF/255.0f blue:0xFF/255.0f alpha:1.0f];
  
  self.view = [[MDCSnackbarMessageView alloc] initWithMessage:self.message dismissHandler:nil];
}

- (void)testNonNil {
  XCTAssertNotNil(self.view);
  XCTAssertNotNil(self.view.snackbarMessageViewBackgroundColor);
  XCTAssertNotNil(self.view.snackbarMessageViewShadowColor);
  XCTAssertNotNil(self.view.snackbarMessageViewTextColor);
}

- (void)testSnackbarMessageViewBackgroundColor {
  const CGFloat *components = CGColorGetComponents(self.view.snackbarMessageViewBackgroundColor.CGColor);
  const CGFloat *expectedComponents = CGColorGetComponents(self.defaultBackgroundColor.CGColor);
  
  XCTAssert(CGColorGetNumberOfComponents(self.view.snackbarMessageViewBackgroundColor.CGColor) == 4);
  [self checkThatComponentsAreEqual:components expectedComponents:expectedComponents];
}

- (void)testSnackbarMessageViewShadowColor {
  const CGFloat *components = CGColorGetComponents(self.view.snackbarMessageViewShadowColor.CGColor);
  const CGFloat *expectedComponents = CGColorGetComponents(self.defaultShadowColor.CGColor);
  
  XCTAssert(CGColorGetNumberOfComponents(self.view.snackbarMessageViewShadowColor.CGColor) == 4);
  [self checkThatComponentsAreEqual:components expectedComponents:expectedComponents];
}

- (void)testSnackbarMessageViewTextColor {
  const CGFloat *components = CGColorGetComponents(self.view.snackbarMessageViewTextColor.CGColor);
  const CGFloat *expectedComponents = CGColorGetComponents(self.defaultTextColor.CGColor);
  
  XCTAssert(CGColorGetNumberOfComponents(self.view.snackbarMessageViewTextColor.CGColor) == 4);
  [self checkThatComponentsAreEqual:components expectedComponents:expectedComponents];
}

- (void)checkThatComponentsAreEqual:(CGFloat *)components expectedComponents:(CGFloat *)expectedComponents {
  for (int i = 0; i <= 3; i++) {
    XCTAssertEqualWithAccuracy(components[i], expectedComponents[i], 0.0001);
  }
}

@end
