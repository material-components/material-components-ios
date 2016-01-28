#import "PestoSettingsViewController.h"

#import "MaterialSwitch.h"
#import "MaterialTypography.h"

static CGFloat kPestoSettingsViewControllerCellViewInset = 20.f;
static CGFloat kPestoSettingsViewControllerCellViewHeight = 48.f;

@interface PestoSettingsViewControllerCellView : UIView

@property(nonatomic) NSString *labelText;
@property(nonatomic) BOOL on;

@end

@interface PestoSettingsViewControllerCellView ()

@property(nonatomic) UILabel *labelView;
@property(nonatomic) MDCSwitch *switchView;

@end

@implementation PestoSettingsViewControllerCellView

- (id)initWithCoder:(NSCoder *)aDecoder {
  self = [super initWithCoder:aDecoder];
  return self;
}

- (id)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    CGRect descRect = CGRectMake(0, 0, self.bounds.size.width * 0.75f, self.bounds.size.height);
    _labelView = [[UILabel alloc] initWithFrame:descRect];
    _labelView.font = [MDCTypography body1Font];
    _labelView.alpha = [MDCTypography body1FontOpacity];
    _labelView.autoresizingMask = UIViewAutoresizingFlexibleWidth |
                                  UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;

    _switchView = [[MDCSwitch alloc] initWithFrame:CGRectZero];
    CGFloat switchX = self.bounds.size.width - _switchView.frame.size.width;
    CGFloat switchY = (self.bounds.size.height - _switchView.frame.size.height) / 2.f;
    _switchView.frame = CGRectOffset(_switchView.frame, switchX, switchY);
    _switchView.onTintColor = [UIColor colorWithRed:0.09f green:0.54f blue:0.44f alpha:1.f];
    _switchView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin |
                                   UIViewAutoresizingFlexibleTopMargin |
                                   UIViewAutoresizingFlexibleBottomMargin;

    [self addSubview:_labelView];
    [self addSubview:_switchView];
  }
  return self;
}

- (void)setLabelText:(NSString *)labelText {
  _labelText = labelText;
  _labelView.text = _labelText;
  [self setNeedsLayout];
}

- (void)setOn:(BOOL)on {
  _on = on;
  _switchView.on = on;
}

@end

@implementation PestoSettingsViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  CGRect testViewFrame = CGRectMake(0,
                                    10.f,
                                    self.view.bounds.size.width,
                                    kPestoSettingsViewControllerCellViewHeight);
  CGRect insetFrame = CGRectInset(testViewFrame, kPestoSettingsViewControllerCellViewInset, 0);
  PestoSettingsViewControllerCellView *testCellView = [[PestoSettingsViewControllerCellView alloc]
      initWithFrame:insetFrame];
  testCellView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
  testCellView.labelText = @"Settings view needs more work?";
  testCellView.on = YES;

  self.view.backgroundColor = [UIColor whiteColor];

  [self.view addSubview:testCellView];
}

@end
