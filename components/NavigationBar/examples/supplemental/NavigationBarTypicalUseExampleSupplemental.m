/*Copyright 2016-present the Material Components for iOS authors. All Rights Reserved.

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
 instructions. It is not necessary to import this file to use Material Components for iOS.
 */

#import <Foundation/Foundation.h>

#import "NavigationBarTypicalUseExampleSupplemental.h"

#import "MaterialNavigationBar.h"

@interface ExampleInstructionsViewNavigationBarTypicalUseExample : UIView

@end

@implementation NavigationBarTypicalUseExample (Supplemental)

- (void)setupExampleViews {
  self.exampleView = [[ExampleInstructionsViewNavigationBarTypicalUseExample alloc]
      initWithFrame:self.view.bounds];
  [self.view insertSubview:self.exampleView belowSubview:self.navBar];

  self.exampleView.translatesAutoresizingMaskIntoConstraints = NO;

  NSDictionary *viewBindings = @{ @"exampleView" : self.exampleView, @"navBar" : self.navBar };
  NSMutableArray<__kindof NSLayoutConstraint *> *arrayOfConstraints = [NSMutableArray array];

  // clang-format off
  [arrayOfConstraints addObjectsFromArray:[NSLayoutConstraint
                                              constraintsWithVisualFormat:@"H:|[exampleView]|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:viewBindings]];
  [arrayOfConstraints addObjectsFromArray:[NSLayoutConstraint
                                            constraintsWithVisualFormat:@"V:[navBar]-[exampleView]|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:viewBindings]];
  // clang-format on
  [self.view addConstraints:arrayOfConstraints];
}

@end

@implementation NavigationBarTypicalUseExample (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Navigation Bar", @"Navigation Bar" ];
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}

+ (NSString *)catalogDescription {
  return @"The Navigation Bar component is a view composed of a left and right Button Bar and"
          " either a title label or a custom title view.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

@end

@implementation NavigationBarTypicalUseExample (Rotation)

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
  [self.exampleView setNeedsDisplay];
}

@end

@implementation ExampleInstructionsViewNavigationBarTypicalUseExample

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

  NSString *instructionText = @"SWIPE RIGHT\n\n\n\nfrom left edge to go back\n\n\n\n\n\n";
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
