// Copyright 2019-present the Material Components for iOS authors. All Rights Reserved.
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

#import "MaterialSnapshot.h"

#import "MaterialTypography.h"

/** A large height that isn't so large UILabel returns nonsense for sizeThatFits:. */
static const CGFloat kLargeHeightValue = 10000;

/** Width of the test view so labels don't get too wide. */
static const CGFloat kViewWidth = 480;

// Pangrams containing large numbers of characters from different scripts.
static NSString *const kPangramLatin = @"New job: fix Mr. Gluck’s hazy TV, PDQ!";
static NSString *const kPangramArabic =
    @"نص حكيم له سر قاطع وذو شأن عظيم مكتوب على ثوب أخضر ومغلف بجلد أزرق";
static NSString *const kPangramHindi = @"ऋषियों को सताने वाले दुष्ट राक्षसों के राजा रावण का सर्वनाश करने "
                                       @"वाले विष्णुवतार भगवान श्रीराम, अयोध्या के महाराज दशरथ के बड़े "
                                        "सपुत्र थे।";
static NSString *const kPangramKorean =
    @"키스의 고유조건은 입술끼리 만나야 하고 특별한 기술은 필요치 않다.";
static NSString *const kPangramCyrillic =
    @"Ајшо, лепото и чежњо, за љубав срца мога дођи у Хаџиће на кафу.";

/** Test view holding labels for all test strings. */
@interface MDCTypographyTestView : UIView
@property(nonatomic, strong) UILabel *labelLatin;
@property(nonatomic, strong) UILabel *labelArabic;
@property(nonatomic, strong) UILabel *labelCyrillic;
@property(nonatomic, strong) UILabel *labelHindi;
@property(nonatomic, strong) UILabel *labelKorean;
@end

@implementation MDCTypographyTestView

- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    _labelLatin = [[UILabel alloc] init];
    _labelLatin.numberOfLines = 0;
    _labelLatin.text = kPangramLatin;
    _labelLatin.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_labelLatin];

    _labelArabic = [[UILabel alloc] init];
    _labelArabic.numberOfLines = 0;
    _labelArabic.text = kPangramArabic;
    _labelArabic.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_labelArabic];

    _labelHindi = [[UILabel alloc] init];
    _labelHindi.numberOfLines = 0;
    _labelHindi.text = kPangramHindi;
    _labelHindi.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_labelHindi];

    _labelCyrillic = [[UILabel alloc] init];
    _labelCyrillic.numberOfLines = 0;
    _labelCyrillic.text = kPangramCyrillic;
    _labelCyrillic.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_labelCyrillic];

    _labelKorean = [[UILabel alloc] init];
    _labelKorean.numberOfLines = 0;
    _labelKorean.text = kPangramKorean;
    _labelKorean.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:_labelKorean];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];

  CGFloat width = CGRectGetWidth(self.bounds);
  CGSize fitSize = CGSizeMake(width, kLargeHeightValue);
  CGFloat lastLabelMaxY = 8;
  NSArray<UILabel *> *labels =
      @[ self.labelLatin, self.labelArabic, self.labelCyrillic, self.labelHindi, self.labelKorean ];

  for (UILabel *label in labels) {
    CGSize labelSize = [label sizeThatFits:fitSize];
    label.frame = CGRectMake(0, lastLabelMaxY, labelSize.width, labelSize.height);
    lastLabelMaxY = CGRectGetMaxY(label.frame) + 8;
  }
}

- (CGSize)sizeThatFits:(CGSize)size {
  CGFloat width = size.width;
  CGSize fitSize = CGSizeMake(width, kLargeHeightValue);
  CGFloat lastLabelMaxY = 8;
  NSArray<UILabel *> *labels =
      @[ self.labelLatin, self.labelArabic, self.labelCyrillic, self.labelHindi, self.labelKorean ];

  for (UILabel *label in labels) {
    lastLabelMaxY += [label sizeThatFits:fitSize].height + 8;
  }

  return CGSizeMake(width, lastLabelMaxY);
}

@end

/** Snapshot tests for MDCTypography fonts. */
@interface MDCTypographySnapshotTests : MDCSnapshotTestCase

/** View containing all labels arranged for snapshotting. */
@property(nonatomic, strong) MDCTypographyTestView *testingView;

@end

@implementation MDCTypographySnapshotTests

- (void)setUp {
  [super setUp];

  // Uncomment below to recreate all the goldens (or add the following line to the specific
  // test you wish to recreate the golden for).
  //  self.recordMode = YES;

  self.testingView =
      [[MDCTypographyTestView alloc] initWithFrame:CGRectMake(0, 0, kViewWidth, 100)];
}

- (void)tearDown {
  self.testingView = nil;

  [super tearDown];
}

- (void)generateSnapshotAndVerifyForView:(UIView *)view {
  UIView *snapshotView = [view mdc_addToBackgroundView];
  [self snapshotVerifyView:snapshotView];
}

- (void)setLabelsFont:(UIFont *)font {
  self.testingView.labelLatin.font = font;
  self.testingView.labelArabic.font = font;
  self.testingView.labelCyrillic.font = font;
  self.testingView.labelHindi.font = font;
  self.testingView.labelKorean.font = font;
}

#pragma mark - Tests

- (void)testDisplay4 {
  // When
  [self setLabelsFont:[MDCTypography display4Font]];

  // Then
  [self.testingView sizeToFit];
  [self generateSnapshotAndVerifyForView:self.testingView];
}

- (void)testDisplay3 {
  // When
  [self setLabelsFont:[MDCTypography display3Font]];

  // Then
  [self.testingView sizeToFit];
  [self generateSnapshotAndVerifyForView:self.testingView];
}

- (void)testDisplay2 {
  // When
  [self setLabelsFont:[MDCTypography display2Font]];

  // Then
  [self.testingView sizeToFit];
  [self generateSnapshotAndVerifyForView:self.testingView];
}

- (void)testDisplay1 {
  // When
  [self setLabelsFont:[MDCTypography display1Font]];

  // Then
  [self.testingView sizeToFit];
  [self generateSnapshotAndVerifyForView:self.testingView];
}

- (void)testHeadline {
  // When
  [self setLabelsFont:[MDCTypography headlineFont]];

  // Then
  [self.testingView sizeToFit];
  [self generateSnapshotAndVerifyForView:self.testingView];
}

- (void)testTitle {
  // When
  [self setLabelsFont:[MDCTypography titleFont]];

  // Then
  [self.testingView sizeToFit];
  [self generateSnapshotAndVerifyForView:self.testingView];
}

- (void)testSubhead {
  // When
  [self setLabelsFont:[MDCTypography subheadFont]];

  // Then
  [self.testingView sizeToFit];
  [self generateSnapshotAndVerifyForView:self.testingView];
}

- (void)testBody2 {
  // When
  [self setLabelsFont:[MDCTypography body2Font]];

  // Then
  [self.testingView sizeToFit];
  [self generateSnapshotAndVerifyForView:self.testingView];
}

- (void)testBody1 {
  // When
  [self setLabelsFont:[MDCTypography body1Font]];

  // Then
  [self.testingView sizeToFit];
  [self generateSnapshotAndVerifyForView:self.testingView];
}

- (void)testCaption {
  // When
  [self setLabelsFont:[MDCTypography captionFont]];

  // Then
  [self.testingView sizeToFit];
  [self generateSnapshotAndVerifyForView:self.testingView];
}

- (void)testButton {
  // When
  [self setLabelsFont:[MDCTypography buttonFont]];

  // Then
  [self.testingView sizeToFit];
  [self generateSnapshotAndVerifyForView:self.testingView];
}

@end
