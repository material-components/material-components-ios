#import <UIKit/UIKit.h>

#import "MaterialButtons.h"
#import "MaterialTabBar.h"

@interface TabBarDemoViewController : UIViewController
@end

@implementation TabBarDemoViewController (CatalogByConvention)

+ (NSArray *)catalogBreadcrumbs {
  return @[ @"Tab Bar", @"Tab Bar" ];
}

+ (BOOL)catalogIsPrimaryDemo {
  return YES;
}

+ (NSString *)catalogDescription {
  return @"The tab bar is a component for switching between views of grouped content.";
}

@end

@implementation TabBarDemoViewController {
  MDCTabBar *_shortTabBar;
  MDCTabBar *_longTabBar;
  MDCRaisedButton *_alignmentButton;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    self.title = @"Tab Bars";

    UIBarButtonItem *badgeIncrementItem =
        [[UIBarButtonItem alloc] initWithTitle:@"Increment"
                                         style:UIBarButtonItemStylePlain
                                        target:self
                                        action:@selector(incrementBadges:)];
    self.navigationItem.rightBarButtonItem = badgeIncrementItem;
  }
  return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
  [super viewDidLoad];

  self.view.backgroundColor = [UIColor colorWithWhite:0.8f alpha:1.0f];

  // Button to change tab alignments.
  _alignmentButton = [[MDCRaisedButton alloc] init];
  [_alignmentButton setTitle:@"Change Alignment" forState:UIControlStateNormal];
  [_alignmentButton sizeToFit];
  _alignmentButton.center = CGPointMake(CGRectGetMidX(self.view.bounds), 100);
  _alignmentButton.autoresizingMask =
      UIViewAutoresizingFlexibleLeftMargin |
      UIViewAutoresizingFlexibleBottomMargin |
      UIViewAutoresizingFlexibleRightMargin;
  [_alignmentButton addTarget:self
                       action:@selector(changeAlignment:)
             forControlEvents:UIControlEventTouchUpInside];
  [self.view addSubview:_alignmentButton];

  self.view.tintColor = [UIColor purpleColor];

  [self loadShortTabBar];
  [self loadLongTabBar];
}

#pragma mark - Action

- (void)incrementBadges:(id)sender {
  // Increment all numeric badge values to show cells updating when their item's properties are set.
  for (MDCTabBar *tabBar in @[_longTabBar, _shortTabBar]) {
    for (UITabBarItem *item in tabBar.items) {
      NSString *badgeValue = item.badgeValue;
      if (badgeValue) {
        NSInteger badgeNumber = badgeValue.integerValue;
        if (badgeNumber > 0) {
          // Update badge value directly - the cell should update immediately.
          item.badgeValue = [NSNumberFormatter localizedStringFromNumber:@(badgeNumber + 1)
                                                             numberStyle:NSNumberFormatterNoStyle];
        }
      }
    }
  }
}

#pragma mark - Private

- (void)loadShortTabBar {
  const CGRect bounds = self.view.bounds;

  // Short tab bar with a small number of items.
  NSBundle *bundle = [NSBundle bundleForClass:[self class]];
  UIImage *infoImage =
      [UIImage imageNamed:@"TabBarDemo_ic_info" inBundle:bundle compatibleWithTraitCollection:nil];
  UIImage *starImage =
      [UIImage imageNamed:@"TabBarDemo_ic_star" inBundle:bundle compatibleWithTraitCollection:nil];
  _shortTabBar =
      [[MDCTabBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(bounds)-20.0f, 0)];
  _shortTabBar.center = CGPointMake(CGRectGetMidX(self.view.bounds), 150);
  _shortTabBar.items = @[
      [[UITabBarItem alloc] initWithTitle:@"Two" image:infoImage tag:0],
      [[UITabBarItem alloc] initWithTitle:@"Tabs" image:starImage tag:1]
  ];

  // Give the last item a badge
  [[_shortTabBar.items lastObject] setBadgeValue:@"1"];

  _shortTabBar.barTintColor = [UIColor blueColor];
  _shortTabBar.tintColor = [UIColor whiteColor];
  _shortTabBar.itemAppearance = MDCTabBarItemAppearanceTitledImages;
  _shortTabBar.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
  [_shortTabBar sizeToFit];
  [self.view addSubview:_shortTabBar];
}

- (void)loadLongTabBar {
  const CGRect bounds = self.view.bounds;

  // Long tab bar with lots of items of varying length. Also demonstrates configurable accent color.
  _longTabBar =
      [[MDCTabBar alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(bounds)-20.0f, 0)];
  _longTabBar.center = CGPointMake(CGRectGetMidX(self.view.bounds), 250);
  _longTabBar.items = @[
      [[UITabBarItem alloc] initWithTitle:@"This Is" image:nil tag:0],
      [[UITabBarItem alloc] initWithTitle:@"A" image:nil tag:0],
      [[UITabBarItem alloc] initWithTitle:@"Tab Bar" image:nil tag:0],
      [[UITabBarItem alloc] initWithTitle:@"With" image:nil tag:0],
      [[UITabBarItem alloc] initWithTitle:@"A Variety of Titles of Varying Length" image:nil tag:0],
  ];

  // Make entire tab bar non-uppercased
  _longTabBar.displaysUppercaseTitles = NO;

  // Give it a white appearance to show dark text and customize the unselected title color.
  _longTabBar.selectedItemTintColor = [UIColor blackColor];
  _longTabBar.unselectedItemTintColor = [UIColor grayColor];
  _longTabBar.tintColor = [UIColor redColor];
  _longTabBar.barTintColor = [UIColor whiteColor];
  _longTabBar.inkColor = [UIColor colorWithWhite:0.0 alpha:0.1];

  _longTabBar.autoresizingMask =
      UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
  [_longTabBar sizeToFit];
  [self.view addSubview:_longTabBar];
}

- (void)changeAlignment:(id)sender {
  UIAlertController *alignmentSheet =
      [UIAlertController alertControllerWithTitle:nil
                                          message:nil
                                   preferredStyle:UIAlertControllerStyleActionSheet];
  [alignmentSheet addAction:[UIAlertAction actionWithTitle:@"Leading"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                     [self setAlignment:MDCTabBarAlignmentLeading];
                                                   }]];
  [alignmentSheet addAction:[UIAlertAction actionWithTitle:@"Center"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                     [self setAlignment:MDCTabBarAlignmentCenter];
                                                   }]];
  [alignmentSheet addAction:[UIAlertAction actionWithTitle:@"Justified"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                     [self setAlignment:MDCTabBarAlignmentJustified];
                                                   }]];
  [alignmentSheet addAction:[UIAlertAction actionWithTitle:@"Selected Center"
                                                     style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * _Nonnull action) {
                                                     [self setAlignment:MDCTabBarAlignmentCenterSelected];
                                                   }]];
  [self presentViewController:alignmentSheet animated:YES completion:nil];
}

- (void)setAlignment:(MDCTabBarAlignment)alignment {
  [_longTabBar setAlignment:alignment animated:YES];
  [_shortTabBar setAlignment:alignment animated:YES];
}

@end
