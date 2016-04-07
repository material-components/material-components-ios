/* IMPORTANT:
 This file contains supplemental code used to populate the examples with dummy data and/or
 instructions. It is not necessary to import this file to implement any Material Design Components.
 */

#import <Foundation/Foundation.h>

#import "FlexibleHeaderTypicalUseSupplemental.h"

#pragma mark - FlexibleHeaderTypicalUseViewController

@interface ExampleInstructionsViewFlexibleHeaderTypicalUse : UIView

@end

@implementation FlexibleHeaderTypicalUseViewController (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Flexible Header", @"Typical use" ];
}

- (BOOL)catalogShouldHideNavigation {
  return YES;
}
@end

@implementation FlexibleHeaderTypicalUseViewController (Rotation)

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
                                         duration:(NSTimeInterval)duration {
  [self.exampleView setNeedsDisplay];
}

@end

@implementation FlexibleHeaderTypicalUseViewController (Supplemental)

- (void)setupExampleViews {
  self.scrollView.translatesAutoresizingMaskIntoConstraints = NO;

  NSDictionary *viewBindings = @{ @"scrollView" : self.scrollView };
  NSMutableArray<__kindof NSLayoutConstraint *> *arrayOfConstraints = [NSMutableArray array];
  [arrayOfConstraints addObjectsFromArray:[NSLayoutConstraint
                                              constraintsWithVisualFormat:@"H:|[scrollView]|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:viewBindings]];
  [arrayOfConstraints addObjectsFromArray:[NSLayoutConstraint
                                              constraintsWithVisualFormat:@"V:|[scrollView]|"
                                                                  options:0
                                                                  metrics:nil
                                                                    views:viewBindings]];

  [self.view addConstraints:arrayOfConstraints];

  self.exampleView = [[ExampleInstructionsViewFlexibleHeaderTypicalUse alloc]
      initWithFrame:self.scrollView.bounds];
  [self.scrollView addSubview:self.exampleView];

  self.exampleView.translatesAutoresizingMaskIntoConstraints = NO;

  NSLayoutConstraint *width = [NSLayoutConstraint constraintWithItem:self.exampleView
                                                           attribute:NSLayoutAttributeHeight
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.view
                                                           attribute:NSLayoutAttributeHeight
                                                          multiplier:1
                                                            constant:0];

  NSLayoutConstraint *centerX = [self.exampleView.centerXAnchor
      constraintEqualToAnchor:self.view.centerXAnchor];
  NSLayoutConstraint *top = [self.exampleView.topAnchor
      constraintEqualToAnchor:self.scrollView.topAnchor];
  NSLayoutConstraint *bottom = [self.exampleView.bottomAnchor
      constraintEqualToAnchor:self.scrollView.bottomAnchor];
  NSLayoutConstraint *leading = [self.exampleView.leadingAnchor
      constraintEqualToAnchor:self.scrollView.leadingAnchor];
  NSLayoutConstraint *trailing = [self.exampleView.trailingAnchor
      constraintEqualToAnchor:self.scrollView.trailingAnchor];

  [self.view addConstraints:@[ width, centerX, top, bottom, leading, trailing ]];
}

@end

@implementation ExampleInstructionsViewFlexibleHeaderTypicalUse

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
        NSForegroundColorAttributeName : [UIColor colorWithRed:0.459
                                                         green:0.459
                                                          blue:0.459
                                                         alpha:0.87f],
        NSParagraphStyleAttributeName : style};
  NSDictionary *instructionAttributes2 =
      @{NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline],
        NSForegroundColorAttributeName : [UIColor colorWithRed:0.459
                                                         green:0.459
                                                          blue:0.459
                                                         alpha:0.87f],
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
  [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(frame) + 16, CGRectGetMinY(frame) + 17.01)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 16, CGRectGetMinY(frame) + 10)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 14, CGRectGetMinY(frame) + 10)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 14, CGRectGetMinY(frame) + 17.01)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 11, CGRectGetMinY(frame) + 17.01)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 15, CGRectGetMinY(frame) + 21)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 19, CGRectGetMinY(frame) + 17.01)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 16, CGRectGetMinY(frame) + 17.01)];
  [bezierPath closePath];
  [bezierPath moveToPoint:CGPointMake(CGRectGetMinX(frame) + 9, CGRectGetMinY(frame) + 3)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 5, CGRectGetMinY(frame) + 6.99)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 8, CGRectGetMinY(frame) + 6.99)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 8, CGRectGetMinY(frame) + 14)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 10, CGRectGetMinY(frame) + 14)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 10, CGRectGetMinY(frame) + 6.99)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 13, CGRectGetMinY(frame) + 6.99)];
  [bezierPath addLineToPoint:CGPointMake(CGRectGetMinX(frame) + 9, CGRectGetMinY(frame) + 3)];
  [bezierPath closePath];
  bezierPath.miterLimit = 4;

  [[UIColor colorWithRed:0.459
                   green:0.459
                    blue:0.459
                   alpha:0.87f] setFill];
  [bezierPath fill];
}

@end
