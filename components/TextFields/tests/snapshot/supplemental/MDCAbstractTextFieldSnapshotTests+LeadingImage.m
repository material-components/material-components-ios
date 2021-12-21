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

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#import "MDCAbstractTextFieldSnapshotTests+LeadingImage.h"

@implementation MDCAbstractTextFieldSnapshotTests (LeadingImage)

- (void)addLeadingImage {
  XCTAssertTrue([self.textField conformsToProtocol:@protocol(MDCLeadingViewTextInput)]);
  if (![self.textField conformsToProtocol:@protocol(MDCLeadingViewTextInput)]) {
    return;
  }
  NSBundle *imageBundle = [NSBundle bundleForClass:[MDCAbstractTextFieldSnapshotTests class]];
  UIImage *leadingImage = [UIImage imageNamed:@"system_icons/search"
                                     inBundle:imageBundle
                compatibleWithTraitCollection:nil];
  leadingImage = [leadingImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  UIView<MDCLeadingViewTextInput> *textField = (UIView<MDCLeadingViewTextInput> *)self.textField;
  textField.leadingViewMode = UITextFieldViewModeAlways;
  textField.leadingView = [[UIImageView alloc] initWithImage:leadingImage];
}
@end
