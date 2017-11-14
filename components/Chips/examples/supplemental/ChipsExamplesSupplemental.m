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

#import "ChipsExamplesSupplemental.h"

#import "MaterialChips.h"

static UIImage *DoneImage() {
  NSBundle *bundle = [NSBundle bundleForClass:[ChipsTypicalUseViewController class]];
  UIImage *image = [UIImage imageNamed:@"ic_done"
                              inBundle:bundle
         compatibleWithTraitCollection:nil];
  return image;
}

static UIImage *FaceImage() {
  NSBundle *bundle = [NSBundle bundleForClass:[ChipsTypicalUseViewController class]];
  UIImage *image = [UIImage imageNamed:@"ic_mask"
                              inBundle:bundle
         compatibleWithTraitCollection:nil];
  return image;
}

static UIButton *DeleteButton() {
  NSBundle *bundle = [NSBundle bundleForClass:[ChipsTypicalUseViewController class]];
  UIImage *image = [UIImage imageNamed:@"ic_cancel"
                              inBundle:bundle
         compatibleWithTraitCollection:nil];
  image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];

  UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
  button.tintColor = [UIColor colorWithWhite:0 alpha:0.7];
  [button setImage:image forState:UIControlStateNormal];

  return button;
}

@implementation ExampleChipCollectionViewController {
  BOOL _popRecognizerDelaysTouches;
}

- (void)viewDidAppear:(BOOL)animated {
  [super viewDidAppear:animated];

  _popRecognizerDelaysTouches =
      self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan;
  self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
  [super viewWillDisappear:animated];

  self.navigationController.interactivePopGestureRecognizer.delaysTouchesBegan =
      _popRecognizerDelaysTouches;
}

@end

@interface ChipsChoiceExampleViewController (Supplemental)
@end

@implementation ChipsChoiceExampleViewController (Supplemental)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Chips", @"Choice" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

@end

@interface ChipsCollectionExampleViewController (Supplemental)
@end

@implementation ChipsCollectionExampleViewController (Supplemental)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Chips", @"Collections" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

@end

@implementation ChipsFilterExampleViewController (Supplemental)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Chips", @"Filter" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

- (UIImage *)doneImage {
  return DoneImage();
}

@end

@implementation ChipsSizingExampleViewController (Supplemental)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Chips", @"Sizing" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return NO;
}

- (UIImage *)faceImage {
  return FaceImage();
}

- (UIButton *)deleteButton {
  return DeleteButton();
}

@end

@implementation ChipsTypicalUseViewController (Supplemental)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Chips", @"Chips" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

- (UIImage *)doneImage {
  return DoneImage();
}

@end

@implementation ChipModel

- (void)apply:(MDCChipView *)chipView {
  chipView.titleLabel.text = self.title;
  chipView.imageView.image = self.showProfilePic ? [self faceImage] : nil;
  chipView.selectedImageView.image = self.showDoneImage ? [self doneImage] : nil;
  chipView.accessoryView = self.showDeleteButton ? [self deleteButton] : nil;
}

- (UIImage *)faceImage {
  return FaceImage();
}

- (UIImage *)doneImage {
  return DoneImage();
}

- (UIButton *)deleteButton {
  return DeleteButton();
}

@end
