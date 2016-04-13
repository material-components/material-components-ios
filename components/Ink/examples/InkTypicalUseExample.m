/*
 Copyright 2015-present Google Inc. All Rights Reserved.

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

#import "MaterialInk.h"

// A set of UILabels in an variety of shapes to tap on.
//
// Something like:
//
// .----.----.----.----.  .----.
// .                   .  .    .
// .                   .  .    .
// .                   .  .    .
// .                   .  .    .
// .                   .  .    .
// .                   .  .    .
// .                   .  .    .
//  ----.----.----.----    ----
//
// .----.----.----.----.  .----.
// .                   .  .    .
// .                   .  .    .
//  ----.----.----.----    ----
@interface ExampleShapes : UIView
@property(nonatomic) CGFloat padding;
@property(nonatomic) CGFloat ratio;
@property(nonatomic, strong) UIColor *shapeColor;
@property(nonatomic, copy) NSString *title;
@end

@interface InkTypicalUseViewController : UIViewController
@end

@interface InkTypicalUseViewController () <MDCInkTouchControllerDelegate>
@property(nonatomic) CGFloat shapeDimension;
@property(nonatomic) CGFloat spacing;
@property(nonatomic, strong) ExampleShapes *boundedShapes;
@property(nonatomic, strong) NSMutableArray *inkTouchControllers;  // MDCInkTouchControllers.
@property(nonatomic, strong) UIView *unboundedShape;
@end

@implementation InkTypicalUseViewController

// TODO: Support other categorizational methods.
+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Ink", @"Ink" ];
}

+ (NSString *)catalogDescription {
  return @"The Ink component provides a radial action in the form of a visual ripple of ink"
          " expanding outward from the user's touch.";
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
  _inkTouchControllers = [[NSMutableArray alloc] init];

  self.spacing = 16;
  self.shapeDimension = 200;
  CGRect customFrame = CGRectMake(0, 0, self.shapeDimension, self.shapeDimension);
  self.boundedShapes = [[ExampleShapes alloc] initWithFrame:customFrame];
  self.boundedShapes.title = @"Bounded";
  self.boundedShapes.autoresizingMask =
      UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin |
      UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
  self.boundedShapes.shapeColor = [UIColor whiteColor];
  for (UIView *view in self.boundedShapes.subviews) {
    MDCInkTouchController *inkTouchController = [[MDCInkTouchController alloc] initWithView:view];
    inkTouchController.delegate = self;
    [inkTouchController addInkView];
    [_inkTouchControllers addObject:inkTouchController];
  }
  [self.view addSubview:self.boundedShapes];

  CGRect unboundedFrame = CGRectMake(self.spacing / 2,
                                     self.spacing / 2,
                                     customFrame.size.width - self.spacing,
                                     customFrame.size.height - self.spacing);
  self.unboundedShape = [[UIView alloc] initWithFrame:unboundedFrame];
  self.unboundedShape.autoresizingMask =
      UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin |
      UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin;
  self.unboundedShape.backgroundColor = [UIColor whiteColor];
  MDCInkTouchController *inkTouchController =
      [[MDCInkTouchController alloc] initWithView:self.unboundedShape];
  inkTouchController.delegate = self;
  [inkTouchController addInkView];
  UIColor *blueColor = [UIColor colorWithRed:0.012 green:0.663 blue:0.957 alpha:0.2];
  inkTouchController.defaultInkView.inkColor = blueColor;
  inkTouchController.defaultInkView.inkStyle = MDCInkStyleUnbounded;
  [_inkTouchControllers addObject:inkTouchController];
  [self.view addSubview:self.unboundedShape];

  UILabel *unboundedTitleLabel = [[UILabel alloc] initWithFrame:self.unboundedShape.bounds];
  unboundedTitleLabel.text = @"Unbounded";
  unboundedTitleLabel.textAlignment = NSTextAlignmentCenter;
  unboundedTitleLabel.textColor = [UIColor grayColor];
  [self.unboundedShape addSubview:unboundedTitleLabel];
}

- (void)viewWillLayoutSubviews {
  if (self.view.frame.size.height > self.view.frame.size.width) {
    self.boundedShapes.center =
        CGPointMake(self.view.center.x, self.view.center.y - self.shapeDimension);
    self.unboundedShape.center = CGPointMake(self.view.center.x,
                                             self.view.center.y + self.spacing * 2);
  } else {
    self.boundedShapes.center =
        CGPointMake(self.view.center.x - self.shapeDimension / 2 - self.spacing * 2,
                    self.view.center.y / 2 + self.spacing * 2);
    self.unboundedShape.center =
        CGPointMake(self.view.center.x + self.shapeDimension / 2 + self.spacing * 2,
                    self.view.center.y / 2 + self.spacing * 2);
  }
}

#pragma mark - Private

- (void)inkTouchController:(MDCInkTouchController *)inkTouchController
         didProcessInkView:(MDCInkView *)inkView
           atTouchLocation:(CGPoint)location {
  NSLog(@"InkTouchController %p did process ink view: %p at touch location: %@",
        inkTouchController,
        inkView,
        NSStringFromCGPoint(location));
}

@end

@interface ExampleShapes ()
@property(nonatomic, strong) UILabel *titleLabel;
@end

@implementation ExampleShapes

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _padding = 8;
    _ratio = 4;

    for (int i = 0; i < 4; ++i) {
      UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
      [self addSubview:view];

      if (i == 0) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        [view addSubview:_titleLabel];
      }
    }
  }
  return self;
}

- (void)setShapeColor:(UIColor *)shapeColor {
  if ([_shapeColor isEqual:shapeColor]) {
    return;
  }

  for (UIView *view in self.subviews) {
    view.backgroundColor = shapeColor;
  }
}

- (NSString *)title {
  return _titleLabel.text;
}

- (void)setTitle:(NSString *)title {
  _titleLabel.text = title;
}

- (void)layoutSubviews {
  CGFloat totalLength = MIN(CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds));

  // There are two shapes in each direction, so three margins total.
  CGFloat available = totalLength - 3 * self.padding;
  if (available <= 0) {
    return;
  }

  // Construct the shape with the right size but at (0,0) and transform later.
  CGFloat shortLength = available / (1 + self.ratio);
  CGFloat longLength = self.ratio * shortLength;

  CGRect bigSquareFrame = CGRectMake(0, 0, longLength, longLength);

  CGRect vertFrame = CGRectMake(CGRectGetMaxX(bigSquareFrame) + self.padding,
                                0,
                                shortLength,
                                longLength);

  CGRect horzFrame = CGRectMake(0,
                                CGRectGetMaxY(bigSquareFrame) + self.padding,
                                longLength,
                                shortLength);

  CGRect smallSquareFrame = CGRectMake(CGRectGetMaxX(bigSquareFrame) + self.padding,
                                       CGRectGetMaxY(bigSquareFrame) + self.padding,
                                       shortLength,
                                       shortLength);

  // Offset the frames so they have the correct leading padding.
  CGRect frames[] = {bigSquareFrame, vertFrame, horzFrame, smallSquareFrame};
  for (int i = 0; i < 4; ++i) {
    frames[i] = CGRectOffset(frames[i], self.padding, self.padding);
  }

  NSArray *subviews = self.subviews;
  NSAssert(subviews.count == 4, @"");
  for (int i = 0; i < 4; ++i) {
    UIView *view = subviews[i];
    view.frame = frames[i];
    if (i == 0) {
      _titleLabel.frame = CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height);
      _titleLabel.textAlignment = NSTextAlignmentCenter;
      _titleLabel.textColor = [UIColor grayColor];
    }
  }
}

@end
