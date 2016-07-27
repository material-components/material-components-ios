/*Copyright 2016-present Google Inc. All Rights Reserved.

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
/* IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to use Material Components iOS.
 */

#import <Foundation/Foundation.h>

#import "HeaderStackViewTypicalUseSupplemental.h"

#import "MaterialHeaderStackView.h"
#import "MaterialNavigationBar.h"

@interface ExampleInstructionsViewHeaderStackViewTypicalUse : UIView

@end

@implementation HeaderStackViewTypicalUse (Supplemental)

- (void)setupExampleViews {
  self.exampleView =
      [[ExampleInstructionsViewHeaderStackViewTypicalUse alloc] initWithFrame:self.view.bounds];
  self.exampleView.autoresizingMask =
      UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;

  [self.view addSubview:self.exampleView];

  self.view.backgroundColor = [UIColor whiteColor];

  self.topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 100)];
  self.topView.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

  UIImageView *imageView = [[UIImageView alloc] initWithImage:[self headerBackgroundImage]];
  imageView.frame = self.topView.bounds;
  imageView.contentMode = UIViewContentModeScaleAspectFill;
  imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;

  self.topView.clipsToBounds = YES;
  [self.topView addSubview:imageView];

  self.navBar = [[MDCNavigationBar alloc] initWithFrame:CGRectZero];
  self.navBar.tintColor = [UIColor whiteColor];
  self.navBar.title = @"Header Stack View";

  // Light blue 500
  [self.navBar setBackgroundColor:[UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:1]];

  UIBarButtonItem *moreButton =
      [[UIBarButtonItem alloc] initWithTitle:@"More"
                                       style:UIBarButtonItemStylePlain
                                      target:self
                                      action:@selector(didTapToggleButton:)];

  // Set the title text attributes before assigning to buttonBar.items
  // because of https://github.com/google/material-components-ios/issues/277
  [moreButton setTitleTextAttributes:[self itemTitleTextAttributes] forState:UIControlStateNormal];
  self.navBar.trailingBarButtonItems = @[ moreButton ];
}

- (NSDictionary *)itemTitleTextAttributes {
  UIColor *textColor = [UIColor whiteColor];
  return @{NSForegroundColorAttributeName : textColor};
}

- (void)didTapToggleButton:(id)sender {
  self.toggled = !self.toggled;

  [UIView animateWithDuration:0.4
                   animations:^{
                     CGRect frame = self.stackView.frame;
                     if (self.toggled) {
                       frame.size.height = 200;
                     } else {
                       frame.size = [self.stackView sizeThatFits:self.stackView.bounds.size];
                     }
                     self.stackView.frame = frame;
                     [self.stackView layoutIfNeeded];
                   }];
}

- (UIImage *)headerBackgroundImage {
  NSBundle *bundle = [NSBundle bundleForClass:[self class]];
  NSString *imagePath = [bundle pathForResource:@"header_stack_view_theme" ofType:@"png"];
  return [UIImage imageWithContentsOfFile:imagePath];
}

- (BOOL)prefersStatusBarHidden {
  return YES;
}

@end

@implementation HeaderStackViewTypicalUse (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Header Stack View", @"Header Stack View" ];
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

+ (NSString *)catalogDescription {
  return @"The Header Stack View component is a view that coordinates the layout of two"
          " vertically-stacked bar views.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

@end

@implementation HeaderStackViewTypicalUse (Rotation)

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
}

@end

@implementation ExampleInstructionsViewHeaderStackViewTypicalUse

- (void)drawRect:(CGRect)rect {
  [[UIColor whiteColor] setFill];
  [[UIBezierPath bezierPathWithRect:rect] fill];

  CGSize textSize = [self textSizeForRect:rect];
  CGRect rectForText = CGRectMake(rect.origin.x + rect.size.width / 2.f - textSize.width / 2.f,
                                  rect.origin.y + rect.size.height / 2.f - textSize.height / 2.f,
                                  textSize.width, textSize.height);
  [[self instructionsString] drawInRect:rectForText];
  [self drawArrowWithFrame:CGRectMake(rect.size.width / 2.f - 12.f,
                                      rect.size.height / 2.f - 58.f - 12.f, 24.f, 24.f)];
}

- (CGSize)textSizeForRect:(CGRect)frame {
  return [[self instructionsString] boundingRectWithSize:frame.size
                                                 options:NSStringDrawingUsesLineFragmentOrigin |
                                                         NSStringDrawingUsesFontLeading
                                                 context:nil]
      .size;
}

- (NSAttributedString *)instructionsString {
  NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
  [style setAlignment:NSTextAlignmentCenter];
  [style setLineBreakMode:NSLineBreakByWordWrapping];

  NSDictionary *instructionAttributes1 = @{
    NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline],
    NSForegroundColorAttributeName :
        [UIColor colorWithRed:0.459 green:0.459 blue:0.459 alpha:0.87f],
    NSParagraphStyleAttributeName : style
  };

  NSDictionary *instructionAttributes2 = @{
    NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline],
    NSForegroundColorAttributeName :
        [UIColor colorWithRed:0.459 green:0.459 blue:0.459 alpha:0.87f],
    NSParagraphStyleAttributeName : style
  };

  NSString *instructionText = @"SWIPE RIGHT\n\n\n\nto go back\n\n\n\n\n\n";
  NSMutableAttributedString *instructionsAttributedString =
      [[NSMutableAttributedString alloc] initWithString:instructionText];
  [instructionsAttributedString setAttributes:instructionAttributes1 range:NSMakeRange(0, 11)];
  [instructionsAttributedString setAttributes:instructionAttributes2
                                        range:NSMakeRange(11, instructionText.length - 11)];

  return instructionsAttributedString;
}

- (void)drawArrowWithFrame:(CGRect)frame {
  UIBezierPath *bezierPath = [UIBezierPath bezierPath];
  [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(frame) + 12, CGRectGetMinY(frame) + 4)];
  [bezierPath
      addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 10.59, CGRectGetMinY(frame) + 5.41)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 16.17, CGRectGetMinY(frame) + 11)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 4, CGRectGetMinY(frame) + 11)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 4, CGRectGetMinY(frame) + 13)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 16.17, CGRectGetMinY(frame) + 13)];
  [bezierPath
      addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 10.59, CGRectGetMinY(frame) + 18.59)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 12, CGRectGetMinY(frame) + 20)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 20, CGRectGetMinY(frame) + 12)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 12, CGRectGetMinY(frame) + 4)];
  [bezierPath closePath];
  bezierPath.miterLimit = 4;

  [[UIColor colorWithRed:0.459 green:0.459 blue:0.459 alpha:0.87f] setFill];
  [bezierPath fill];
}

@end
