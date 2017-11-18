//
//  ExampleFloatingButtonThemer.m
//  MaterialComponents
//
//  Created by Rob Moore on 11/15/17.
//

#import "ExampleFloatingButtonThemer.h"
#import "MDCButtonColorThemer.h"

@implementation ExampleFloatingButtonThemer

+ (void)applyToButton:(nonnull MDCFloatingButton *)button
      withColorScheme:(nullable NSObject<MDCColorScheme> *)colorScheme {
  if (colorScheme) {
    [MDCButtonColorThemer applyColorScheme:colorScheme toButton:button];
  }
  UIEdgeInsets expandedLeadingInsets = UIEdgeInsetsMake(4, 6, 4, 12);

  UIEdgeInsets hitAreaCompactDefault = UIEdgeInsetsMake(-8, -8, -8, -8);
  UIEdgeInsets hitAreaCompactMini = UIEdgeInsetsMake(-16, -16, -16, -16);

  CGSize sizeCompactDefault = CGSizeMake(50, 50);
  CGSize sizeExtendedMinimum = CGSizeMake(100, 32);

  [button setContentEdgeInsets:expandedLeadingInsets
                       forType:MDCFloatingButtonTypeDefault
                          mode:MDCFloatingButtonModeExtended];

  [button setHitAreaInsets:hitAreaCompactMini
                   forType:MDCFloatingButtonTypeMini
                      mode:MDCFloatingButtonModeNormal];
  [button setHitAreaInsets:hitAreaCompactDefault
                   forType:MDCFloatingButtonTypeDefault
                      mode:MDCFloatingButtonModeNormal];

  [button setMinimumSize:sizeCompactDefault
                 forType:MDCFloatingButtonTypeDefault
                    mode:MDCFloatingButtonModeNormal];
  [button setMaximumSize:sizeCompactDefault
                 forType:MDCFloatingButtonTypeDefault
                    mode:MDCFloatingButtonModeNormal];

  [button setMinimumSize:sizeExtendedMinimum
                 forType:MDCFloatingButtonTypeDefault
                    mode:MDCFloatingButtonModeExtended];
  [button setMaximumSize:sizeExtendedMinimum
                 forType:MDCFloatingButtonTypeDefault
                    mode:MDCFloatingButtonModeExtended];

  [button setElevation:3 forState:UIControlStateNormal];
  [button setElevation:6 forState:UIControlStateHighlighted];

  [button setImageTitlePadding:4];
}

@end
