//
//  TextField.m
//  ComponentsProject
//
//  Created by Andrew Overton on 9/6/18.
//  Copyright © 2018 andrewoverton. All rights reserved.
//

#import "SimpleTextField.h"

#import <MDFInternationalization/MDFInternationalization.h>
#import <MaterialComponents/MDCMath.h>

#import "SimpleTextFieldLayout.h"
#import "SimpleTextFieldLayoutUtils.h"

@interface SimpleTextField ()

@property (strong, nonatomic) UIFont *floatingPlaceholderFont;
@property (strong, nonatomic) UIFont *placeholderFont;

@property (strong, nonatomic) UIButton *clearButton;
@property (strong, nonatomic) UIImageView *clearButtonImageView;
@property (strong, nonatomic) UILabel *placeholderLabel;
@property (strong, nonatomic) UILabel *leftUnderlineLabel;
@property (strong, nonatomic) UILabel *rightUnderlineLabel;

@property (strong, nonatomic) SimpleTextFieldLayout *layout;

@property (strong, nonatomic) CAShapeLayer *outlinedSublayer;
@property (strong, nonatomic) CAShapeLayer *filledSublayer;
@property (strong, nonatomic) CAShapeLayer *filledSublayerUnderline;

@property (nonatomic, assign) UIUserInterfaceLayoutDirection layoutDirection;

@end

// TODO: Go through UITextField.h and make sure you consider the entire public API
@implementation SimpleTextField

#pragma mark Object Lifecycle

-(instancetype)init {
  self = [super init];
  if (self) {
    [self commonSimpleTextFieldInit];
  }
  return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self commonSimpleTextFieldInit];
  }
  return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  if (self) {
    [self commonSimpleTextFieldInit];
  }
  return self;
}

- (void)commonSimpleTextFieldInit {
  [self addObservers];
  [self setUpFonts];
  [self setUpLayoutDirection];
  [self setUpPlaceholderLabel];
  [self setUpUnderlineLabels];
  [self setUpClearButton];
  [self setUpStyleLayers];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark View Setup

- (void)setUpLayoutDirection {
  self.layoutDirection = self.mdf_effectiveUserInterfaceLayoutDirection;
}

- (void)setUpFonts {
  self.placeholderFont = self.effectiveFont;
  self.floatingPlaceholderFont = [self floatingPlaceholderFontWithFont:self.effectiveFont
                                                        textFieldStyle:self.textFieldStyle];
}

- (void)setUpStyleLayers {
  [self setUpOutlineSublayer];
  [self setUpFilledSublayer];
  // TODO: Underline
}

- (void)setUpOutlineSublayer {
  self.outlinedSublayer = [[CAShapeLayer alloc] init];
  self.outlinedSublayer.strokeColor = [UIColor purpleColor].CGColor;
  self.outlinedSublayer.fillColor = [UIColor clearColor].CGColor;
  self.outlinedSublayer.lineWidth = 2.0;
}

- (void)setUpFilledSublayer {
  UIColor *fillColor = [UIColor colorWithWhite:0 alpha:0.2];
  UIColor *underlineFillColor = [UIColor purpleColor];
  self.filledSublayer = [[CAShapeLayer alloc] init];
  self.filledSublayer.fillColor = fillColor.CGColor;
  self.filledSublayer.lineWidth = 0.0;
  self.filledSublayerUnderline = [[CAShapeLayer alloc] init];
  self.filledSublayerUnderline.fillColor = underlineFillColor.CGColor;
  [self.filledSublayer addSublayer:self.filledSublayerUnderline];
}

- (void)setUpUnderlineLabels {
  self.leftUnderlineLabel = [[UILabel alloc] init];
  [self addSubview:self.leadingUnderlineLabel];
  self.rightUnderlineLabel = [[UILabel alloc] init];
  [self addSubview:self.trailingUnderlineLabel];
}

- (void)setUpPlaceholderLabel {
  self.placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, -10, 200, 60)];
  [self addSubview:self.placeholderLabel];
}

- (void)setUpClearButton {
  CGRect clearButtonFrame = CGRectMake(0, 0, kClearButtonTouchTargetSideLength, kClearButtonTouchTargetSideLength);
  self.clearButton = [[UIButton alloc] initWithFrame:clearButtonFrame];
  [self.clearButton addTarget:self
                       action:@selector(clearButtonPressed:)
             forControlEvents:UIControlEventTouchUpInside];

  CGFloat clearButtonImageViewSideLength = [self clearButtonImageViewSideLength];
  CGRect clearButtonImageViewRect = CGRectMake(0, 0, clearButtonImageViewSideLength, clearButtonImageViewSideLength);
  self.clearButtonImageView = [[UIImageView alloc] initWithFrame:clearButtonImageViewRect];
  self.clearButtonImageView.image = [self clearButtonImage];
  self.clearButtonImageView.tintColor = UIColor.lightGrayColor;
  [self.clearButton addSubview:self.clearButtonImageView];
  [self addSubview:self.clearButton];
  self.clearButtonImageView.center = self.clearButton.center;
}

- (void)addObservers {
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidEndEditingWithNotification:) name:UITextFieldTextDidEndEditingNotification object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidBeginEditingWithNotification:) name:UITextFieldTextDidBeginEditingNotification object:nil];
}

#pragma mark UIView Overrides

- (SimpleTextFieldLayout *)calculateLayoutWithTextFieldBounds:(CGRect)textFieldBounds {
  UIFont *effectiveFont = self.effectiveFont;
  UIFont *floatingFont = [self floatingPlaceholderFontWithFont:effectiveFont
                                                textFieldStyle:self.textFieldStyle];
  CGFloat normalizedCustomUnderlineLabelDrawPriority =
  [self normalizedCustomUnderlineLabelDrawPriority:self.customUnderlineLabelDrawPriority];
  return [[SimpleTextFieldLayout alloc] initWithTextFieldBounds:textFieldBounds
                                                 textFieldStyle:self.textFieldStyle
                                                           text:self.text
                                                    placeholder:self.placeholder
                                                           font:effectiveFont
                                        floatingPlaceholderFont:floatingFont
                                            canPlaceholderFloat:self.canPlaceholderFloat
                                                       leftView:self.leftView
                                                   leftViewMode:self.leftViewMode
                                                      rightView:self.rightView
                                                  rightViewMode:self.rightViewMode
                                                    clearButton:self.clearButton
                                                clearButtonMode:self.clearButtonMode
                                             leftUnderlineLabel:self.leftUnderlineLabel
                                            rightUnderlineLabel:self.rightUnderlineLabel
                                     underlineLabelDrawPriority:self.underlineLabelDrawPriority
                               customUnderlineLabelDrawPriority:normalizedCustomUnderlineLabelDrawPriority
                                                          isRTL:[self isRTL]
                                                      isEditing:self.isEditing];
}

-(void)layoutSubviews {
  self.layout = [self calculateLayoutWithTextFieldBounds:self.bounds];
  // important layout methods like -textRectForBounds: are called in the super class implementation
  // so we want to have values for them figured out ahead of time.
  [super layoutSubviews];

  PlaceholderState state = [self determineCurrentPlaceholderState];
  [self layOutPlaceholderWithState:state];

  BOOL isFloatingPlaceholder = state == PlaceholderStateFloating;
  [self applyTextFieldStyle:self.textFieldStyle
            textFieldBounds:self.bounds
   floatingPlaceholderFrame:self.layout.placeholderFrameFloating
    topRowBottomRowDividerY:self.layout.topRowBottomRowDividerY
      isFloatingPlaceholder:isFloatingPlaceholder];

  self.clearButton.frame = self.layout.clearButtonFrame;
  self.clearButton.hidden = self.layout.clearButtonHidden;
  self.leftUnderlineLabel.frame = self.layout.leftUnderlineLabelFrame;
  self.rightUnderlineLabel.frame = self.layout.rightUnderlineLabelFrame;
  self.leftView.hidden = self.layout.leftViewHidden;
  self.rightView.hidden = self.layout.rightViewHidden;


  // TODO: Hide any views that the layout says to hide
  // TODO: Hide views that won't fit by validating frames (checking if they fit inside the bounds and don't overlap)
}

// UIView's sizeToFit calls this method.
// UITextField's sizeToFit calls this method and then also calls setNeedsLayout.
// When the system calls this method the size parameter is the view's current size.
// A vanilla UITextField returns a 9x21 size as the smallest UITextFields
// It does so irrespective of leftView/rightView, but it does take into account text.
// I think that this implementation should calculate a height for size.width.
-(CGSize)sizeThatFits:(CGSize)size {
  return [self preferredSizeWithWidth:size.width];
}

- (CGSize)preferredSizeWithWidth:(CGFloat)width {
  if (!self.layout) {
    self.layout = [self calculateLayoutWithTextFieldBounds:self.bounds];
  }
  return CGSizeMake(width, self.layout.calculatedHeight);
}

-(CGSize)intrinsicContentSize {
  return [self preferredSizeWithWidth:CGRectGetWidth(self.bounds)];
}

- (NSLayoutConstraint *)highestPriorityConstraintOnView:(UIView *)view
                                          withAttribute:(NSLayoutAttribute)attribute {
  UILayoutPriority maxPriority = 0;
  NSLayoutConstraint *result = nil;
  for (NSLayoutConstraint *constraint in view.constraints) {
    BOOL isAHeightConstraintOnSelf =
    (constraint.firstItem == view && constraint.firstAttribute == attribute) ||
    (constraint.secondItem == view && constraint.secondAttribute == attribute);
    if (isAHeightConstraintOnSelf && constraint.priority > maxPriority) {
      result = constraint;
    }
  }
  return result;
}

- (CGSize)systemLayoutSizeFittingSize:(CGSize)targetSize {
  NSLog(@"TODO: Implement systemLayoutSizeFittingSize:");
  return [super systemLayoutSizeFittingSize:targetSize];
}

-(void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
  [super traitCollectionDidChange:previousTraitCollection];
  [self setUpLayoutDirection];
}

#pragma mark UITextField Accessor Overrides

-(void)setFont:(UIFont *)font {
  [super setFont:font];
  [self setUpFonts];
}

-(void)setPlaceholder:(NSString *)placeholder {
  self.placeholderLabel.attributedText = nil;
  self.placeholderLabel.text = [placeholder copy];
  // TODO: Determine if setNeedsLayout is necessary here. I think it might be...
}

-(NSString *)placeholder {
  return self.placeholderLabel.text;
}

-(void)setAttributedPlaceholder:(NSAttributedString *)attributedPlaceholder {
  self.placeholderLabel.text = nil;
  self.placeholderLabel.attributedText = attributedPlaceholder;
  // TODO: Determine if setNeedsLayout is necessary here. I think it might be...
  // TODO: Also make layout aware of attributedPlaceholder
}

-(NSAttributedString *)attributedPlaceholder {
  return self.placeholderLabel.attributedText;
}

-(void)setLeftViewMode:(UITextFieldViewMode)leftViewMode {
  NSLog(@"Setting leftViewMode is not recommended. Consider setting leadingViewMode and trailingViewMode instead.");
  [self mdc_setLeftViewMode:leftViewMode];
}

-(void)setRightViewMode:(UITextFieldViewMode)rightViewMode {
  NSLog(@"Setting rightViewMode is not recommended. Consider setting leadingViewMode and trailingViewMode instead.");
  [self mdc_setRightViewMode:rightViewMode];
}

-(void)setLeftView:(UIView *)leftView {
  NSLog(@"Setting rightView and leftView are not recommended. Consider setting leadingView and trailingView instead.");
  [self mdc_setLeftView:leftView];
}

-(void)setRightView:(UIView *)rightView {
  NSLog(@"Setting rightView and leftView are not recommended. Consider setting leadingView and trailingView instead.");
  [self mdc_setRightView:rightView];
}

-(void)setClearButtonMode:(UITextFieldViewMode)clearButtonMode {
  [super setClearButtonMode:clearButtonMode];
  //TODO: determine whether a call to setNeedsLayout is necessary. I don't think it is...
}

-(void)setBorderStyle:(UITextBorderStyle)borderStyle {
  // enforce UITextBorderStyle.none
  [super setBorderStyle:UITextBorderStyleNone];
}

#pragma mark Custom Accessors

-(UILabel *)leadingUnderlineLabel {
  if ([self isRTL]) {
    return self.rightUnderlineLabel;
  } else {
    return self.leftUnderlineLabel;
  }
}

-(UILabel *)trailingUnderlineLabel {
  if ([self isRTL]) {
    return self.leftUnderlineLabel;
  } else {
    return self.rightUnderlineLabel;
  }
}

-(void)setLayoutDirection:(UIUserInterfaceLayoutDirection)layoutDirection {
  if (_layoutDirection == layoutDirection) {
    return;
  }
  _layoutDirection = layoutDirection;
  [self setNeedsLayout];
}

-(void)setTrailingView:(UIView *)trailingView {
  if ([self isRTL]) {
    [self mdc_setLeftView:trailingView];
  } else {
    [self mdc_setRightView:trailingView];
  }
}

-(UIView *)trailingView {
  if ([self isRTL]) {
    return self.leftView;
  } else {
    return self.rightView;
  }
}

-(void)setLeadingView:(UIView *)leadingView {
  if ([self isRTL]) {
    [self mdc_setRightView:leadingView];
  } else {
    [self mdc_setLeftView:leadingView];
  }
}

-(UIView *)leadingView {
  if ([self isRTL]) {
    return self.rightView;
  } else {
    return self.leftView;
  }
}

- (void)mdc_setLeftView:(UIView *)leftView {
  [super setLeftView:leftView];
  // TODO: Determine if a call to setNeedsLayout is necessary
}

- (void)mdc_setRightView:(UIView *)rightView {
  [super setRightView:rightView];
}

-(void)setTrailingViewMode:(UITextFieldViewMode)trailingViewMode {
  if ([self isRTL]) {
    [self mdc_setLeftViewMode:trailingViewMode];
  } else {
    [self mdc_setRightViewMode:trailingViewMode];
  }
}

-(UITextFieldViewMode)trailingViewMode {
  if ([self isRTL]) {
    return self.leftViewMode;
  } else {
    return self.rightViewMode;
  }
}

-(void)setLeadingViewMode:(UITextFieldViewMode)leadingViewMode {
  if ([self isRTL]) {
    [self mdc_setRightViewMode:leadingViewMode];
  } else {
    [self mdc_setLeftViewMode:leadingViewMode];
  }
}

-(UITextFieldViewMode)leadingViewMode {
  if ([self isRTL]) {
    return self.rightViewMode;
  } else {
    return self.leftViewMode;
  }
}

- (void)mdc_setLeftViewMode:(UITextFieldViewMode)leftViewMode {
  [super setLeftViewMode:leftViewMode];
}

- (void)mdc_setRightViewMode:(UITextFieldViewMode)rightViewMode {
  [super setRightViewMode:rightViewMode];
}

-(void)setCanPlaceholderFloat:(BOOL)canPlaceholderFloat {
  if (_canPlaceholderFloat == canPlaceholderFloat) {
    return;
  }
  _canPlaceholderFloat = canPlaceholderFloat;
  [self setNeedsLayout];
}

#pragma mark UITextField Layout Overrides

-(CGRect)textRectForBounds:(CGRect)bounds {
  return [self adjustTextAreaFrame:self.layout.textAreaFrame
      withParentClassTextAreaFrame:[super textRectForBounds:bounds]];
}

-(CGRect)editingRectForBounds:(CGRect)bounds {
  return [self adjustTextAreaFrame:self.layout.textAreaFrame
      withParentClassTextAreaFrame:[super editingRectForBounds:bounds]];
}

- (CGRect)adjustTextAreaFrame:(CGRect)textAreaFrame
 withParentClassTextAreaFrame:(CGRect)parentClassTextAreaFrame {
  CGFloat height = CGRectGetHeight(parentClassTextAreaFrame);
  CGFloat minY = CGRectGetMidY(textAreaFrame) - (height * 0.5);
  return CGRectMake(CGRectGetMinX(textAreaFrame), minY, CGRectGetWidth(textAreaFrame), height);
}

-(CGRect)leftViewRectForBounds:(CGRect)bounds {
  return self.layout.leftViewFrame;
}

-(CGRect)rightViewRectForBounds:(CGRect)bounds {
  return self.layout.rightViewFrame;
}

- (CGRect)borderRectForBounds:(CGRect)bounds {
  return CGRectZero;
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
  return CGRectZero;
}

#pragma mark Custom Layout Methods

- (CGFloat)normalizedCustomUnderlineLabelDrawPriority:(CGFloat)customPriority {
  CGFloat value = customPriority;
  if (value < 0) {
    value = 0;
  } else if (value > 1) {
    value = 1;
  }
  return value;
}


#pragma mark Fonts

- (UIFont *)effectiveFont {
  return self.font ?: [self uiTextFieldDefaultFont];
}

- (UIFont *)uiTextFieldDefaultFont {
  static dispatch_once_t onceToken;
  static UIFont *font;
  dispatch_once(&onceToken, ^{
    font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
  });
  return font;
}

#pragma mark Clear Button

- (UIImage *)clearButtonImage {
  CGFloat clearButtonImageViewSideLength = [self clearButtonImageViewSideLength];
  CGSize clearButtonSize = CGSizeMake(clearButtonImageViewSideLength, clearButtonImageViewSideLength);
  CGRect rect = CGRectMake(0, 0, clearButtonSize.width, clearButtonSize.height);
  UIGraphicsBeginImageContextWithOptions(rect.size, false, 0);
  [[UIColor grayColor] setFill];
  [[self pathForClearButtonImageWithFrame:rect] fill];
  UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
  return image;
}

// This generated code is taken from the MDCTextField.
- (UIBezierPath *)pathForClearButtonImageWithFrame:(CGRect)frame {
  CGRect innerBounds =
  CGRectMake(CGRectGetMinX(frame) + 2, CGRectGetMinY(frame) + 2,
             MDCFloor((frame.size.width - 2) * (CGFloat)0.90909 + (CGFloat)0.5),
             MDCFloor((frame.size.height - 2) * (CGFloat)0.90909 + (CGFloat)0.5));

  UIBezierPath *ic_clear_path = [UIBezierPath bezierPath];
  [ic_clear_path moveToPoint:CGPointMake(CGRectGetMinX(innerBounds) +
                                         (CGFloat)0.50000 * innerBounds.size.width,
                                         CGRectGetMinY(innerBounds) + 0 * innerBounds.size.height)];
  [ic_clear_path
   addCurveToPoint:CGPointMake(
                               CGRectGetMinX(innerBounds) + 1 * innerBounds.size.width,
                               CGRectGetMinY(innerBounds) + (CGFloat)0.50000 * innerBounds.size.height)
   controlPoint1:CGPointMake(
                             CGRectGetMinX(innerBounds) + (CGFloat)0.77600 * innerBounds.size.width,
                             CGRectGetMinY(innerBounds) + 0 * innerBounds.size.height)
   controlPoint2:CGPointMake(
                             CGRectGetMinX(innerBounds) + 1 * innerBounds.size.width,
                             CGRectGetMinY(innerBounds) + (CGFloat)0.22400 * innerBounds.size.height)];
  [ic_clear_path
   addCurveToPoint:CGPointMake(
                               CGRectGetMinX(innerBounds) + (CGFloat)0.50000 * innerBounds.size.width,
                               CGRectGetMinY(innerBounds) + 1 * innerBounds.size.height)
   controlPoint1:CGPointMake(
                             CGRectGetMinX(innerBounds) + 1 * innerBounds.size.width,
                             CGRectGetMinY(innerBounds) + (CGFloat)0.77600 * innerBounds.size.height)
   controlPoint2:CGPointMake(
                             CGRectGetMinX(innerBounds) + (CGFloat)0.77600 * innerBounds.size.width,
                             CGRectGetMinY(innerBounds) + 1 * innerBounds.size.height)];
  [ic_clear_path
   addCurveToPoint:CGPointMake(
                               CGRectGetMinX(innerBounds) + 0 * innerBounds.size.width,
                               CGRectGetMinY(innerBounds) + (CGFloat)0.50000 * innerBounds.size.height)
   controlPoint1:CGPointMake(
                             CGRectGetMinX(innerBounds) + (CGFloat)0.22400 * innerBounds.size.width,
                             CGRectGetMinY(innerBounds) + 1 * innerBounds.size.height)
   controlPoint2:CGPointMake(
                             CGRectGetMinX(innerBounds) + 0 * innerBounds.size.width,
                             CGRectGetMinY(innerBounds) + (CGFloat)0.77600 * innerBounds.size.height)];
  [ic_clear_path
   addCurveToPoint:CGPointMake(
                               CGRectGetMinX(innerBounds) + (CGFloat)0.50000 * innerBounds.size.width,
                               CGRectGetMinY(innerBounds) + 0 * innerBounds.size.height)
   controlPoint1:CGPointMake(
                             CGRectGetMinX(innerBounds) + 0 * innerBounds.size.width,
                             CGRectGetMinY(innerBounds) + (CGFloat)0.22400 * innerBounds.size.height)
   controlPoint2:CGPointMake(
                             CGRectGetMinX(innerBounds) + (CGFloat)0.22400 * innerBounds.size.width,
                             CGRectGetMinY(innerBounds) + 0 * innerBounds.size.height)];
  [ic_clear_path closePath];
  [ic_clear_path
   moveToPoint:CGPointMake(
                           CGRectGetMinX(innerBounds) + (CGFloat)0.73417 * innerBounds.size.width,
                           CGRectGetMinY(innerBounds) + (CGFloat)0.31467 * innerBounds.size.height)];
  [ic_clear_path
   addLineToPoint:CGPointMake(
                              CGRectGetMinX(innerBounds) + (CGFloat)0.68700 * innerBounds.size.width,
                              CGRectGetMinY(innerBounds) + (CGFloat)0.26750 * innerBounds.size.height)];
  [ic_clear_path
   addLineToPoint:CGPointMake(
                              CGRectGetMinX(innerBounds) + (CGFloat)0.50083 * innerBounds.size.width,
                              CGRectGetMinY(innerBounds) + (CGFloat)0.45367 * innerBounds.size.height)];
  [ic_clear_path
   addLineToPoint:CGPointMake(
                              CGRectGetMinX(innerBounds) + (CGFloat)0.31467 * innerBounds.size.width,
                              CGRectGetMinY(innerBounds) + (CGFloat)0.26750 * innerBounds.size.height)];
  [ic_clear_path
   addLineToPoint:CGPointMake(
                              CGRectGetMinX(innerBounds) + (CGFloat)0.26750 * innerBounds.size.width,
                              CGRectGetMinY(innerBounds) + (CGFloat)0.31467 * innerBounds.size.height)];
  [ic_clear_path
   addLineToPoint:CGPointMake(
                              CGRectGetMinX(innerBounds) + (CGFloat)0.45367 * innerBounds.size.width,
                              CGRectGetMinY(innerBounds) + (CGFloat)0.50083 * innerBounds.size.height)];
  [ic_clear_path
   addLineToPoint:CGPointMake(
                              CGRectGetMinX(innerBounds) + (CGFloat)0.26750 * innerBounds.size.width,
                              CGRectGetMinY(innerBounds) + (CGFloat)0.68700 * innerBounds.size.height)];
  [ic_clear_path
   addLineToPoint:CGPointMake(
                              CGRectGetMinX(innerBounds) + (CGFloat)0.31467 * innerBounds.size.width,
                              CGRectGetMinY(innerBounds) + (CGFloat)0.73417 * innerBounds.size.height)];
  [ic_clear_path
   addLineToPoint:CGPointMake(
                              CGRectGetMinX(innerBounds) + (CGFloat)0.50083 * innerBounds.size.width,
                              CGRectGetMinY(innerBounds) + (CGFloat)0.54800 * innerBounds.size.height)];
  [ic_clear_path
   addLineToPoint:CGPointMake(
                              CGRectGetMinX(innerBounds) + (CGFloat)0.68700 * innerBounds.size.width,
                              CGRectGetMinY(innerBounds) + (CGFloat)0.73417 * innerBounds.size.height)];
  [ic_clear_path
   addLineToPoint:CGPointMake(
                              CGRectGetMinX(innerBounds) + (CGFloat)0.73417 * innerBounds.size.width,
                              CGRectGetMinY(innerBounds) + (CGFloat)0.68700 * innerBounds.size.height)];
  [ic_clear_path
   addLineToPoint:CGPointMake(
                              CGRectGetMinX(innerBounds) + (CGFloat)0.54800 * innerBounds.size.width,
                              CGRectGetMinY(innerBounds) + (CGFloat)0.50083 * innerBounds.size.height)];
  [ic_clear_path
   addLineToPoint:CGPointMake(
                              CGRectGetMinX(innerBounds) + (CGFloat)0.73417 * innerBounds.size.width,
                              CGRectGetMinY(innerBounds) + (CGFloat)0.31467 * innerBounds.size.height)];
  [ic_clear_path closePath];

  return ic_clear_path;
}

-(void)prepareForInterfaceBuilder {
  [super prepareForInterfaceBuilder];
  [self invalidateIntrinsicContentSize];
}

#pragma mark Placeholder Management

- (void)layOutPlaceholderWithState:(PlaceholderState)state {
  UIFont *font = nil;
  CGRect frame = CGRectZero;
  UIColor *color = UIColor.darkGrayColor;
  // TODO: Take color into account
  BOOL placeholderShouldHide = NO;
  switch (state) {
    case PlaceholderStateFloating:
      font = self.floatingPlaceholderFont;
      frame = self.layout.placeholderFrameFloating;
      color = UIColor.purpleColor;
      break;
    case PlaceholderStateNormal:
      font = self.placeholderFont;
      frame = self.layout.placeholderFrameNormal;
      break;
    case PlaceholderStateNone:
      font = self.placeholderFont;
      frame = self.layout.placeholderFrameNormal;
      placeholderShouldHide = YES;
      break;
    default:
      break;
  }
  self.placeholderLabel.hidden = placeholderShouldHide;
  __weak typeof(self) weakSelf = self;
  // TODO: Figure out a better way of doing this.
  // One idea: Make it so placeholder animation is actually of a layer transform
  // but at the end you really change the font and frame and stuff.
  [UIView animateWithDuration:kFloatingPlaceholderAnimationDuration animations:^{
    weakSelf.placeholderLabel.frame = frame;
    weakSelf.placeholderLabel.font = font;
    weakSelf.placeholderLabel.textColor = color;
  }];
}

- (PlaceholderState)determineCurrentPlaceholderState {
  return [self placeholderStateWithPlaceholder:self.placeholder
                                          text:self.text
                           canPlaceholderFloat:self.canPlaceholderFloat
                                     isEditing:self.isEditing];
}

- (PlaceholderState)placeholderStateWithPlaceholder:(NSString *)placeholder
                                               text:(NSString *)text
                                canPlaceholderFloat:(BOOL)canPlaceholderFloat
                                          isEditing:(BOOL)isEditing {
  BOOL hasPlaceholder = placeholder.length > 0;
  BOOL hasText = text.length > 0;
  if (hasPlaceholder) {
    if (canPlaceholderFloat) {
      if (isEditing) {
        return PlaceholderStateFloating;
      } else {
        if (hasText) {
          return PlaceholderStateFloating;
        } else {
          return PlaceholderStateNormal;
        }
      }
    } else {
      if (hasText) {
        return PlaceholderStateNone;
      } else {
        return PlaceholderStateNormal;
      }
    }
  } else {
    return PlaceholderStateNone;
  }
}

- (UIFont *)floatingPlaceholderFontWithFont:(UIFont *)font
                             textFieldStyle:(TextFieldStyle)textFieldStyle {
  CGFloat floatingPlaceholderFontSize = 0.0;
  CGFloat outlinedFloatingPlaceholderScale = (CGFloat)41 / (CGFloat)55;
  CGFloat filledFloatingPlaceholderScale = (CGFloat)53 / (CGFloat)71;
  switch (textFieldStyle) {
    case TextFieldStyleFilled:
      floatingPlaceholderFontSize = round((double)(font.pointSize * filledFloatingPlaceholderScale));
      break;
    case TextFieldStyleOutline:
      floatingPlaceholderFontSize = round((double)(font.pointSize * outlinedFloatingPlaceholderScale));
      break;
    default:
      break;
  }
  return [font fontWithSize:floatingPlaceholderFontSize];
}

- (CGFloat)clearButtonImageViewSideLength {
  return kClearButtonTouchTargetSideLength - kTextRectSidePadding;
}

#pragma mark User Actions

- (void)clearButtonPressed:(UIButton *)clearButton {
  self.text = nil;
  // TODO: I'm pretty sure there is a control event or notification UITextField sens or posts here. Add it!
}

#pragma mark Notification Listener Methods

- (void)textFieldDidEndEditingWithNotification:(NSNotification *)notification {
  if (notification.object != self) {
    return;
  }
}

//- (void)textFieldDidChangeWithNotification:(NSNotification *)notification {
//  if (notification.object != self) {
//    return;
//  }
//  BOOL shouldHidePlaceholder = NO;
//  if (self.text.length > 0 && !self.canPlaceholderFloat) {
//    shouldHidePlaceholder = YES;
//  }
//  self.placeholderLabel.hidden = shouldHidePlaceholder;
//}

- (void)textFieldDidBeginEditingWithNotification:(NSNotification *)notification {
  if (notification.object != self) {
    return;
  }
}

#pragma mark Internationalization

- (BOOL)isRTL {
  return self.layoutDirection == UIUserInterfaceLayoutDirectionRightToLeft;
}

#pragma mark Style Management

- (void)applyCurrentStyle {
  
}

- (void)applyTextFieldStyle:(TextFieldStyle)textFieldStyle
            textFieldBounds:(CGRect)textFieldBounds
   floatingPlaceholderFrame:(CGRect)floatingPlaceholderFrame
    topRowBottomRowDividerY:(CGFloat)topRowBottomRowDividerY
      isFloatingPlaceholder:(BOOL)isFloatingPlaceholder {
  [self applyOutlinedStyle:textFieldStyle == TextFieldStyleOutline
           textFieldBounds:textFieldBounds
  floatingPlaceholderFrame:floatingPlaceholderFrame
   topRowBottomRowDividerY:topRowBottomRowDividerY
     isFloatingPlaceholder:isFloatingPlaceholder];
  [self applyFilledStyle:textFieldStyle == TextFieldStyleFilled
         textFieldBounds:textFieldBounds
 topRowBottomRowDividerY:topRowBottomRowDividerY];
}

- (void)applyOutlinedStyle:(BOOL)isOutlined
           textFieldBounds:(CGRect)textFieldBounds
  floatingPlaceholderFrame:(CGRect)floatingPlaceholderFrame
   topRowBottomRowDividerY:(CGFloat)topRowBottomRowDividerY
     isFloatingPlaceholder:(BOOL)isFloatingPlaceholder {
  if (!isOutlined) {
    [self.outlinedSublayer removeFromSuperlayer];
    return;
  }
  UIBezierPath *path = [self outlinePathWithTextFieldBounds:textFieldBounds
                                   floatingPlaceholderFrame:floatingPlaceholderFrame
                                    topRowBottomRowDividerY:topRowBottomRowDividerY
                                      isFloatingPlaceholder:isFloatingPlaceholder];
  self.outlinedSublayer.path = path.CGPath;
  if (self.outlinedSublayer.superlayer != self.layer) {
    [self.layer insertSublayer:self.outlinedSublayer atIndex:0];
  }
}

- (void)applyFilledStyle:(BOOL)isFilled
         textFieldBounds:(CGRect)textFieldBounds
 topRowBottomRowDividerY:(CGFloat)topRowBottomRowDividerY {
  if (!isFilled) {
    [self.filledSublayer removeFromSuperlayer];
    return;
  }

  UIBezierPath *filledSublayerPath = [self filledSublayerPathWithTextFieldBounds:textFieldBounds
                                                         topRowBottomRowDividerY:topRowBottomRowDividerY];
  UIBezierPath *filledSublayerUnderlinePath = [self filledSublayerUnderlinePathWithTextFieldBounds:textFieldBounds
                                                                           topRowBottomRowDividerY:topRowBottomRowDividerY];
  self.filledSublayer.path = filledSublayerPath.CGPath;
  self.filledSublayerUnderline.path = filledSublayerUnderlinePath.CGPath;
  if (self.filledSublayer.superlayer != self.layer) {
    [self.layer insertSublayer:self.filledSublayer atIndex:0];
  }
}


#pragma mark Path Drawing

- (UIBezierPath *)outlinePathWithTextFieldBounds:(CGRect)textFieldBounds
                        floatingPlaceholderFrame:(CGRect)floatingPlaceholderFrame
                         topRowBottomRowDividerY:(CGFloat)topRowBottomRowDividerY
                           isFloatingPlaceholder:(BOOL)isFloatingPlaceholder {
  UIBezierPath *path = [[UIBezierPath alloc] init];
  //TODO: inject state so you can set width and color correctly
  CGFloat radius = kOutlinedTextFieldCornerRadius;
  CGFloat textFieldWidth = CGRectGetWidth(textFieldBounds);
  CGFloat sublayerMinY = 0;
//  if (CGSizeEqualToSize(CGSizeZero, floatingPlaceholderFrame.size)) {
//    sublayerMinY = CGRectGetMidY(floatingPlaceholderFrame);
//  }
  CGFloat sublayerMaxY = topRowBottomRowDividerY;

  CGPoint startingPoint = CGPointMake(radius, sublayerMinY);
  CGPoint topRightCornerPoint1 = CGPointMake(textFieldWidth - radius, sublayerMinY);
  [path moveToPoint:startingPoint];
  if (isFloatingPlaceholder) {
    CGFloat leftLineBreak = CGRectGetMinX(floatingPlaceholderFrame) - kFloatingPlaceholderSideMargin;
    CGFloat rightLineBreak = CGRectGetMaxX(floatingPlaceholderFrame) + kFloatingPlaceholderSideMargin;
    [path addLineToPoint:CGPointMake(leftLineBreak, sublayerMinY)];
    [path moveToPoint:CGPointMake(rightLineBreak, sublayerMinY)];
    [path addLineToPoint:CGPointMake(rightLineBreak, sublayerMinY)];
  } else {
    [path addLineToPoint:topRightCornerPoint1];
  }

  CGPoint topRightCornerPoint2 = CGPointMake(textFieldWidth, sublayerMinY + radius);
  [self addTopRightCornerToPath:path
                      fromPoint:topRightCornerPoint1
                        toPoint:topRightCornerPoint2
                     withRadius:radius];

  CGPoint bottomRightCornerPoint1 = CGPointMake(textFieldWidth, sublayerMaxY - radius);
  CGPoint bottomRightCornerPoint2 = CGPointMake(textFieldWidth - radius, sublayerMaxY);
  [path addLineToPoint:bottomRightCornerPoint1];
  [self addBottomRightCornerToPath:path
                         fromPoint:bottomRightCornerPoint1
                           toPoint:bottomRightCornerPoint2
                        withRadius:radius];

  CGPoint bottomLeftCornerPoint1 = CGPointMake(radius, sublayerMaxY);
  CGPoint bottomLeftCornerPoint2 = CGPointMake(0, sublayerMaxY - radius);
  [path addLineToPoint:bottomLeftCornerPoint1];
  [self addBottomLeftCornerToPath:path
                        fromPoint:bottomLeftCornerPoint1
                          toPoint:bottomLeftCornerPoint2
                       withRadius:radius];

  CGPoint topLeftCornerPoint1 = CGPointMake(0, sublayerMinY + radius);
  CGPoint topLeftCornerPoint2 = CGPointMake(radius, sublayerMinY);
  [path addLineToPoint:topLeftCornerPoint1];
  [self addTopLeftCornerToPath:path
                     fromPoint:topLeftCornerPoint1
                       toPoint:topLeftCornerPoint2
                    withRadius:radius];

  return path;
}

- (UIBezierPath *)filledSublayerPathWithTextFieldBounds:(CGRect)textFieldBounds
                                topRowBottomRowDividerY:(CGFloat)topRowBottomRowDividerY {
  UIBezierPath *path = [[UIBezierPath alloc] init];
  CGFloat topRadius = kFilledTextFieldTopCornerRadius;
  CGFloat bottomRadius = 0;
  CGFloat textFieldWidth = CGRectGetWidth(textFieldBounds);
  CGFloat sublayerMinY = 0;
  CGFloat sublayerMaxY = topRowBottomRowDividerY;

  CGPoint startingPoint = CGPointMake(topRadius, sublayerMinY);
  CGPoint topRightCornerPoint1 = CGPointMake(textFieldWidth - topRadius, sublayerMinY);
  [path moveToPoint:startingPoint];
  [path addLineToPoint:topRightCornerPoint1];

  CGPoint topRightCornerPoint2 = CGPointMake(textFieldWidth, sublayerMinY + topRadius);
  [self addTopRightCornerToPath:path
                      fromPoint:topRightCornerPoint1
                        toPoint:topRightCornerPoint2
                     withRadius:topRadius];

  CGPoint bottomRightCornerPoint1 = CGPointMake(textFieldWidth, sublayerMaxY - bottomRadius);
  CGPoint bottomRightCornerPoint2 = CGPointMake(textFieldWidth - bottomRadius, sublayerMaxY);
  [path addLineToPoint:bottomRightCornerPoint1];
  [self addBottomRightCornerToPath:path
                         fromPoint:bottomRightCornerPoint1
                           toPoint:bottomRightCornerPoint2
                        withRadius:bottomRadius];

  CGPoint bottomLeftCornerPoint1 = CGPointMake(bottomRadius, sublayerMaxY);
  CGPoint bottomLeftCornerPoint2 = CGPointMake(0, sublayerMaxY - bottomRadius);
  [path addLineToPoint:bottomLeftCornerPoint1];
  [self addBottomLeftCornerToPath:path
                        fromPoint:bottomLeftCornerPoint1
                          toPoint:bottomLeftCornerPoint2
                       withRadius:bottomRadius];

  CGPoint topLeftCornerPoint1 = CGPointMake(0, sublayerMinY + topRadius);
  CGPoint topLeftCornerPoint2 = CGPointMake(topRadius, sublayerMinY);
  [path addLineToPoint:topLeftCornerPoint1];
  [self addTopLeftCornerToPath:path
                     fromPoint:topLeftCornerPoint1
                       toPoint:topLeftCornerPoint2
                    withRadius:topRadius];

  return path;
}

- (UIBezierPath *)filledSublayerUnderlinePathWithTextFieldBounds:(CGRect)textFieldBounds
                                         topRowBottomRowDividerY:(CGFloat)topRowBottomRowDividerY {
  //TODO: Consider underline labels, don't place underline under them
  UIBezierPath *path = [[UIBezierPath alloc] init];
  CGFloat textFieldWidth = CGRectGetWidth(textFieldBounds);
  CGFloat sublayerMaxY = topRowBottomRowDividerY;
  CGFloat sublayerMinY = sublayerMaxY - kFilledTextFieldUnderlineHeight;

  CGPoint startingPoint = CGPointMake(0, sublayerMinY);
  CGPoint topRightCornerPoint1 = CGPointMake(textFieldWidth, sublayerMinY);
  [path moveToPoint:startingPoint];
  [path addLineToPoint:topRightCornerPoint1];

  CGPoint topRightCornerPoint2 = CGPointMake(textFieldWidth, sublayerMinY);
  [self addTopRightCornerToPath:path
                      fromPoint:topRightCornerPoint1
                        toPoint:topRightCornerPoint2
                     withRadius:0];

  CGPoint bottomRightCornerPoint1 = CGPointMake(textFieldWidth, sublayerMaxY);
  CGPoint bottomRightCornerPoint2 = CGPointMake(textFieldWidth, sublayerMaxY);
  [path addLineToPoint:bottomRightCornerPoint1];
  [self addBottomRightCornerToPath:path
                         fromPoint:bottomRightCornerPoint1
                           toPoint:bottomRightCornerPoint2
                        withRadius:0];

  CGPoint bottomLeftCornerPoint1 = CGPointMake(0, sublayerMaxY);
  CGPoint bottomLeftCornerPoint2 = CGPointMake(0, sublayerMaxY);
  [path addLineToPoint:bottomLeftCornerPoint1];
  [self addBottomLeftCornerToPath:path
                        fromPoint:bottomLeftCornerPoint1
                          toPoint:bottomLeftCornerPoint2
                       withRadius:0];

  CGPoint topLeftCornerPoint1 = CGPointMake(0, sublayerMinY);
  CGPoint topLeftCornerPoint2 = CGPointMake(0, sublayerMinY);
  [path addLineToPoint:topLeftCornerPoint1];
  [self addTopLeftCornerToPath:path
                     fromPoint:topLeftCornerPoint1
                       toPoint:topLeftCornerPoint2
                    withRadius:0];

  return path;
}


- (void)addTopRightCornerToPath:(UIBezierPath *)path
                      fromPoint:(CGPoint)point1
                        toPoint:(CGPoint)point2
                     withRadius:(CGFloat)radius {
  CGFloat startAngle = - (CGFloat)(M_PI / 2);
  CGFloat endAngle = 0;
  CGPoint center = CGPointMake(point1.x, point2.y);
  [path addArcWithCenter:center
                  radius:radius
              startAngle:startAngle
                endAngle:endAngle
               clockwise:YES];
}

- (void)addBottomRightCornerToPath:(UIBezierPath *)path
                         fromPoint:(CGPoint)point1
                           toPoint:(CGPoint)point2
                        withRadius:(CGFloat)radius {
  CGFloat startAngle = 0;
  CGFloat endAngle = - (CGFloat)((M_PI * 3) / 2);
  CGPoint center = CGPointMake(point2.x, point1.y);
  [path addArcWithCenter:center
                  radius:radius
              startAngle:startAngle
                endAngle:endAngle
               clockwise:YES];
}

- (void)addBottomLeftCornerToPath:(UIBezierPath *)path
                        fromPoint:(CGPoint)point1
                          toPoint:(CGPoint)point2
                       withRadius:(CGFloat)radius {
  CGFloat startAngle = - (CGFloat)((M_PI * 3) / 2);
  CGFloat endAngle = - (CGFloat)M_PI;
  CGPoint center = CGPointMake(point1.x, point2.y);
  [path addArcWithCenter:center
                  radius:radius
              startAngle:startAngle
                endAngle:endAngle
               clockwise:YES];
}

- (void)addTopLeftCornerToPath:(UIBezierPath *)path
                     fromPoint:(CGPoint)point1
                       toPoint:(CGPoint)point2
                    withRadius:(CGFloat)radius {
  CGFloat startAngle = - (CGFloat)M_PI;
  CGFloat endAngle = - (CGFloat)(M_PI / 2);
  CGPoint center = CGPointMake(point1.x + radius, point2.y + radius);
  [path addArcWithCenter:center
                  radius:radius
              startAngle:startAngle
                endAngle:endAngle
               clockwise:YES];
}



- (IBAction)outletTextField:(id)sender {
}
@end
