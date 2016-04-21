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

/** IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to implement any Material Design Components.
 */

#import "FlexibleHeaderTypicalUseInstructionsView.h"

@implementation FlexibleHeaderTypicalUseInstructionsView

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
  return [[self instructionsString]
             boundingRectWithSize:frame.size
                          options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                          context:nil]
      .size;
}

- (NSAttributedString *)instructionsString {
  NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
  [style setAlignment:NSTextAlignmentCenter];
  [style setLineBreakMode:NSLineBreakByWordWrapping];

  NSDictionary *instructionAttributes1 =
      @{NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline],
        NSForegroundColorAttributeName : [UIColor colorWithRed:(CGFloat)0.459
                                                         green:(CGFloat)0.459
                                                          blue:(CGFloat)0.459
                                                         alpha:(CGFloat)0.87],
        NSParagraphStyleAttributeName : style};
  NSDictionary *instructionAttributes2 =
      @{NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline],
        NSForegroundColorAttributeName : [UIColor colorWithRed:(CGFloat)0.459
                                                         green:(CGFloat)0.459
                                                          blue:(CGFloat)0.459
                                                         alpha:(CGFloat)0.87],
        NSParagraphStyleAttributeName : style};

  NSString *instructionText1 = @"PULL DOWN\n\nMDCFlexibleHeaderViewController\nallows the\
  blue area to stretch\nwhen scrolled down.\n\n\n\n\n\n";
  NSMutableAttributedString *instructionsAttributedString1 = [[NSMutableAttributedString alloc]
      initWithString:instructionText1];
  [instructionsAttributedString1 setAttributes:instructionAttributes1
                                         range:NSMakeRange(0, 9)];
  [instructionsAttributedString1 setAttributes:instructionAttributes2
                                         range:NSMakeRange(9, instructionText1.length - 9)];

  NSString *instructionText2 = @"PUSH UP\n\nIt also adds a shadow\nwhen scrolled up.\n\n\n\n\n\n\n";
  NSMutableAttributedString *instructionsAttributedString2 = [[NSMutableAttributedString alloc]
      initWithString:instructionText2];
  [instructionsAttributedString2 setAttributes:instructionAttributes1
                                         range:NSMakeRange(0, 7)];
  [instructionsAttributedString2 setAttributes:instructionAttributes2
                                         range:NSMakeRange(7, instructionText2.length - 7)];

  [instructionsAttributedString1 appendAttributedString:instructionsAttributedString2];

  return instructionsAttributedString1;
}

- (void)drawArrowWithFrame:(CGRect)frame {
  UIBezierPath *bezierPath = [UIBezierPath bezierPath];
  [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(frame) + 16,
                                      CGRectGetMinY(frame) + (CGFloat)17.01)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 16, CGRectGetMinY(frame) + 10)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 14, CGRectGetMinY(frame) + 10)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 14,
                                         CGRectGetMinY(frame) + (CGFloat)17.01)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 11,
                                         CGRectGetMinY(frame) + (CGFloat)17.01)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 15, CGRectGetMinY(frame) + 21)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 19,
                                         CGRectGetMinY(frame) + (CGFloat)17.01)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 16,
                                         CGRectGetMinY(frame) + (CGFloat)17.01)];
  [bezierPath closePath];
  [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(frame) + 9, CGRectGetMinY(frame) + 3)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 5,
                                         CGRectGetMinY(frame) + (CGFloat)6.99)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 8,
                                         CGRectGetMinY(frame) + (CGFloat)6.99)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 8, CGRectGetMinY(frame) + 14)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 10,
                                         CGRectGetMinY(frame) + 14)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 10,
                                         CGRectGetMinY(frame) + (CGFloat)6.99)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 13,
                                         CGRectGetMinY(frame) + (CGFloat)6.99)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 9,
                                         CGRectGetMinY(frame) + 3)];
  [bezierPath closePath];
  bezierPath.miterLimit = 4;

  [[UIColor colorWithRed:(CGFloat)0.459
                   green:(CGFloat)0.459
                    blue:(CGFloat)0.459
                   alpha:0.87f] setFill];
  [bezierPath fill];
}

@end
