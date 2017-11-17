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
  UIEdgeInsets compactInsets = UIEdgeInsetsZero;
  UIEdgeInsets expandedLeadingInsets = UIEdgeInsetsMake(4, 6, 4, 8);
  UIEdgeInsets expandedTrailingInsets = UIEdgeInsetsMake(4, 8, 4, 6);

  UIEdgeInsets hitAreaCompactDefault = UIEdgeInsetsMake(-8, -8, -8, -8);
  UIEdgeInsets hitAreaCompactMini = UIEdgeInsetsMake(-16, -16, -16, -16);

  CGSize sizeCompactDefault = CGSizeMake(50, 50);
  CGSize sizeExtendedMinimum = CGSizeMake(32, 72);

  [button setContentEdgeInsets:compactInsets forShape:MDCFloatingButtonShapeDefault];
  [button setContentEdgeInsets:compactInsets forShape:MDCFloatingButtonShapeMini];
  [button setContentEdgeInsets:compactInsets forShape:MDCFloatingButtonShapeLargeIcon];
  [button setContentEdgeInsets:expandedLeadingInsets
                      forShape:MDCFloatingButtonShapeExtendedLeadingIcon];
  [button setContentEdgeInsets:expandedTrailingInsets
                      forShape:MDCFloatingButtonShapeExtendedTrailingIcon];

  [button setHitAreaInsets:hitAreaCompactDefault forShape:MDCFloatingButtonShapeDefault];
  [button setHitAreaInsets:hitAreaCompactDefault forShape:MDCFloatingButtonShapeLargeIcon];
  [button setHitAreaInsets:hitAreaCompactMini forShape:MDCFloatingButtonShapeMini];

  [button setMinimumSize:sizeCompactDefault forShape:MDCFloatingButtonShapeDefault];
  [button setMaximumSize:sizeCompactDefault forShape:MDCFloatingButtonShapeDefault];
  [button setMinimumSize:sizeCompactDefault forShape:MDCFloatingButtonShapeLargeIcon];
  [button setMaximumSize:sizeCompactDefault forShape:MDCFloatingButtonShapeLargeIcon];
  [button setMinimumSize:sizeExtendedMinimum forShape:MDCFloatingButtonShapeExtendedLeadingIcon];
  [button setMinimumSize:sizeExtendedMinimum forShape:MDCFloatingButtonShapeExtendedTrailingIcon];

  [button setElevation:3 forState:UIControlStateNormal];
  [button setElevation:6 forState:UIControlStateHighlighted];
  [button setElevation:3 forState:UIControlStateNormal];
  [button setElevation:6 forState:UIControlStateHighlighted];

  [button setImageTitlePadding:4];
}

@end
